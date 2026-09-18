[//]: #(home)
[home]: ../../README.md

[//]: #(ref)
[lfc whatis]:     ../../../concept/lifecycle/whatis/ep.md
[roadmap whatis]: ../../../concept/lifecycle/whatis/ep.md



[↖][home]

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a program](../whatis/program.md)      | Internal | |
| [What is a lifecycle][lfc whatis]      | Internal ||
| [How-to for Software project](../howto/ep.md) | Internal | See  |
| [List of projects](../../../project/README.md) | Internal | See  |

<h1 align="center">What is a Project</h1>



# Definition
## Project
- Usually starts as an **idea** or **vision**.
- Usually end up with one or more **values** for one or more stakeholders.
- Defines a path to transform that **idea** into those **values**.
- Can be modeled and represented using the concept of [lifecycle][lfc whatis] and a [roadmap][roadmap whatis]

## Program
- a collection of projects
- Allow to manage very large projects
- Split very large projects into a set of smaller related projects

## Representation of a project

  
```yaml
# Global view
idea --> Project --> values
            ▲
            |
            ├── Lifecycle (the sequence of stage)
            └── Roadmap   (additional constraints on stages)   

# Detail view
idea --> Phase1  --> Phase1  --> Phase3 --> values
```  

# Example of product

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

## Terminology

| Concept | Phase | Project |
| - | - | - |
| **Inputs**  | *What a phase receives to perform its work.*<br>**Examples:** Ideas, Needs, Requests, Materials, Knowledge, Information, Resources | *The initial inputs of the project.*<br>**Examples:** Deliverables, Artifacts, Results                           |
| **Outputs** | *What a phase produces as part of its work.*<br>**Examples:** Phase deliverables, artifacts, results, decisions, information       | *What the project produces.*<br>**Examples:** **Products, Services, Results**                                    |
| **Outcome** | *What a phase achieves after its work is done.*<br>**Examples:** Completed work, validated capability, decision achieved           | *What the project achieves.*<br>**Examples:** Business value, organizational change, benefit, objective achieved |


# Todo : definition

A **Project** is an ephemeral workspace designed to move a specific technical initiative from discovery to live production. Once a project completes its scope, its artifacts transition into permanent system documentation (`concept/`, `language/`, or `tool/`) and the project workspace is archived.

```text
Project Lifecycle Flow
├── 1. Discovery (RFC / Draft Spec in project/*/specs/)
├── 2. Implementation (Active work tracked in project/*/backlog.md)
├── 3. Promotion (Publish clean docs to concept/, language/, or tool/)
└── 4. Archival (Mark project status Done & archive workspace)

# Todo : terminology

|||
|-|-|
| Operations | actions that operates on the delivery


# Todo : key Characteristics of a project

| Key     | Meaning | Note |
| ------- | ------- | ---- |
|Temporary|has a defined start and end |
|Unique|produces something new or different | context, stakeholders, requirements, environment, or constraints.
|Constrained|limited by time, cost, scope, and resources | influence how the project is planned, executed, and controlled.



