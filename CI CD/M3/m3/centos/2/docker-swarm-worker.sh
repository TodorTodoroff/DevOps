#!/bin/bash

# passed agrument from vagrantfile $1 - last ip symbol
echo "* Swarm join on worker $(hostname -f)... "
echo "* args check: $1 from vagrant file ... "
docker swarm join --token $(cat /vagrant/worker_token) --advertise-addr 192.168.99.10$1 192.168.99.101:2377
