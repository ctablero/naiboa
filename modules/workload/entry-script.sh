#!/bin/bash
sudo yum update -y && sudo yum install docker -y
sudo systemctl start docker
sudo usermod -aG docker ec2-user
docker container run -d --restart always -p 8080:80 --name videogames-api-gw nginx:alpine
