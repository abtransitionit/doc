#!/bin/bash
# File:Name:ops.ve.controler.sh
# File:Role:Define Var@env for Node@(Openstack, controler)

# define > var
export gNODE_IP="${gNODE_CONTROLER_IP}"
export gNODE_NAME="${gNODE_CONTROLER_NAME}"

## File@Conf
export gMARIADB_FILE_CONF_PATH="/etc/mysql/mariadb.conf.d/99-ops.cnf"
export gMEMCACHED_FILE_CONF_PATH="/etc/memcached.conf"
export gETCD_FILE_CONF_PATH="/etc/default/etcd"
export gKEYSTONE_FILE_CONF_PATH="/etc/keystone/keystone.conf"
export gKEYSTONE_APACHE_FILE_CONF_PATH="/etc/apache2/conf-enabled/ops-httpd.conf"
export gGLANCE_FILE_CONF_PATH="/etc/glance/glance-api.conf"
export gPLACEMENT_FILE_CONF_PATH="/etc/placement/placement.conf"
# export gNOVA_FILE_CONF_PATH="/etc/nova/nova.conf"

## Usernanme
### keystone
export gKEYSTONE_DB_NAME="keystone"
export gKEYSTONE_DB_USER_NAME="keystone"
export gKEYSTONE_USER_OS_NAME="keystone"
export gKEYSTONE_USER_OS_GROUP="keystone"
### glance
export gGLANCE_DB_NAME="glance"
export gGLANCE_DB_USER_NAME="glance"
export gGLANCE_USER_OS_NAME="glance"
### placement
export gPLACEMENT_DB_NAME="placement"
export gPLACEMENT_DB_USER_NAME="placement"
### compute
export gNOVA_DB_NAME="nova"
export gNOVA_API_DB_NAME="nova_api"
export gNOVA_CELL_DB_NAME="nova_cell0"
export gNOVA_DB_USER_NAME="nova"

## Secret
### keystone
export gKEYSTONE_USER_PWD="ops"
export gKEYSTONE_DB_USER_PWD="ops"
### glance
export gGLANCE_USER_PWD="ops"
export gGLANCE_DB_USER_PWD="ops"
### placement
export gPLACEMENT_DB_USER_PWD="ops"
### compute
export gNOVA_DB_USER_PWD="ops"
