# [Linux Tool][Topic_Whatis] > [Whatis][Whatis_List] > Network


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Whatis_List]:  ../list/whatis_list.md
[Chrony_Howto]: ../howto/chrony_howto.md
[Network_Howto]: ../howto/network_howto.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Chrony|[How-to][Chrony_Howto]
|Network|[How-to][Network_Howto]
<br>

# Ubuntu
- Ubuntu 22.04 (e.g Jammy Jellyfish) uses Netplan to manage many network configuration settings.
# Nat
- allow to translate Ip@Private to Ip@Public
## Type
- Dynamic
  - Map N Ip@Private to Ip@Public in 1 Pool
  - Map N Ip@Private to M Ip@Public
- Static
  - Map N Ip@Private to 1 Ip@Public
- PAT
  - Map N Ip@Private to 1 Ip@Public:N Port

# Dns
- Is1 service/sever that Map Name to Ip
# Fip
- Is1 IP@public
- Allow to point to active member of 1 load balanced member (e.g in case of fail over)

