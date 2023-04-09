#!/bin/bash


echo "* Download and install logstash... "
sudo dnf install -y --enablerepo=elasticsearch logstash

echo "* Change JVM settings... "
sudo sed -i 's/-Xms1g/-Xms512m/g' /etc/logstash/jvm.options
sudo sed -i 's/-Xmx1g/-Xmx512m/g' /etc/logstash/jvm.options

echo "* Restart service... "
sudo systemctl daemon-reload
sudo systemctl enable logstash
sudo systemctl start logstash

echo "* Add port 5044 to firewall-cmd and restart... "
sudo firewall-cmd --add-port 5044/tcp --permanent
sudo firewall-cmd --reload 


echo "* Copy config file /etc/logstash/conf.d/beats.conf... "
sudo cp /vagrant/beats.conf /etc/logstash/conf.d/

echo "* Restart logstash service... "
sudo systemctl restart logstash
sudo systemctl daemon-reload