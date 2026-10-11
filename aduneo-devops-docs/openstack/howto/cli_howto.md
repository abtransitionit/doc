# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Cli

[//]: #(Reference)
[Topic_Whatis]:  ../README.md
[Howto_List]:    ../list/howto_list.md
[Cli_Whatis]:    ../whatis/cli_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Cli|[Whatis][Cli_Whatis]
<br>

# Get help
```bash
openstack --version
openstack --help
openstack help show
```


# List Object
```bash
# object@ops
openstack project|domain|user|role|service|stack list 
openstack flavor|keypair| list
openstack security group|security group rule| list

# keypair
lKEYPAIR_NAME="mxkey01"
openstack keypair show ${lKEYPAIR_NAME} --public-key
# Vm
openstack server list

# Network and Subnet
openstack network list
openstack network list -c ID -c Name 

openstack subnet list  --sort-column Name
openstack subnet list  -c Name -c Network -c Subnet --sort-column Name
openstack subnet list  --long


# port
openstack port list  --long
# Sg and Sgr
openstack security group list 

openstack security group rule list 
openstack security group rule list \
  -c "Security Group"              \
  -c "Ethertype"                   \
  -c "Port Range"                  \
  -c "Direction"                   \
  -c "IP Range"                    \
  | grep -v IPv6 

# role for user/prj
lUSER_NAME="USER_NAME"
lTENANT_ID="PRJ_NAMEORID"

openstack role assignment list
openstack role assignment list --na
openstack role assignment list \
  --user    ${lUSER_NAME} \
  --project ${lTENANT_ID} \
  --names

openstack role list 
  --user    ${lUSER_NAME} 
  --project ${lTENANT_ID}

# service
openstack endpoint list
openstack endpoint list --service glance  
openstack endpoint list --service glance --interface public  
```

# Display Object
```bash
ObjName="mxexample"
openstack project|domain|user|role|service|stack|image show ${ObjName}
# Vm
lVM_ID="959b64af-728f-44ee-a508-92a9d2520f7f"
openstack server show ${lVM_ID}
```

# Create Object
## Create network
```bash
## step01
lNETWORK_NAME="vn_admin"
lNETWORK_DESC="vn for admin purpose"
openstack network create ${lNETWORK_NAME}  \
  --description "${lNETWORK_DESC}"
## step02
lSUBNET_NAME="${lNETWORK_NAME}_subnet"
lNETWORK_CIDR="192.68.2.0/24"
openstack subnet create ${lSUBNET_NAME} \
  --network      ${lNETWORK_NAME}       \
  --subnet-range ${lSUBNET_CIDR}        \

# Bind to network
openstack router set --external-gateway <network> <router>
openstack router add subnet <router> <subnet>
openstack router set --external-gateway <network> <router>

```
## Create Router
```bash
lROUTER_NAME="routeur"
openstack router create ${lROUTER_NAME}
```

## Create Keypair
```bash
# and save key@(ssh,priv) in file
lKEYSSH_NAME="njkey01"
openstack keypair create ${lKEYSSH_NAME} > /tmp/key.shh.priv.ops.nubo.${lKEYSSH_NAME}
openstack keypair create ${lKEYSSH_NAME} > /tmp/ksp.aduneo..${lKEYSSH_NAME}
```

# Create Sg
```bash
lSG_DESC="ping from all ip"
lSG_NAME="mxsg-ping-from-all"
openstack security group create ${lSG_NAME} \
  --description "${lSG_DESC}" 

lSG_DESC="ssh from all ip"
lSG_NAME="mxsg-ssh-from-all"
openstack security group create ${lSG_NAME} \
  --description "${lSG_DESC}" 
```


# Create Sgr - Add Sgr to Sg01
```bash
# Allow ip:all to ping
lSG_NAME="mxsg-ping-from-all"
lSGR_PROTOCOL="icmp"
lSGR_IP_FROM="0.0.0.0/0"
openstack security group rule create ${lSG_NAME} \
  --protocol ${lSGR_PROTOCOL} \
  --remote-ip ${lSGR_IP_FROM}
#  --ethertype IPv4 
#  --ethertype IPv6


# Allow ip:all to ssh
lSGR_PROTOCOL="tcp"
lSGR_IP_FROM="0.0.0.0/0"
openstack security group rule create ${lSG_NAME} \
  --protocol ${lSGR_PROTOCOL} \
  --remote-ip 0.0.0.0/0 

lSGR_NAME="mxsg-ping"
lSGR_PROTOCOL="icmp"
openstack security group rule create 
  --protocol ${lSGR_PROTOCOL} \
  --remote-ip ${lSGR_IP_FROM}

lSGR_PROTOCOL="ipv6-icmp"
openstack security group rule create 
  --protocol ${lSGR_PROTOCOL} \
--remote-ip 2001:700:100:12::61 5157 dbad-f96b-4921-b9ba-520b5e2ce995

lSGR_PROTOCOL="tcp"
lSGR_PORT="22"
openstack security group rule create 
  --protocol ${lSGR_PROTOCOL} \
  --dst-port ${lSGR_PORT} \
  --remote-ip 129.240.12.61 5157 dbad-f96b-4921-b9ba-520b5e2ce995

lSGR_PROTOCOL="tcp "
lSGR_PORT="22"
openstack security group rule create
  --ethertype IPv6 
  --protocol ${lSGR_PROTOCOL} \
  --dst-port ${lSGR_PORT} \
  --remote-ip 2001:700:100:12::61 5157 dbad-f96b-4921-b9ba-520b5e2ce995

# Allow    Bastion to ssh
# DisAllow other   to ssh
```

## Create Vm
```bash
lVM_NAME="mxMyVm"
lVM_KEYSSH_NAME="mxkey02"
lVM_FLAVOR_NAME="MO1.1"
lIMAGE_NAME="centos7"
lNETWORK_NAME="mxvn-internal"
lSG_NAME="mxsg-ping"
lNET_ID01=""
lNET_ID03=""
openstack server create ${lVM_NAME}
  --flavor ${lVM_FLAVOR_NAME}
  --image ${lIMAGE_ID}
  --key-name ${lVM_KEYSSH_NAME} 
  --nic net-id=${lNET_ID01}
  --nic net-id=${lNET_ID02} 
openstack server create ${lVM_NAME}
  --flavor         ${lVM_FLAVOR_NAME}
  --image          ${lIMAGE_ID}
  --key-name       ${lVM_KEYSSH_NAME} 
  --network        ${lNETWORK_NAME}
  --security-group ${lSG_NAME}

# openstack server create ${lVM_NAME}
#   --flavor         ${lVM_FLAVOR_NAME}
#   --image          ${lIMAGE_ID}
#   --key-name       ${lVM_KEYSSH_NAME} 
#   --security-group ${lSG_NAME}
#   --nic net-id=${lNET_ID01}
#   --nic net-id=${lNET_ID02} 
# openstack server create srv01 
# --image 'Debian 9' 
# --net private 
# --key-name fake 
# --flavor c2-7 
# Display Vm:boot:log
openstack console log show my-instance

```




# Add Sg to Vm
```bash
lSG_NAME
openstack server add security group test 'SSH and ICMP'
openstack server add security group ${lVM_NAME} default
```


# Delete Object
```bash
# Delete keypair
lKEYSSH_NAME="mxkey01"
openstack keypair delete "${lKEYSSH_NAME}"

# Delete network and associated subnet
lNETWORK_NAME="mxvn-internal-01"
openstack network delete "${lNETWORK_NAME}"

# Delete sgr
lSGR_ID="xxx"
openstack security group rule delete ${lSGR_ID}
```


# Connect Object
## Connect router 
```bash
lROUTER_NAME="routeur"
lROUTER_NAME="router-front"
lNETWORK_NAME="FIP_PUBLICATION_DGFIP"
lNETWORK_NAME="FIP_ADMINISTRATION_DINUM"
lSUBNET_NAME="subnet_reseau_interne"
lSUBNET_NAME="vn-front-subnet"
#
openstack router set ${lROUTER_NAME} \
  --external-gateway ${lNETWORK_NAME}
#
openstack router add subnet ${lROUTER_NAME} ${lSUBNET_NAME}
```
# Add Node@Compute to Cell
```bash
# make host visible to the scheduler
# make host available for instances (i.e VM)
nova-manage cell_v2 discover_hosts
```
# Install cde@Plugin
```bash
# install cde@plugin for service:placement
pip3 install osc-placement
# Usage > Method
openstack --os-placement-api-version 1.2 resource class list --sort-column name
openstack --os-placement-api-version 1.6 trait list --sort-column name

# Usage > Method
export OS_PLACEMENT_API_VERSION=1.2
openstack resource class list --sort-column name

export OS_PLACEMENT_API_VERSION=1.6
openstack trait list --sort-column name

export OS_PLACEMENT_API_VERSION=1.10
openstack allocation candidate list --resource VCPU=1

```


# Check access to cloud:ops:node@controler
```bash
# from node@(ops, client)
openstack token issue
```





# Disable
```bash
# user
lOBJ_NAME="example"
openstack domain  set ${lOBJ_NAME} --disable
openstack user    set ${lOBJ_NAME} --disable
openstack project set ${lOBJ_NAME} --disable
openstack domain  set ${lOBJ_NAME} --disable

```

# Delete
Step
 1. disable object
 1. delete object

```bash
# Domain
lOBJ_NAME="example"
openstack domain delete ${lOBJ_NAME}

# Project
lOBJ_NAME="default"
openstack project delete ${lOBJ_NAME}

# Role from pair user/prj
lUSER_NAME="USER_NAME"
lROLE_NAME="ROLE_NAME"
lTENANT_ID="PRJ_NAMEORID"

openstack role remove ${lROLE_NAME}
  --user    ${lUSER_NAME} 
  --project ${lTENANT_ID}

```

# Create

## domain
```bash
lOBJ_NAME="example"
lOBJ_DESC="An Example Domain"
openstack domain create ${lOBJ_NAME}
  --description ${lOBJ_DESC}  
```

## project
```bash
lDOMAIN_NAME="default"
lPRJ_NAME="default"

# create
lPRJ_DESC="Service Project"
openstack project create ${lPRJ_NAME}
  --domain ${lDOMAIN_NAME}
  --description ${lPRJ_DESC}     \

# create
lPRJ_DESC="Demo Project"
openstack project create ${lPRJ_NAME}  \
  --domain      ${lDOMAIN_NAME}        \
  --description ${lPRJ_DESC}          \
  

# create
lPRJ_NAME="myproject"
lPRJ_DESC="Demo Project"
openstack project create       \
  --domain      ${lDOMAIN_NAME}  \
  --description ${lPRJ_DESC}     \
  ${lPRJ_NAME}  
```

## Role
```bash
lROLE_NAME="mxrole"
openstack role create ${lROLE_NAME}

lROLE_NAME="myrole"
openstack role create ${lROLE_NAME}

```


## Image
```bash
# Add image to glance
lVM_IMAGE_NAME="cirros"
lVM_IMAGE_FILE_PATH="/var/tmp/cirros-0.4.0-x86_64-disk.img"
glance image-create               \
  --name "${lVM_IMAGE_NAME}"      \
  --file "${lVM_IMAGE_FILE_PATH}" \
  --disk-format qcow2             \
  --container-format bare         
```


## User
```bash
lUSER_NAME="mxuser1"
lUSER_PWD="test"
lUSER_DESC="user@dev"
lUSER_MAIL="user1@example.com"
lPRJ_NAME="dev"

openstack user create "${lUSER_NAME}" \
  --email             "${lUSER_MAIL}" \
  --description       "${lUSER_NAME}" \
  --project           "${lPRJ_NAME}"  \
  --password          "${lUSER_PWD}"  

```

# Bind
## Assign role to 1 pair user/project
```bash
lUSER_NAME="USER_NAME"
lROLE_NAME="ROLE_NAME"
lTENANT_ID="PRJ_NAMEORID"

openstack role add 
  --user     ${lUSER_NAME} 
  --project  ${lTENANT_ID}  
  ${lROLE_NAME} 

# Check
openstack role assignment list \
  --user    ${lUSER_NAME} \
  --project ${lTENANT_ID} \
  --names
```

# Assign a user to a project
## Assign role to 1 user-project pair 
```bash
lDOMAIN_NAME="default"
lUSER_NAME="myuser"
openstack user create      \
  --domain ${lDOMAIN_NAME} \
  --password-prompt        \
  ${lUSER_NAME}

## add role to project/user
lROLE_NAME="myrole"
lPRJ_NAME="myproject"
lUSER_NAME="myuser"
openstack role add         \
  --project ${lPRJ_NAME}   \
  --user    ${lUSER_NAME}  \
  ${lROLE_NAME}
```

## Manage Service
```bash
# Create
lSERVICE_NAME="myservice"
lSERVICE_TYPE="myservicetype"
lSERVICE_DESC="My service OPS"
openstack service create         \
  --name ${lSERVICE_NAME}        \
  --description ${lSERVICE_DESC} \
  ${lSERVICE_TYPE}
```

<hr>

# register Service
```bash
## create service
## create endpoint
```


## Manage Endpoint
```bash
# create
lCONTROLLER_NODE_NAME="myservice"
lREGION_NAME="RegionOne"
openstack endpoint create 
  --region ${lREGION_NAME} \
  image [public|internal|admin] http://${lCONTROLLER_NODE_NAME}:9292
```
## Manage image
```bash
## display info

openstack image set            \
  --property hw_disk_bus='ide' \
  image_name_or_id

openstack image set               \
  --property architecture=arm     \
  --property hypervisor_type=qemu \
  image_name_or_id
```

## Manage Token
```bash
# Create  token@unscoped
openstack token issue

# Create  token@system
openstack token issue --os-system-scope

# Create  token@project
openstack token issue
```

## Manage Stack
### Create Stack from Template Heat
```bash
lHeatFilePath="xxx"
lStackName="MyStack"
opentack stack create 
  -t ${HeatFilePath} 
  ${lStackName}
```


# Glance
```bash
# load files from this folder into the database:
glance-manage db_load_metadefs

# unload files from database:
glance-manage db_unload_metadefs

# export definitions in JSON format
glance-manage db_export_metadefs
```


# Manage Service:Credential
The following Usecase is for service:Glance
## create user
```bash
lDOMAIN_NAME="default"
lUSER_NAME="glance"

openstack user create      \
  --domain ${lDOMAIN_NAME} \
  --password-prompt        \
  ${lUSER_NAME}
```

## Add role:admin to project/user
```bash
lROLE_NAME="admin"
lPRJ_NAME="service"
lUSER_NAME="glance"
openstack role add         \
  --project ${lPRJ_NAME}   \
  --user    ${lUSER_NAME}  \
  ${lROLE_NAME}
```
## Create service:Glance
```bash
lSERVICE_NAME="glance"
lSERVICE_TYPE="image"
lSERVICE_DESC="My service OPS"
openstack service create         \
  --name ${lSERVICE_NAME}        \
  --description ${lSERVICE_DESC} \
  ${lSERVICE_TYPE}
```

# Todo
```bash
openstack --os-cloud infra server list
openstack configuration show
```
## token
```bash
openssl rand -hex 10
export OS_TOKEN=$(openssl rand -hex 10)
```
## example
openstack image create "Ubuntu2004" 
--file /var/kvm/images/ubuntu2004.img 
--disk-format qcow2 
--container-format bare 
--public

# reference
- https://docs.openstack.org/python-openstackclient/latest/configuration/index.html#configuration

