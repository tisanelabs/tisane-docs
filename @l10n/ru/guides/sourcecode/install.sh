#!/bin/bash
USER_HOME=$(eval echo ~${SUDO_USER})
TISANE_INSTALL_DIR="$USER_HOME/tisane"
TISANE_EXECUTABLE="$TISANE_INSTALL_DIR/tisane"
TISANE_CONFIG="$TISANE_INSTALL_DIR/tisane.conf"
force_install=false
while getopts "f:p:d:u" opt; do
  case $opt in
    f) files=$OPTARG ;;
    p) IFS=',' read -ra ports <<< "$OPTARG" ;;
    d) type=$OPTARG ;;
    u) force_install=true ;;
    *) exit 1 ;;
  esac
done
if [[ -z $type ]]; then
  type="forking"
fi
if [ ! -e $files ]; then
    echo "$files no such file or directory"
    echo "Aborting"
    exit 1
fi
firewall="unknown"

if sudo systemctl status ufw 2>/dev/null | grep -q "Active: active (running)"; then
    firewall="ufw"
elif sudo systemctl status firewalld 2>/dev/null | grep -q "Active: active (running)"; then
    firewall="firewalld"
elif sudo systemctl status iptables 2>/dev/null | grep -q "Active: active (running)"; then
    firewall="iptables"
fi
echo "The active firewall is: $firewall"

services=$(systemctl list-unit-files --type=service | grep tisane | awk '{print $1}')
if [[ $force_install == true ]]; then
    echo "Force installation"
    # services=$(systemctl list-unit-files --type=service | grep tisane | awk '{print $1}')
    if [ -z "$services" ]; then 
        echo "No Tisane services running"
        echo "Continuing with the install"
    else
        echo "Tisane services are active"
        echo "Attempting to stop and purge them"
        for service in $services
        do 
            systemctl stop $service
            if [[ $(systemctl is-active $service) != "active" ]]; then
                echo "Stopped $service"
                rm "/etc/systemd/system/$service"
            else
                echo "Could not stop $service"
                echo "please check logs to debug"
                echo "journalctl -u $service"
                echo "Aborting install"
                exit 1
            fi
        done
    fi
    if [ -d $TISANE_INSTALL_DIR ]; then
        echo "Found existing tisane install"
        echo "Attempting to remove it" 
        rm -r $TISANE_INSTALL_DIR
        if [ $? -eq 0 ]; then
            echo "Sucessfully removed existing install."
        else
            echo "Failed to remove existing install"
            echo "failed with exit status $?."
            echo "Aborting"
            exit 1
        fi
    fi
fi
if [ ! -x "$TISANE_EXECUTABLE" ]; then
# if [ -x "$TISANE_EXECUTABLE" ]; then
    echo "Tisane binary not found at $TISANE_EXECUTABLE"
    echo "Extracting tisane to $TISANE_INSTALL_DIR"
    tar -xvzf $files -C "$USER_HOME/" | awk 'BEGIN {ORS=" "} {if(NR%325==0)print "."}'
    if [ $? -ne 0 ]; then
        echo "Could not extract the archive"
        echo "Exiting"
        exit 1
    fi
    cd "$TISANE_INSTALL_DIR"
    chmod +x $TISANE_EXECUTABLE
    echo "Tisane installed at $TISANE_EXECUTABLE"
    if [ -f "$TISANE_CONFIG" ]; then
        daemon=$(grep "^daemon" $TISANE_CONFIG | awk -F= '{print $2}')
        if [ -z "$daemon" ]; then
            echo "daemon = true" >> "$TISANE_CONFIG"
        else 
            echo "daemon mode set to $daemon"
        fi
    else
        echo "No config file found"
        exit 1
    fi
    # echo "Checking installed firewall"
    case "$firewall" in
        "firewalld")
        for port in "${ports[@]}"; do
                process=$(ss -tulpn | grep ":$port\b" | awk '{print $NF}')
                if [ -z "$process" ]; then
                    if firewall-cmd --permanent --add-port=$port/tcp | grep  -q success; then
                        firewall-cmd --reload
                        echo "opened port $port"
                        echo "Creating service files for each daemon"
                        service="tisane"_"$port"
                        cat > "/etc/systemd/system/$service.service" <<EOF
[Unit]
Description=$service

