#!/bin/bash

# Get the names of all services that contain the string "tisane"
services=$(systemctl list-unit-files --type=service | grep tisane | awk '{print $1}')

echo "All tisane services"
echo "$services"
# stop all tisane services
systemctl stop $services
echo "Stopped all tisane services"
# for service in $services
# do
#   echo $service
#   systemctl stop $service
# done

# start all tisane services
# systemctl start $services
# for service in $services
# do
#   systemctl start $service
# done
