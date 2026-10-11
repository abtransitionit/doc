# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Port

[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:   ../list/howto_list.md
[Port_Whatis]:  ../whatis/port_whatis.md
[Cli_Howto]:    ../howto/cli_howto.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Port|[Whatis][Port_Whatis]|
|Cli|[How-to][Cli_Howto]|
<br>


# Create port
```bash
# with specific Ip
lPORT_NAME="port1"
openstack port creat ${lPORT_NAME}
  --network net1
  --fixed-ip subnet=subnet1,ip-address=192.0.2.40 

# without specifying Ip
openstack port creat ${lPORT_NAME}
  --network net1

```