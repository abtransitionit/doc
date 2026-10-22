[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)

<div align="center">

# Project RMS — List of use cases

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


| Field            | Value              |
| ---------------- | ------------------ |
| **Doc-ID**       | LIST-UC-01-RMS    |
| **Project**      | RMS                |
| **Path**         | `list/usecase.md` |
| **Last Updated** | 2026-10-20         |

Steps
- concurent/sequential


**composite on one resource**
Create a file
- resource = file
- capability= `mkdir` + `write` + `chmod`
- order = sequence
**orchestration across resources**
provision a VM
- resource = VM
- capability = configure + start + verify, on multiple resources

OperationRequest 
- a sequence
- a DAG
- a single operation 