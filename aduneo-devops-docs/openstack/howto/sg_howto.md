# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Sg

[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:   ../list/howto_list.md
[Sg_Whatis]:    ../whatis/sg_whatis.md
[Cli_Howto]:    ../howto/cli_howto.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Sg|[Whatis][Sg_Whatis]|
|Cli|[How-to][Cli_Howto]|
<br>

# Allow communication using SG not CIDR
```bash
# Vm with sg:lSG_NAME01 ACCEPT communication from vm with Sg:lSG_NAME02
lSG_NAME01="database"
lSG_NAME02="web"
lSGR_PROTOCOL="tcp"
lSGR_PORT="3306"
openstack security group rule create ${lSG_NAME01}
  --direction ingress 
  --ethertype IPv4 
  --protocol     ${lSGR_PROTOCOL} 
  --dst-port     ${lSGR_PORT}
  --remote-group ${lSG_NAME02}
```