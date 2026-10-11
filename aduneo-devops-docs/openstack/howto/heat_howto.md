# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Use > Heat

[//]: #(Reference)
[Topic_Whatis]:  ../README.md
[Howto_List]:    ../list/howto_list.md
[Heat_Whatis]:   ../whatis/heat_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Heat|[Whatis][Heat_Whatis]|
<br>

# Other Action
```bash
# List
openstack stack list
# Display
lHEAT_STACK_NAME="mxst-vm"
openstack stack show ${lHEAT_STACK_NAME}
```

https://xx:glpat-R4pevtLzu8L1CjxAUwZE@forge.dgfip.finances.rie.gouv.fr/dinsic/maia/maia-docker.git


# Create Stack
```bash
# From File
lHEAT_TPL_PATH="/tmp/vm.heat.yaml"
lHEAT_TPL_PATH="/tmp/network.heat.yaml"
lHEAT_TPL_PATH=" /var/tmp/code/heat/vm.01.yaml"
lHEAT_STACK_NAME="mxst-vm"
openstack stack create ${lHEAT_STACK_NAME} -t ${lHEAT_TPL_PATH} \
 --parameter vm_name=opn-front \
 --parameter vm_network=vn-front \
 --parameter vm_key_ssh=mxkey01 \
 --parameter vm_image_id=ubuntu20.04_server \
 --parameter vm_cpuram_id=MO1.1

# From Url
url="https://opendev.org/openstack/heat-templates/raw/src/branch/master/hot/F20/WordPress_Native.yaml"
lHEAT_STACK_NAME="mxst-worpress"
openstack stack create ${lHEAT_STACK_NAME} -t ${Url} 
  --parameter key_name=heat_key 
  --parameter image_id=my-fedora-image 
  --parameter instance_type=m1.small 

lHEAT_TPL_PATH=" /var/tmp/code/heat/network.02.yaml"
lHEAT_STACK_NAME="mxst-network"
openstack stack create ${lHEAT_STACK_NAME} -t ${lHEAT_TPL_PATH}

lHEAT_TPL_PATH=" /var/tmp/code/heat/fip.01.yaml"
lHEAT_STACK_NAME="mxst-fip"
openstack stack create ${lHEAT_STACK_NAME} -t ${lHEAT_TPL_PATH}

lHEAT_TPL_PATH=" /var/tmp/code/heat/router.01.yaml"
lHEAT_STACK_NAME="mxst-router"
openstack stack create ${lHEAT_STACK_NAME} -t ${lHEAT_TPL_PATH}
```

# Display output
```bash
lHEAT_STACK_NAME="mxst-worpress"
lHEAT_STACK_NAME="mxtest"
openstack stack output show ${lHEAT_STACK_NAME} --all 
```

# Display info
```bash
lHEAT_STACK_NAME="mxst-worpress"
openstack stack show ${lHEAT_STACK_NAME} --all 
```

# Delete Stack
```bash
lHEAT_STACK_NAME="mxst-worpress"
openstack stack delete ${lHEAT_STACK_NAME}
openstack stack delete ${lHEAT_STACK_NAME} --yes 
```


```bash
```

# todo
```bash
lHEAT_NAME="teststack"
openstack stack event list ${lHEAT_NAME}
```
