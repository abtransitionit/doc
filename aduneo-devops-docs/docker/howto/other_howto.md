# [Docker][Topic_Whatis] > [Howto][Howto_List] > Other


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Application_Whatis]:  ../whatis/application_whatis.md


# Create targz from image@(docker local)
## Method
```bash
lIMAGE_NAME="docker-registry.maq.aduneo.com/neopage"
lIMAGE_TAG="latest"
lTARGZ_FULLPATH="/tmp/mxi-neopage.tgz"

lIMAGE_NAME="nginx"
lIMAGE_TAG="latest"
lTARGZ_FULLPATH="/tmp/mxi-nginx.tgz"

lIMAGE_NAME="tomcat"
lIMAGE_TAG="9.0-jdk8-adoptopenjdk-openj9"
lTARGZ_FULLPATH="/tmp/mxi-tomcat.tgz"

lIMAGE_FULLNAME="${lIMAGE_NAME}:${lIMAGE_TAG}" 
docker save -o ${lTARGZ_FULLPATH} ${lIMAGE_FULLNAME} 
```
## Method
```bash
lIMG_01="registry.aduneo.com/client-dinum/dinum-jason"
lIMG_02="registry.aduneo.com/client-dinum/dinum-neopage"
lIMG_03="registry.aduneo.com/aduneo-docker/backup-images/nginx"
lDST_FILE="image.aduneo"
docker save ${lIMG_01} ${lIMG_02} ${lIMG_03}  > ${lDST_FILE}
tar -cvzf ${lDST_FILE}.tgz ${lDST_FILE}
```
# Create image@(docker local) from targz 
## Method
```bash
lTARGZ_FULLPATH="/var/tmp/mxi-neopage.tgz"
docker load < ${lTARGZ_FULLPATH}  
```
## Method
```bash
tar -xvzf  ${lDST_FILE}.tgz 
docker load < ${lDST_FILE}
docker load -i ${lDST_FILE}
```
# List
```bash
# container|image
docker container|image list -a
# container|image:Id
docker container|image list -aq
# image@dangling
docker images -f "dangling=true"
```


# Delete
```bash
# container:all
docker container stop  $(docker container list -aq)
docker container rm    $(docker container list -aq)
docker container rm -f $(docker container list -aq)

# image:all
docker image rm -f     $(docker container list -aq)

# image@dangling
docker image rm $(docker images -f "dangling=true")
# all - 
docker system prune -af

```

# Enter 1 container
```bash
lIMAGE_DOCKER_NAME="ubuntu:jammy"
lCONTAINER_DOCKER_NAME="mxc_ubuntu_2204"
docker container run -d --name ${lCONTAINER_DOCKER_NAME} ${lIMAGE_DOCKER_NAME}
docker exec -it ${lCONTAINER_DOCKER_NAME} /bin/bash -l
```

# Login to Registry before push or pull
```bash
# To registry@(gitlab, docker)
lTOKEN_LOGIN_GITLAB="vscode-git-AT"
lTOKEN_PWD_GITLAB="******"
docker login --username ${lTOKEN_LOGIN_GITLAB}  --password ${lTOKEN_PWD_GITLAB} registry.aduneo.com

docker login registry.example.com:5000 --username my_username --password my_password
```

# Logout
```bash
docker logout registry.example.com:5000
```

# Create image from container@running
```bash
lCONTAINER_NAME="cdevops"
lIMAGE_NAME="mxi/devops-git:ubuntu"
lIMAGE_NAME="mxi/ubuntu:dind"
# Create image @untagged
docker commit ${lCONTAINER_NAME} ${lIMAGE_NAME}
```

# todo
```
docker images -f “dangling=true”  -q --no-trunc
```