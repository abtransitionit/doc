# [Govc][Topic_Whatis] > [Howto][Howto_List] > Manage > Vm


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md




# Display Info

```bash
# List vm:all
govc ls /Datacenter/vm/*

# Display Vm:info
## Define var
vm="/Datacenter/vm/DEV VM core"
vm="/Datacenter/vm/VM0010 - Aduneo - Teraform - Debian11"
vm="/Datacenter/vm/Discovered virtual machine/LosAltos - SICIO - Maquette Haproxy"

## play cli 
govc vm.info "$vm"
```

# Get Vm:Var@env
```bash
GOVC_GUEST_LOGIN="root"

govc guest.getenv -vm ${vm} HOME
```bash

# Power on/off Vm
```bash
# shutdown@gracefully OS@Guest using tools
VmName="myvm-001"
govc vm.power -s=true "${VmName}"

# shutdown@immediate
govc vm.power -off=true "${VmName}"

# power on 
govc vm.power -on=true "${VmName}"
```
# Créer 1 VmWare:Vm
- Property
  - datastore-cluster: LocalEurope
  - host: europe.aduneo.com
  - nom: Cf.Nomenclature
    - nom = f(recherché les ip libre)
  - datastore-cluster
  - disk-datastore =  LocalEurope
  - cpu
  - Ram
  - disk-size
  - Netwpork = VM Network
  - Iso-Path

  - lecteurCd + Iso

# Reference
