# [Docker][Topic_Whatis] > [Howto][Howto_List] > Image


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md
[Container_Howto]:     ../howto/container_howto.md

See also:
|Name|Tag|Description|
|-|-|-|
|Container|[How-to][Container_Howto]|-|

# Delete [all | only] Image@none 
```bash
# Method
docker image rm -f  $(docker images -f dangling=true -q)
# Method
docker rmi $(docker images -f dangling=true -q)
```

# Build Container from image
```bash
# Define var
lIMAGE_NAME="mxi/ubuntu:22.04"
# Do not > Play > file > .bashrc
docker run -it ${lIMAGE_NAME}
# Play > file > .bashrc
docker run -it ${lIMAGE_NAME} -c /bin/bash
```