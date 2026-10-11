#!/bin/bash
# File:Name:ops.controler.sh
# File:Role:Install component on Node@controler

# Define Var
lNODE_IP="localhost"
lDOMAIN_NAME="default"
lPRJ_NAME="service"
lPRJ_DESC="Mx Project@ops for service like glance, neutron, ..."

# ----- Configure Dns - Node:This must communicate with Node@(Openstack, other) (e.g compute, ...)
## update /etc/hosts    
cat "${gETCHOST_FILE_CONF_PATH}" | grep "${gNODE_COMPUTE_NAME}"   || echo "${gNODE_COMPUTE_IP} ${gNODE_COMPUTE_NAME}" | sudo tee -a "${gETCHOST_FILE_CONF_PATH}" > /dev/null


# ----- Configure chrony - Allow host:time:synchronize
## create file@conf
cat <<EOM | sudo tee "${gCHRONY_FILE_CONF_PATH}" > /dev/null
# server  NTP_SERVER iburst
allow ${gNODE_COMPUTE_IP}
EOM
## restart service
lListService="chrony"; sudo systemctl restart ${lListService}



# ----- Install  Db:Mysql
##
echo -e "\nMx > install package\n"
##
lListPackage="mariadb-server python3-pymysql"; sudo apt install ${lListPackage} -y
## create file@conf
lNODE_IP="localhost"
cat <<EOM | sudo tee "${gMARIADB_FILE_CONF_PATH}" > /dev/null
[mysqld]
#bind-address = ${lNODE_IP}
bind-address = 0.0.0.0
default-storage-engine = innodb
innodb_file_per_table = on
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8
EOM
## restart service
lListService="mariadb"; sudo systemctl restart ${lListService}
## Ckeck install
### sudo mysql -e "show databases;"



# ----- Install & Configure rabbbitmq
lListPackage="rabbitmq-server"; sudo apt install ${lListPackage} -y
## enable IHM
sudo rabbitmq-plugins enable rabbitmq_management           
## add user@admin and permissions for vhost "/"
sudo rabbitmqctl list_users | grep ${gRABBITMQ_USER_NAME} || {
  sudo rabbitmqctl add_user        ${gRABBITMQ_USER_NAME} ${gRABBITMQ_USER_PWD}
  sudo rabbitmqctl set_user_tags   ${gRABBITMQ_USER_NAME} administrator
  sudo rabbitmqctl set_permissions -p / ${gRABBITMQ_USER_NAME} ".*" ".*" ".*"
}
## set 
## Ckeck install
### sudo systemctl status     rabbitmq-server
### sudo systemctl is-enabled rabbitmq-server
### sudo ss -tunelp | egrep "15672|25672"
### http://${gNODE_IP}:15672



# ----- Install & Configure memcache
lListPackage="memcached python3-memcache"; sudo apt install ${lListPackage} -y
## update file@conf
sudo sed -i "s/-l 127.0.0.1/-l ${gNODE_IP}/" ${gMEMCACHED_FILE_CONF_PATH}
## install tool to test memcached
lListPackage="libmemcached-tools"; sudo apt install ${lListPackage} -y
## restart service
lListService="memcached"; sudo systemctl restart ${lListService}
## Ckeck install
### sudo systemctl is-enabled memcached
### sudo systemctl status     memcached
### sudo ss -tunelp | grep 11211
### cat /etc/memcached.conf | egrep -v "^#|^$"
### memcstat --servers=127.0.0.1 - will not work
### memcstat --servers=${gNODE_IP}



