[//]: #(home)
[home]: ../../README.md

[//]: #(ref)
[project whatis]: ../../../concept/project/whatis/ep.md
[roadmap whatis]: ../whatis/roadmap.md


[↖][home]
| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a project][project whatis]      | Internal | |
| [What is a roadmap][roadmap whatis]      | Internal | |


<h1 align="center">What is a Lifecycle</h1>



# Definition
- Model the evolution of an entity (e.g. system, process, activity).
- Basically an ordered sequence of **phases**.
- can be formally defined in mathematics, using **graph theory** and its extension **Petri nets**.

## Example <a id='example'></a> 

The lifecycle can be used to model in various contetfrom building software to planning a wedding

| Context | representation of the lifecycle's phases |
|-|-|
| Theoretical | `A` → `B` → `C` → `D` → `A` → `A` → `D`
| Biology | `birth` → `development` → `reproduction` → `death`
| [Software](#software) | `development` → `testing` → `deployment` → `operation` → `retirement`
| [Project](#project) | `initiation` → `planning` → `execution` → `closure`
| [Software Project](#sproject) | `vision` → `domain` → `model` → `prototype` → `implementation` → `validation` → `release` → `operation`|
| [Product](#product) | `conception` → `development` → `launch` → `maturity` → `decline`
| [Organization](#organization) | `creation` → `growth` → `maturity` → `transformation/dissolution`
| [Data](#data) | `creation` → `processing` → `storage` → `archival/deletion`
| [Document](#document) | `draft` → `review` → `approval` → `publication` → `archival`

- Each arrow represents a **transition** from one phase to another


## Terminology

| Term | Meaning |
| - | - |
| **phase**      | <li>A named stage <li>represents a state  <li>can produces/creates **outputs** and/or **outcomes** |
| **transition** | <li>is represented by the arrow in the lifecycle <li>is caused/triggered by an **event** <li>has a **source** phase and a **destination** phase|
| **event**      | What triggers/permits/causes a transition |
| **output**	  | <li>what a phase produced <li>can be used by the next pahese as **input**|
| **input**	    | <li>what a phase consumed |
| **outcome**	  | <li>what a phase achieves |

# Kind

| Name | Representation | Description |
|---|---|---|
| **Linear** | `A → B → C → D` | A straightforward sequence where each stage follows the previous one, with no branching or repetition. |
| **Branching** | `A → B → C`<br> `       ↘ D` | A main path continues, but an alternative path splits off at some point. |
| **Cyclic** | `A → B → A → B → ...` | The process repeats in a loop, returning to an earlier stage. |
| **Mixed** | `A → B → B → ...`<br>`    ↘ D ➚` | Combines branching and repetition: there is a loop back to an earlier stage and an alternate branch that rejoins the main flow. |


# Examples detailed

## [↑](#example) Software lifecycle <a id='software'></a>

```
development → test → deployment → operation → retirement
```



| Stage | What Happens | Inputs | Output | Outcome | Nex stage |
| - | - | - | - | - | - |
| `Development` | <li>Write code <li>Create initial features <li>Fix initial bugs | <li>Requirements <li>User stories             | <li>Source code <li>Build artifacts <li>Developer documentation            | Software is ready for testing        | `Test`       |
| `Test`        | Run automated and manual tests to find bugs                     | Build                                         | <li>Test results <li>Bug reports <li>Verified release package              | Software is verified                 | `Deployment` |
| `Deployment`  | Install and configure the build on live servers                 | <li>Verified release package <li>Config files | <li>Deployed application <li>Deployment logs <li>Deployment configuration  | Application is running in production | `Operation`  |
| `Operation`   | <li>Run the app in production <li>Monitor <li>Fix bugs          | Deployed application                          | <li>Monitoring data <li>Bug fixes <li>Operational updates <li>New releases | Application is operational           | `Retirement` |
| `Retirement`  | <li>Decommission servers <li>Migrate user data <li>Shut down    | <li>Live application <li>Migration plan       | <li>Archived data <li>Migrated data <li>Decommissioning records            | Application is retired               | —            |



## [↑](#example) Project lifecycle <a id='project'></a>

```text
initiation → planning → execution → closure
```

| Stage | What Happens | Inputs | Output | Outcome | Nex stage |
| - | - | - | - | - | - |
| `Initiation` | <li>Define the project <li>Identify objectives <li>Identify stakeholders     | <li>Business need <li>Initial requirements                           | <li>Project charter <li>Initial requirements <li>Stakeholder list | Project is defined and approved | `Planning`  |
| `Planning`   | <li>Define scope <li>Plan activities <li>Estimate resources and costs        | <li>Project charter <li>Requirements <li>Constraints                 | <li>Project plan <li>Schedule <li>Budget <li>Risk register        | Project is ready for execution  | `Execution` |
| `Execution`  | <li>Perform planned activities <li>Produce deliverables <li>Monitor progress | <li>Project plan <li>Resources <li>Budget                            | <li>Project deliverables <li>Progress reports <li>Project records | Project objectives are achieved | `Closure`   |
| `Closure`    | <li>Deliver final results <li>Close contracts <li>Capture lessons learned    | <li>Project deliverables <li>Acceptance criteria <li>Project records | <li>Final deliverables <li>Closure report <li>Lessons learned     | Project is formally completed   | —           |

## [↑](#example) Software Project lifecycle <a id='sproject'></a>


```text
Project Lifecycle Flow
├── 1. Discovery (RFC / Draft Spec in project/*/specs/)
├── 2. Implementation (Active work tracked in project/*/backlog.md)
├── 3. Promotion (Publish clean docs to concept/, language/, or tool/)
└── 4. Archival (Mark project status Done & archive workspace)
```

```
vision → domain → model → prototype → implementation → validation → release → operation
```

```
Discovery ➔ Design ➔ Dev ➔ Test ➔ Release / Deployment
                          │
                   FINAL SPEC CREATED
                 (Base for Software Hub)
```


**simplified table**:

| Phase            | Purpose                                                           |
| ---------------- | ----------------------------------------------------------------- |
| `Vision`         | Define the purpose, problem, goals, and direction.                |
| `Domain`         | Understand the problem space, concepts, rules, and relationships. |
| `Model`          | Structure the domain into system abstractions and behavior.       |
| `Prototype`      | Explore the solution and test assumptions.                        |
| `Implementation` | Build the actual system.                                          |
| `Validation`     | Verify that the system satisfies its requirements and purpose.    |
| `Release`        | Make a validated version available for use.                       |
| `Operation`      | Use and maintain the system in its real environment.              |


**detailed table**:


| Stage | What Happens | Inputs | Output | Outcome | Nex stage |
| - | - | - | - | - | - |
| `Vision` | <li>Define the purpose <li>Identify the problem <li>Establish goals and direction                     | <li>Needs <li>Opportunities <li>Stakeholder expectations                         | <li>Vision statement <li>Goals <li>Initial constraints                          | The purpose and direction of the system are defined                         | `Domain`         |
| `Domain` | <li>Identify concepts <li>Understand rules and relationships <li>Define the problem space             | <li>Vision <li>Requirements <li>Domain knowledge <li>Constraints                 | <li>Domain concepts <li>Domain rules <li>Domain boundaries                      | The problem space and its essential rules are understood                    | `Model`          |
| `Model` | <li>Structure the domain <li>Define system abstractions <li>Specify behavior and relationships        | <li>Domain concepts <li>Domain rules <li>Requirements                            | <li>System model <li>Architecture <li>Behavior specifications                   | The system is sufficiently specified to be explored and built               | `Prototype`      |
| `Prototype` | <li>Explore solutions <li>Test assumptions <li>Experiment with interactions and behavior              | <li>System model <li>Hypotheses <li>Technical constraints                        | <li>Prototype <li>Experiments <li>Findings                                      | The proposed solution is explored and assumptions are tested                | `Implementation` |
| `Implementation` | <li>Build the system <li>Integrate components <li>Produce the intended behavior | <li>System model <li>Prototype findings <li>Technical resources | <li>Implemented system <li>Source code <li>Technical records | The system is built according to the model and prototype findings | `Validation` |
| `Validation` | <li>Verify behavior <li>Evaluate requirements <li>Identify and resolve defects                        | <li>Implemented system <li>Requirements <li>Acceptance criteria <li>Test results | <li>Validated system <li>Validation results <li>Defect records                  | The system is demonstrated to satisfy its intended purpose and requirements | `Release`        |
| `Release` | <li>Prepare the system for use <li>Deploy the system <li>Make the system available to users           | <li>Validated system <li>Release criteria <li>Deployment resources               | <li>Released system <li>Release documentation <li>Deployment records            | The system is made available for operational use                            | `Operation`      |
| `Operation` | <li>Use the system <li>Monitor behavior <li>Maintain reliability and performance                      | <li>Released system <li>Operational resources <li>User activity                  | <li>Operational system <li>Usage data <li>Operational records <li>Feedback      | The system provides value in its real operating environment                 | |


**detailed table 2**:

```
VISION
  │
  ├── Vision
  └── Initial goals
       ↓
DOMAIN
  │
  ├── Requirements
  ├── Domain concepts
  └── Domain rules
       ↓
MODEL
  │
  ├── System model
  ├── Architecture
  ├── Design decisions
  └── ADRs
       ↓
PROTOTYPE
  │
  ├── Experiments
  ├── Technical validation
  └── Prototype findings
       ↓
IMPLEMENTATION
  │
  ├── Development
  ├── Tests
  └── Documentation
       ↓
VALIDATION
  │
  ├── Requirements verification
  ├── Acceptance tests
  └── Defect resolution
       ↓
RELEASE
  │
  ├── Release preparation
  ├── Packaging
  └── Deployment
       ↓
OPERATION
```
**Extra phase**:
```

              ┌──────────────────────────────┐
              │                              ↓
vision → domain → model → prototype → implementation → validation
 ↑                                                        ↓
 └──────────── evolution ← operation ← release ←─────────┘
``` 


| Stage | What Happens | Inputs | Output | Outcome | Nex stage |
| - | - | - | - | - | - |
| `Evolution` | <li>Observe changing needs <li>Analyze feedback and operational data <li>Adapt and improve the system | <li>Operational feedback <li>Usage data <li>New needs <li>Environmental changes  | <li>New requirements <li>System changes <li>Updated model <li>Evolution roadmap | The system continuously adapts to remain useful and relevant                | `Vision`         |


## [↑](#example) Product lifecycle <a id='product'></a>

```
conception → development → launch → maturity → decline
```

| Stage | What Happens | Inputs | Output | Outcome | Nex stage |
| - | - | - | - | - | - |
| `Conception`  | <li>Identify user needs <li>Define the product concept <li>Define initial requirements     | <li>User needs <li>Market opportunities                       | <li>Product concept <li>Product requirements <li>Initial design | Product is defined and ready for development         | `Development` |
| `Development` | <li>Design the product <li>Build the product <li>Validate the product                      | <li>Product requirements <li>Product concept                  | <li>Product <li>Technical documentation <li>Validation results  | Product is ready for launch                          | `Launch`      |
| `Launch`      | <li>Release the product <li>Make it available to users <li>Promote the product             | <li>Validated product <li>Launch plan <li>Marketing materials | <li>Released product <li>Sales channels <li>Launch data         | Product is available in the market                   | `Maturity`    |
| `Maturity`    | <li>Operate and maintain the product <li>Improve features <li>Support users                | <li>Product <li>User feedback <li>Market data                 | <li>Product updates <li>Support data <li>Performance data       | Product is established and reaches stable demand     | `Decline`     |
| `Decline`     | <li>Reduce or stop development <li>Manage decreasing demand <li>Prepare product retirement | <li>Product <li>Market data <li>Retirement plan               | <li>Final product version <li>Retirement plan <li>Archived data | Product is no longer actively maintained or marketed | —             |




## [↑](#example) Organization lifecycle <a id='organization'></a>

```text
creation → growth → maturity → transformation/dissolution
```

| Stage | What Happens | Inputs | Output | Outcome | Nex stage |
| - | - | - | - | - | - |
| `Creation`                   | <li>Define the organization <li>Establish its structure <li>Set initial objectives | <li>Mission <li>Resources <li>Initial objectives                               | <li>Organization structure <li>Roles and responsibilities <li>Initial processes | Organization is established and operational | `Growth`                     |
| `Growth`                     | <li>Expand activities <li>Acquire resources <li>Develop capabilities               | <li>Organization structure <li>Resources <li>Market opportunities              | <li>New capabilities <li>Expanded operations <li>New processes                  | Organization is expanding and developing    | `Maturity`                   |
| `Maturity`                   | <li>Operate at scale <li>Optimize processes <li>Maintain capabilities              | <li>Established operations <li>Resources <li>Performance data                  | <li>Optimized processes <li>Performance data <li>Organizational knowledge       | Organization is established and stable      | `Transformation/Dissolution` |
| `Transformation/Dissolution` | <li>Transform the organization <li>Merge or restructure <li>End activities         | <li>Organization <li>Strategic decision <li>Transformation or dissolution plan | <li>New organization structure <li>Transition records <li>Archived data         | Organization is transformed or dissolved    | —                            |



## [↑](#example) Data lifecycle <a id='data'></a>

```
creation → processing → storage → archival/deletion
```

| Stage | What Happens | Inputs | Output | Outcome | Nex stage |
| - | - | - | - | - | - |
| `Creation`          | <li>Generate data <li>Capture data <li>Validate initial data  | <li>Events <li>User input <li>Source systems              | <li>Raw data <li>Metadata <li>Creation records               | Data is available for processing        | `Processing`        |
| `Processing`        | <li>Clean data <li>Transform data <li>Enrich data             | <li>Raw data <li>Processing rules <li>Reference data      | <li>Processed data <li>Derived data <li>Processing records   | Data is ready for use or storage        | `Storage`           |
| `Storage`           | <li>Store data <li>Organize data <li>Manage access            | <li>Processed data <li>Storage policies <li>Access rules  | <li>Stored data <li>Indexes <li>Access records               | Data is available for ongoing use       | `Archival/Deletion` |
| `Archival/Deletion` | <li>Archive data <li>Delete data <li>Apply retention policies | <li>Stored data <li>Retention policies <li>Deletion rules | <li>Archived data <li>Deletion records <li>Retention records | Data is retained or permanently removed | —                   |

## [↑](#example) Document lifecycle <a id='document'></a>

```
draft → review → approval → publication → archival
```

| Stage | What Happens | Inputs | Output | Outcome | Nex stage |
| - | - | - | - | - | - |
| `Draft`       | <li>Create the document <li>Write initial content <li>Format the document      | <li>Requirements <li>Source information     | <li>Draft document <li>Source references                          | Document is ready for review               | `Review`      |
| `Review`      | <li>Check content <li>Identify errors <li>Request changes                      | <li>Draft document <li>Review criteria      | <li>Review comments <li>Correction requests <li>Reviewed document | Document is ready for approval             | `Approval`    |
| `Approval`    | <li>Evaluate the document <li>Confirm compliance <li>Approve the final content | <li>Reviewed document <li>Approval criteria | <li>Approved document <li>Approval record                         | Document is approved for publication       | `Publication` |
| `Publication` | <li>Publish the document <li>Distribute it <li>Make it available to users      | <li>Approved document <li>Publication plan  | <li>Published document <li>Publication record                     | Document is officially available           | `Archival`    |
| `Archival`    | <li>Store the document <li>Apply retention rules <li>Control access            | <li>Published document <li>Retention policy | <li>Archived document <li>Archival record                         | Document is preserved for future reference | —             |


## [↑](#example) Other Software lifecycle <a id='other'></a>

```
vision → requirements → design → implementation → validation → release → operation
```

**requirements**:
- Describe what The Software must be able to do.


