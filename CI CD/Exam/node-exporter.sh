#!/bin/bash

echo "* Download and start the metric exported in background mode..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz 

tar xzvf node_exporter-1.5.0.linux-amd64.tar.gz
cd node_exporter-1.5.0.linux-amd64/
./node_exporter &> /tmp/node-exporter.log &


echo "* Add port 9100 to firewall and restart firewall service..."
sudo firewall-cmd --permanent --add-port=9100/tcp
sudo firewall-cmd --reload