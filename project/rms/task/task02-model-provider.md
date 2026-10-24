
[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ List Task][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
<div align="center">

# Project RMS — Task - Model - Provider

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

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


# Provider and Mechanism
- file on S3 or FS = provider


