#!/bin/bash

echo "* Install Additional Packages ..."
dnf install -y jq tree git nano

echo "* Adding hosts... "
echo "192.168.99.100 jenkins.do1.lab jenkins" >> /etc/hosts
echo "192.168.99.101 docker.do1.lab docker" >> /etc/hosts