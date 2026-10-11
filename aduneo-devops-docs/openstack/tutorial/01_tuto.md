# [Openstack][Topic_Whatis] > [Tutorial][Tutorial_List] > Cli

[//]: #(Reference)
[Topic_Whatis]:   ../README.md
[Tutorial_List]:  ../list/tutorial_list.md
[Cli_Howto]:      ../howto/cli_howto.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Cli|[How-to][Cli_Howto]
<br>


# Create Vm and ssh it
create the following object@ops
  - network
  - router
  - router:interface
  - allow following communication (create sg and sgr)
    - vm can be sshed  from bastion only
    - vm can be pinged from bastion 

# Create Sg
```bash
lSG_NAME="mxsg-ping-from-all"
openstack security group create ${lSG_NAME}
lSG_NAME="mxsg-ssh-from-all"
openstack security group create ${lSG_NAME}
lSG_NAME="mxsg-access-outside"
openstack security group create ${lSG_NAME}
```
# Create Sg:Sgr
```bash
# Create
lSG_NAME="mxsg-ping-from-all"
lSGR_PROTOCOL="icmp"
lSGR_IP_FROM="0.0.0.0/0"
openstack security group rule create ${lSG_NAME} \
  --ingress \
  --protocol ${lSGR_PROTOCOL} \
  --remote-ip ${lSGR_IP_FROM}
# Create
lSG_NAME="mxsg-ssh-from-all"
lSGR_PROTOCOL="tcp"
lSGR_PORT="22"
lSGR_IP_FROM="0.0.0.0/0"
openstack security group rule create ${lSG_NAME} \
  --ingress \
  --protocol  ${lSGR_PROTOCOL} \
  --remote-ip ${lSGR_IP_FROM}  \
  --dst-port  ${lSGR_PORT}
# Create
lSG_NAME="mxsg-access-outside"
lSGR_PROTOCOL="tcp"
lSGR_PORT="22"
lSGR_IP_FROM="0.0.0.0/0"
openstack security group rule create ${lSG_NAME} \
  --egress \
# Add Sg to Vm
lSG_NAME="mxsg-ping-from-all"
lSG_NAME="mxsg-access-outside"
lVM_NAME="mxVm01"
openstack server add security group  ${lVM_NAME} ${lSG_NAME}

Error: Port security must be enabled and port must have an IP address in order to use security groups. 

```

# Create network
```bash
## network
lNETWORK_ROOT_NAME="mxvn-net01"
lNETWORK_SUBNET_NAME="${lNETWORK_ROOT_NAME}-subnet"
lNETWORK_CIDR="192.68.0.0/24"
lNETWORK_DESC="Network@virtual 01"
openstack network create ${lNETWORK_ROOT_NAME}  \
  --description "${lNETWORK_DESC}" 
openstack subnet create ${lNETWORK_SUBNET_NAME} \
  --network ${lNETWORK_ROOT_NAME} \
  --gateway auto
  --dhcp 
  --subnet-range ${lNETWORK_CIDR}
## network
lNETWORK_ROOT_NAME="mxvn-net02"
lNETWORK_SUBNET_NAME="${lNETWORK_ROOT_NAME}-subnet"
lNETWORK_CIDR="10.0.0.0/16"
lNETWORK_DESC="Network@virtual 02"
openstack network create ${lNETWORK_ROOT_NAME}  \
  --description "${lNETWORK_DESC}" 
openstack subnet create ${lNETWORK_SUBNET_NAME} \
  --network ${lNETWORK_ROOT_NAME} \
  --gateway auto
  --dhcp 
  --subnet-range ${lNETWORK_CIDR}
## network
lNETWORK_ROOT_NAME="mxvn-net03"
lNETWORK_SUBNET_NAME="${lNETWORK_ROOT_NAME}-subnet"
lNETWORK_CIDR="192.168.1.0/24"
lNETWORK_DESC="Network@virtual 02"
openstack network create ${lNETWORK_ROOT_NAME}  \
  --description "${lNETWORK_DESC}" 
openstack subnet create ${lNETWORK_SUBNET_NAME} \
  --network ${lNETWORK_ROOT_NAME} \
  --gateway auto
  --dhcp 
  --subnet-range ${lNETWORK_CIDR}
#  --dns-nameserver 213.186.33.99 

# Configure Network
lNETWORK_ROOT_NAME="mxvn-net01"
openstack network set ${lNETWORK_ROOT_NAME} --enable-port-security
```

# Manage router
```bash
# Create
lROUTER_NAME="mxrt-routeur"
openstack router create ${lROUTER_NAME}
# Configure - attach to Ext-Net
lNETWORK_SDEF="Ext-Net"
openstack router set ${lROUTER_NAME} \
  --external-gateway ${lNETWORK_SDEF}
# Configure - attach to Network@Custom
lNETWORK_ROOT_NAME="mxvn-net01"
lNETWORK_SUBNET_NAME="${lNETWORK_ROOT_NAME}-subnet"
openstack router add subnet ${lROUTER_NAME} ${lNETWORK_SUBNET_NAME}
# Configure - attach to Network@Custom
lNETWORK_ROOT_NAME="mxvn-net02"
lNETWORK_SUBNET_NAME="${lNETWORK_ROOT_NAME}-subnet"
openstack router add subnet ${lROUTER_NAME} ${lNETWORK_SUBNET_NAME}
```

# Create key@ssh
```bash
lKEYSSH_NAME="mxkey01"
openstack keypair create ${lKEYSSH_NAME} > /tmp/key.shh.priv.ops.${lKEYSSH_NAME}
```


# Create Vm
```bash

X4oL3aQZj3XK
lVM_NAME="mxVm01"
lVM_SG01="mxsg-ssh-from-all"
lVM_SG02="mxsg-ping-from-all"
lVM_KEYSSH_NAME="mxkey01"
lVM_FLAVOR_NAME="d2-2"
lIMAGE_NAME="Ubuntu 22.04"
lNETWORK_NAME="mxvn-net01"
openstack server create ${lVM_NAME} \
  --flavor  ${lVM_FLAVOR_NAME}      \
  --image   "${lIMAGE_NAME}"        \
  --key-name ${lVM_KEYSSH_NAME}     \
  --network  ${lNETWORK_NAME}       \
  --security-group  ${lVM_SG01}   \
  --security-group  ${lVM_SG02}   

lVM_NAME="mxVm02"
lVM_KEYSSH_NAME="mxkey01"
lVM_FLAVOR_NAME="d2-2"
lIMAGE_NAME="Ubuntu 22.04"
lNETWORK_NAME="Ext-Net"
openstack server create ${lVM_NAME} \
  --flavor  ${lVM_FLAVOR_NAME}      \
  --image   "${lIMAGE_NAME}"        \
  --key-name ${lVM_KEYSSH_NAME}     \
  --network  ${lNETWORK_NAME}       \
  --security-group  ${lVM_SG01}   \
  --security-group  ${lVM_SG02}   
```


# Manage Fip (Floating IP)
```bash
# Create - get ip from this network
lNETWORK_NAME="Ext-Net"
openstack floating ip create ${lNETWORK_NAME}
# get - Fip:Name
lFIP_NAME="141.94.215.114"
# Configure - map to Vm
lVM_NAME="mxVm01"
openstack server add floating ip ${lVM_NAME} ${lFIP_NAME}
```



# Delete All
```bash
lVM_NAME="mxVm01"
openstack server delete  ${lVM_NAME}
#
openstack router  delete ${lROUTER_NAME}
#
lNETWORK_ROOT_NAME="mxvn-net01"
openstack network delete ${lNETWORK_ROOT_NAME}
#
lNETWORK_ROOT_NAME="mxvn-net02"
openstack network delete ${lNETWORK_ROOT_NAME}
#
```