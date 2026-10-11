# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Image

[//]: #(Reference)
[Topic_Whatis]:  ../README.md
[Howto_List]:    ../list/howto_list.md
[Image_Whatis]:  ../whatis/image_whatis


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Image|[Whatis][Image_Whatis]|
<br>

# Convert Between Format
## with **qemu-img**
```bash
# Convert from raw to qcow2
qemu-img convert -f raw -O qcow2 image.img image.qcow2

# Convert from vmdk to raw
qemu-img convert -f vmdk -O raw image.vmdk image.img

# Convert from vmdk to qcow2
qemu-img convert -f vmdk -O qcow2 image.vmdk image.qcow2
```
- When converting an image file with Windows, ensure the virtio driver is installed.

## with **VBoxManage**
```bash
# Convert from raw to vmdi with Virtualbox:Cli:VBoxManage
VBoxManage clonehd ~/VirtualBox\ VMs/image.vdi image.img --format raw
```