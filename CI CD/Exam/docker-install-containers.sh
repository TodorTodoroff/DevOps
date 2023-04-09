#!/bin/bash

echo "* Add Docker repository"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "* Install Docker"
dnf install -y docker-ce docker-ce-cli containerd.io java-17-openjdk git

echo "* Configure metrics"
echo -e "{
  \"metrics-addr\" : \"0.0.0.0:9323\",
  \"experimental\" : true
}" > /etc/docker/daemon.json

echo "* Start Docker service"
systemctl enable --now docker

echo "* Adjust group membership"
usermod -aG docker vagrant

echo "* Init docker swarm..."
docker swarm init --advertise-addr 192.168.99.201

echo "* Adjust the firewall"
firewall-cmd --add-port 8080/tcp --permanent
firewall-cmd --add-port 80/tcp --permanent
firewall-cmd --add-port 9323/tcp --permanent
firewall-cmd --add-port 3000/tcp --permanent
firewall-cmd --reload

