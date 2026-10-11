# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Sg


[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Whatis_List]:      ../list/whatis_list.md
[Openstack_Whatis]: ../README.md
[Sg_Howto]:         ../howto/sg_howto.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Sg|[How-to][Sg_Howto]
<br>


# Definition
## Sg
### definition
- is acronyme for **S**ecurity **G**roup
- is1 bind to 1..N Vm
### member
- 1 name
- 1 set of sgr

# Sgr
- is acronyme for **S**ecurity **G**roup **R**ule
- is1 rule
- define what communication is allowed or not from and to Vm

## Type
- ingress
  - communication@input (i.e traffic@incoming)
- egress
  - communication@output (i.e traffic@outgoing)

# Example
- allow 1..1 IP address/port combination
- 