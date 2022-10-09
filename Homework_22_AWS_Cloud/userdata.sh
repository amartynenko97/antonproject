#!/bin/bash
sudo su
yum update -y
yum install httpd -y
aws s3 cp s3://antoha.storage/index1.html /var/www/html/index.html
systemctl enable httpd
systemctl start httpd