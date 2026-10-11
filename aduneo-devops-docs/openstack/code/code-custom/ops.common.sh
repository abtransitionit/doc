#!/bin/bash
# File:Name:ops.common.sh
# Prerequisit: os:package are update and upgrade to version:latest
# File:Role:define action common to Node@openstack

# ----- update Host:name 
sudo hostnamectl set-hostname ${gNODE_NAME}
cat "${gETCHOST_FILE_CONF_PATH}" | grep "${gNODE_NAME}"           || echo "${gNODE_IP} ${gNODE_NAME}"                 | sudo tee -a "${gETCHOST_FILE_CONF_PATH}" > /dev/null

# ----- install Package
lListPackage="software-properties-common chrony"; sudo apt install ${lListPackage} -y
