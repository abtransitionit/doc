# [Docker][Topic_Whatis] > [Howto][Howto_List] > Container


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md
[Image_Howto]:         ../howto/image_howto.md

See also:
|Name|Tag|Description|
|-|-|-|
|Image|[How-to][Image_Howto]|-|


# Create Container
```bash
lCONTAINER_NAME="cdevops"
lIMAGE_NAME="mxi/devops:ubuntu"
docker run --detach --name ${lCONTAINER_NAME} ${lIMAGE_NAME} -c "/usr/bin/sleep infinity"
docker run -d --name cdevop mxi/devops:ubuntu -c "sleep infinity"
```

# Enter Container
## from container@exist
```bash
lCONTAINER_NAME="cdevops"
docker exec -it ${lCONTAINER_NAME} /bin/bash -l
docker exec -it ${lCONTAINER_NAME} /bin/bash -l
```

## from image
```bash
lIMAGE_ID="408a43fb7204"
docker run -it lIMAGE_ID
```

# Delete Container
```bash
# All
docker container rm -f $(docker container list -aq)
docker rm -f $(docker container list -aq)
```

