#!/bin/bash
# File:Name:ops.compute.sh
# File:Role:Install cli:openstack on Node@(Openstack,Client)


# ----- Configure Dns - Node:This must communicate with Node@(Openstack, controler)
## update /etc/hosts
cat "${gETCHOST_FILE_CONF_PATH}" | grep "${gNODE_CONTROLER_NAME}" || echo "${gNODE_CONTROLER_IP} ${gNODE_CONTROLER_NAME}" | sudo tee -a "${gETCHOST_FILE_CONF_PATH}" > /dev/null


# ----- Configure chrony - Allow host to synchronize
## create file@conf
cat <<EOM | sudo tee "${gCHRONY_FILE_CONF_PATH}" > /dev/null
# host that reference time
server  ${gNODE_CONTROLER_NAME} iburst
EOM
## restart service
lListService="chrony"; sudo systemctl restart ${lListService}


# ----- Install  package@basic
lListPackage="jq tree bash-completion"; sudo apt install ${lListPackage} -y
# ---- install > cli:pip
sudo DEBIAN_FRONTEND=noninteractive apt install -y python3-pip && \
# ---- install > cli:openstack  (if not exists)
which openstack || sudo pip install python-openstackclient && \
# ---- install > cli:openstack:plugin for service:placement
pip list | grep osc-placement || pip install osc-placement
# ---- install > cli : openstack : completion (if not exists)
[ ! -f /etc/bash_completion.d/osc.bash_completion ] && openstack complete | sudo tee /etc/bash_completion.d/osc.bash_completion > /dev/null && \
## Configure cli:openstack
mkdir -p ${HOME%/}/debug/varenv
cp /var/tmp/ops.admin.rc.sh      ${HOME%/}/debug/varenv/
cp /var/tmp/ops.ve.controler.sh  ${HOME%/}/debug/varenv/
cp /var/tmp/ops.ve.common.sh     ${HOME%/}/debug/varenv/
grep "ops.ve.common.sh"      .bashrc > /dev/null || echo ". ${HOME%/}/debug/varenv/ops.ve.common.sh"     >> .bashrc
grep "ops.ve.controler.sh"   .bashrc > /dev/null || echo ". ${HOME%/}/debug/varenv/ops.ve.controler.sh"  >> .bashrc
grep "ops.admin.rc.sh"       .bashrc > /dev/null || echo ". ${HOME%/}/debug/varenv/ops.admin.rc.sh"      >> .bashrc

