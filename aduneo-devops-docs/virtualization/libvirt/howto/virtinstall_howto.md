# [LibVirt][Topic_Whatis] > [Howto][Howto_List] > Virt-Install


[//]: #(Reference)
[Topic_Whatis]:   ../README.md
[Howto_List]:    ../list/howto_list.md
[Virtinstall_Whatis]:  ../whatis/virtinstall_whatis.md
[Virsh_Howto]:   ../howto/virsh_howto.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Virtinstall|[Whatis][Virtinstall_Whatis]
|Virsh|[How-to][Virsh_Howto]
<br>



# Parameter
|Name|Tag|Description|
|-|-|-|
|name|Vm:Name||
|vcpus|Vm:Cpu||
|memory|Vm:Memory||
|os-variant|os:type||
|network|
|cdrom|File@Iso|-|
|location|File@Iso|Iso used to Boot from and install on Vm|
|noautoconsole||VM will run in the bg|
|graphics|vnc,listen=0.0.0.0|Server@Vnc will listen on all interface
|boot|cdrom, hd|boot order cdrom and hd@virtual
<br>

# Create Vm
```bash
lVM_NAME="centos8-2"
lVM_CPU="1"
lVM_MEMORY="1024"
lVM_OS_TYPE="linux"
# list variant > osinfo-query os
lVM_OS_VARIANT="centos7.0"
# list network > virsh net-list
lVM_NETWORK="default"

virt-install  \
  --name       ${lVM_NAME} \
  --vcpus      ${lVM_CPU} \
  --memory     ${lVM_MEMORY} \
  --os-type    ${lVM_OS_TYPE} \
  --os-variant ${lVM_OS_VARIANT}
  --network network=${lVM_NETWORK} \
  --location
  --graphics=none

```