# ----- Install & Configure etcd
lListPackage="etcd"; sudo apt install ${lListPackage} -y
## save file@conf
sudo \cp ${gETCD_FILE_CONF_PATH} ${gETCD_FILE_CONF_PATH}-${gTimestampInstall}
## use localhost
lNODE_IP="localhost"
## update file@conf
cat <<EOM | sudo tee "${gETCD_FILE_CONF_PATH}" > /dev/null
ETCD_NAME="${lNODE_IP}"
# path to directory@data 
ETCD_DATA_DIR="/var/lib/etcd"
ETCD_INITIAL_CLUSTER_STATE="new"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster-01"
ETCD_INITIAL_CLUSTER="default=http://${lNODE_IP}:2380"
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://${lNODE_IP}:2380, http://${gNODE_NAME}:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://${lNODE_IP}:2379"
ETCD_LISTEN_PEER_URLS="http://0.0.0.0:2380"
ETCD_LISTEN_CLIENT_URLS="http://${lNODE_IP}:2379"
EOM
## restart service
lListService="etcd"; sudo systemctl restart ${lListService}
## Check Install
### sudo systemctl is-enabled etcd
### sudo systemctl status     etcd
### sudo ss -tunelp | egrep "2379|2380"
### cat ${gETCD_FILE_CONF_PATH} | egrep -v "^#|^$"
### etcdctl member   list
### etcdctl cluster-health

# ----- Install  cli:openstack - needed by Component:glance,placement, compute
## Install  package@basic
lListPackage="jq tree bash-completion"; sudo apt install ${lListPackage} -y
## install > cli : pip
sudo DEBIAN_FRONTEND=noninteractive apt install -y python3-pip && \
## install > cli : openstack  (if not exists)
which openstack || sudo pip install python-openstackclient && \
# install cli:opsc:plugin for service:placement
pip list | grep osc-placement || pip install osc-placement
# ---- install > cli : openstack : completion (if not exists)
[ ! -f /etc/bash_completion.d/osc.bash_completion ] && openstack complete | sudo tee /etc/bash_completion.d/osc.bash_completion > /dev/null && \
## Configure cli:openstack
mkdir -p ${HOME%/}/debug/varenv
cp /var/tmp/ops.admin.rc.sh         ${HOME%/}/debug/varenv/
cp /var/tmp/ops.ve.controler.sh  ${HOME%/}/debug/varenv/
grep "ops.ve.controler.sh"   .bashrc > /dev/null || echo "source ${HOME%/}/debug/varenv/ops.ve.controler.sh"  >> .bashrc
grep "ops.admin.rc.sh"       .bashrc > /dev/null || echo "source ${HOME%/}/debug/varenv/ops.admin.rc.sh"      >> .bashrc
source "${HOME%/}/debug/varenv/ops.ve.controler.sh"
source "${HOME%/}/debug/varenv/ops.admin.rc.sh"




# ----- Install & Configure Keystone
##
echo -e "\nMx > create db:keystone (if not exists)\n"
##
sudo mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${gKEYSTONE_DB_NAME}";
## Grant
sudo mysql -u root -h localhost << EOF
GRANT ALL PRIVILEGES ON ${gKEYSTONE_DB_NAME}.* TO '${gKEYSTONE_DB_USER_NAME}'@'localhost' IDENTIFIED BY '${gKEYSTONE_DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${gKEYSTONE_DB_NAME}.* TO '${gKEYSTONE_DB_USER_NAME}'@'%'         IDENTIFIED BY '${gKEYSTONE_DB_USER_PWD}';
EOF
##
echo -e "\nMx > install package\n"
##
lListPackage="keystone"; sudo apt install ${lListPackage} -y
## save file@conf
sudo \cp ${gKEYSTONE_FILE_CONF_PATH} ${gKEYSTONE_FILE_CONF_PATH}-${gTimestampInstall}
## update file@conf
## section [api]
sudo sed -i "s|^connection.*|connection = mysql+pymysql://${gKEYSTONE_DB_USER_NAME}:${gKEYSTONE_DB_USER_PWD}@${lNODE_IP}/${gKEYSTONE_DB_NAME}|" ${gKEYSTONE_FILE_CONF_PATH}
## section [api]
sudo sed -i "/#memcache_server/s/^#//" ${gKEYSTONE_FILE_CONF_PATH}
## section [token]
sudo cat ${gKEYSTONE_FILE_CONF_PATH}  | grep "^provider = fernet" || sudo sed -i "s|^\[token\]|\[token\]\nprovider = fernet\n|" ${gKEYSTONE_FILE_CONF_PATH}
##
echo -e "\nMx > populate db:keystone (if needed)\n"
##
sudo touch /var/log/keystone/keystone-manage.log
sudo chown keystone.keystone /var/log/keystone/keystone-manage.log
sudo mysql -e "use keystone; select * from credential;" &> /dev/null || sudo su -s /bin/bash ${gKEYSTONE_USER_OS_NAME} -c "keystone-manage db_sync" 
##
echo -e "\nMx > initialize key@Fernet\n"
##
## TODO THIS ACTIO  TAKE TIME EVERY TIME => Check howto test this is done
sudo keystone-manage fernet_setup     --keystone-user ${gKEYSTONE_USER_OS_NAME} --keystone-group ${gKEYSTONE_USER_OS_GROUP}
sudo keystone-manage credential_setup --keystone-user ${gKEYSTONE_USER_OS_NAME} --keystone-group ${gKEYSTONE_USER_OS_GROUP}
# bootstrap service
sudo keystone-manage bootstrap \
  --bootstrap-password     ${gKEYSTONE_USER_PWD}     \
  --bootstrap-admin-url    http://${gNODE_NAME}:5000/v3/ \
  --bootstrap-internal-url http://${gNODE_NAME}:5000/v3/ \
  --bootstrap-public-url   http://${gNODE_NAME}:5000/v3/ \
  --bootstrap-region-id    RegionOne
