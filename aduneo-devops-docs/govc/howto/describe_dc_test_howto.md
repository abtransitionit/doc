# [Govc][Topic_Whatis] > [Howto][Howto_List] > Describle > Datacenter : Test

[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:   ../list/howto_list.md





# All in 1 Cli
```bash
govc tree
```

# Datacenter

```bash
$ govc about

FullName:     VMware ESXi 6.5.0 build-4887370
Name:         VMware ESXi
Vendor:       VMware, Inc.
Version:      6.5.0
Build:        4887370
OS type:      vmnix-x86
API type:     HostAgent
API version:  6.5
Product ID:   embeddedEsx
UUID:

$ govc datacenter.info

Name:                ha-datacenter
  Path:              /ha-datacenter
  Hosts:             1
  Clusters:          0
  Virtual Machines:  0
  Networks:          1
  Datastores:        1
  
# Esxi
dc="ha-datacenter"

$ govc ls /$dc/host/
$ govc ls host

/ha-datacenter/host/aduplesxm01.aduneo.com

# Network
$ govc ls /$dc/network/
$ govc ls network

/ha-datacenter/network/VM Network

# Datastore
$ govc ls /$dc/datastore/
$ govc ls datastore

/ha-datacenter/datastore/LocalAduplesxm01

$ govc datastore.info
Name:        LocalAduplesxm01
  Path:      /ha-datacenter/datastore/LocalAduplesxm01
  Type:      VMFS
  URL:       /vmfs/volumes/627a5e5d-8d70c518-9a68-0024e8493636
  Capacity:  3342.8 GB
  Free:      3341.8 GB
```

Il est constitué des éléments suivants

|Object|Quantité|Name|Tag|Desc|
|-|-|-|-|-|
|Datacenter|1|ha-datacenter|Hosts
|Esxi|1|aduplesxm01.aduneo.com|Hosts
|Clusters|0|
|Vm|0|
|Networks|1|VM Network
|Datastores|1|LocalAduplesxm01
<br>


# List Vm et subfolder
```bash
$ govc ls /$dc/vm/ | sort
$ govc ls /$dc/vm/* | sort
$ govc ls vm              | sort
$ govc ls /$dc/vm | grep -v "vm\/VM" | sort
$ govc ls /$dc/vm | grep "vm\/VM" | sort

```

# List Template
```bash
$ govc ls /$dc/vm/__Templates__/*/*/ | sort

```


# List events
```bash
# do "govc logs" then "govc events"
govc events

[Tue May 24 10:50:22 2022] [info] User root@192.168.253.19 logged out (login time: Tuesday, 24 May, 2022 10:00:27, number of API invocations: 0, user agent: govc/0.28.0)
[Tue May 24 11:47:05 2022] [info] User root@192.168.253.19 logged in as govc/0.28.0
```
