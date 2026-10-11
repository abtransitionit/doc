# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Use > Heat : Language

[//]: #(Reference)
[Topic_Whatis]:  ../README.md
[Howto_List]:    ../list/howto_list.md
[Heat_Whatis]:   ../whatis/heat_whatis.md
[Heat_Language_Whatis]:   ../whatis/heat_language_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Heat|[Whatis][Heat_Whatis]|
|Language|[Whatis][Heat_Language_Whatis]|
<br>

# Output
```yaml
# Example
resources:
  server: 
  ...

outputs:
  server_networks:
    description: The networks of the deployed server
    value: { get_attr: [server, networks] }

# Example
outputs:
  private_key:
    description: Private key
    value: { get_attr: [ my_key, private_key ] }
```
# Vm
```yaml
resources:
  my_instance:
    type: OS::Nova::Server
    properties:
      key_name: mxkey01
      image:    Ubuntu 22.04
      flavor:   d2-2
      networks:
        - network: Ext-Net
```
