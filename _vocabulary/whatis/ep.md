[//]: #(home)
[home doc]: ../../README.md


[//]: #(ref)
[cpu whatis]: /concept/resource/whatis/hardware.md
[↖ Doc][home doc]

<h1 align="center">Knowledge Base Controlled Vocabulary</h1>



# Meta-definition
- **Common Definition**: A general meaning of a term or expression that is independent of a specific **domain** or **context**.
- **Computer Science Definition**: A meaning of a term or expression specific to the field of **computer science**.
- **Controlled Vocabulary**: A subset of a domain specific definition in which definition of terms or expression are extended or overriden to ensure a shared understanding and reduce semantic ambiguity in document.

# Common definition

| Term | Type | Definition | Lexical field/synonym |
| -- | -- | -- | -- |
| Set | noun |contains elements | Collection, Container
| Element | noun |belongs to a set | Item, Component
| Create | verb | bring something into existence | Build, Generate
| Resource | noun | something that achieves a purpose | Thing
| Action | noun | something to be done  | Task, Operation
| Environment | noun | the context in which a resource exists, evolves |
| Tool | noun | a resource used to perform an action|
| Manage | verb |  | Handle, Use, Control, Coordinate, Orchestrate



## Model
An intentional, simplified representation of something, a phenomenon, or a concept.
- **intentional**: the model is built on purpose, for a specific context
- **simplified**: it focus only on specific properties, omitting complexity.
- **representation**: It can be a string, a programing language structure, a yaml model, ...




# Computer Science Terminology

| Term | Type | Definition | Lexical field |
| -- | -- | -- | -- |
| Provision | verb | make a resource available for use | Register, Prepare, Create, Install, Add, Instanciate, Assign, Allocate
| Identify | verb | determine which thing is being referred to |
| Manage | verb | | Update, Delete, Change, Modify, 
| Action | noun | something to be done, performed | Function, Procedure
| Task | noun | A unit of action | Job, Operation, Work, Instruction
| Capability | noun | an action a resource provide or support | Feature, Ability
| Operate | verb | make a resource perform its intended capability | Launch, Run, Execute, Drive, 
| Nested | adj | contained within a resource of the same kind | Hierachical, Level, Recursive, Inner, Embeded
| Granularity | noun | the level of detail a resource or action is represented | Detail, Whole, Resolution
| Environment | noun | the context in which a resource is provisioned, managed and operated |

## Modeling resource

**Physical resource** — a real, tangible resource (you can touch it).
- a server
- a network switch
- a hard disk
- a CPU core

**Logical resource** — a resource that exists as a concept, definition, configuration, or allocation, not as hardware.
- an IP address
- a DNS name
- a user account
- a file path
- a database schema
- a license

**Virtual resource** — a model of a physical or logical resource.
- the model is implemented in code/software (emulation, abstraction, simulation, class, object, instance)
- Reproduces some of the properties or capabilities of that resource.
- **example**, 
  - a virtual network may model physical networking
  - a virtual machine may provide a software-defined computing environment backed by physical resources.




## Provisioning Resource
The following situation correspond to provisioning
- assign 
  - an IP address to a machine
  - a CPU core to a VM
  - a license to a user
  - a port to a service
  - bandwidth to a connection.
- allocate RAM (or disk, GPU, etc.) for a program.







## System
- A set of components designed to perform one or more tasks.

## Computer System
- A system that performs computing tasks.
- **Example**:
  - A machine physical or virtual
  - A container
  - A cluster of containers or machines

## Computing Task
- A task that originate from [CPU][cpu whatis] instructions.

## Machine
- Aka. compute machine
- A member of a computer system. 
- Basically, a system with CPUs and other hardware resources (ROM, RAM, DISK, NIC, GPUs...).
- Runs different kind of code
  - firmware - low level code/program to boot the OS and allow communication between harware and OS
  - Os - higher level code/program that provide services and primitives for other high level code/program
  - high level code/program - provide additional capabilities and allow to do task of different granularity 


## Resource
- Can be physical, Virtual or abstract
- Lives in a computer system (and can be operated on).
- Everything, at a given moment and within a given context, can be considered a resource. 
- A resource is distinguished from another resource by its **kind**.
- The **kind** specifies how it is classified within that context.
- **Example**:
  - A **file** is a resource of kind **File** (if that kind identifies the specific type of entity)
  - A **database** is a resource of kind DB (if that kind identifies the specific type of entity)
  - A CPU is a resource of kind **Compute**  (if that kind identifies a broader category of entity)
  - An API is a resource of kind **Service** (if that kind identifies a broader category of entity)




## Tool
- Aka machine program
- can be hardware, software or both
- Perform specific tasks.
- **Example**:
  |Tool name|Task|
  |-|-|
  |Hypervisor| VM provider |
  |Cloud| Services Provider |
  |Container Runtime| Container provider |

## Granularity
- Applies to anything that can be considered at different levels of detail
- **Example**:
  - **Resource**: A machine as a whole vs. its CPU, memory, and disk.
  - **Action**: Provision a machine vs. create its disk, configure its network, and start it.
  - **Task**: Deploy an application vs. download its files, configure it, and start.
  - **Data**: A file vs. an individual field within that file.

## Other Definition

    
- **Device**: Basically, a hardware resource

- **Meta**: 
  - Something is meta when it describes or defines other things of the same kind.
  - **Example**: 
    - Metadata describes other data.
    - Meta-definition is a definition about a definition
- **Nested**: 
  - Contained within another structure of the same kind.
  - Describes a structural relationship: One structure is contained within another.
  - **Example**: 
    - A folder inside another folder is a nested folder.
    - A repository inside another repository is a nested repository.
    - A collection inside another collection is a nested collection.



## Related to Execution

Related to the execution of an action, operation or task

- **completed**  = succeeded OR failed
- **succeeded**  ⊂ completed
- **failed**     ⊂ completed
## Related to Resource

- **Atomic** Resource: 
  - a resource treated as a whole. 
  - Does not necessarily mean that the underlying resource has no parts.
  - **Example**: 
    - An atomic operation either succeeds completely or fails completely.
- **Composite** Resource: 
  - Made up of two or more `components` (resource of kind `Component`).
  - Can be treated as **atomic** by a system and **composite** by another.  
- **Component** Resource: Part of **composite** resource. 
- **Provision** a Resource: **Prepare** it and making it **available** for use.
    - lexical field: load, add, create, install
- **Operate** on a Resource: Perform an action on it.
    - lexical field: load, add, create, install, start, stop, read, write, update, delete.
- Resource **Capability**: 
  - An action, operation or task that a resource **CAN** perform or support.
  - Describes a possibility or ability offered by the resource.
  - Describes what is possible.
  - **lexical field**: support, allow, execute, provide, expose.
- **Action/Operation** on a Resource:
  - An action or operation **requested** on a resource.
  - The requested action or operation MUST correspond to a capability that the resource can perform or support.
- **Manage** a resource: Coordinate the actions related to it capability and potentially its lifecycle.
    - Lexical field: monitor, configure, provision, operate, control.



## What a Resource Can Do vs. What an Agent Asks a Resource to Do

*A Resource's Capability vs. a Request to Perform an Operation on a Resource*

A **capability** describes what a resource can do. A **request** asks the resource to perform a specific operation.

**Step 1. The request is evaluated.** It may be:
- **Rejected** if the request is invalid or not authorized.
- **Ignored** if the resource or system does not process the request.
- **Accepted** if the request is valid, authorized, **and** the operation is supported by the resource.

> ⚠️ Accepting a request does not guarantee successful execution

**Step 2. The resource attempts to perform the operation.** The execution may:
- **Succeed** if the operation completes successfully.
- **Fail** if the operation cannot be completed.

> ⚠️ The existence of a capability does not ensure the resource successfully perform the requested operation.

**Example: Starting a VM**

A server has the capability to start virtual machines.

1. An agent requests that the server start a specific VM.
2. The request may be rejected, ignored, or accepted.
3. If accepted and processed, the server attempts to start the VM.
4. The operation may succeed or fail.


|Resource|Capability|request|
|-|-|-|
|Hypervisor|create VM|idem|
|Disk|store data|write data to disk|
|NIC|Transmit packets|idem|

# Modeling file vs Modeling CPU

The distinction is between 
- modeling **information** 
- modeling a **physical resource**.

**Data / logical modeling**: 
- model a **file**, **folder**, kernel **module** or **parameter** is represented according to its logical structure, meaning, or role. For example, a Go structure describes the contents of a file. This is not necessarily a model of a physical object.

**Physical resource modeling**: 
- A **VM**, **vNIC**, or **vCPU** represents selected properties and capabilities of physical computing resources through software.

In short: A Go structure models the data of a file; a VM models a computing environment corresponding to a physical machine.

For now, I would call these data modeling and resource virtualization, respectively.



## Atomic Resource Vs. Composite REsource

- These expression describe how a resource is represented in a model.
- The same resource may be represented as **atomic** or **composite** depending on
  - the model used.
  - the context of its isage.

**Example:**

A **machine** containing CPUs, RAM, and DISKs may be represented as:
- A **atomic** resource and treated as a whole, e.g. at a provisoning stage.
- A **composite** resource and represented as its components resources, e.g. when provisioning an additional Disk.

## 4.2. Nested vs. Composite


**Distinction:**

- **Nested** describes containment.
- **Composite** describes composition.

**Examples:**

- A folder inside another folder is nested.
- A machine made up of CPUs, memory, and disks is composite.
- A composite resource may contain nested resources.






## Kind Vs. Model
- A file can be modeled as a resource of kind File (if the kind identifies the specific type of entity).
- A database can be modeled as a resource of kind Database (if the kind identifies the specific type of entity).
- A CPU can be modeled as a resource of kind CPU (if the kind identifies the specific type of entity).
- An API can be modeled as a resource of kind API (if the kind identifies the specific type of entity).
More generally, the kind could instead identify a broader category, such as Storage, Compute, or Service, depending on the purpose and level of abstraction of the model.


A CPU could be represented in several ways:
- A resource of kind CPU — if the kind identifies the specific type of hardware.
- A resource of kind Compute — if the kind represents a broader category of computational resources.
- A resource of kind Hardware — if the kind represents the general class of physical components.


# Todo 

- **Nested and composite describe different aspects**: A structure can be composite and contain nested structures.
- **Atomic and composite are context-dependent**: The same resource can be represented differently in different models.



# Todo > Virtualization
- The concept of creating Nested Machine: Machine inside Machine
  - 1 Os (Machine) denote 1 Os@**guest** (Machine@**Virtual**)
  - 1 Os (Machine) denote 1 Os@**Host**  (Machine@**Physical**)
# Todo > Isolated environment

# Todo > Resource

- An identifiable entity that a computer system can access, use, allocate, create, modify, or manage.
- An  that a computer system can access, use, allocate, create, modify, or manage.



# Todo > Physical, Virtual, Logical

## Physical resource
- Exists as a physical entity
- **Example**:
  - a CPU chip
  - a RAM module.

## Virtual
- an abstraction presented by software or virtualization.
- **Example**:
  - vCPU
  - vRAM

A **virtual** component is often **logical**, but not every logical component is virtual. For example, a logical volume can be built on physical disks without being a virtual hardware device.

## Logical
- defined by its role, organization, or representation within a system.
- **Example**:
  - lCPU
  - lVolume
  - lNetwork

## Virtual Vs. Logical
- A **virtual** component is often **logical**
- Not every **logical** component is **virtual**. 
- For example
    - a logical volume can be built on physical disks without being a virtual hardware device.

physical or virtual as the primary distinction and explain logical components separately.


# Todo > Hardware resource, Device




# Todo > Verbs
- **Allocate**: Assign something to a particular use or purpose.
- **Access**: Ability to reach or interact with something.
- **Consume**: Use something or use up some of it.


# Todo > Nouns and Expressions
- **Atomic**: Treated as a whole, single or indivisible.
- **Granularity**: The level of detail at which something is considered.
- **Physical**: Having a material existence in the physical world.

