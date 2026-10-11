#!/bin/bash
# File:Name:ops.ve.common.sh
# File:Context:Define Var@env common to Node@Controler and Node@Compute

# define > var
export gNODE_CONTROLER_IP="51.210.10.195"   # o1u
export gNODE_COMPUTE_IP="51.77.213.243"     # o2u
export gNODE_CONTROLER_NAME="controler"
export gNODE_COMPUTE_NAME="compute01"

export gInternetPing="amazon.com"
export gEtcHostFilePath="/etc/hosts"
export gOPS_VERSION_NAME="yoga"

export gTimestampInstall=$(date +"%Y-%m-%d-%H%M")

# MxListFile="ops.common ops.compute ops.controler ops.ve.common ops.ve.controler ops.ve.compute"
# MxFilePath="/home/mxadm/debug/git/aduneo/aduneo-docs/openstack/code" 
# MxFolderDst="/Users/max/Documents/NotInCloud/RepoDevops/dockervol/ops" 
# MxListVm="o1u o2u o3u"
# for file in ${MxListFile}; do docker cp mxc_devops-mx:${MxFilePath}/${file}.sh ${MxFolderDst}/; done; for vm in ${MxListVm}; do scp ${MxFolderDst}/* ${vm}:/tmp; done;
# . /tmp/ops.ve.common.sh && . /tmp/ops.ve.controler.sh && /tmp/ops.common.sh && /tmp/ops.controler.sh
# . /tmp/ops.ve.common.sh && . /tmp/ops.ve.compute.sh   && /tmp/ops.common.sh && /tmp/ops.compute.sh
