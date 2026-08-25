[//]: #(Home)
[HOME]: ../whatis/ep.md

[//]: #(functional)
[hypervisor whatis]: ../whatis/hypervisor.md
[hypervisor list]:   ../list/tool.md#list

[←][HOME] 

Related topics
|||
|-|-|
|[whatis a hypervisor][hypervisor whatis]|internal
|[List of hypervisors][hypervisor list]|internal
|[what is QEMU](../whatis/qemu.md)|see


<h1 align="center">QEMU</h1>

# Launch QEMU 

**without KVM**
```sh
# pure software emulation
qemu-system-x86_64 -m 512 -cdrom ubuntu.iso
```

**with KVM**
```sh
 # ardware acceleration
qemu-system-x86_64 -m 512 -cdrom ubuntu.iso -enable-kvm
```