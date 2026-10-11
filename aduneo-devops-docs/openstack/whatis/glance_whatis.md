# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Glance


[//]: #(Reference)
[Topic_Whatis]:   ../README.md
[Whatis_List]:    ../list/whatis_list.md
[Component_List]: ../list/component_list.md
[Image_Whatis]:   ../whatis/image_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Composant|[List][Component_List]
|Image|[Whatis][Image_Whatis]
<br>

# Definition
Glance est
  - 1 composant OpenStack

Glance
- Provide image for instance
- Can store|provide image from different backend
  - Nfs : San/Nas
  - S3
  - Ceph, Swift
  - file (i.e Forlder **/var/lib/glance/images/**)
- manage Image and Image:Data@Meta
- allow to
  - list|display|get|store Vm:image (and Image:Metadata)

# Component
- api
- db
- storage
- Metada service  

# Toknow
- A number of periodic processes run on the OpenStack Image service to support caching.
  