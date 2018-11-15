#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
# This script doesn't work if you created it in visual studio code. TO get it working, make sure it is compatible with linux!!!!
#apt-get update
# install curl
apt-get -y install wget
apt-get -y install curl

# Install influxdb/kapacitor
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt-get update && sudo apt-get install influxdb
sudo service influxdb start
sudo apt-get -y install kapacitor
sudo service kapacitor start