[//]: #(home)
[home]: ../../README.md

[//]: #(ref)
[hres whatis]: ../../../concept/machine/whatis/hres.md
[term list]: ../list/term.md
[system whatis]: #
[artifact whatis]: #


[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[List of terms][term list]|internal|
|[What is a Hardware Resource][hres whatis]|internal|



<h1 align="center">Concept of Tool</h1>



# Definition
This section provides a terminology (Program, OS, System, Framework, Tool, etc.) that helps define a tool.


## (CPU) Operation
- The lowest atomic action executed in computing a [systems][system whatis].
- Executed directly by the CPU [Hardware][hres whatis] (e.g., bitwise shift, register read, memory store).


```go
// Examples of CPU operations
Read R1
Send R1 to ALU input A
```

## Assembly Statement
- The next lowest atomic action executed in computing [systems][system whatis].
- Usually triggers several CPU Operations.

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
- a sentence written in a human understandable language (Shell, Java, Python, Go, etc.)
- performs a task
- Is translated (at **compiltime** by a compiler/linker or interpreter) into assembly/machine Statements


```go
// a statement 
x := x + a 
```


## Block of code
- A set of single statements considered as a whole
- Performs a task

```go
// some code
if index < 0 || index >= len(slice) {
    return zero, false
}
```


## Function/Procedure

- A named, reusable block of code considered as a whole
- Performs a task
- Can receive inputs (parameters).
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

1. statements are translated into machine instructions
1. machine instructions cause the CPU to perform operations.



## Library
- A collection of functions and procedures often packaged in an [artifact][artifact whatis].

## Software / Program

- A set of code, configuration and libraries assembled together to executes/perfoms an action or task.
- The granularity of the action or task ranges from 
  - **low-level** OS operations (e.g., file I/O) to 
  - **high-level** platform workflows (e.g., environment provisioning).
- Provides the capability to **perform, enable, simplify, or automate** an action or task.


## Tool <a id='tool'></a>
- A software or program invoked by an [Agent](#agent).
- Examples:
  - functions, softawre, programs, 
  - compilers, CLI commands, APIs, servers, IDEs.
  - Word, Excel, ...

## Agent <a id='agent'></a>
Invokes (i.e initiates, executes) a [tool](#tool).


| Kind | How tool is invoked |
| --- | --- |
| Human | Intentional, direct usage |
| Program / Script / Code | Programmatic invocation of functions, APIs, or commands |
| Automated Process | Rule-driven execution via schedules or triggers |
| AI System | Autonomous tool selection, planning, and execution |




# Todo
Execution Environment (e.g., kernel-space vs. user-space, or container vs. cloud platform).


# Kind

```
                         TOOL
                           │
             ┌─────────────┼─────────────┐
             │             │             │
          PURPOSE         ROLE        INTERFACE
             │             │             │
           Task       Consumer/       CLI
           Action     Provider        GUI
           Operation                  API
                                      REPL
                                      etc.
```

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

```
                 ┌──────────────┐
                 │     TOOL     │
                 └──────┬───────┘
                        │
                   provides
                        │
                        ▼
                 ┌──────────────┐
                 │  CAPABILITY  │
                 └──────┬───────┘
                        │
                    enables
                        │
                        ▼
                 ┌──────────────┐
                 │    ACTION    │
                 └──────┬───────┘
                        │
                    contributes
                        │
                        ▼
                 ┌──────────────┐
                 │     TASK     │
                 └──────┬───────┘
                        │
                    achieves
                        │
                        ▼
                 ┌──────────────┐
                 │     GOAL     │
                 └──────────────┘
```                 

# Example
- `git` is a tool that have a CLI named `git` which is an interface through which the tool is operated.


## Related Terms

| Term | Relationship to Tool |
|------|---------------------|
| Software | Tool = Software that performs a specific function |
| Application | Tool = Application focused on user tasks |
| System | Tool = System component or standalone utility |
| Platform | Tool = Built on a platform or is a platform itself |
| Task | Tool = Enables task completion |
| Action | Tool = Performs actions |
| Operation | Tool = Executes operations |

## Lexical Field
Related terms and concepts:

| Term | Relationship |
|------|--------------|
| Action | often synonym for operation |
| Server | <li>Tool that provides services to client <li> listens requests from client |
| Client | <li>Tool that consumes services from servers <li> sends request to server |
| Software | <li>Digital tool |
| Application | User-facing tool |
| System | Complex tool or tool environment |
| Platform | Foundation for other tools |
| Task | What a tool performs |
| Operation | Atomic unit of work |


`Server` · `Client/Server` · `Software` · `Application` · `System` · `Platform` · `Task` · `Action` · `Operation`


# The Ecosystem

## 🔄 By Role
```
┌───────────┐         ┌───────────┐
│  Client   │ ◄─────► │  Server   │
│ (Consumer)│         │ (Provider)│
└───────────┘         └───────────┘
```

## 📊 By Abstraction Level

```
┌─────────────────────────────────────────┐
│ HIGH LEVEL                              │
│  ┌─────────┐  ┌─────────┐               │
│  │  Batch  │  │   GUI   │               │
│  └─────────┘  └─────────┘               │
│  ┌─────────┐  ┌─────────┐               │
│  │  Shell  │  │  REPL   │               │
│  └─────────┘  └─────────┘               │
│  ┌─────────┐  ┌─────────┐               │
│  │  CLI    │  │  CDE    │               │
│  └─────────┘  └─────────┘               │
│  ┌─────────┐  ┌─────────┐               │
│  │ Program │  │Function │               │
│  └─────────┘  └─────────┘               │
│ LOW LEVEL                               │
└─────────────────────────────────────────┘
```


## 🔧 By Interface Type

| Type | Interaction | Use Case |
|------|-------------|----------|
| CLI | Text commands | Automation, scripts |
| Interactive | Two-way dialogue | Development, debugging |
| Shell | OS command interface | System administration |
| REPL | Execute-evaluate loop | Prototyping, testing |
| Batch | Pre-defined sequence | Scheduled tasks, ETL |
| GUI | Point-and-click | User-friendly applications |
| CDE | Integrated environment | Full development workflow |


## Dimensions of a Tool

### 1. Abstraction Level
| Level | Examples |
|-------|----------|
| Extra Low | Operating System |
| Low | Sentence, Instruction, Procedure, Function, Program |

### 2. Role
| Role | Description |
|------|-------------|
| Client | Consumes services |
| Server | Provides services |

### 3. Interface
| Kind | Description |
|------|-------------|
| CLI | Command-line text interface |
| CDE | Command-line development environment |
| Interactive | Two-way communication |
| Shell | OS command interface |
| REPL | Read-Eval-Print Loop |
| Batch | Non-interactive automation |
| GUI | Graphical user interface |

---



# Taxonomy by Abstraction Level

## Extra Low Level
- **Operating System** — Foundation code that manages a [machine][machine whatis]'s hardware reources and provides base services for programs

## Low Level
- **Sentence** — Executable unit of code
- **Instruction** — Atomic CPU operation
- **Procedure** — Sequence of instructions
- **Function** — Reusable block of code
- **Program** — Complete executable

```
Sentence → Instruction → Procedure → Function → Program
```

## Tool Kinds

| Category | Kinds |
|----------|-------|
| Role | Client · Server |
| Interface | CLI · CDE · GUI · Interactive · Shell · REPL · Batch |

## Tool Kinds by Interface

| Kind | Description | Examples |
|------|-------------|----------|
| Client | Consumes services from servers | Web browser, API client |
| Server | Provides services to clients | Web server, database |
| CLI | Command-line interface | `grep`, `curl`, `git` |
| CDE | Command-line development environment | Vim, Emacs |
| Interactive | Two-way communication | Shell, REPL environments |
| Shell | User interface to OS | Bash, Zsh |
| REPL | Read-Eval-Print Loop | Python REPL, Node.js |
| Batch | Non-interactive, automated execution | Cron jobs, CI scripts |
| GUI | Graphical User Interface | VS Code, GIMP |

---

## Visual Summary

```
┌─────────────────────────────────────────────────────────┐
│                      TOOL                               │
│           Something that helps to do things             │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  LOW LEVEL                    HIGH LEVEL                │
│  ┌─────────────┐            ┌──────────────┐            │
│  │ OS          │            │ Client       │            │
│  │ Program     │            │ Server       │            │
│  │ Function    │            │ GUI          │            │
│  │ Instruction │            │ Batch        │            │
│  └─────────────┘            └──────────────┘            │
│                                                         │
│  INTERFACES                                             │
│  ┌──────────────────────────────────────────────┐       │
│  │ CLI  │  Interactive  │  Shell  │  REPL  │    │       │
│  └──────────────────────────────────────────────┘       │
└─────────────────────────────────────────────────────────┘
```








