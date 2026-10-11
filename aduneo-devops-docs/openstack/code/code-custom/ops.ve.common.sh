#!/bin/bash
# File:Name:ops.ve.common.sh
# File:Role:Define Var@(env,common) to Node@openstack

# define > var
export gTimestampInstall=$(date +"%Y-%m-%d-%H%M")
export gOPS_VERSION_NAME="yoga"

# File@conf
export gCHRONY_FILE_CONF_PATH="/etc/chrony/conf.d/ops.node.conf"
export gETCHOST_FILE_CONF_PATH="/etc/hosts"
export gNOVA_FILE_CONF_PATH="/etc/nova/nova.conf"

# Ip
export gNODE_CONTROLER_IP="51.77.213.243"   # o1u
export gNODE_CONTROLER_NAME="controler"

export gNODE_COMPUTE_IP="141.94.26.17"     # o2u
export gNODE_COMPUTE_NAME="compute01"

export gNODE_CLIENT_IP="92.222.22.21"       # o3u
export gNODE_CLIENT_NAME="client"

## User
export gRABBITMQ_USER_NAME="openstack"
export gNOVA_USER_OS_NAME="nova"
export gPLACEMENT_USER_OS_NAME="placement"

## Secret
export gRABBITMQ_USER_PWD="ops"
export gNOVA_USER_PWD="ops"
export gPLACEMENT_USER_PWD="ops"

