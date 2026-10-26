[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md


[//]: #(ref)
[poc whatis]:     ../whatis/poc.md
[mvp whatis]:     ../whatis/mvp.md
[agent whatis]:   /concept/tool/whatis/ep.md

[↖ Concept][home domain] · [↖ Doc][home doc]

<div align="center">

# What is a Declarative System

The Concept of Declarative System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Overview

**Declarative** an **Imperative** are foundational concepts apllied in several domains of computer science.

**The concepts**

- In a **declarative** context, an [agent][agent whatis] ask a system **what to do**
- In a **imperative** context, an [agent][agent whatis] ask a system **how to do** 

**The root**

For a long time, software used 
- declarative paradigms for **databases**, **UI** and **build tools** 
- imperative paradigms for **IT Infrastructure** with shell scripts or through GUI wizards step-by-step.

When iconic tools like **Terraform** and **Kubernetes** introduced **manifests** and ***state reconciliation*** to manage infrastructure, it felt like a revolution. Not because the concept was new, but because the declarative pradigm was finally being applied to infrastructure.

**Manifest**

- a document that list a set of items (aka. inventory)
- often a txt file in YAML, JSON or TOML
- answers the fundamental question: **"What is this thing, what does it contain, and what does it need to run?"**
- **Examples**:
    - `package.json` in Node.js, 
    - `AndroidManifest.xml` in Android, 
    - extension manifests in browsers. 





## Declarative "In the Hood" vs. Imperative

In software architecture:

* **Declarative** is an interface for humans (or [agents][agent whatis]), while **Imperative** is the engine for the machine.
* At the bare metal level, computers cannot "understand" a **goal** or an **intent**. They only understand sequential **instructions**: fetch this memory address, evaluate this if statement, execute this loop.
* What we call **"declarative systems"** are actually just (clever) **software layers** that **hide imperative logic behind a declarative interface**.

**Declarative design** doesn't eliminate imperative code. It **delegates** it. Instead of an [agents][agent whatis] writing procedural steps for a tool to execute line-by-line and achieve a goal, the agent simply writes a configuration file (a manifest that ultimately defines a goal/intent), and lets the declarative system manage the tasks on its behalf to reach that exact same goal/intent.


**The Declarative approach:** 
- Focus on the **what**.
- Built on manifests and state configurations.
- **Agent:** Defines the **desired end state/Goal/Intent** by creating a manifest. E.g: "create a server running on port 8080 with 2GB of RAM"
- **The System:** Figures out the necessary steps to achieve it.

**Imperative approach:** 
- Focus on the **how**. 
- **Agent / Human:** Provides an **imperative script** or a **sequence of CLI/Instruction**. E.g.: Step 1: ..., Step2: ... .
- **The System:** Executes instructions strictly in order.

**Analogy summary**: 
- **Declarative**: Tell a taxi driver, *"Take me to the airport,"* and letting them figure out the route.
- **Imperative**: Tell a taxi driver, *"Turn left on Main Street, go three blocks, turn right on 5th Avenue..."*
- The counterpart to a declarative config file (manifest) is an **imperative script** or a **sequence of CLI**


## Declarative in a CLI Context

When a command-line tool accepts a **manifest**, it refers to a declarative configuration file that describes the desired state, resources, or execution parameters for a task.

Instead of chaining dozens of flags and arguments in the terminal (e.g., `tool deploy --name app --port 8080 --image v1`), you bundle that configuration into a single document. The CLI reads the manifest as a **single source of truth**, parses its structure, and applies the defined instructions.

* **Common examples:** 
- Kubernetes configuration files (`kubectl apply -f manifest.yaml`), 
- container orchestration files, or build configurations for deployment tools.

**Core value:** It moves interaction from 
- **imperative**: telling the CLI step-by-step what commands to run to
- **declarative** telling the CLI what the final outcome should look like.



# Howto create a pure declarative manifest
- **Pure declarative system** (like Kubernetes or Terraform) 
- the user *never* specifies **steps**, **phases**, or **dependencies**. 
- The user just writes the target reality:
    - *"I want 1 control plane node, 2 worker nodes, and Cilium CNI installed."*
    - The tool figures out that it needs to
        - install packages
        - reboot
        - initialize the cluster behind the scenes.


# foundational component of a declarative system

The architecture of a declarative system (e.g., a CLI) must bridge the gap between an **agent intent**, expressed in a declarative configuration file, and the **machine execution**, carried out by an imperative engine.

This section explores the core building blocks/components of such a declarative CLI architecture, explaining how each component transforms **user intent** into **concrete actions**.


## 1. Manage the manifest

**component**:
- The Manifest Parser
- The Schema Validator (The Contract)


* **What it does:** 
    - Before doing anything
    - a **component** of the system (CLI) reads the manifest (a YAML, JSON, or TOML file).
    - if it failed : this **component** emits an error immediately.
* **The Mechanism:** 
    - a **component** of the system (CLI) validates the file against a predefined schema (like JSON Schema or OpenAPI). 
    - this is done by applying a set of rules (misspelling a property, omitting required field
    - if the validation **failed**: this **component** rejects it immediately.
* **Role:** Translates static text into a structured, programmatic object that the rest of the CLI can understand.

## 2. State Discovery / Introspection Engine (The Observer)

* **What it does:** To know what changes to make, the CLI must first look at the real world (e.g., querying a cloud API, checking a local directory, or inspecting a database).
* **The Mechanism:** It runs procedural queries to fetch the **Actual State**.
* **Role:** Answers the question: *"What currently exists right now in the environment?"*

## 3. The Diff Engine / Reconciler (The Brain)

* **What it does:** This is the core mathematical or logical heart of the system. It takes two inputs:
1. The **Desired State** (parsed from your manifest).
2. The **Actual State** (discovered by the observer).


* **The Mechanism:** It compares them and computes the **Delta** (the difference).
* *If Desired == Actual:* Do nothing ("No changes required").
* *If Desired != Actual:* Generate a plan of action (e.g., "Resource X needs to be created, Resource Y needs its port updated").



## 4. The Execution Engine (The Muscle)

* **What it does:** Once the delta is computed, this component takes over to close the gap.
* **The Mechanism:** This is where the **imperative logic lives**. It translates the abstract delta into concrete, step-by-step API calls, terminal commands, or file writes.
* **Role:** It executes the procedural steps (`Step 1: Call API to create...`, `Step 2: Wait for status...`) sequentially until the environment matches the manifest.

## 5. State Storage / Registry (The Memory)

* **What it does:** Many declarative systems need to remember what they applied previously so they can clean it up later (e.g., if you remove a line from your manifest, the system needs to know it used to exist so it can delete it).
* **The Mechanism:** A hidden state file, local database, or remote registry (like Terraform's `.tfstate` or Kubernetes `etcd`).
* **Role:** Tracks historical metadata about managed resources.


## The End-to-End Flow in a Declarative CLI

When a user runs `my-cli apply -f manifest.yaml`, the internal components execute in this exact sequence:

```text
[ Manifest File ] 
       │
       ▼
 1. Parser & Validator  ──(Validates syntax & structure)
       │
       ▼
 2. Introspection Engine ──(Asks: "What exists right now?")
       │
       ▼
 3. Diff Engine ──────────(Compares Desired vs. Actual -> Calculates Delta)
       │
       ▼
 4. Execution Engine ─────(Runs imperative code to fix the Delta)
       │
       ▼
 5. State Storage ────────(Saves the new state record)

```


<details>

## Todo

Thes concepts leads to the distinction between

* the **WHAT?** and the **HOW?**
* **AUTOMATION** and **PROCEDURE**
* **STATE RECONCILIATION** and **STEP-BY-STEP EXECUTION**
* **MANIFEST** artifact and **CODE** artifact


| Aspect | Declarative | Imperative |
| --- | --- | --- |
| **Question** | **What?** (The desired end state) | **How?** (The exact sequence of steps) |
| **Artifact** | **Manifest file** (YAML, JSON, TOML) | **Code file** (Script, CLI commands, procedural logic) |
| **Execution Logic** | The system figures out how to reach the goal | You explicitly define every single action in order |
| **Execution Logic** | **State Reconciliation** (System computes the delta and applies it) | **Step-by-Step Execution** (Blindly follows instructions in order) |
| **Idempotency** | **High** (Safe to run multiple times; ensures target state holds) | **Low** (Running twice might fail, throw errors, or create duplicates) |
| **Error Recovery** | System handles state reconciliation and drift automatically | Requires manual intervention or custom error-handling code/logic |
| **Readability** | Easy to understand the final setup at a glance | Harder to grasp the big picture buried inside procedural logic |
| **Analogy** | *"Take me to the airport."* (Driver figures out the route) | *"Turn left on Main St, go 3 blocks..."* (You dictate every turn) |

## TODO > Example

* **Databases:** **SQL** (`SELECT * FROM users WHERE age > 18`) is declarative—you ask *what* data you want, and the query engine figures out *how* to scan the disk. Writing manual loops in C to read byte-by-byte is imperative.
* **User Interfaces:** Modern frameworks like **React** or **SwiftUI** are declarative—you state what the UI should look like based on the state. Vanilla JavaScript DOM manipulation is imperative.
* **Build Systems:** Dependency manifests like `package.json` are declarative, whereas old-school shell scripts compiling source files line-by-line are imperative.


### Databases

SQL vs. Procedural Code

**Declarative (SQL):** 
- You write `SELECT * FROM users WHERE age > 18;`. 
- You ask the database **what** data you want. 
- You don't care *how* it scans the hard drive, builds indexes, or traverses memory; 
- the database engine's query optimizer figures out the execution path.

- You write a declarative query (`SELECT * FROM users WHERE age > 18`). 
- the database engine's query planner translates that into a procedural, imperative execution plan. E.g. 
    - Step 1: Scan Index B
    - Step 2: Filter rows where page > offset
    - Step 3: Stream to buffer
    - ...


**Imperative (Procedural):** 
- You write a custom loop in C or Python that opens a file, reads line by line, checks if the age byte is greater than 18, and manually appends it to an array (**how** to get the data).


### User Interfaces 

(Modern UI Frameworks)

**Declarative (React, SwiftUI, Flutter):** 
- You state, *"Render this button with the text 'Loading' if `isLoading` is true, otherwise show 'Submit'."
- The framework automatically handles updating the screen when the state changes.

**Imperative (Vanilla JavaScript / DOM manipulation):** 
- You write step-by-step instructions: `let btn = document.getElementById('my-btn'); btn.innerText = 'Loading'; btn.disabled = true;` 
- telling the browser every single mutation to make


* **UI Frameworks (React):** 
- You declaratively write what the page should look like based on state. 
- Under the hood, **React** runs procedural JavaScript algorithms (like the Fiber reconciler) to issue imperative DOM commands to the browser (`document.createElement`, `element.appendChild`).


### Build tools

Software Packaging & Build Systems

**Declarative (Node.js `package.json`, Java Maven `pom.xml`):** 
- You list the dependencies your project requires. 
- A package manager reads the manifest and resolves the tree.


**Imperative:** 
- Writing a shell script that downloads source code, runs `gcc -c` with specific flags, links libraries manually, and copies binaries to a specific folder step-by-step.








## TODO > Other concepts

```
            [ System Design Paradigm ]
              (or Execution Philosophy)
                         │
        ┌────────────────┴────────────────┐
        ▼                                 ▼
[ Declarative ]                   [ Imperative ]
(Intent-driven)                  (Step-driven)
        │                                 │
  - Manifest file                   - Script / Commands
  - Focus: WHAT                     - Focus: HOW
  - State Reconciliation            - Step-by-Step Execution
 ``` 





## TODO > The Prompt Engineering Parallel

This exact same dynamic plays out in how we interact with AI through prompts:

**Prompts are inherently Declarative:** 
- When you write a prompt like, *"Summarize this report into three bullet points for a non-technical executive,- "
- you are defining a **goal and a desired end state**. 
- You are telling the LLM *what*, leaving it to figure out the internal token generation steps to get there.

**Chains and Function Calling lean Imperative:** 
- When you start using frameworks like **LangChain**
- Or writing strict programmatic guardrails
    — "First extract the entities"
    - "Then pass them to Tool A"
    - "Then validate the output against Schema B"
— you are stepping into **imperative territory**. 
- You are scripting the exact procedural recipe the agent must follow.










## TDOO > How It Works: The Abstraction Stack

1. **The Agent Layer (Declarative):** 
    - You write a manifest telling the system **what** you want without writing code.
    - Examples: *"I want 3 replicas of my app."* You tell 
2. **The Control Layer (Imperative Engine):** 
    - Underneath, the system runs a reconciliation loop (like a Kubernetes controller written in Go). 
    - That controller is literally made of procedural code:
    ```go
    for {
        actualState := getClusterState()
        if actualState.replicas < desiredState.replicas {
            createPod() // Imperative action
        } else if actualState.replicas > desiredState.replicas {
            deletePod() // Imperative action
        }
        time.Sleep(10 * seconds)
    }

    ```


</details>
