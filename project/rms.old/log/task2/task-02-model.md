[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[cli howto]: /concept/tool/howto/ep.md#design-the-grammar-of-a-cli
[repo whatis]: /concept/repository/whatis/ep.md

Related topics

| Topic | Location| Kind |
|-|-|-|
|[How-to for CLI][cli howto]|
|[What is a Repository][repo whatis]|


---

[cli howto]: ../howto/cli-grammar.md
[REQ-01]: ../../spec/REQ-01-requirements.md
[SPEC-01]: ../../spec/SPEC-01-architecture.md
[ADR-02]: ../../adr/ADR-02-decoupled-output-formatting.md

**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Project: RCtl — Task: Model the resource</h1>



1. Requirements — establish scope and constraints.
2. Domain modeling — define Resource, Resource Kind, and their relationships.
3. Operation design — define capabilities, requests, execution, and outcomes.
4. Go architecture — choose types, interfaces, and package boundaries.
5. Implementation — implement incrementally.
6. Testing and validation — verify behavior against requirements.






### Phase 1 — Resource Modeling

**Objective:** Define the Resource concept and its classification.

- Define what constitutes a resource.
- Define how resources are classified by kind.
- Identify the resource kinds required by the system.

**Expected outcome:** A conceptual model of resources and resource kinds.

### Phase 2 — Operation Modeling

**Objective:** Define how resources can be operated on.

- Define resource capabilities.
- Identify the operations supported by each resource kind.
- Define how an agent requests an operation on a resource.
- Define request handling and execution outcomes.

**Expected outcome:** A conceptual model of capabilities, operations, requests, and outcomes.

### Phase 3 — Resource Implementation Design

**Objective:** Determine how to represent the resource model in Go.

- Define the Go types and interfaces for resources.
- Represent resource kinds and their relationships.
- Determine how specific resource types relate to the general Resource concept.

**Expected outcome:** A Go type design for resources and resource kinds.

### Phase 4 — Operation Implementation Design

**Objective:** Determine how to implement resource operations in Go.

- Represent capabilities and operation requests.
- Design operation dispatch and resource handlers.
- Define validation, execution, and error handling.
- Determine how operations are exposed through the CLI/system.

**Expected outcome:** A Go design for implementing and exposing resource operations.


### Step 1 — Model the Resource Concept

**Objective:** Define the general Resource concept independently of implementation.

Identify:
- What defines a resource.
- How a resource's kind is identified.
- How specific resource kinds (e.g., File, DB, Compute, Service) relate to the general Resource concept.

**Expected outcome:** A conceptual model of resources and resource kinds.

### Step 2 — Design Resource Operations

**Objective:** Define how resources can be operated on.

Identify:
- How capabilities are associated with resource kinds.
- Which operations each resource kind supports.
- How an agent requests an operation on a resource.
- How operation requests are accepted, rejected, or ignored, and how execution success or failure is represented.

**Expected outcome:** An operation model describing resource capabilities, operations, and requests independently of implementation.

### Step 3 — Implement the Resource Model in Go

**Objective:** Translate the resource concept into Go types and structures.

Identify:
- How to represent resources and their kinds.
- How to express relationships between general and specific resource types.

**Expected outcome:** A Go design implementing the resource model.

### Step 4 — Implement Resource Operations

**Objective:** Implement the operation model in Go and expose it through the CLI/system.

Identify:
- How to represent and validate operation requests.
- How to dispatch requests to the appropriate resource handlers.
- How to execute operations and report their outcomes.

**Expected outcome:** A working implementation through which agents can request operations on resources.





### Todo > Step 1 — Model the Resource Concept

**Objective:** Define how resources are conceptually represented in the system.

Identify:

- What defines a resource.
- How a resource's kind is identified.
- How specific resource kinds (e.g., File, DB, Compute, Service) relate to the general Resource concept.
- How capabilities are associated with resources.
- How an agent requests an operation on a resource.

**Expected outcome:** A conceptual model of resources, kinds, capabilities, and requested operations, independent of any programming language or implementation.

### Todo > Step 2 — Implement the Resource Model in Go

**Objective:** Translate the conceptual model into Go types and interfaces.

Identify:

- How to represent resources and their kinds.
- How to define resource-specific capabilities.
- How to expose capabilities as operations through the CLI/system.
- How to handle requests from agents.

**Expected outcome:** A Go design that implements the conceptual model while keeping resource definitions and operation handling clear and maintainable.



# TODO > Step 1 — Define the Resource Model

**Objective:** Define the Go types needed to represent resources in the system.

Start from the general `Resource` concept and identify how specific resource kinds (e.g., File, DB, Compute, Service) will be represented in Go.

For each resource kind
- **identify** its specific capabilities
- **identify** how those capabilities will be exposed through system so that an agent can request operations on a resource.

**Expected outcome:** A clear Go type design that defines:

- How a **resource** is represented.
- How its **kind** is identified.
- How resource-specific capabilities are defined.
- How those capabilities can be exposed as operations through the CLI/system.

**Review question:** What are the possible Go design approaches, and what are their respective trade-offs?


- next > Separate the modeling and implementation steps
- next > Define the Resource interface explicitly

