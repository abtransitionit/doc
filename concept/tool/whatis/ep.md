[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[res hardware whatis]: /concept/resource/whatis/hardware.md
[term list]: ../list/term.md
[system whatis]: #
[artifact whatis]: #
[prj software whatis]: /concept/project/kind/software/whatis/ep.md
[software whatis]: ../whatis/software.md
[tool list]:       ../list/ep.md
[tool arm list]:   /tool/README.md
[language list]: /language/README.md
[tool howto]:      ../howto/ep.md
[ssg whatis]:      ../whatis/ssg.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Language][language whatis]|internal| 
|[What is a Hardware Resource][res hardware whatis]|internal| kind |
|[What is a Software Project][prj software whatis]|internal|
|[List of tools][tool list]|internal| list |
|[List of languagess][language list]|internal| list |
|[How-to for CLI][tool howto]|internal|  |
|[List of  ARM Tools][tool arm list]|external|  |



<h1 align="center">What is a Tool</h1>

The concept of tool ([software][software whatis])


# Definition

## Agent <a id='agent'></a>
Invokes (i.e initiates, executes) a [tool](#tool).


| Kind | How tool is invoked |
| --- | --- |
| Human | Intentional, direct usage |
| Program / Script / Code | Programmatic invocation of functions, APIs, or commands |
| Automated Process | Rule-driven execution via schedules or triggers |
| AI System | Autonomous tool selection, planning, and execution |

## Tool <a id='tool'></a>
- Aka. **Program**, **Software**
- A set of code, configuration and libraries assembled together
- Executes/perfoms an action or task.
- The granularity of the action or task ranges from 
  - **low-level** OS operations (e.g., file I/O)
  - **high-level** platform workflows (e.g., environment provisioning).
- Provides the capability to **perform, enable, simplify, or automate** an action or task.
- Invoked by an [Agent](#agent)
- Examples:
  - compilers, servers, etc.
  - CLI, Cde, APIs, etc.
  - IDEs, Browsers, Word, Excel, etc.

# Dimensions of a Tool

Designing a tool requires mapping it across these core dimensions:

```
Tool
│
├── Purpose
│
├── Capability
│
├── Role
│   ├── Consumer
│   └── Provider
│
├── Interface
│   ├── CLI
│   ├── GUI
│   ├── API
│   ├── REPL
│   └── ...
│
├── Abstraction level
│
├── Execution model
│
└── Composition
```

## 1. Abstraction Level

| Level | Examples |
|-------|----------|
| Extra Low | Operating System |
| Low | Sentence, Instruction, Procedure, Function, Program |

```
┌────────────────────────────────────────────────────────────────────────┐
│                                 TOOL                                   │
│           Software capability that executes a task or workflow         │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│                                                                        │
│  LOW-LEVEL (Primitives)                                                │
│  ┌─────────────────────────────────┐                                   │
│  │ OS Syscalls • Functions • Libs  │ ───┐                              │
│  │ e.g., read_file(), socket_open  │    │                              │
│  └─────────────────────────────────┘    │  Imported / Linked statically │
│                                         │  or dynamically into code    │
│  MID-LEVEL (Building Blocks)            │                              │
│  ┌─────────────────────────────────┐ ◄──┘                              │
│  │ Single APIs • Utilities • Cmds  │ ───┐                              │
│  │ e.g., S3.UploadFile(), grep     │    │                              │
│  └─────────────────────────────────┘    │  Piped, chained, or wrapped  │
│                                         │  via API orchestration       │
│  HIGH-LEVEL (Composite Workflows)       │                              │
│  ┌─────────────────────────────────┐ ◄──┘                              │
│  │ Orchestrators • E2E Pipelines   │                                   │
│  │ e.g., terraform apply, CI/CD    │                                   │
│  └─────────────────────────────────┘                                   │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

## 2. Role
| Role | Description |
|------|-------------|
| Client | Consumes services |
| Server | Provides services |

## 3. Interface

| Kind | Description |
|------|-------------|
| CLI | Command-line interface |
| GUI | Graphical user interface |
| API | App Programing  interface |


# The general model

This model shows how a software capability turns user intent into business value:

```
┌─────────┐    provides    ┌──────────────┐    enables    ┌────────┐   contributes   ┌──────┐ achieves  ┌──────┐
│   TOOL  │ ─────────────> │  CAPABILITY  │ ───────────>  │ ACTION │ ──────────────> │ TASK │ ────────> │ GOAL │
└─────────┘                └──────────────┘               └────────┘                 └──────┘           └──────┘
```


a single backend entity is typically accessed through multiple clients:

```
one service, several ways to reach it:

                         TOOL
                           │
             ┌─────────────┼─────────────┐
             │             │             │
          PURPOSE         ROLE        INTERFACE
             │             │             │
           Task       Consumer/         CLI
           Action     Provider          API
           Operation                    SDK
                                        GUI
                                        REPL
                                        etc.
```

The following layered architecture maps how [agents](#agent) (e.g; human actors, automated workflows, and AI systems) traverse entry points down to core logic

```
========================================================================================================================
 ENTRY POINT           Terminal             Code               Browser             Pipeline             Agent           
========================================================================================================================
 CLIENTS               • CLI                • SDK              • GUI               • CI/CD Jobs         • MCP Tools     
                       • Scripts            • Libraries        • Web UI            • GitOps Agents      • AI Bots       
                       • REPL               • Script           • Dashboards        • IaC Runners        • Copilots      
                                                                                   • Scripts                            
====================================================================================================================    
 PURPOSE               • Interactive        • Integration      • Visual            • Automation         • Autonomous    
                       • Dev, Debug, Test   • Application      • Exploration      • Deployment        • Reasoning       
                       • Admin.             • Batch            • Monitoring       • Orchestration     • Tool Use        
                                                                                  • Infrastructure   • Delegation       
--------------------------------------------------------------------------------------------------------------------    
 PARADIGM              Imperative /         Imperative /       Interactive         Imperative /          Intent-Driven  
                       Declarative          Programmatic       (Visual)            Declarative         (Natural Languag
                                                                                  (Automation)
========================================================================================================================
                               │                    │                   │
                               ▽                    ▽                   ▽
 PROTOCOL / TRANSPORT     [ REST / GraphQL ]   [ gRPC / WS ]      [ Other Protos ]
                               │                    │                   │
                               └────────────────────┼───────────────────┘
                                                    │
====================================================================================================================
                                                    │
                                                    ▽
 API SURFACE                                [ API Gateway / Spec ]                               <───── API Layer
 (The Contract)                             (OpenAPI, Proto, Schema)
                                                    │
                                                    ▽
 SERVER / BACKEND                           [ Service / Server ]                                 <───── Core Engine
                                            (Domain Logic, Data)

```


```
┌───────────┐         ┌───────────┐
│  Client   │ ◄─────► │  Server   │
│ (Consumer)│         │ (Provider)│
└───────────┘         └───────────┘
```

**API as Source of Truth:**
- Defines capabilities, *what* the system can do. 
- Every feature must exist in the API first before a CLI, SDK, or UI can expose it.
- It's the contract: endpoints, auth, request/response shapes. Everything else is a client of it.

**CLI and SDK:**
- the CLI and SDK expose subsets of the API.
- A CLI command may only cover 80% of endpoints
- the SDK usually covers ~100% (auto-generated from the API spec)
- Sit at the exact same level in the architecture stack.
- Both sit on top of the API. 
- **SDK** wraps the same API so you can call it from code (Python, Go, JS, Java…). It handles auth, serialization, retries, pagination.
- **CLI** is a program that wraps the API in shell-friendly commands. Usually written *using* an SDK (or the same underlying client code).
- Often the CLI is literally built on the SDK, but conceptually they're peers.It is simply an SDK with a terminal interface attached to it. 
- In fact, many major tech companies (like `AWS`, `Stripe`, or `GitHub`) auto-generate both their SDKs and their CLI tool directly from the exact same `OpenAPI` or `gRPC` specification file.

**Versioning the API.** 
- When the API adds an **endpoint**, SDKs get regenerated, and CLIs get updated — usually in that order.

**Auth is often shared:** CLIs store credentials the API needs. The SDK reads the same credentials (env vars, config files).
- `gh auth login`, 
- `aws configure`/SSO, 
- `kubectl`'s kubeconfig 


**Service Endpoint Examples:**
- **`api.github.com`** $\rightarrow$ Web API Endpoint (REST / GraphQL)
- **`s3.amazonaws.com`** $\rightarrow$ Object Storage API Endpoint (REST)
- **`kube-apiserver`** $\rightarrow$ Cluster Management API Endpoint (REST / HTTP)

**The Complete Chain in Action**

$$\text{API (Contract)} \longrightarrow \begin{cases} \text{\textbf{SDK}} & \text{(Language Bindings for Programmers)} \\ \text{\textbf{CLI}} & \text{(Terminal Commands for Humans / Scripts)} \\ \text{\textbf{Web UI}} & \text{(Graphical Interface for Browsers)} \\ \text{\textbf{MCP / Agent}} & \text{(Tool Specs for AI Models)} \end{cases}$$



# Example


## GitHub
- **API**: GitHub REST API + GitHub GraphQL API.
- **SDK**: `go-github` (Go), `octokit` (JS), `PyGithub` (Python), etc.
- **CLI**: `gh` — built in Go, uses the GitHub API directly / via Go libraries.
- **Link**: `gh pr create` → sends REST/GraphQL calls to `api.github.com`. You could do the same from Python with `PyGithub`.

## Amazon Web Services
- **API**: Each AWS service has its own API (S3, EC2, IAM…). Mostly HTTP/JSON (query or REST-ish), plus some gRPC.
- **SDK**: `boto3` (Python), `aws-sdk-js`, `aws-sdk-go`, `aws-sdk-java`, etc.
- **CLI**: `aws` (v2) — itself built on the `botocore` layer (same core as `boto3`).
- **Link**: `aws s3 cp file s3://bucket/` → hits the S3 API. `boto3.client('s3').upload_file(...)` → same API. The CLI is essentially a thin shell over the same SDK internals.

## Kubernetes
- **API**: The Kubernetes API server (REST over HTTP, resource-oriented, `/api`, `/apis`).
- **SDK**: `client-go` (Go, the canonical one), `kubernetes-client/python`, `kubernetes-client/javascript`, etc.
- **CLI**: `kubectl` — built on `client-go`.
- **Link**: `kubectl get pods` → GET request to the API server. A Python script with the `kubernetes` client doing `list_namespaced_pod(...)` → same API call. Same kubeconfig, same auth.

## Helm

* **API**: Kubernetes API server (Helm acts as a client that creates/manages Kubernetes custom resources and secrets).
* **SDK**: `helm.sh/helm/v3/pkg/...` (Go packages like `action`, `chart`, `release`).
* **CLI**: `helm` — built in Go, consumes the Helm Go packages directly.
* **Link**: `helm install my-app ./chart` → parses the chart via Helm Go libraries and issues gRPC/REST calls to `kube-apiserver`. A custom Go program importing `helm.sh/helm/v3/pkg/action` doing `install.Run(...)` → same API calls.

## OpenStack

* **API**: Individual service APIs (`nova` for compute, `neutron` for networking, `cinder` for storage) exposed as HTTP/REST endpoints.
* **SDK**: `openstacksdk` (Python), `gophercloud` (Go), `openstack-sdk-php`, etc.
* **CLI**: `openstack` (OpenStackClient / OSC) — written in Python, built directly on top of `openstacksdk`.
* **Link**: `openstack server create my-vm` → sends POST requests to the Nova API endpoint. A Python script using `openstacksdk` with `conn.compute.create_server(...)` → hits the exact same REST API.

## Docker / Moby

* **API**: Docker Engine HTTP API (Unix domain socket locally, TCP/TLS remotely).
* **SDK**: `docker` / `moby/moby` (Go SDK), `docker` (Python library), `dockerode` (Node.js), etc.
* **CLI**: `docker` — built in Go, uses the official Go Docker SDK under the hood.
* **Link**: `docker run nginx` → sends a `POST /containers/create` request to `/var/run/docker.sock`. A Node.js script using `dockerode.createContainer(...)` → sends the exact same HTTP request to the same socket.

## HashiCorp Terraform

* **API**: Terraform Cloud / Enterprise REST API (for remote state and execution) and individual Provider Cloud APIs (AWS, Azure, GCP APIs).
* **SDK**: `terraform-plugin-sdk` / `terraform-plugin-framework` (Go framework for writing providers that translate declarative configuration to downstream APIs).
* **CLI**: `terraform` — built in Go, executes the engine core and calls provider binaries via gRPC.
* **Link**: `terraform apply` → the engine evaluates state, invokes the provider plugin, and sends REST calls to the cloud API (e.g., `api.github.com`). A Go program using the `terraform-exec` library → invokes the same engine and provider pipeline.



# Terminology



## (CPU) Operation
- The lowest atomic action executed in a computing [systems][system whatis].
- Executed at **runtime** directly by the CPU [Hardware][res hardware whatis] (e.g., bitwise shift, register read, memory store).


```go
// Examples of CPU operations
OPERATION 1:Read R1
OPERATION 2:Send R1 to ALU input A
```

## Assembly Statement
- Aka Machine statement
- The next lowest atomic action executed in computing [systems][system whatis].
- Usually triggers several **CPU Operations**.

```go
// Example of a assembly/machine language Statement
ADD R1, R2 → R3

// resulting CPU Operations
OPERATION 1: Read R1
OPERATION 2: Read R2
OPERATION 3: Send R1 to ALU input A
OPERATION 4: Send R2 to ALU input B
OPERATION 5: ALU performs addition
OPERATION 6: Store ALU result in R3
OPERATION 7: Update CPU flags
```

## Language Statement
- a sentence written in a human understandable [language][language whatis] (Shell, Java, Python, Go, etc.)
- performs a task
- Is translated (at **compiltime** by a compiler/linker or interpreter) into several **Assembly statements**



```go
// a statement 
x := x + a 
```


## Block of code
- A set of Language statements considered as a whole
- Performs a task

```go
// some code
if index < 0 || index >= len(slice) {
    return zero, false
}
```


## Function/Procedure

- A reusable, named block of code
- Configurable through inputs (parameters).
- Procedure: Traditionally **does not return a value** to its caller.
- Function:  Usually **returns a value** to its caller.
- The fundamental building block for **Program**


Example:

```python
// procedure that accepsts one parameter: msg and return nothing
def print_message(msg):
    // statement
    print(msg)

// function that accepsts 2 parameters: a and b an return something
def square(a, b):    
    y = a * b        # Statement
    return y         # Statement

```


## Library
- A collection of functions and procedures often packaged in an [artifact][artifact whatis].



# Summary

**Extra Low Level**
- Operating System 
— Foundation software that manages a machine's hardware resources and provides base services for programs

**Low Level**
- Instruction — Atomic CPU operation
- Statement — Executable unit of source code

**Mid Level**
- Procedure — Named sequence of operations
- Function — Reusable callable unit of code
- Library — Reusable collection of code and data/resources
- SDK — Collection of libraries, tools, data/resources, and supporting artifacts

**High Level**
- Program — Executable software assembled from code, libraries/SDKs, and data/resources
- CLI — User interface for interacting with a program through text commands
- Software — General term for programs, libraries, SDKs, tools, and related artifacts


**Data** 
- can originate at any level of the software stack. 
- It may be defined or embedded inside a library, SDK, or program.
- It may be supplied externally at runtime (e.g. a database, YAML/JSON file, environment variable, or user input)

# Kind of Tool
- [SSG][ssg whatis]

# Todo
Execution Environment 
- kernel-space vs. user-space
- container, vm, cloud platform.

## Relationship


| Term | Relationship |
|------|--------------|
| Action | often synonym for operation |
| Task | What a tool performs |
| Operation | Atomic unit of work |
| Server | <li>Tool that provides services to client <li> listens requests from client |
| Client | <li>Tool that consumes services from servers <li> sends request to server |









