# [Packer][Topic_Whatis] > [Howto][Howto_List] > Template


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Terraform_Whatis]: ../README.md
[Template_Whatis]:  ../whatis/template_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Template|[Whatis][Template_Whatis]


## Create
```bash
lFOLDER_PATH="/home/ubuntu/mxpacker"
lILE_NAME="docker-ubuntu.pkr.hcl"
lILE_PATH="${lFOLDER_PATH}/${lILE_NAME}"
# Create folder
mkdir ${lFOLDER_PATH}
# Create file
cd folder
touch ${lILE_PATH}

# Update file
packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:xenial"
  commit = true
}

build {
  name    = "learn-packer"
  sources = [
    "source.docker.ubuntu"
  ]
}

```