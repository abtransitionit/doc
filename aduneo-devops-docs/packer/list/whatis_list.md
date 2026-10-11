# [Packer][Topic_Whatis] > [List][List_List] > Whatis


[//]: #(Reference)
[Topic_Whatis]:             ../README.md
[List_List]:                ../list/list_list.md
[Tempmlate_Whatis]:         ../whatis/template_whatis.md
[Build_Whatis]:             ../whatis/build_whatis.md
[Machine_Whatis]:           ../whatis/machine_whatis.md
[Provisioner_Whatis]:       ../whatis/provisioner_whatis.md
[Var_Whatis]:               ../whatis/var_whatis.md
[Other_Whatis]:             ../whatis/other_whatis.md
[Builder_Whatis]:           ../whatis/builder_whatis.md
[Builder_Docker_Whatis]:    ../whatis/builder_docker_whatis.md
[Builder_Openstack_Whatis]: ../whatis/builder_openstack_whatis.md




Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Tempmlate|[Whatis][Tempmlate_Whatis]
|Build|[Whatis][Build_Whatis]
|Machine|[Whatis][Machine_Whatis]
|Provisioner|[Whatis][Provisioner_Whatis]
|Var|[Whatis][Var_Whatis]
|Other|[Whatis][Other_Whatis]
|Builder|[Whatis][Builder_Whatis]
|Builder Docker|[Whatis][Builder_Docker_Whatis]
|Builder Openstack|[Whatis][Builder_Openstack_Whatis]
<br>

# Builder and communicator
Source blocks use 
  - builders
  - communicators
  
    to define 
      - what kind of virtualization to use
      - howto launch the image you want to provision
      - howto connect to it. 

Builders and communicators are bundled together and configured side-by-side in a source block

# Builder
Each builder has its own unique set of configuration attributes.

## example
plugin docker have following attributes
 - image
 - commit

## example
plugin xx have following attributes
 - xx
 - xx
# Source
1  source 
  - can be reused across multiple builds

1 build
  - can use multiple sources

# Plugin@Builder
- is 1 component of Packer
- is used to 
  - create 1 machine
  - turning that machine into 1 image