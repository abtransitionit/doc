#!/bin/bash
# File:Name:admin-openrc.sh
# File:Role:file@conf for cli:openstack

export OS_USERNAME=admin
export OS_PASSWORD=${gKEYSTONE_USER_PWD}
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://${gNODE_NAME}:5000/v3
export OS_IDENTITY_API_VERSION=3

# ###########    


# sudo mysql -e "show databases; use keystone; show tables; select * from project;"
# sudo mysql -e "show databases; use keystone; show tables; select * from endpoint;"
