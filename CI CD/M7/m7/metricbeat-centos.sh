#!/bin/bash

echo '* Installing metricbeat on centos ...'
wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.6.2-x86_64.rpm
sudo rpm -Uvh metricbeat-8.6.2-x86_64.rpm
sudo rm -rf metricbeat*.rpm

echo '* Copy config file and restart service ...'
sudo cp /vagrant/metricbeat.yml /etc/metricbeat/
sudo metricbeat test config
sudo metricbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.99.101:9200"]'
sudo systemctl daemon-reload
sudo systemctl enable metricbeat
sudo systemctl start metricbeat

echo '* Add port 5044 and restart firewall-cmd ...'
sudo firewall-cmd --add-port 5044/tcp --permanent
sudo firewall-cmd --reload 

echo '* Create data view via API ...'
curl -XPOST http://192.168.99.101:5601/api/index_patterns/index_pattern -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'{"index_pattern": {"name":"Metricbeat","title":"metricbeat*","timeFieldName":"@timestamp"}}'