## configure Apache
sudo cat ${gKEYSTONE_FILE_CONF_PATH}  | grep "^ServerName" || sudo sed -i "s|#ServerRoot \"/etc/apache2\"|#ServerRoot \"/etc/apache2\"\nServerName mx.srv.world|" ${gKEYSTONE_FILE_CONF_PATH}
## restart service
lListService="apache2"; sudo systemctl restart ${lListService}
## Check Install
## sudo cat  ${gKEYSTONE_FILE_CONF_PATH} | egrep "^provider|^memcache_ser|^conn.*"
## sudo mysql -e "show databases; use keystone; show tables;"
## sudo mysql -e "show databases; use keystone; show tables; desc project_endpoint;"
## sudo mysql -e "show databases; use keystone; show tables; select * from project;"




# ----- Create project@ops:service
## used by all service@ops (e.g glance, placement, compute, neutron)
openstack project show ${lPRJ_NAME} &> /dev/null || openstack project create ${lPRJ_NAME}  --domain ${lDOMAIN_NAME} --description "${lPRJ_DESC}"




# ----- Install & Configure Glance
##
echo -e "\nMx > create db:glance (if not exists)\n"
##
sudo mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${gGLANCE_DB_NAME}";
## Grant
sudo mysql -u root -h localhost << EOF
GRANT ALL PRIVILEGES ON ${gGLANCE_DB_NAME}.* TO '${gGLANCE_DB_USER_NAME}'@'localhost' IDENTIFIED BY '${gGLANCE_DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${gGLANCE_DB_NAME}.* TO '${gGLANCE_DB_USER_NAME}'@'%'         IDENTIFIED BY '${gGLANCE_DB_USER_PWD}';
EOF
## create ops:object
lUSER_NAME=${gGLANCE_USER_OS_NAME}
lUSER_PWD=${gGLANCE_USER_PWD}
lSERVICE_NAME="glance"
lSERVICE_TYPE="image"
lSERVICE_DESC="Mx Service\@${lSERVICE_TYPE} named ${lSERVICE_NAME}"
##
echo -e "\nMx > create user@ops:glance (if not exists)\n"
##
openstack user show ${lUSER_NAME} &> /dev/null   || openstack user create ${lUSER_NAME} --domain ${lDOMAIN_NAME} --password ${lUSER_PWD}
## add role:admin to user/prj
openstack role add admin --project ${lPRJ_NAME} --user ${lUSER_NAME}
##
echo -e "\nMx > create service@${lSERVICE_TYPE}:${lSERVICE_NAME} (if not exists)\n"
openstack service show ${lSERVICE_NAME} &> /dev/null  || openstack service create ${lSERVICE_TYPE} --name ${lSERVICE_NAME} --description "${lSERVICE_DESC}"
##
echo -e "\nMx > create endpoint@${lSERVICE_TYPE}:${lSERVICE_NAME} (if not exists)\n"
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface public)"   ] && openstack endpoint create ${lSERVICE_TYPE} public   http://${gNODE_NAME}:9292 --region RegionOne 
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface internal)" ] && openstack endpoint create ${lSERVICE_TYPE} internal http://${gNODE_NAME}:9292 --region RegionOne 
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface admin)"    ] && openstack endpoint create ${lSERVICE_TYPE} admin    http://${gNODE_NAME}:9292 --region RegionOne 
## Define quotas (optional)
##
echo -e "\nMx > install package\n"
##
lListPackage="glance"; sudo apt install ${lListPackage} -y
## save file@conf
sudo \cp ${gGLANCE_FILE_CONF_PATH} ${gGLANCE_FILE_CONF_PATH}-${gTimestampInstall}
## update file@conf
### section [database]
sudo sed -i "s|^connection.*|connection = mysql+pymysql://${gGLANCE_DB_USER_NAME}:${gGLANCE_DB_USER_PWD}@${lNODE_IP}/${gGLANCE_DB_NAME}|" ${gGLANCE_FILE_CONF_PATH}
### section [keystone_authtoken]
lContent=$(cat <<EOF
[keystone_authtoken] \
\nwww_authenticate_uri = http://${lNODE_IP}:5000 \
\nauth_url = http://${lNODE_IP}:5000 \
\nmemcached_servers = ${gNODE_NAME}:11211 \
\nauth_type = password \
\nproject_domain_name = Default \
\nuser_domain_name = Default \
\nproject_name = ${lPRJ_NAME} \
\nusername = ${gGLANCE_USER_OS_NAME} \
\npassword = ${gGLANCE_USER_PWD}
EOF
)
sudo cat ${gGLANCE_FILE_CONF_PATH} | grep "^www_authenticate_uri" || sudo sudo sed  -i "s|^\[keystone_authtoken\]|${lContent}|" ${gGLANCE_FILE_CONF_PATH}
### section [glance_store]
lContent=$(cat <<EOF
\n[glance_store] \
\nstores = file,http \
\ndefault_store = file \
\nfilesystem_store_datadir = /var/lib/glance/images/
EOF
)
sudo cat ${gGLANCE_FILE_CONF_PATH} | grep "^stores = file" || sudo sudo sed  -i "s|^\[glance_store\]|${lContent}|" ${gGLANCE_FILE_CONF_PATH}
##
echo -e "\nMx > populate db:glance (if needed)\n"
##
sudo mysql -e "use glance; select * from images;" &> /dev/null || sudo su -s /bin/bash ${gGLANCE_USER_OS_NAME} -c "glance-manage db_sync" 
## restart service
lListService="glance-api"; sudo systemctl restart ${lListService}
## check
### egrep -nv "^#|^$" ${gGLANCE_FILE_CONF_PATH}
### openstack role list
### openstack user list
### openstack project list
### openstack role assignment list --user ${lUSER_NAME} --project ${lPRJ_NAME} --names
### sudo mysql -e "use glance; show tables"



