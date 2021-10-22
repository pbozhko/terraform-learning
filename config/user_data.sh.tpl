#!/bin/bash
yum -y update
yum -y install httpd
...
sudo service httpd start

echo "${f_name}"
%{for x in names ~}
echo "Hello, ${x}"
%{endfor ~}
