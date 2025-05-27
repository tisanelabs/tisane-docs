#!/bin/bash

# Get the names of all services that contain the string "tisane"
services=$(systemctl list-unit-files --type=service | grep tisane | awk '{print $1}')

echo "All tisane services"
echo "$services"
systemctl start $services
echo "Started all tisane services"