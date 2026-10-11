# [&larr;][Home_Readme]Libvirt


[//]: #(Reference)
[Home_Readme]:    ../README.md
[Howto_list]:     list/howto_list.md
[List_list]:      list/list_list.md
[Reference_List]: list/reference_list.md
[Hyperviseur_Whatis]: ../linuxtool/whatis/hypervisor_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|List|[list][List_List]|
|Hyperviseur|[Whatis][Hyperviseur_Whatis]|
<br>



# Libvirt > C'est quoi
Est 1 library **de bas niveau**  
  - utilisé par de nombreuses Cli et Hyperviseur
  - disponable dans plusiuers langage (e.g Go, Python, ..)
  - qui utilkise des fichier XML comme fichier de config
  - qui permet les actions suivantes sur 1 Vm:
    - create
    - delete
    - migrate
    - ...

# File@Conf
- /etc/libvirt/qemu/networks/
- var/lib/libvirt/