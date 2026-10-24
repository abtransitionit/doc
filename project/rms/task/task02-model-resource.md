
[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ Task][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
<div align="center">

# Project RMS — Task - Model - Resource

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Target
- Describes where RMS operates
- **Example**:
    - localhost
    - a remote VM
    - an endpoint

# Provider
- A component
- Describes **how** RMS accesses or manages the resource on that target.
- Knows how to access and manage that a resource in a particular environment.
- Describes **how** the resource is managed.

The same resource can be managed through different providers depending on the target and available capabilities.

The target and provider determine how RMS reaches and manages it.

## Example
- resource=`service/linux:sshd` 
- target=`local` => transport = local
- provider=defaulted to `tool` for this target, but can be override by user

- resource=`service/linux:sshd` 
- target=o1u (vm)  => transport = ssh
- provider=defaulted to `tool` for this target, but can be override by user

# Adress
- Identifies which resource is managed.
- The name or path of one or more resource on the target
- Target **dependant**
- **Example**:
    - a file can be on an S3 or FS
# Kind
- Target independant
- Describes what is managed
- Uses a hierarchical taxonomy/path
- **Example**:
    - `repo/git`, `repo/image/comtainer`, `repo/package/os`
    - `file/file`, `file/folder`
    - `os/kernel/parameter`, `os/kernel/module`
    - `os/linux`, `os/windows`, `os/mac`
    - `package/os`, `module/go`
    - `service/linux/sshd`
    - `vm`, `container`
    - `cluster`, `config`, `manifest`
    - `cluster/k8s`, `cluster/openstack`
    - `cluster/container/k8s`, `cluster/openstack`
    - `cluster/vm/k8s`


# Representation
**As String**

```html
<resource-Kind>:<resource-Adress>
```

**Example**
- `repo/git:my-org/my-app`
- `repo/container/image:nginx`
- `service/os:sshd`
- `file/file:/etc/hosts`

# Reference

[What is a resource](/concept/resource/whatis/ep.md)


# Provider and Mechanism
- file on S3 or FS = provider
# Todo
- resource Kind -> define as path: first item = resource Root Kind = Resource Category
- resource provider
- resource backend
- resource driver

