# [Govc][Topic_Whatis] > [List][List_List] > Composant


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[List_List]:  ../list/list_list.md
# Aduneo > Datacenter

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Govc|[How-to][Govc_howto]
<br>

[//]: #(Reference)
[Govc_Howto]: ../howto/govc_howto.md



# All in 1 Cli
```bash
govc tree
```

# Datacenter

```bash
$ govc about
$ govc datacenter.info

Name:                Datacenter
  Path:              /Datacenter
  Hosts:             3
  Clusters:          0
  Virtual Machines:  217
  Networks:          3
  Datastores:        4
```

Il est constitué des éléments suivants

|Nom|Quantité|Tag|Desc|
|-|-|-|-|
|Esxi|3||Hosts
|Clusters|0|
|Vm|217|
|Networks|3|
|Datastores|4|
<br>

# Les Esxi
```bash
$ govc ls /Datacenter/host/
$ govc ls host

/Datacenter/host/afrique.aduneo.com
/Datacenter/host/amerique.aduneo.com
/Datacenter/host/europe.aduneo.com
```

# Network
```bash
$ govc ls /Datacenter/network/
$ govc ls network

/Datacenter/network/VMDZ
/Datacenter/network/VM Network
/Datacenter/network/Vlan_Maquette
```

# Datastore
```bash
$ govc ls /Datacenter/datastore/
$ govc ls datastore

/Datacenter/datastore/ISO
/Datacenter/datastore/LocalAmerique
/Datacenter/datastore/LocalEurope
/Datacenter/datastore/LocalAfrique
```

```bash
$ govc datastore.info
Name:        ISO
  Path:      /Datacenter/datastore/ISO
  Type:      NFS
  URL:       ds:///vmfs/volumes/de88864d-bef4a88b/
  Capacity:  5487.4 GB
  Free:      3797.8 GB
  Remote:    bucarest.aduneo.com:/volume1/ISO
Name:        LocalAmerique
  Path:      /Datacenter/datastore/LocalAmerique
  Type:      VMFS
  URL:       ds:///vmfs/volumes/5fd79418-9ccb7578-27be-bc97e1a5a254/
  Capacity:  6703.2 GB
  Free:      2730.6 GB
Name:        LocalEurope
  Path:      /Datacenter/datastore/LocalEurope
  Type:      VMFS
  URL:       ds:///vmfs/volumes/6051d59b-a9584ab0-fbf0-bc97e1a5ec04/
  Capacity:  6703.2 GB
  Free:      3857.6 GB
Name:        LocalAfrique
  Path:      /Datacenter/datastore/LocalAfrique
  Type:      VMFS
  URL:       ds:///vmfs/volumes/624da0fe-93bf4c17-5a9e-5c6f697ebd00/
  Capacity:  4469.8 GB
  Free:      2197.2 GB
```

# List Vm et subfolder
```bash
$ govc ls /Datacenter/vm/ | sort
$ govc ls /Datacenter/vm/* | sort
$ govc ls vm              | sort
$ govc ls /Datacenter/vm | grep -v "vm\/VM" | sort
$ govc ls /Datacenter/vm | grep "vm\/VM" | sort
```

# List Template
```bash
$ govc ls /Datacenter/vm/__Templates__/*/*/ | sort

/Datacenter/vm/__Templates__/Linux/Debian/Debian_7_x86_64
/Datacenter/vm/__Templates__/Windows/Clients/Windows 7 Pro 32bits
/Datacenter/vm/__Templates__/Windows/Clients/Windows 7 Pro 64bits
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows 2003 R2 Standard 32 bits
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows 2003 R2 standard 64 bits
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows-2012R2-standard-english
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows-2016-standard-english
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows-2016-standard-francais
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows-2019-standard-english
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows-2019-standard-francais
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows_2008R2_etp_french
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows_2008R2_std_english
/Datacenter/vm/__Templates__/Windows/Serveurs/Windows_2012_std_x64_fr_4.11
```


# List events
```bash
# do "govc logs" then "govc events"
govc events
```

# Reference
- https://github.com/vmware/govmomi