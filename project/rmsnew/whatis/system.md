[//]: # (home)
[home doc]:    ../../../README.md
[home domain]: ../../README.md
[home topic]:  ../whatis/ep.md

[↖ Project][home topic] · [↖ Projects][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[whatis resource]: ../list/term.md#resource
[whatis host]: ../list/term.md#host
[whatis cluster]: ../list/term.md#cluster

<div align="center">

# Project RMS - The system

A universal Resource Provisioning and Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Purpose
Provision and manage [reources][whatis resource] on a [host][whatis host]


# Provisoning a single resource

# Provisoning multiple resource
- explicitly defined in the manifest
- automatically inferred by the engine
- strict top-to-bottom sequence


# When a provisioning job runs across a [cluster][whatis cluster] and fails on just one of them, what should happen?
The job will have a property named `on_failure` that will be able to take one of the three token:
- **fail-fast** (**stop-all**):
    - Halt the deployment across the entire cluster immediately so things don't get out of sync.
    - The system should stop the whole deployment
- **Best-Effort** (**Continue**)
    - Keep deploying to the remaining healthy nodes and report which ones failed.
    - The system should let the other hosts continue
- **Rollback**: 
    - Undo the changes on the failed node (and optionally the whole cluster) to return to a clean state.
    - The system should roll back everything


# When a resource is successfully provisioned on a node
The system log its current state/metadata? Example
- a local file/state store on the node
- a centralized database
- somewhere else?


## Where do these operation logs get stored or sent?
1. streamed to standard output
1. after: streamed to standard output and local files on each node
1. later: sent to a centralized logging destination?

# When connecting to remote nodes (via SSH or APIs)
The system handle credentials and secrets (like SSH keys, tokens, or passwords)? 
1. read from local environment variables
1. for SSH: SSH clients must be configured
1. after: a local config file
1. later: a dedicated secrets manager

# Operations on resources beyond provisioning
- operation on a resource is resource dependant. 
- a standard set of interface verbs (like a common API contract: read, write, list, inspect, ... that different resources may implement): It keeps the core engine clean while allowing **custom behavior** per resource.

# How The system know how to handle a specific resource type? 
- built-in handlers compiled into the system
- dynamically loaded plugins/binaries
- or something else

we will use the concept of driver where some are compiled into the core and some other dynamically loaded

# Agent experience

How the agent uses the CLI

1. the CLI is built on top of a SDK (a set of GO modules)
2. the cli should accept 2 modes: imperative; declarative
  1. imperative should allows to provision/operate a uniq resource on a host, a set of host or cluster
  2. declarative should first allow to provision/operate a set of resource on a cluster then later a set of resource on a set of cluster

**example**: provision/manage a resource on a host :
```sh
rms resource_kind:resource_location:resource_operation host
```

**example**: provision/manage different resources on a cluster :
```sh
rms manifest/k8s:/tmp/manifest.yaml:provision cluster
```


# When a command runs from the CLI

Feedback and progress must be displayed to the user
- standard streaming text lines
- a rich terminal UI with progress spinners
- or something else?

That covers all the core foundations of your project:

* **Scope:** Nodes and Clusters (local or remote).
* **Execution & Comm:** Agent-based or agentless (SSH), built on a Go SDK with a CLI.
* **Manifests:** Both declarative (YAML/JSON/TOML) and imperative.
* **Resilience:** Configurable `failure_policy` (`fail-fast`, `best-effort`, `rollback`).
* **Extensibility:** Core built-in drivers plus dynamic plugins.
* **Auditing:** Highly configurable logging.

Since you wanted to keep it clear, avoid overengineering, and not talk too long: **Do you want to start designing the Go SDK package structure, or sketch out the YAML manifest schema for a resource?**


# Resource vs. ResourceSet in manifest
`ResourceSet` should be structured relative to individual `Resource` definitions. Example
- a top-level list of individual resources
- a grouped object containing shared defaults
- a list of items