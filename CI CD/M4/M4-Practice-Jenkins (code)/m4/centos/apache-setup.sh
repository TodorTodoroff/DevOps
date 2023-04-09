#!/bin/bash

echo "* Create projects directory and change ownership to jenkins user..."
sudo mkdir -p /projects/
sudo chown -R jenkins:jenkins /projects


echo "* Install apache... "
sudo dnf install -y httpd

echo "* Start and enable apache from systemctl... "
sudo systemctl enable httpd
sudo systemctl start httpd