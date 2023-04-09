#!/bin/bash


echo "* Download and install kibana... "
sudo dnf install -y --enablerepo=elasticsearch kibana

echo "* Configure and restart service... "
sudo cp /vagrant/KI/kibana.yml /etc/kibana/
sudo systemctl daemon-reload
sudo systemctl enable kibana
sudo systemctl start kibana

echo "* Configure and restart firewall-cmd for port 5601... "
sudo firewall-cmd --add-port 5601/tcp --permanent
sudo firewall-cmd --reload