# ----- Install & Configure Placement
##
echo -e "\nMx > create db:placement (if not exists)\n"
##
sudo mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${gPLACEMENT_DB_NAME}";
## Grant
sudo mysql -u root -h localhost << EOF
GRANT ALL PRIVILEGES ON ${gPLACEMENT_DB_NAME}.* TO '${gPLACEMENT_DB_USER_NAME}'@'localhost' IDENTIFIED BY '${gPLACEMENT_DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${gPLACEMENT_DB_NAME}.* TO '${gPLACEMENT_DB_USER_NAME}'@'%'         IDENTIFIED BY '${gPLACEMENT_DB_USER_PWD}';
EOF
## create ops:object
lUSER_NAME=${gPLACEMENT_USER_OS_NAME}
lUSER_PWD=${gPLACEMENT_USER_PWD}
lSERVICE_NAME="placement"
lSERVICE_TYPE="placement"
lSERVICE_DESC="Mx Service\@${lSERVICE_TYPE} named ${lSERVICE_NAME}"
##
echo -e "\nMx > create user@ops:placement (if not exists)\n"
##
openstack user show ${lUSER_NAME} &> /dev/null   || openstack user create ${lUSER_NAME} --domain ${lDOMAIN_NAME} --password ${lUSER_PWD}
## add role:admin to user/prj
openstack role add admin --project ${lPRJ_NAME} --user ${lUSER_NAME}
##
echo -e "\nMx > create service@${lSERVICE_TYPE}:${lSERVICE_NAME} (if not exists)\n"
openstack service show ${lSERVICE_NAME} &> /dev/null  || openstack service create ${lSERVICE_TYPE} --name ${lSERVICE_NAME} --description "${lSERVICE_DESC}"
##
echo -e "\nMx > create endpoint@${lSERVICE_TYPE}:${lSERVICE_NAME} (if not exists)\n"
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface public)"   ] && openstack endpoint create ${lSERVICE_TYPE} public   http://${gNODE_NAME}:8778 --region RegionOne 
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface internal)" ] && openstack endpoint create ${lSERVICE_TYPE} internal http://${gNODE_NAME}:8778 --region RegionOne 
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface admin)"    ] && openstack endpoint create ${lSERVICE_TYPE} admin    http://${gNODE_NAME}:8778 --region RegionOne 
##
echo -e "\nMx > install package\n"
##
lListPackage="placement-api"; sudo apt install ${lListPackage} -y
## save file@conf
sudo \cp ${gPLACEMENT_FILE_CONF_PATH} ${gPLACEMENT_FILE_CONF_PATH}-${gTimestampInstall}
## update file@conf
### section [api]
sudo cat ${gPLACEMENT_FILE_CONF_PATH} | grep "^auth_strategy"  || sudo sudo sed  -i "s|^\[api\]|\[api\]\nauth_strategy = keystone|" ${gPLACEMENT_FILE_CONF_PATH}
### section [database]
sudo sed -i "s|^connection.*|connection = mysql+pymysql://${gPLACEMENT_DB_USER_NAME}:${gPLACEMENT_DB_USER_PWD}@${lNODE_IP}/${gPLACEMENT_DB_NAME}|" ${gPLACEMENT_FILE_CONF_PATH}
### section [keystone_authtoken]
lContent=$(cat <<EOF
[keystone_authtoken] \
\nauth_url = http://${lNODE_IP}:5000/v3 \
\nmemcached_servers = ${gNODE_NAME}:11211 \
\nauth_type = password \
\nproject_domain_name = Default \
\nuser_domain_name = Default \
\nproject_name = ${lPRJ_NAME} \
\nusername = ${gPLACEMENT_USER_OS_NAME} \
\npassword = ${gPLACEMENT_USER_PWD}
EOF
)
sudo cat ${gPLACEMENT_FILE_CONF_PATH} | grep "^auth_url" || sudo sudo sed  -i "s|^\[keystone_authtoken\]|${lContent}|" ${gPLACEMENT_FILE_CONF_PATH}
##
echo -e "\nMx > populate db:placement (if not exists)\n"
##
sudo mysql -e "use placement; select * from projects;" &> /dev/null || sudo su -s /bin/bash ${gPLACEMENT_USER_OS_NAME} -c "placement-manage db sync" 
## restart service
lListService="apache2"; sudo systemctl restart ${lListService}
# Check
## sudo placement-status upgrade check





