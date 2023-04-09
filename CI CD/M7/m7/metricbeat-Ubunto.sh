#!/bin/bash

echo '* Installing metricbeat on ubuntu ...'
wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.6.2-amd64.deb
sudo dpkg -i metricbeat-8.6.2-amd64.deb
sudo rm -rf metricbeat-8.6.2-amd64.deb

echo '* Copy metricbeat.yml ...'
sudo cp /vagrant/metricbeat.yml /etc/metricbeat/
sudo metricbeat test config
sudo systemctl daemon-reload
sudo systemctl enable metricbeat
sudo systemctl start metricbeat
