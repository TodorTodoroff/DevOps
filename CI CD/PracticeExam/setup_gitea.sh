#!/bin/bash

# Start Gitea
docker compose -f /vagrant/gitea/docker-compose.yml up -d

# Wait until ready
while true; do 
  echo 'Trying to connect to http://192.168.99.202:3000 ...'; 
  if [ $(curl -s -o /dev/null -w "%{http_code}" http://192.168.99.202:3000) == "200" ]; then 
    echo '... connected - OK.'; 
    break; 
  else 
    echo '... no success. Sleep for 5s and retry.'; 
    sleep 5; 
  fi 
done


