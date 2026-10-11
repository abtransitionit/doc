# [LibVirt][Topic_Whatis] > [Howto][Howto_List] > Virsh


[//]: #(Reference)
[Topic_Whatis]:   ../README.md
[Howto_List]:    ../list/howto_list.md
[Virsh_Whatis]:  ../whatis/virsh_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Virsh|[Whatis][Virsh_Whatis]

<br>


# Display Vm:info
```bash
virsh dominfo ${VmName}
```

# Display Domain (i.e Vm:Info)
```bash
virsh dumpxml             ${VmName}
virsh dumpxml    --domain ${VmName}
#
virsh domblklist          ${VmName}
virsh domblklist --domain ${VmName}
```

# Display Vm:Vnc:Port
```bash
virsh vncdisplay ${VmName}
```

# Display Vm:networkinfo
```bash
virsh net-info  ${NetworkName}
```

# list snapshot
```bash
virsh snapshot-list --domain ${VmName}
```

# delete snapshot
```bash
virsh snapshot-delete --domain ${VmName} --snapshotname ${SnapName}
```

# list network@virtual
```bash
# Check libvirt:network@default is started
virsh net-list
virsh net-list --all
```

# list Vm
```bash
virsh list 
virsh list --inactive
virsh list --all
```

# Create Vm
```bash
virsh create ${XmlConf}
```

# start/stop/delete Vm
```bash
virsh start    ${VmName}
virsh shutdown ${VmName}
virsh destroy  ${VmName}
virsh undefine  ${VmName}
```

# start Network@Virtual
```bash
# Start libvirt:network@default
virsh net-start default 
```

# delete Network@Virtual
```bash
virsh  net-destroy  ${NetworkName}
```
# delete Vm
```bash
virsh  undefine  ${VmName}
```


