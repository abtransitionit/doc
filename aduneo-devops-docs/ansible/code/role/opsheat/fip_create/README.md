# [&larr;][Home_Readme]dinum-ansible > play > Roles > This

[//]: #(Reference)
[Home_Readme]:        ../README.md


this ansible:role
  - create 1 openstack:floating ip (aka Fip)
  - perform the following actions (defined in file **tasks/main.yml**): 
    - Create 1 Fip [if needed]
    - Associate this Fip to 1 Vm
    - Create file@(config, ssh) to [easily] access the vm via cli:ssh

## Openstack:stack:name
openstack:stack:name is defined in file  **defaults/main.yml**

# ansible:role:parameter
```Yaml
# 1  parameter only named INPUT that define the object:property
INPUT:
  type:     fip
  id:       string
  name:     string
  vm:       vm:name
  provided: string  (optional)
  network: 
    src:    vn:name
    dst:    vn:name

# Example
INPUT:
  type:     fip
  id:       vm_bastion
  name:     fip_vm_bastion
  network: 
    src:   Ext-Net
    dst:   vn_admin
  vm:      "{{ vm.bastion }}"
```

# How it works
- fip can be 
  - Assoiated only 
  - Created and associated

The existence of var **Input.provided** triger one of the two action
  - if var **Input.provided** exists
    - the creation of fip should failed silently
    - the association should success
  - if var **Input.provided** not exists
    - the creation of fip shoud success
    - the association shoud success

