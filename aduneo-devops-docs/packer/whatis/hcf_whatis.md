# [Packer][Topic_Whatis] > [Whatis][Whatis_List] > Hcf


[//]: #(Reference)
[Topic_Whatis]:       ../README.md
[Whatis_List]:        ../list/whatis_list.md
[Builder_Howto]:     todo
[Template_Howto]:    ../howto/template_howto.md

# Definition
- is1 Acronym
- is1 file@txt written in Hcl

# Member
block
- packer
- source
- build

# Example
```bash
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

# Block : Packer
## Member
|Name|Tag|Desc|
|-|-|-|
|required_plugins|-|define plugin@(required, HashiCorp)|

# Block : Source
is uniquely defined by 
  - Member:Type
  - Member:Name
## Member
|Name|Tag|Desc|
|-|-|-|
|Type|
|Name|
|property||set of kvpair

# Block : Build

## Member
|Name|Tag|Desc|
|-|-|-|
|provision|-|Define additional provisioning steps|
|Post-process|-|Define what do to with the build artifacts|
