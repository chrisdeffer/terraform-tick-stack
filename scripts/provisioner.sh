#!/bin/bash

# Try and wait until this server is up in aws ..
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done


myhost=`hostname`

# All hosts get docker
curl -fsSL https://test.docker.com/ | sh

# All hosts get Tick stack repo set up
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt-get update
sudo mkdir -p /var/log/telegraf
sudo touch /var/log/telegraf/telegraf.log
sudo chmod 777 /var/log/telegraf/telegraf.log


# All hosts get telegraf
sudo apt-get install telegraf
sudo service telegraf stop
sudo usermod -aG docker telegraf



# set up chronograf
host2() {
  echo "[INSTALL-LOG] setting up chronograf"
  sudo apt-get install chronograf
}
# set up influxdb
host3() {
  echo "[INSTALL-LOG] setting up influxdb"
  sudo apt-get install influxdb
  sudo service influxdb start
  sudo apt-get -y install kapacitor
  sudo service kapacitor start
  sudo apt-get install apache2 -y
  # Get private ip
  priv_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
  # set up master
  sudo docker swarm init --listen-addr ${priv_ip}:2377
  sudo docker swarm join-token worker -q >> /tmp/tmp.txt
  sudo tr -d '[[:space:]]' < /tmp/tmp.txt > /tmp/token.txt
  sudo chmod 777 /tmp/token.txt
  mytoken=$(cat /tmp/token.txt)
  sudo chmod 777 /var/www/html/index.html
  echo $mytoken > /var/www/html/index.html

}

case $myhost in
     swarm-master)
          host1
          ;;
     chrono)
          host2
          ;;
     influx)
          host3
          ;;
     *)
          echo "Hmm, seems i've never used it."
          ;;
esac

