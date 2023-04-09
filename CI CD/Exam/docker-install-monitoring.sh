#!/bin/bash

echo "* Add Docker repository"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "* Install Docker"
dnf install -y docker-ce docker-ce-cli containerd.io java-17-openjdk git

echo "* Start Docker service"
systemctl enable --now docker

echo "* Adjust group membership"
usermod -aG docker vagrant

echo "* Adjust the firewall"
firewall-cmd --add-port 9090/tcp --permanent
firewall-cmd --add-port 3000/tcp --permanent
firewall-cmd --reload



