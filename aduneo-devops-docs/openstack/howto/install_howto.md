# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Install

[//]: # (Reference)
[Topic_Whatis]:    ../README.md
[Howto_List]:    ../list/howto_list.md
[Install_Dashboard_howto]:      https://docs.openstack.org/horizon/yoga/install/index.html
[Install_Horizon_Plugin_howto]: https://docs.openstack.org/horizon/yoga/install/plugin-registry.html
[Configure_Dashboard_howto]:    https://docs.openstack.org/horizon/yoga/admin/
[Install_Keystone_howto]:       https://docs.openstack.org/keystone/latest/install/index.html
[Component_Whatis]:             ../whatis/component_whatis.md
[Kolla_Whatis]:                ../whatis/devstack_whatis.md
[Devstack_Whatis]:             ../whatis/kolla_whatis.md
[tripleo_Whatis]:              ../whatis/tripleo_whatis.md
[install_Whatis]:              ../whatis/install_whatis.md
[Bastion_Whatis]:              ./install_howto.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Install|[Whatis][Install_Whatis]|
|Component|[Whatis][Component_Whatis]|
|Devstack|[Whatis][Devstack_Whatis]|
|Kolla|[Whatis][Kolla_Whatis]|
|TripleO|[Whatis][Tripleo_Whatis]|
|Bastion|[Whatis][Bastion_Whatis]|
<br>


# Install OpenStack on Vm

## Prérequisite
- create gitlab:image@docker:**devops** (for openstack)

## Create Vm

- Créer 4 Vms dans 1 cloud (e.g vmware, aws, ovh)
- attribuer arbitrairement, 1 triplet {Ip, Role, Name} à chaque Vm

|Id|Ip|Role|Name SshConfig|Tag|
|-|-|-|-|-|
|Vm1|51.210.10.195|Node@(ops, Bastion)|Bastion|o1u
|Vm2|51.77.213.243|Node@(ops, Controler)|Controler|o2u
|Vm3|92.222.22.21|Node@(ops, Client)|Client|o3u
|Vm4|141.94.26.17|Node@(ops, Compute)|Compute|o4u
<br>

## Ckeck
 - ssh vm:all as user@sudo

## Bootstrap Bastion (e.g ubuntu 22.04)

```bash
lHostRemoteName="o1u"
lHostRemoteName="ovh2"
lListPackage="tree docker.io docker-compose"
lSecretFolderRoot="/Users/max/Documents/NotInCloud/RepoDevops/secret"
lLogPathName="/tmp/opsbastion.log"
lLogPathName="/tmp/${lHostRemoteName}.log"
# Upgrade Os
nohup ssh ${lHostRemoteName} "sudo apt update -y && sudo apt upgrade -y && sudo reboot"  > ${lLogPathName} &

# Chek upgrade - value must be 35
ssh o1u "uname -a | cut -d' ' -f3 | cut -d'-' -f2"

# Install package - ubuntu denote user@sudo on remote²x<>
nohup ssh ${lHostRemoteName} "sudo apt install ${lListPackage} -y && sudo usermod -aG docker ubuntu && sudo reboot" > /${lLogPathName} &

# Create folder:secret
nohup ssh ${lHostRemoteName} "mkdir secret"

# add folder@Secret to Vm
scp -r ${lSecretFolderRoot}/keyssh ${lHostRemoteName}:secret/
scp -r ${lSecretFolderRoot}/git    ${lHostRemoteName}:secret/

# scp following file to Bastion:/var/tmp
- git.lib.sh
- var.env.git.sh
```
## Configure Bastion
```bash
ssh ${lHostRemoteName}
# source env
export DF_SECRET_GIT="git/var.env.secret.git.sh"
source /var/tmp/var.env.git.sh
source /var/tmp/git.lib.sh

# Get repo@git:dinum-docker that contains image@docker:devops
mx-git-repo-clone aduneo dinum-docker
# TODO AUTO: Update file in folder: ~/debug/git/aduneo/dinum-docker/devops/devops-aduneo/res/ssh/include
# Create container@docker:devops
```

## Update vm:os:package:version
```bash
# from container:devops
nohup ssh opscontroler "sudo apt update -y && sudo apt upgrade -y && sudo reboot"  > /tmp/opscontroler.log &
nohup ssh opscompute   "sudo apt update -y && sudo apt upgrade -y && sudo reboot"  > /tmp/opscompute.log   &
nohup ssh opsclient    "sudo apt update -y && sudo apt upgrade -y && sudo reboot"  > /tmp/opsclient.log    &
# Check
lListVm="opscontroler opscompute opsclient" 
lListVm="opscontroler" 
for vm in ${lListVm}; do watch -n1 ssh "${vm}" "uname -a | cut -d' ' -f3"; done
```

## copier les fichiers du folder **code** dans le /var/tmp de chaque vm
```bash
# from container:devops
## Update file > ~/debug/git/aduneo/aduneo-docs/openstack/code/code-custom/ops.ve.common.sh
## Update file in > ~/debug/git/aduneo/dinum-docker/devops/devops-aduneo/res/ssh/include/*
chmod +x ~/debug/git/aduneo/aduneo-docs/openstack/code/code-custom/ops.varenv.sh
~/debug/git/aduneo/aduneo-docs/openstack/code/code-custom/ops.varenv.sh
```
## installer Openstack
```bash
# from container:devops
nohup ssh opscontroler "/var/tmp/ops.init.controler.sh" > /tmp/opscontroler.log &

## provision node@(ops, compute)
nohup ssh opscompute   "/var/tmp/ops.init.compute.sh"   > /tmp/opscompute.log   &

## provision node@(ops, client)
nohup ssh opsclient    "/var/tmp/ops.init.client.sh"    > /tmp/opsclient.log    &
```











# Todo

## Check Install

```bash
# on Node:all
service --status-all
chronyc sources

# on Node@controler
sudo systemctl status rabbit
sudo mysql -e "show databases; use keystone; show tables;"
sudo mysql -e "show databases; use glance; show tables;"
sudo mysql -e "show databases; use keystone; show tables; select * from project;"
sudo mysql -e "show databases; use keystone; show tables; select * from endpoint;"

# on Node@compute

# on Node@client
openstack --help
openstack token isue
```

## Create openstack:Object
```bash
# This guide uses project named servcie that contains a unique user for each service that you add to your environment
## Create Project
lDOMAIN_NAME="default"
lPRJ_NAME="service"
lPRJ_DESC="Mx Project for Service"

openstack project create  ${lPRJ_NAME} \
  --domain ${lDOMAIN_NAME}             \
  --description "${lPRJ_DESC}"
  
## Create Project@NotAdmin
lDOMAIN_NAME="default"
lPRJ_NAME="mxprj"
lPRJ_DESC="Mx Project not used by user@admin"

openstack project create  ${lPRJ_NAME} \
  --domain ${lDOMAIN_NAME}             \
  --description "${lPRJ_DESC}"

## check  
openstack project list

## Create User@NotAdmin
lDOMAIN_NAME="default"
lUSER_NAME="mxuser01"
lUSER_PWD="ops"

openstack user create ${lUSER_NAME} \
  --domain   ${lDOMAIN_NAME}        \
  --password ${lUSER_PWD}

## Create Role
lROLE_NAME="mxrole01"
openstack role create ${lROLE_NAME}

## Bind Role to user/prj
openstack role add ${lROLE_NAME} \
  --project ${lPRJ_NAME}         \
  --user    ${lUSER_NAME}

#check
openstack role assignment list

openstack role assignment list \
  --user    ${lUSER_NAME}      \
  --project ${lPRJ_NAME}       \
  --names

```


## Check Dns between Node@Controler and Node@Compute
```bash
# From Node@Controler
source ops.ve.common.sh

# From Node@Compute
source ops.ve.common.sh
ping -c 4 ${gNODE_CONTROLER_NAME}
```

## Install OpenStack on Vm with ops:tool:DevSatck




## Install Other component
- install Openstack:Keystone (cf. [reference@exteral][Install_Keystone_howto])
- Install Openstack:Dashboard (cf. [reference@exteral][Install_Dashboard_howto])
- Install Openstack:Horizon:Plugin (cf. [reference@exteral][Install_Horizon_Plugin_howto])
- Configure Openstack:Dashboard (cf. [reference@exteral][Configure_Dashboard_howto])

# Check Install

```bash
# Check service
service etcd      status
service mysql     status 
service memcached status 
service apach2    status 
```



# Installer DevStack sur 1 Vm
```bash
# Define Var
ADU_USER_SUDO="stack"
ADU_DEVSTACK_CONF_FILENAME="${HOME%/}/local.conf"
export ADMIN_PASSWORD="root"
# Create user@sudo
sudo useradd -s /bin/bash -d /opt/stack -m ${ADU_USER_SUDO}
echo "${ADU_USER_SUDO} ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/user-${stack}
sudo -u stack -i
git clone https://opendev.org/openstack/devstack
cd devstack
cat <<EOM > ${ADU_DEVSTACK_CONF_FILENAME}
[[local|localrc]]
ADMIN_PASSWORD=root
DATABASE_PASSWORD=${ADMIN_PASSWORD}
RABBIT_PASSWORD=${ADMIN_PASSWORD}
SERVICE_PASSWORD=${ADMIN_PASSWORD}
EOM
```
## Todo
```bash
timedatectl set-timezone xx/yy

```



# Todo

## Code:draft
```bash
lListFile="ops.common ops.compute ops.controler ops.ve.common ops.ve.controler ops.ve.compute"
lFilePath="/home/mxadm/debug/git/aduneo/aduneo-docs/openstack/code" 
lFolderDst="/Users/max/Documents/NotInCloud/RepoDevops/dockervol/ops" 
lListVm="controler compute"
for file in ${lListFile}; do docker cp mxc_devops-mx:${lFilePath}/${file}.sh ${lFolderDst}/; done; for vm in ${lListVm}; do scp ${lFolderDst}/* ${vm}:/tmp; done;
```

## Installer Openstack sur du bare-Metal

## Pwd used
|Name|User|Service|Tag|Desc|
|-|-|-|-|-|
|ADMIN_PASS|admin|Os
|CINDER_DBPASS|Db|Block Storage service
|CINDER_PASS|cinder|Block Storage service
|DASH_DBPASS|Db|Dashboard
|DEMO_PASS|demo|Os
|GLANCE_DBPASS|Db|Image service
|GLANCE_PASS|glance|Image service
|KEYSTONE_DBUSER_PWD|keystone|Identity service
|METADATA_SECRET||Secret for the metadata proxy
|NEUTRON_DBPASS|Db|Networking service
|NEUTRON_PASS|neutron|Networking service
|NOVA_DBPASS|Db|Compute service
|NOVA_PASS|nova|Compute service
|PLACEMENT_PASS|placement|Placement service
|RABBIT_PASS|openstack|RabbitMQ


# Todo
```bash

# ------ Add Repo@package:OpenStack - Already exist in ubuntu 22.04
# sudo add-apt-repository cloud-archive:${gOPS_VERSION_NAME} -y
# Update repo@added
# sudo apt update -y

# disallow msg@interactive "new kernel available"
## cf. file /var/run/reboot-required
## cf. package UnattendedUpgrades
```

# Reference

- https://docs.openstack.org/install-guide/index.html
- https://docs.openstack.org/install-guide/
- https://docs.openstack.org/yoga/install/

[/]: # (sudo systemctl enable --now mysql)
[/]: # (sudo systemctl enable mysql --now)
[/]: # (su -s /bin/sh -c "keystone-manage db_sync" keystone)


