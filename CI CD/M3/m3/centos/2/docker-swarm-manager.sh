#!/bin/bash

echo "* Swarm init on manager... "
docker swarm init --advertise-addr 192.168.99.101
docker swarm join-token --quiet worker > /vagrant/worker_token