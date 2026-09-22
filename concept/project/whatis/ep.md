[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[lfc whatis]:             ../../../concept/lifecycle/whatis/ep.md
[lfc project whatis]:     ../../../concept/lifecycle/kind/project/whatis/ep.md
[rm project whatis]: ../../../concept/roadmap/kind/project/whatis/ep.md



Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a project lifecycle][lfc project whatis]      | Internal | Member |
| [What is a Project Roadmap][rm project whatis] | Internal | Member  |
| [What is a Software project](../kind/software/whatis/ep.md) | Internal | kind  |
| [List of projects](../../../project/README.md) | Internal | See  |
| [How-to Bootstrap a project](../howto/ep.v1.md) | Internal | See  | Member

<h1 align="center">What is a Project</h1>

The concept of project

# Definition

## Project
A subject/entity 
  - that has a [lifecycle][lfc whatis]
  - to which is attach a [lifecycle][lfc whatis]

## Project
- Usually starts as an **idea** or **vision**.
- Usually end up with one or more **values** for one or more stakeholders.
- Defines a path to transform that **idea** into those **values**.
- Can be modeled and represented using the concept of [lifecycle][lfc whatis] and [roadmap][rm project whatis]
- Is represented by a lifecycle (its stages).

## Program
- a collection of projects
- Allow to manage very large projects
- Split very large projects into a set of smaller related projects

## Member
```yaml
project:
  - lifecycle:
    - constraints: # if presents it become a roadmap
```

## Representation of a project

```yaml
project
  └── has constraints
        └── modeled as constraints on the lifecycle
              └── = roadmap
```                
```yaml
# Global view
idea --> Project --> values
            ▲
            |
            ├── Lifecycle (the sequence of stage)
            └── Roadmap   (additional constraints on stages)   

# Detailed view
idea --> Phase1  --> Phase1  --> Phase3 --> values
```  


# Terminology

| Concept | Phase context | Project context |
| - | - | - |
| **Inputs**  | *What a phase receives to perform its work.*<br>**Examples:** Ideas, Needs, Requests, Materials, Knowledge, Information, Resources | *The initial inputs of the project.*<br>**Examples:** Deliverables, Artifacts, Results                           |
| **Outputs** | *What a phase produces as part of its work.*<br>**Examples:** Phase deliverables, artifacts, results, decisions, information       | *What the project produces.*<br>**Examples:** **Products, Services, Results**                                    |
| **Outcome** | *What a phase achieves after its work is done.*<br>**Examples:** Completed work, validated capability, decision achieved           | *What the project achieves.*<br>**Examples:** Business value, organizational change, benefit, objective achieved |


# Example of project's product

The outputs of a project are often **products**, **services** or **results**

| Category | Examples |
|----------|----------|
| **Physical Products** | Cars, furniture, electronics, clothing, buildings |
| **Digital Products** | Mobile apps, websites, SaaS platforms, AI models |
| **Services** | Consulting, healthcare, education, repair, logistics |
| **Internal Projects** | Process improvement, team restructuring, policy development |
| **Creative Works** | Films, books, marketing campaigns, art installations |
| **Nonprofit / Social** | Community programs, disaster relief, advocacy campaigns |
| **Personal** | Fitness goals, learning paths, relocation plans |
| **Hybrid** | Product-as-a-service (e.g., subscription boxes), platform ecosystems |

- Service*: capability or activity provided to users or customers.

# Todo : definition

A **Project** is an ephemeral workspace designed to move a specific technical initiative from discovery to live production. Once a project completes its scope, its artifacts transition into permanent system documentation (`concept/`, `language/`, or `tool/`) and the project workspace is archived.

