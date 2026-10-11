# [Openstack][Topic_Whatis] > [Howto][Howto_List] > Glance

[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Howto_List]:       ../list/howto_list.md
[Glance_Whatis]:    ../howto/glance_howto.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Glance|[Whatis][Glance_Whatis]|
<br>

# uplo  ad image
```bash
# get image
wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img

# upload image to registry@glance (e.g folder)
lVM_IMAGE_NAME="cirros"
lVM_IMAGE_FILE_PATH="/tmp/cirros-0.4.0-x86_64-disk.img"
glance image-create               \
  --name "${lVM_IMAGE_NAME}"      \
  --file "${lVM_IMAGE_FILE_PATH}" \
  --disk-format qcow2             \
  --container-format bare         

```bash
openstack image create "cirros2" 
--file cirros-0.3.5-x86_64-disk.img 
--disk-format qcow2 
--container-format bare 
--public