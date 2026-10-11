# [Docker][Topic_Whatis] > [Howto][Howto_List] > Dockerfile


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md




docker rmi $(docker images -f dangling=true -q)
