[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ The System][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[blue whatis]: /project/blueprj/whatis/ep.md
[agent whatis]: ../whatis/pp1.term.md#agent

<div align="center">

# Project RMS — Phase1: Overview

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


| Field            | Value              |
| ---------------- | ------------------ |
| **Doc-ID**       | PP1-VIEW-01-RMS    |
| **Project**      | RMS                |
| **Path**         | `pp1.vision.md`    |
| **Last Updated** | 2026-10-20         |

# Overview

The RMS [projects][blue whatis] aims to provide a unified way to define, manage and provision resources on different environments.

# Problem it solves

Resources are often exposed through heterogeneous tools, protocols, APIs, services, and technologies. Each may require its own interface, interaction rules and execution procedure.

# How it works

1. The [Agent][agent whatis] supplies its intent and inputs to the system.
1. The System builds a request using the standard mechanism (parse, create, normalize, validate).
1. The System executes the request.
1. The System returns the result to the Agent.
