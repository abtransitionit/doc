# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Fip

[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:   ../list/howto_list.md
[Fip_Whatis]:   ../whatis/fip_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Fip|[Whatis][Fip_Whatis]|
<br>

# With Cli

## Create fip
```bash
# Fip:Ip is in ${lNETWORK_NAME}:CIDR
lNETWORK_NAME="Ext-Net"
openstack floating ip create ${lNETWORK_NAME}
```
## [Re]Associate fip
```bash
# vm have 1..1 Ip (i.e 1 interface)
lVM_NAME="opvm-bastion"
lFIP_IP="141.94.215.114"
openstack server add floating ip ${lVM_NAME} ${lFIP_IP}

# vm have 2..2 Ip (i.e 2 interface)

```
## Dissociate fip
```bash
# vm have 1..1 Ip (i.e 1 interface)
lVM_NAME="opvm-bastion"
lFIP_IP="141.94.215.114"
openstack server remove floating ip ${lVM_NAME} ${lFIP_NAME}
# vm have 2..2 Ip (i.e 2 interface)
openstack server remove floating ip ${lVM_NAME} ${lFIP_NAME}


# Delte mapinng
lVM_NAME="srv01"
openstack server remove floating ip ${lVM_NAME} ${lFIP_NAME}


```

# Other
 - Get fip:Property
 - Delete fip

# Other
```bash
# Get - Fip:Name > openstack floating ip list
lFIP_NAME="141.94.215.114"
lFIP_NAME="100.67.22.138"
lFIP_NAME="141.94.213.120"
lFIP_NAME="141.94.211.145"





# get - Fip:Ip > openstack floating ip list
lFIP_NAME="141.94.215.114"
lFIP_NAME="100.67.22.138"



# Configure - remap to anotherVm
lVM_NAME="srv02"
openstack server add floating ip ${lFIP_NAME}
```


# With Heat And Ansible

## Create fip
```yaml
heat_template_version: 2018-08-31
description: >
  Tpl@(Ops, Heat, Ansible) to create:
  -  1 FIP (aka Floating IP)

# resource to create
resources:
  ## Floating IP
  fip_{{ lobj.id }}:
    type: OS::Neutron::FloatingIP
    properties:
      floating_network:  {{ lobj.network.name }}
```

# With Heat Alone
