
# Resource

* a thing that can be [operated][Operation] on in a [system][System]


## Resource Categories


| Category                | Description                                   | Examples                            |
| ----------------------- | --------------------------------------------- | ----------------------------------- |
| Storage Resource        | stores data or state                          | file, database                      |
| Data Resource           | informational content                         | dataset, logs                       |
| Compute Resource        | executes operations                           | service, process                    |
| Model Resource          | produces outputs from inputs using operations | rule-based system, function service |
| Infrastructure Resource | provides system capacity                      | physical machine, cloud node        |
| Host Resource           | execution environment for compute             | VM, container                       |
| Runtime Resource        | active running instance of compute            | running service                     |



## Storage Resource

* stores/persists data or system state for other resources


## Data Resource

* contains informational content
* can be **structured** or **unstructured** (eg. logs or datasets)
* input or output of an [operation][Operation] or [process][Process]


## Compute Resource

* performs execution or computation logic
* runs operations on input to produce outputs
* transforms input resources into output resources



## Model Resource

* a **compute resource** that produces outputs from inputs using learned behavior
* used for inference and prediction tasks
* transforms inputs into **structured outputs**

## Infrastructure Resource

* ensures existence of execution environments


## Host Resource

* provides an execution environment for compute resources
* compute resources run on it


## Runtime Resource

* an instance of a compute resource
* represents execution state on a host

---

# How it works

* Infrastructure provides Host
* Host runs Runtime
* Runtime executes Compute or Model
* Compute/Model operate on Data/Storage resources


---

# Operation

* an action applied to a [resource][Resource] or [system][System]
* transforms input resources into output resources
* cf. [process][Process]

---

# Input

* a resource **provided** to an operation or system

---

# Output

* a resource **produced** by an operation or system


---

# Process

* a sequence of [operations][Operation] [applied to resources]
* cf. [training][Training]


---

# System

* a set of [resources][resource]
* resources interact through [operations][Operation]
* defines how resources are transformed and coordinated


---

# Dataset

* a structured collection of data resources
* input or output of [processes][Process]

---

# Parameter

* a configurable value inside a [model resource][ModelResource] that influences outputs (its behavior)
* adjusted during [training processes][Training]



# Todo



How information is represented: 

* 1/N Txt file: 
* 1/N Structured file: (e.g. YAML, JSON)
* 1/N Database records
* Documents in a document store
* Records managed by a project management system
* A combination of representations


How information is stored: 


* files in local filesystem
* files in A Git repository
* files in A database
* files in A remote service
* files in Cloud storage
* files in Another storage mechanism


How information is accessed: 

