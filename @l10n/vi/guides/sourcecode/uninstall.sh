#!/bin/bash
USER_HOME=$(eval echo ~${SUDO_USER})
TISANE_INSTALL_DIR="$USER_HOME/tisane"
TISANE_EXECUTABLE="$TISANE_INSTALL_DIR/tisane"
TISANE_CONFIG="$TISANE_INSTALL_DIR/tisane.conf"
services=$(systemctl list-unit-files --type=service | grep tisane | awk '{print $1}')

if [ -z "$services" ]; then 
    echo "No Tisane services running"
    echo "Continuing with the uninstall"
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
else
    echo "Could not find tisane installation at"
    echo "$TISANE_INSTALL_DIR"
fi