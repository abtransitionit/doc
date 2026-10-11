[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[registry list]: ../list/registry.md
[hypervisor list]: ../list/hypervisor.md
[vm whatis]: ../list/registry.md
[container whatis]: ../whatis/vm.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[List of registries][registry list]|
|[List of hypervisor][hypervisor list]|

<h1 align="center">How-to for Image</h1>

The concept of Image

# How-to for VM images


# create 1 image@(vm, empty)
```bash
# define var
lIMAGE_VM_PATH="/var/kvm/images/ubuntu2004.img"
lIMAGE_VM_PATH="/tmp/centos.qcow2"
lIMAGE_VM_SIZE="10G"
lIMAGE_VM_FORMAT="qcow2"

# create folder
mkdir -p /var/kvm/images

# create the VM IMAGE
qemu-img create -f ${lIMAGE_VM_FORMAT} ${lIMAGE_VM_PATH} ${lIMAGE_VM_SIZE}
```


# install
```sh

virt-install \
--network     network=default \
--disk    path=/var/kvm/images/ubuntu2004.img,format=qcow2 \
--location    'http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' \
--os-type linux \
--os-variant  ubuntu20.04 \
--name    ubuntu2004 \
--ram     2048 \
--vcpus   2 \
--graphics    none \
--console     pty,target_type=serial \
--extra-args  'console=ttyS0,115200n8 serial'

 virt-install \
--network    network=default \
--disk       /tmp/centos.qcow2,format=qcow2 \
--location=/data/isos/CentOS-7-x86_64-NetInstall-1611.iso
--os-type=linux \
--os-variant=centos7.0 \
--name      centos 
--ram       1024 \
--virt-type kvm 
--graphics   vnc,listen=0.0.0.0 
--noautoconsole \
```

# after finishing installation, back to KVM Host and shutdown VM
```bash
# from Host
virsh shutdown ubuntu2004
```


# Create VM
```bash
# Download Image
lVM_IMAGE_RES_NAME="jammy-server-cloudimg-amd64.img"
lVM_IMAGE_RES_PATH="jammy/current"
lVM_IMAGE_URL="cloud-images.ubuntu.com"
lVM_IMAGE_SRC1_NAME="ubuntu-22-server.qcow2"
lVM_IMAGE_SRC2_NAME="root-disk.qcow2"
lVM_IMAGE_SRC1_FOLDER="/var/lib/libvirt/images/original"
lVM_IMAGE_SRC2_FOLDER="/var/lib/libvirt/images/ubuntu-22-server-cloud"

wget https://${lVM_IMAGE_URL}/${lVM_IMAGE_RES_PATH}/${lVM_IMAGE_RES_NAME} -P /tmp/

# Rename Image:Extension
sudo mkdir /var/lib/libvirt/images/original
sudo mv /tmp/${lVM_IMAGE_RES_NAME} /var/lib/libvirt/images/original/${lVM_IMAGE_NAME}
# Convert Image
sudo qemu-img convert -f qcow2 -O qcow2 /var/lib/libvirt/images/original/ubuntu-22-server.qcow2  /var/lib/libvirt/images/$VM_NAME/root-disk.qcow2
```


```sh
#!/bin/bash

lVM_NAME="mx-ubuntu-bionic-mini"
lVM_MEMORY="1024"
lVM_NETWORK="default"
lVM_OS_VARIANT="ubuntu18.04"
lIMAGE_VM_SRC_PATH="/tmp/mini.iso"
lIMAGE_VM_DST_PATH="/tmp/mx-ubuntu-bionic.qcow2"
lIMAGE_VM_FORMAT="qcow2"



 virt-install \
  --virt-type kvm \
  --network network="${lVM_NETWORK}" \
  --name       "${lVM_NAME}"  \
  --os-variant "${lVM_OS_VARIANT}" \
  --memory     "${lVM_MEMORY}" \
  --location   "${lIMAGE_VM_SRC_PATH}" \
  --disk       "${lIMAGE_VM_DST_PATH}",bus=virtio,format="${lIMAGE_VM_FORMAT}" \
  --graphics none \
  --extra-args console=ttyS0 \
  --console pty,target_type=serial \
  -v --debug





#  virt-install \
#   --virt-type kvm \
#   --network network="${lVM_NETWORK}" \
#   --name       "${lVM_NAME}"  \
#   --os-variant "${lVM_OS_VARIANT}" \
#   --memory     "${lVM_MEMORY}" \
#   --cdrom      "${lIMAGE_VM_SRC_PATH}" \
#   --disk       "${lIMAGE_VM_DST_PATH}",bus=virtio,format="${lIMAGE_VM_FORMAT}" \
#   --nographics \
#   -v --debug






#  --connect qemu:///system
# --cdrom=/home/customize.iso \
# --network bridge=br0 \
# --network bridge=br0 \
# --disk path=/VMs/harddisk/vm.img \
#-x "console=ttyS0" --nographics \
#-v --debug
#   --location   "http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/" \
#   --noautoconsole \
#  --console pty,target_type=serial \
# virt-install 
# --location=/var/lib/libvirt/images/CentOS-7-x86_64-Minimal-1511.iso \
# --disk /var/lib/libvirt/images/centos7.qcow2,device=disk,bus=virtio,size=8 \
# --network bridge:br0 \
# --os-type=linux  \
# --extra-args='console=tty0 console=ttyS0,115200n8 serial'
#  --graphics none \


# virt-install --connect qemu:///system
#-x "console=ttyS0" \


# virt-install \
# -n ApacheServer \
# --description "CENTOS7 for Apache Server" \
# --os-type=Linux \
# --os-variant=rhel6 \
# --ram=2048 \
# --vcpus=1 \
# --disk path=/var/lib/libvirt/images/CentOS7-Apache.img,bus=virtio,size=10 \
# --graphics none \
# --console pty,target_type=serial \
# --location /home/server/Downloads/CentOS-7-x86_64-Minimal-1810.iso \
# --network bridge:virbr0 \
# --extra-args console=ttyS0



# virsh --connect qemu:///system console mx-ubuntu-bionic-mini
```


## Download Image
```sh
# Define var
# CentOS 8 Linux x86_64 - QCOW2
lImageName="CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
lImagePath="centos/8/x86_64/images"
lImageUrl="cloud.centos.org"


# CentOS 8 Linux x86_64 - ISO
lImageName="CentOS-8.2.2004-x86_64-boot.iso"
lImagePath="centos/8.2.2004/isos/x86_64"
lImageUrl="mirror.dhakacom.com/centos"

# CentOS 8 Stream Linux x86_64 - QCOW2
lImageName="CentOS-Stream-GenericCloud-8-20200113.0.x86_64.qcow2"
lImagePath="centos/8-stream/x86_64/images"
lImageUrl="cloud.centos.org"


# CirrOS - IMG 
lImageName="cirros-0.5.1-x86_64-disk.img"
lImagePath="0.5.1"
lImageUrl="download.cirros-cloud.net"

# Ubuntu 22.04 - IMG
lImageName="jammy-server-cloudimg-amd64.img"
lImagePath="jammy/current"
lImageUrl="cloud-images.ubuntu.com"

# Ubuntu bionic - small - ISO
lImageName="mini.iso"
lImagePath="ubuntu/dists/bionic/main/installer-amd64/current/images/netboot"
lImageUrl="archive.ubuntu.com"

# Download the VM image
wget https://${lImageUrl}/${lImagePath}/${lImageName}
```


## Convert Image:Format
```sh
# from RAW (aka IMG) to QCOW2 
lIMAGE_SRC="/tmp/jammy-server-cloudimg-amd64.img"
lIMAGE_DST="/tmp/jammy-server-cloudimg-amd64.qcow2"

qemu-img convert -f raw -O qcow2 "${lIMAGE_SRC}" "${lIMAGE_DST}"
```



## Create 1 vDISK
```sh
# Define Var
lIMAGE_VM_SIZE="10G"
lIMAGE_VM_FORMAT="qcow2"
## QCOW2
lIMAGE_VM_DST_PATH="/tmp/mx-ubuntu-bionic.qcow2"
lIMAGE_VM_DST_PATH="/tmp/centos.qcow2"
lIMAGE_VM_DST_PATH="/tmp/mxubuntu2204.qcow2"

## IMG
lIMAGE_VM_DST_PATH="/var/kvm/images/ubuntu2004.img"

# create vDISK - create 1 image@(vm, empty)
qemu-img create -f ${lIMAGE_VM_FORMAT} ${lIMAGE_VM_DST_PATH} ${lIMAGE_VM_SIZE}
```



```sh
# Define Var
lIMAGE_VM_FORMAT="raw"
lIMAGE_VM_SIZE="10G"
## QCOW2
lIMAGE_VM_DST_PATH="/var/lib/libvirt/qemu/debian-vm.img"
#
mkdir -p /var/lib/libvirt/qemu/
#
## create vDISK
qemu-img create -f -f ${lIMAGE_VM_FORMAT} -o size=${lIMAGE_VM_SIZE} ${lIMAGE_VM_DST_PATH}
```

## Create 1 VM
```sh
# Define var
lVM_NAME="mx-ubuntu-bionic-mini"
lVM_MEMORY="1024"
lVM_NETWORK="default"
lVM_OS_VARIANT="ubuntu18.04"
lIMAGE_VM_SRC_PATH="/tmp/mini.iso"
lIMAGE_VM_DST_PATH="/tmp/mx-ubuntu-bionic.qcow2"
lIMAGE_VM_FORMAT="qcow2"

# Create VM
 virt-install \
  --virt-type kvm \
  --name "${lVM_NAME}"  \
  --ram  "${lVM_MEMORY}" \
  --cdrom "${lIMAGE_VM_SRC_PATH}" \
  --disk  "${lIMAGE_VM_DST_PATH}",format="${lIMAGE_VM_FORMAT}" \
  --network network="${lVM_NETWORK}" \
  --graphics none \
  --console pty,target_type=serial \
  --noautoconsole \
  --os-variant "${lVM_OS_VARIANT}"
#  --disk /var/lib/libvirt/images/bionic.qcow2,bus=virtio,size=10,format=qcow2 \
```

```
## Define Var
lVM_NAME="mxubuntu2204"
lVM_CPU="1"
lVM_MEMORY="1024"
lVM_NETWORK="default"
lVM_OS_VARIANT="ubuntu22.04"
lIMAGE_VM_SRC_PATH="/tmp/jammy-server-cloudimg-amd64.img"
lIMAGE_VM_SRC_PATH="/tmp/jammy-server-cloudimg-amd64.qcow2"
lIMAGE_VM_DST_PATH="/tmp/mxubuntu2204.qcow2"
lIMAGE_VM_FORMAT="qcow2"

# instanciate Vm with image
virt-install \
  --virt-type   "kvm" \
  --network     network="${lVM_NETWORK}" \
  --name        "${lVM_NAME}" \
  --vcpus       "${lVM_CPU}" \
  --memory      "${lVM_MEMORY}" \
  --os-variant  "${lVM_OS_VARIANT}" \
  --location    "${lIMAGE_VM_SRC_PATH}" \
  --disk        "${lIMAGE_VM_DST_PATH}",format="${lIMAGE_VM_FORMAT}" \
  --graphics    none \
  --noautoconsole


virt-install 
--name centos8-2 
--memory 10240 
--vcpus=2 
--location=/tmp/rhel-server-7.6-x86_64-dvd.iso  
--network bridge=nm-bridge  
--graphics=none 
--console pty,target_type=serial 
--noautoconsole 
--extra-args console=ttyS0  -v Using centos7.0 default --disk size=10






# instanciate Vm with image
virt-install \
  --location    "${lIMAGE_VM_SRC_PATH}" \
  --os-variant  "${lIMAGE_VM_SRC_OS_VARIANT}" \
  --os-type     "${lIMAGE_VM_SRC_OS_TYPE}" \
  --name        "${lVM_NAME}" \
  --virt-type   "kvm" \
  --ram         1024 \
  --disk        "${lIMAGE_VM_DST_PATH}",format=${lIMAGE_VM_FORMAT} \
  --network     network=default \
  --graphics    vnc,listen=0.0.0.0 \
  --noautoconsole \



## Define Var > Vm
lIMAGE_VM_SRC_PATH="/data/isos/CentOS-7-x86_64-NetInstall-1611.iso"
lIMAGE_VM_SRC_OS_VARIANT="centos7.0"
lIMAGE_VM_SRC_OS_TYPE="linux"
lVM_NAME="mxcentos7"


# Method
virt-install   \
--name Debian-vm   \
--ram 1024  \
--disk path=./var/lib/libvirt/qemu/debian-vm.img \
--vcpus 1 \
--os-type linux \
--network bridge=virbr0 \
--graphics vnc,port=5999 \
--console pty,target_type=serial \
--cdrom ./debian.iso
```

```sh
# Method
virt-install \
--network     network=default \
--disk    path=/var/kvm/images/ubuntu2004.img,format=qcow2 \
--location    'http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' \
--os-type linux \
--os-variant  ubuntu20.04 \
--name    ubuntu2004 \
--ram     2048 \
--vcpus   2 \
--graphics    none \
--console     pty,target_type=serial \
--extra-args  'console=ttyS0,115200n8 serial'
```

```sh
# Method
 virt-install \
--network    network=default \
--disk       /tmp/centos.qcow2,format=qcow2 \
--location=/data/isos/CentOS-7-x86_64-NetInstall-1611.iso
--os-type=linux \
--os-variant=centos7.0 \
--name      centos 
--ram       1024 \
--virt-type kvm 
--graphics   vnc,listen=0.0.0.0 
--noautoconsole \
```

# Other
```sh
virsh list --all
```