#!/bin/bash

echo "* Download Jenkins repository information..."
sudo wget https://pkg.jenkins.io/redhat/jenkins.repo -O /etc/yum.repos.d/jenkins.repo

echo "* Import Jenkins repository key..."
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

echo "* Refresh repo information..."
sudo dnf makecache

echo "* Install Jenkins..."
sudo dnf install -y jenkins

echo "* Install Java 17..."
sudo dnf install -y java-17-openjdk


echo "* Start and enable jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "* Add port 8080 and 80 /tcp to firewall and restart firewall service..."
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --reload


sudo echo "jenkins ALL=(ALL)    NOPASSWD: ALL" >> /etc/sudoers
sudo usermod -s /bin/bash jenkins
sudo systemctl restart jenkins
# Bad practice...
echo "jenkins:Password1" | sudo chpasswd


