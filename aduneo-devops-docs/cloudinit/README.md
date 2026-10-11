# [&larr;][Home_Readme]Cloudinit


[//]: #(Reference)
[Home_Readme]:    ../README.md
[Howto_list]:     list/howto_list.md
[List_list]:      list/list_list.md
[Reference_List]: list/reference_list.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|List|[List][List_list]|
|Reference|[List][Reference_List]
<br>



# C'est quoi

CloudInit est
  - 1 standard

CloudInit permet
  - d'exécuter des instruction sur une Vm lors de sa création dans 1 cloud (aws, azure, openstack, vmware, ...)

# Process
On instance boot, cloud-init will
- Identify the cloud it is running on
- Read any provided metadata from the cloud
- Execute code in the metadata. This may involve (setting up many other aspects of a system)
  - Setting up network
  - Setting up storage devices
  - Configure SSH keys
- Parse and process any optional user or vendor data that was passed to the instance

