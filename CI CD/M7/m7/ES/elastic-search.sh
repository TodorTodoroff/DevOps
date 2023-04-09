#!/bin/bash


echo "* Download and install elasticsearch... "
sudo update-crypto-policies --set LEGACY
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo cp /vagrant/ES/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo 
sudo dnf install -y --enablerepo=elasticsearch elasticsearch > /vagrant/ES/install-output.txt

echo "* Copy and replace ES config file..."
sudo cp /vagrant/ES/elasticsearch.yml /etc/elasticsearch/

echo "* Copy ES JVM config file..."
sudo cp /vagrant/ES/jvm.options /etc/elasticsearch/jvm.options.d/

echo "* Restart and enable deamon and ES service"
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

echo "* Export elastic password to a variable... "
export PASSWORD="$(grep -oP '(?<=is\s:\s)\S+' /vagrant/ES/install-output.txt)"

echo "* Point the command to the certificate... "
sudo curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$PASSWORD https://localhost:9200

echo "* Add port 9200 to Firewall and restart firewall-cmd... "
sudo firewall-cmd --add-port 9200/tcp --permanent
sudo firewall-cmd --reload