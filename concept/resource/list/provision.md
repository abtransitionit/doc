[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Resource][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[res whatis]:  ../whatis/ep.md
[repo whatis]: /concept/repository/whatis/ep.md
[ope whatis]:  ../whatis/operation.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Resource][res whatis]|see|
|[What is a Repo][repo whatis]|see|
|[What is an Operation][ope whatis]|see|


<h1 align="center">List of Resource Provisioning</h1> <a id='ope'></a>

> **Provision** — make a resource available and ready for use, by assigning, allocating, creating, instantiating, installing, configuring, registering, or reserving it.

**Assigning an identity or address**
- an IP address to a machine
- a DNS name to a service
- a MAC address to a network interface
- a port to a service
- a URL to an endpoint

**Assigning capacity**
- a CPU core to a VM
- RAM (or disk, GPU) to a program
- bandwidth to a connection
- storage quota to a user or tenant
- IOPS to a volume

**Assigning rights or credentials**
- a license to a user
- a role or permission to an account
- an API key or token to an application
- a certificate to a server

**Creating and configuring the resource itself**
- a user account (create + set permissions)
- a database schema (create + set access)
- a file path or directory (create + set ownership)
- a virtual machine (instantiate from an image)
- a container (instantiate from an image)
- a network (create + attach endpoints)

**Registering or enrolling**
- a device into a fleet
- a node into a cluster
- a service into a registry or catalog
- a resource into an inventory

**Reserving**
- a block of addresses for a subnet
- a time slot or window for a job
- a seat or concurrent-session slot for a user

**Provisioning compute** — making processing capacity available
- a virtual machine (instantiate from an image)
- a container (instantiate from an image)
- a bare-metal server (PXE boot, image, configure)
- a CPU core or GPU to a VM
- a serverless function (deploy + set memory/timeout)

**Provisioning an application** — making software available and runnable
- an application (deploy + configure + start)
- a service (register + expose + wire dependencies)
- an environment (dev/staging/prod: create + populate + configure)
- a database (create instance + schema + users)
- a message queue or topic (create + set retention)

**Provisioning storage** — making space available for data
- a volume or disk (create + attach + format)
- a bucket (create + set policy)
- a file share (create + grant access)
- a backup or snapshot (schedule + store)

**Provisioning network** — making connectivity available
- a network or subnet (create + set CIDR)
- a load balancer (create + attach backends)
- a firewall rule (create + attach)
- a VPN or tunnel (create + exchange keys)
- an IP address, port, or DNS name (assign)

**Provisioning infrastructure** — making the underlying platform available
- a cluster (create + join nodes)
- a node into a cluster (join + label)
- a tenant or namespace (create + set quota)
- a region or availability zone (enable + configure)
- an infrastructure-as-code stack (apply template)

**Provisioning identity and access** — making rights available
- a user account (create + set credentials)
- a role or permission (assign)
- an API key or token (issue)
- a certificate (issue + install)

**Provisioning tooling** — making tools available on a target
- a tool (install + configure + register)
- an agent (install on a host + enroll)
- a plugin or extension (install + enable)
- a CLI or SDK (install + configure credentials)

**Provisioning data** — making data available for use
- a dataset (load + index)
- a schema or migration (apply)
- a catalog entry (register + describe)

**Provisioning licensing and quota** — making entitlement available
- a license (assign)
- a quota or budget (set + enforce)
- a seat (assign)

**Provisioning a reservation** — holding something for future use
- a time window or slot (reserve)
- a job (submit + queue)
- a concurrency slot (reserve)



**Provisioning files and directories** — making filesystem objects available
- create a file
- create a directory
- create a symbolic link
- set file permissions (chmod)
- set file ownership (chown)
- mount a filesystem
- create a swap file

**Provisioning processes** — making a running program available
- fork a process
- exec a program
- set a process priority (nice)
- set resource limits (ulimit, cgroups)
- create a daemon or systemd unit
- start / enable a service

**Provisioning kernel modules** — making kernel code available
- load a module (insmod / modprobe)
- unload a module (rmmod)
- add a module to the kernel
- set a module parameter
- blacklist a module
- rebuild the initramfs with a module

**Provisioning devices** — making hardware accessible
- create a device node (mknod)
- load a device driver
- bind a driver to a device
- set a device permission (udev rule)
- enable / disable a device

**Provisioning users and groups** — making identities available
- create a user (useradd)
- create a group (groupadd)
- add a user to a group
- set a password
- set sudo rights
- create an SSH key pair / authorize a key

**Provisioning network interfaces** — making connectivity available
- create a virtual interface (veth, bridge, bond)
- assign an IP address (ip addr add)
- add a route (ip route add)
- set a firewall rule (iptables / nftables)
- bring an interface up
- configure DNS (/etc/resolv.conf)

**Provisioning services (daemons)** — making a service run
- create a systemd unit
- enable a unit at boot
- start / stop / restart a unit
- set environment variables for a service
- open a port for a service
- configure a service config file

**Provisioning storage at low level** — making block/volume storage available
- create a partition (fdisk / parted)
- create a filesystem (mkfs)
- create an LVM volume
- attach a loop device
- create a RAID array (mdadm)
- create a ZFS pool / dataset

**Provisioning scheduling and limits** — making runtime capacity available
- create a cron job
- create a systemd timer
- set a cgroup limit (CPU, memory)
- set an I/O priority (ionice)
- pin a process to a CPU (taskset)

**Provisioning security context** — making a sandbox / policy available
- set an SELinux context
- set an AppArmor profile
- create a namespace (unshare)
- create a seccomp filter
- set capabilities on a binary (setcap)

**Provisioning boot** — making the system bootable
- add a kernel entry to GRUB
- set the default kernel
- set kernel boot parameters
- create an initramfs
- configure fstab