[Service]
Type=$type
ExecStart= $TISANE_EXECUTABLE -port $port
Restart=always
RestartSec=3
User=root
Group=root
WorkingDirectory=$TISANE_INSTALL_DIR/
[Install]
WantedBy=multi-user.target
EOF
                        echo "sucessfully created service file"
                        systemctl daemon-reload
                        systemctl start "$service.service"
                        systemctl enable $service
                        echo "Started tisane on port $port"
                    else
                        echo "Could not open port $port"
                        echo "Moving to next port"
                        continue
                    fi
                else
                    echo "port $port already in use"
                    echo "$process"
                    continue
                fi        
            done
            ;;
    "ufw")
        for port in "${ports[@]}"; do
            process=$(ss -tulpn | grep ":$port\b" | awk '{print $NF}')
                if [ -z "$process" ]; then
                    ufw allow "$port"/tcp
                    echo "opened port $port"
                    echo "Creatiing service files for each demon"
                    service="tisane"_"$port"
                    cat > "/etc/systemd/system/$service.service" <<EOF
[Unit]
Description=$service

[Service]
Type=$type
ExecStart= $TISANE_EXECUTABLE -port $port
Restart=always
RestartSec=3
User=root
Group=root
WorkingDirectory=$TISANE_INSTALL_DIR/
[Install]
WantedBy=multi-user.target
EOF
                    systemctl daemon-reload
                    systemctl start "$service.service"
                    systemctl enable $service
                    echo "Started tisane on port $port"
                else
                    echo "prot $port already in use"
                    echo "$process"
                    continue
                fi
            done
            ;;
    *)
        echo "Unknown firewall"
        # exit 1
        echo "Continuing the install, you will need to open the ports manually after install"
        for port in "${ports[@]}" ; do
            process=$(ss -tulpn | grep ":$port\b" | awk '{print $NF}')
            if [ -z "$process" ]; then
                echo "Creatiing service files for each demon"
                service="tisane"_"$port"
                    cat > "/etc/systemd/system/$service.service" <<EOF
[Unit]
Description=$service

[Service]
Type=$type
ExecStart= $TISANE_EXECUTABLE -port $port
Restart=always
RestartSec=3
User=root
Group=root
WorkingDirectory=$TISANE_INSTALL_DIR/
[Install]
WantedBy=multi-user.target
EOF
                systemctl daemon-reload
                systemctl start "$service.service"
                systemctl enable $service
                echo "Started tisane on port $port"
            else
                echo "port $port already in use"
                echo "$process"
                continue
            fi
        done
        ;;
    esac

else 
    echo "Tisane binary found at $TISANE_EXECUTABLE"
    echo "Updating tisane"
    if [ -z $files ]; then
        echo "Please give path to update package"
        exit 1
    else
        if [ ! -f $files ]; then
            echo "No such file $files"
            exit 1
        fi
    fi
    echo "Stopping all tisane services"
    # services=$(systemctl list-unit-files --type=service | grep tisane | awk '{print $1}')
    # systemctl stop $serivces
    for service in $services
    do 
        systemctl stop $service
        if [[ $(systemctl is-active $service) != "active" ]]; then
            echo "Stopped $service"
        else
            echo "Could not stop $service"
            echo "please check logs to debug"
            echo "journalctl -u $service"
        fi
    done

    # echo "All tisane services stopped $services"
    echo "backing up current config file as $USER_HOME/tisane.conf.backup"
    mv $TISANE_INSTALL_DIR/tisane.conf $USER_HOME/tisane.conf.backup
    echo "Extracting new files to $USER_HOME/tisane"
    tar -xvzf $files -C "$USER_HOME/" | awk 'BEGIN {ORS=" "} {if(NR%325==0)print "."}'
    chmod +x $TISANE_EXECUTABLE
    echo ""
    echo "Moving the original config file"
    mv $USER_HOME/tisane.conf.backup $TISANE_INSTALL_DIR/tisane.conf
    echo "Attempting to restart tisane services"
    # systemctl start $serivces
    for service in $services
    do 
        systemctl start $service
        if [[ $(systemctl is-active $service) == "active" ]]; then
            echo "Started $service"
        else
            echo "Could not start $service"
            echo "please check logs to debug"
            echo "journalctl -u $service"
        fi
    done
fi