# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Port


[//]: #(Reference)
[Topic_Whatis]:    ../README.md
[Whatis_List]:     ../list/whatis_list.md
[Component_List]:  ../list/component_list.md
[Instance_Whatis]: ../whatis/instance_whatis.md
[Port_Howto]:      ../howto/port_howto.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Port|[How-to][Port_Howto]
<br>

# Definition

## Port
1 port 
  - represents a virtual switch port on a logical network switch
  - defines to the interfaces plugged into them:
    - MAC address
    - IP address(es) 

### Example
  - Vm attach their interfaces into ports
## Toknow
When IP addresses are associated to a port => 
  - port is associated with a subnet from which the the Ip 

(because the IP address was taken from the allocation pool for a specific subnet.)
## Port and Vm
- when 1 vm is created. It receive 1 port with a fixed IP address on the vm:network
- this Ip
  - is1 ip@(private, permanent) associate to the Vm
  - is deleted when the vm is deleted
  - is used to communication between vm [on the same network ??]

## Port and network
- New networks receive 2 Port

# Todo