# ----- Install & Configure Compute (part on Controler)
##
echo -e "\nMx > create db:compute (if not exists)\n"
##
sudo mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${gNOVA_DB_NAME}";
sudo mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${gNOVA_API_DB_NAME}";
sudo mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${gNOVA_CELL_DB_NAME}";
## Grant
sudo mysql -u root -h localhost << EOF
GRANT ALL PRIVILEGES ON ${gNOVA_DB_NAME}.* TO '${gNOVA_DB_USER_NAME}'@'localhost' IDENTIFIED BY '${gNOVA_DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${gNOVA_DB_NAME}.* TO '${gNOVA_DB_USER_NAME}'@'%'         IDENTIFIED BY '${gNOVA_DB_USER_PWD}';
EOF
sudo mysql -u root -h localhost << EOF
GRANT ALL PRIVILEGES ON ${gNOVA_API_DB_NAME}.* TO '${gNOVA_DB_USER_NAME}'@'localhost' IDENTIFIED BY '${gNOVA_DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${gNOVA_API_DB_NAME}.* TO '${gNOVA_DB_USER_NAME}'@'%'         IDENTIFIED BY '${gNOVA_DB_USER_PWD}';
EOF
sudo mysql -u root -h localhost << EOF
GRANT ALL PRIVILEGES ON ${gNOVA_CELL_DB_NAME}.* TO '${gNOVA_DB_USER_NAME}'@'localhost' IDENTIFIED BY '${gNOVA_DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${gNOVA_CELL_DB_NAME}.* TO '${gNOVA_DB_USER_NAME}'@'%'         IDENTIFIED BY '${gNOVA_DB_USER_PWD}';
EOF
## create ops:object
lUSER_NAME=${gNOVA_USER_OS_NAME}
lUSER_PWD=${gNOVA_USER_PWD}
lSERVICE_NAME="nova"
lSERVICE_TYPE="compute"
lSERVICE_DESC="Mx Service\@${lSERVICE_TYPE} named ${lSERVICE_NAME}"
##
echo -e "\nMx > create user@ops:nova (if not exists)\n"
##
openstack user show ${lUSER_NAME} &> /dev/null   || openstack user create ${lUSER_NAME} --domain ${lDOMAIN_NAME} --password ${lUSER_PWD}
## add role:admin to user/prj
openstack role add admin --project ${lPRJ_NAME} --user ${lUSER_NAME}
##
echo -e "\nMx > create service@${lSERVICE_TYPE}:${lSERVICE_NAME} (if not exists)\n"
openstack service show ${lSERVICE_NAME} &> /dev/null  || openstack service create ${lSERVICE_TYPE} --name ${lSERVICE_NAME} --description "${lSERVICE_DESC}"
##
echo -e "\nMx > create endpoint@${lSERVICE_TYPE}:${lSERVICE_NAME} (if not exists)\n"
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface public)"   ] && openstack endpoint create ${lSERVICE_TYPE} public   http://${gNODE_NAME}:8774/v2.1 --region RegionOne 
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface internal)" ] && openstack endpoint create ${lSERVICE_TYPE} internal http://${gNODE_NAME}:8774/v2.1 --region RegionOne 
[ -z "$(openstack endpoint list --service ${lSERVICE_NAME} --interface admin)"    ] && openstack endpoint create ${lSERVICE_TYPE} admin    http://${gNODE_NAME}:8774/v2.1 --region RegionOne 
##
echo -e "\nMx > install package\n"
##
lListPackage="nova-api nova-conductor nova-novncproxy nova-scheduler"; sudo apt install ${lListPackage} -y
## save file@conf
sudo \cp ${gNOVA_FILE_CONF_PATH} ${gNOVA_FILE_CONF_PATH}-${gTimestampInstall}
## update file@conf
### section [neutron]
####### TODO this section (cf. install of neutron)
### section [api_database]
sudo sed -i "/nova_api.sqlite/s|^connection.*|connection = mysql+pymysql://${gNOVA_DB_USER_NAME}:${gNOVA_DB_USER_PWD}@${lNODE_IP}/${gNOVA_API_DB_NAME}|" ${gNOVA_FILE_CONF_PATH}
### section [database]
sudo sed -i "/nova.sqlite/s|^connection.*|connection = mysql+pymysql://${gNOVA_DB_USER_NAME}:${gNOVA_DB_USER_PWD}@${lNODE_IP}/${gNOVA_DB_NAME}|" ${gNOVA_FILE_CONF_PATH}
### section [DEFAULT]
sudo sed -i "/^log_dir/d" ${gNOVA_FILE_CONF_PATH}
sudo cat ${gNOVA_FILE_CONF_PATH}  | grep "^my_ip"         || sudo sed -i "s|^\[DEFAULT\]|\[DEFAULT\]\nmy_ip = ${lNODE_IP}|" ${gNOVA_FILE_CONF_PATH}
sudo cat ${gNOVA_FILE_CONF_PATH}  | grep "^transport_url" || sudo sed -i "s|^\[DEFAULT\]|\[DEFAULT\]\ntransport_url = rabbit://${gRABBITMQ_USER_NAME}:${gRABBITMQ_USER_PWD}@${gNODE_NAME}:15672/|" ${gNOVA_FILE_CONF_PATH}
### section [api]
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^auth_strategy"  || sudo sudo sed  -i "s|^\[api\]|\[api\]\nauth_strategy = keystone|" ${gNOVA_FILE_CONF_PATH}
### section [glance]
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^api_servers"    || sudo sudo sed  -i "s|^\[glance\]|\[glance\]\napi_servers = http://${lNODE_IP}:9292|" ${gNOVA_FILE_CONF_PATH}
### section [oslo_concurrency]
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^lock_path"      || sudo sudo sed  -i "s|^\[oslo_concurrency\]|\[oslo_concurrency\]\nlock_path = /var/lib/nova/tmp|" ${gNOVA_FILE_CONF_PATH}
### section [keystone_authtoken]
lContent=$(cat <<EOF
[keystone_authtoken] \
\nwww_authenticate_uri = http://${lNODE_IP}:5000/ \
\nauth_url = http://${lNODE_IP}:5000/ \
\nmemcached_servers = ${gNODE_NAME}:11211 \
\nauth_type = password \
\nproject_domain_name = Default \
\nuser_domain_name = Default \
\nproject_name = ${lPRJ_NAME} \
\nusername = ${gNOVA_USER_OS_NAME} \
\npassword = ${gNOVA_USER_PWD}
EOF
)
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^www_authenticate_uri" || sudo sudo sed  -i "s|^\[keystone_authtoken\]|${lContent}|" ${gNOVA_FILE_CONF_PATH}
### section [vnc]
lContent=$(cat <<EOF
[vnc] \
\nenabled = true \
\nserver_listen = \$my_ip \
\nserver_proxyclient_address = \$my_ip
EOF
)
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^server_proxyclient_address" || sudo sudo sed  -i "s|^\[vnc\]|${lContent}|" ${gNOVA_FILE_CONF_PATH}
### section [placement]
lContent=$(cat <<EOF
[placement] \
\nregion_name = RegionOne \
\nproject_domain_name = Default \
\nproject_name = ${lPRJ_NAME} \
\nauth_type = password \
\nuser_domain_name = Default \
\nauth_url = http://${lNODE_IP}:5000/v3 \
\nusername = ${gPLACEMENT_USER_OS_NAME} \
\npassword = ${gPLACEMENT_USER_PWD}
EOF
)
sudo cat ${gNOVA_FILE_CONF_PATH} | grep "^username = ${gPLACEMENT_USER_OS_NAME}" || sudo sudo sed  -i "s|^\[placement\]|${lContent}|" ${gNOVA_FILE_CONF_PATH}
##
echo -e "\nMx > populate db:compute (if needed)\n"
##
sudo mysql -e "use nova_api; select * from allocations;" &> /dev/null || sudo su -s /bin/bash ${gNOVA_USER_OS_NAME} -c "nova-manage api_db sync" 
# register cell
####sudo mysql -e "use nova_cell0;" &> /dev/null || sudo su -s /bin/bash ${gNOVA_USER_OS_NAME} -c "nova-manage cell_v2 map_cell0" 
sudo su -s /bin/bash ${gNOVA_USER_OS_NAME} -c "nova-manage cell_v2 map_cell0" 
## create cell:cell1
sudo su -s /bin/bash ${gNOVA_USER_OS_NAME} -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" 
## populate db nova
sudo mysql -e "use nova; select * from allocations;" &> /dev/null || sudo su -s /bin/bash ${gNOVA_USER_OS_NAME} -c "nova-manage db sync" 
# ## restart service
lListService="nova-api nova-scheduler nova-conductor nova-novncproxy"; sudo systemctl restart ${lListService}
# Check
## sudo su -s /bin/sh nova -c "nova-manage cell_v2 list_cells"
## 


