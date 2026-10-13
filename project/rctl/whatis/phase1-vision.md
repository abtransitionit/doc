[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[project software howto]: /project/blueprj/howto/boostrap.md
[res whatis]:             /concept/resource//whatis/ep.md
[provision whatis]:             /concept/resource/whatis/provision.md
[ope whatis]:             /concept/resource/whatis/operation.md
[tool whatis]:            /concept/tool/whatis/ep.md
[adr list]:   ../adr/ep.md

Related topics

| Topic | Location| Kind |
|-|-|-|
|[What is a resource][res whatis]|
|[How-to for Software Project][project software howto]|


**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Project - Phase1: Vision</h1>


# Problem

[Provisioning][provision whatis] and [operating][ope whatis] [resources][res whatis] usually requires different [tools][tool whatis], commands, systems, configurations, and procedures because resources, mechanisms, and targets each vary in both **kind** and **granularity**. This complexity can be broken down into a few key dimensions:

| Dimension | Question it answers | Example
|---|---| ---|
| **Resource type** | *What* is being provisioned? | files, container, VMs, clusters, repos |
| **Target environment** | *Where* does it live? | local, remote, cloud|
| **Access mechanism** | *How* is it reached? | CLI, API, SSH, SDK, native protocol |
| **Lifecycle phase** | *When* in the lifecycle? | create, configure, operate, reset, destroy |
| **Operational concern** | *Which* transversal aspect matters? | auth, state, idempotency, observability |



# Core vision

Build a system that can **provision**, **operate** and **control** different kinds of **resources** in different kinds of **targets**, through a **common model**.

# Strategy

The system's strategy should be based on the following principles:
* **Expose / Adopt** resources provisioned outside the system, making them **first-class citizens**.
* **Rely** on existing tooling (tools, platforms, APIs) as system **building blocks** to handle specialized capabilities.
* **Compose** resources, tools, and capabilities into complete workflows.
* **Serve** as a unifying layer over external tooling rather than a replacement.

# Target Outcome

Provide a **common way** to **provision** and **operate** resources, regardless of:
- The **target** where they reside.
- The **mechanism** used to manage them.

Here are two ways to integrate those two ideas directly into your **Vision (User Experience)** section, depending on how detailed you want it to be.

# User Experience

An agent (human or tool) should express **what** should be provisioned or operated, and **where**, without having to encode **how**.

* **Intent-Based Execution:** Shifts the experience:
  * From **imperative scripting** (*doing step A, then step B via tool X*)
  * To **declarative intent** (*defining the desired state*)
  * Where the system provides the operational intelligence for **how** by 
    * removing the exponential complexity `complexity = resource × environment × tool`
    * determining the execution plan from the desired state
    * selecting the right resources, tools, and workflows for the target environment
    * resolving dependencies and ordering operations automatically
    * handling environment-specific constraints and configuration
    * executing, validating, and reconciling the resulting state
    * adapting the execution as resources, environments, or constraints change
