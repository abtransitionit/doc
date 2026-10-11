# [Nubo][Topic_Whatis] > [Howto][Howto_List] > Tutorial 01


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md


# Objective
Create 1 Vm via 
  - Ihm (Horizon)
  - Heat
This Vm  will be accessible via Ssh

# Prerequis
- use tenant :  
- login to Horizon

# Step via Horizon
- create network
    - Network:Name:    ADMIN_DINUM
    - subNetwork:Name: Admin
    - CIDR: 192.168.1.0/24
- create router
  
- create route
- create sg
- create v


# Step via cli
## create network
```bash
# Method
lHEAT_TPL_PATH="01a-DINSIC-Nubo-Initialisation_reseaux.yml"
lHEAT_STACK_NAME="network-stack"
openstack stack create -t ${lHEAT_TPL_PATH} ${lHEAT_STACK_NAME}

# Method
lNETWORK_DESCRIPTION="réseau interne"
lNETWORK_NAME="reseau_interne"
lNETWORK_SUB_NAME="subnet_reseau_interne"
lNETWORK_CIDR="192.168.0.0/24"
openstack network create ${lNETWORK_NAME}     --description ${lNETWORK_DESCRIPTION}
openstack subnet create  ${lNETWORK_SUB_NAME} --subnet-range 192.168.0.0/24 --network  ${lNETWORK_NAME} 
```

## create keypair
```bash
openstack keypair create --public-key id_rsa.pub cle_import
```

## create instance
```bash
lHEAT_TPL_PATH="01b-DINSIC-Nubo-vm_ubuntu.yml"
lHEAT_STACK_NAME="ubuntu-os"
lKEY_SSH_PRIV_NAME="nom_de_votre_clé_privée_ssh"

openstack stack create -t ${lHEAT_TPL_PATH} --parameter keyname=${lKEY_SSH_PRIV_NAME} ${lHEAT_STACK_NAME}


```

## Check

```bash
# project
openstack project list
# network
openstack network list
openstack network show xxx
# instance
openstack server list
openstack flavir list

# Follow stack creation
lHEAT_STACK_NAME="ubuntu-os"
openstack stack event list ${lHEAT_STACK_NAME}

# TODO NOT WORK . Maybe install osc:plugin
openstack stack list
openstack stack output show ubuntu-os public_ip
openstack stack output show ubuntu-os admin_ip
```

# Step via Horizon


