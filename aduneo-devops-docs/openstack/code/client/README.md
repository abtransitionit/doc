# [&larr;][Home_Readme]OpenStack > Client


[//]: #(Reference)
[Home_Readme]:      ../README.md
[Component_Whatis]: ./whatis/component_whatis.md
[Client_Whatis]:    whatis/client_whatis.md
[List_list]:        list/list_list.md
[Howto_list]:       list/howto_list.md
[Component_List]:   list/component_list.md
[Release_List]:     list/release_list.md
[Reference_List]:   list/reference_list.md
[release_Whatis]:   whatis/release_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|List|[List][List_list]|
|Client|[Whatis][Client_Whatis]|
|OpenStack|[How-to][Howto_list]|
|Composant|[List][Component_List], [Whatis][Component_Whatis]
|Release|[List][Release_List], [Whatis][release_Whatis]
|Reference|[List][Reference_List]
<br>

# file : clouds.yaml
- is1 file@(txt.yaml)
- is1 file@config
- Allow to connect to 1..N cloud@ops
- is private to 1 user
- is used by cli:openstack
- have location:
  - **~/.config/openstack**
  - **/etc/openstack**


# file : ${project}-openrc.sh