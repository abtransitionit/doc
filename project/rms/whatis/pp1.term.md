[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ The System][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)

<div align="center">

# Project RMS — Phase1: Terminology

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>



|Term|Meaning|Example|
|-|-|-|
|**Resource**| An entity on which it is possible to perfom an action|a host, a file, a package|
|**Capability** | An **action** a resource provide or support|read, write, start, stop|
|**Execution Environment**|The context in which a resource exists or is provisioned| a cloud infra, a cluster, a host| 
|**Host**|an execution environment|a VM, a container, a bare-metal
|**Agent** | User that invokes the system|a Human, a Program, an AI agent
|**Intent** | An **action** an agent want to perform on a resource|read a file, provision a k8s cluster, start VM, Install a package|
|**Operation Request** |the system internal representation of an **intent**||
|**Deployment Stage**|The stage in which resources are deployed and managed.| dev, stagging, prod|

**Note**

1. According to the **context**, an entity:
    - may be considered as a whole (**atomic**) or made of component resources (**composite**)
    - may have the role of **resource** or **host**.
1. An Execution Environment may be considered as a resource when provisioning it.

<details>
<summary><h1>Document Metadata</h1></summary>

**Information**

| Property | Value |
|:--|:--|
| **Doc-ID**       | PP1-TERM-01-RMS    |
| **Project**      | RMS                |
| **Path**         | `pp1.term.md)` |
| **Last Updated** | 2026-10-20         |

**Revision History**

| Date | Version | Author | Summary |
|:--|:--|:--|:--|
| 2026-10-18 | `v0.1` | amar | Initial draft |

</details>
