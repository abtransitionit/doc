#!/bin/bash
# File:Name:ops.compute.sh
# File:Role:Install component on Node@Compute

# Define Var
lNODE_IP="localhost"
lPRJ_NAME="service"

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



# ----- Install & Configure Compute
##
echo -e "\nMx > install package\n"
##
lListPackage="nova-compute"; sudo apt install ${lListPackage} -y
## save file@conf
sudo \cp ${gNOVA_FILE_CONF_PATH} ${gNOVA_FILE_CONF_PATH}-${gTimestampInstall}
## update file@conf
### section [neutron]
####### TODO this section (cf. install of neutron)
### section [DEFAULT]
#sudo sed -i "/^log_dir/d" ${gNOVA_FILE_CONF_PATH}
sudo cat ${gNOVA_FILE_CONF_PATH}  | grep "^my_ip"         || sudo sed -i "s|^\[DEFAULT\]|\[DEFAULT\]\nmy_ip = ${lNODE_IP}|" ${gNOVA_FILE_CONF_PATH}
sudo cat ${gNOVA_FILE_CONF_PATH}  | grep "^transport_url" || sudo sed -i "s|^\[DEFAULT\]|\[DEFAULT\]\ntransport_url = rabbit://${gRABBITMQ_USER_NAME}:${gRABBITMQ_USER_PWD}@${gNODE_CONTROLER_NAME}:15672/|" ${gNOVA_FILE_CONF_PATH}
### section [api]
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^auth_strategy"  || sudo sudo sed  -i "s|^\[api\]|\[api\]\nauth_strategy = keystone|" ${gNOVA_FILE_CONF_PATH}
### section [glance]
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^api_servers"    || sudo sudo sed  -i "s|^\[glance\]|\[glance\]\napi_servers = http://${gNODE_CONTROLER_NAME}:9292|" ${gNOVA_FILE_CONF_PATH}
### section [keystone_authtoken]
lContent=$(cat <<EOF
[keystone_authtoken] \
\nwww_authenticate_uri = http://${gNODE_CONTROLER_NAME}:5000/ \
\nauth_url = http://${gNODE_CONTROLER_NAME}:5000/ \
\nmemcached_servers = ${gNODE_CONTROLER_NAME}:11211 \
\nauth_type = password \
\nproject_domain_name = Default \
\nuser_domain_name = Default \
\nproject_name = ${lPRJ_NAME} \
\nusername = ${gNOVA_USER_OS_NAME} \
\npassword = ${gNOVA_USER_PWD}
EOF
)
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^www_authenticate_uri" || sudo sudo sed  -i "s|^\[keystone_authtoken\]|${lContent}|" ${gNOVA_FILE_CONF_PATH}
### section [libvirt] - possible value = libvirt
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^virt_type"  || sudo sudo sed  -i "s|^\[libvirt\]|\[libvirt\]\nvirt_type = qemu|" ${gNOVA_FILE_CONF_PATH}
### section [oslo_concurrency]
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "\/var\/lib\/nova/\tmp"      || sudo sudo sed  -i "s|^\[oslo_concurrency\]|\[oslo_concurrency\]\nlock_path = /var/lib/nova/tmp|" ${gNOVA_FILE_CONF_PATH}
### section [placement]
lContent=$(cat <<EOF
[placement] \
\nregion_name = RegionOne \
\nproject_domain_name = Default \
\nproject_name = ${lPRJ_NAME} \
\nauth_type = password \
\nuser_domain_name = Default \
\nauth_url = http://${gNODE_CONTROLER_NAME}:5000/v3 \
\nusername = ${gPLACEMENT_USER_OS_NAME} \
\npassword = ${gPLACEMENT_USER_PWD}
EOF
)
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^username = ${gPLACEMENT_USER_OS_NAME}" || sudo sudo sed  -i "s|^\[placement\]|${lContent}|" ${gNOVA_FILE_CONF_PATH}
### section [vnc]
lContent=$(cat <<EOF
[vnc] \
\nenabled = true \
\nserver_listen = 0.0.0.0 \
\nserver_proxyclient_address = \$my_ip \
\nnovncproxy_base_url = http://${gNODE_CONTROLER_NAME}:6080/vnc_auto.html
EOF
)
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^server_proxyclient_address" || sudo sudo sed  -i "s|^\[vnc\]|${lContent}|" ${gNOVA_FILE_CONF_PATH}
## restart service
lListService="nova-compute"; sudo systemctl restart ${lListService}
## Check Install
### sudo systemctl is-enabled nova-compute
