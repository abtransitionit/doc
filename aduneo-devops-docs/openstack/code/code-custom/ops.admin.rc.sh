#!/bin/bash
# File:Name:ops.ve.compute.sh (cf. File:Name:admin-openrc.sh)
# File:Role:Define Var@env for Node@(Openstack, compute)
# File:Role:file@conf for cli:openstack


## value@(ops, hardcoded) needed by cli:openstack
## can be put in file admin-openrc.sh
## varenv@(cli:opsc)
export OS_USERNAME=admin
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://${gNODE_CONTROLER_NAME}:5000/v3
export OS_IDENTITY_API_VERSION=3

# varenv@(Secret,cli:opsc)
export OS_PASSWORD=${gKEYSTONE_USER_PWD}

