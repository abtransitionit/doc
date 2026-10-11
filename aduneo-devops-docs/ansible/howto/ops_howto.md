# [Ansible][Topic_Whatis] > [Howto][Howto_List] > Openstack


[//]: #(Reference)
[Topic_Whatis]:   ../README.md
[Howto_List]:     ../list/howto_list.md
[Ansible_Whatis]: ../README.md
[Install_Howto]:  ../howto/install_howto.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Install|[How-to][Install_Howto]
<br>

# Example
```bash
---
- name: Using Openstack Cloud collection
  hosts: localhost
  tasks:
    - openstack.cloud.server:
        name: vm
        state: present
        cloud: openstack
        region_name: ams01
        image: Ubuntu Server 14.04
        flavor_ram: 4096
        boot_from_volume: True
        volume_size: 75
```

# Example
```bash
# Gather information about all available flavors
- name: Using Openstack Cloud collection
  hosts: localhost
  tasks:
    - openstack.cloud.compute_flavor_info:
        cloud: mycloud
      register: result

- debug:
    msg: "{{ result.openstack_flavors }}"
```


# Example
```bash
---
- name: Using Openstack Cloud collection
  hosts: localhost
  collections:
    - openstack.cloud
  tasks:
    - server_volume:
        state: present
        cloud: openstack
        server: Mysql-server
        volume: mysql-data
        device: /dev/vdb
```