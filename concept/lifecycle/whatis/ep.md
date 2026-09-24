[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[project whatis]: /concept/project/whatis/ep.md
[model whatis]:   /concept/model/whatis/ep.md
[rm whatis]:      ../../roadmap/whatis/ep.md
[concept whatis]: /concept/concept/whatis/ep.md
[lfc list]: ../list/ep.md
[entity whatis]: /concept/entity/whatis/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a project][project whatis]            | Internal | Subject |
| [What is a roadmap][rm whatis]                 | Internal | kind |

<h1 align="center">What is a Lifecycle</h1>

The concept of lifecycle

# Definition


## Lifecycle
- [Model][model whatis] the **evolution** an [entity][entity whatis]
- can be formally defined in mathematics, using **graph theory** and its extension **Petri nets**.
- Has a **start** and an **end**.

**Key point**
- An **entity's lifecycle** exists as soon as a lifecycle is attached to it.
- When it's done: the entity evolution can be described through the lifecycle's stages


# Model
- Defines the set of **stages/phases** the entity goes through
- **Ordered**: each **stages/phases** follows another.
- The default lifecycle of any entity is: `new → exists → end`

```yaml
lifecycle:
  - Stages: # The steps the thing goes through 
    - start
    - stg 01
    - stg 02
    - stg 03
    - end
  - Order:  # The sequence the stages follow
    - stg 01 -> stg 02 -> stg 02 -> stg 03 -> stg 01
  - Entry:  # Where the lifecycle begins 
  - Exit:   # Where the lifecycle ends
```

## Representations

There are different possible representations.

**Txt Graph**

```yaml
Start --> Stage1 --> Stage2 --> Stage3 --> End
```

**Txt Table**

|id|Phase Name|
|-|-|
|1|start|
|2|Stage1|
|3|Stage2|
|4|Stage3|
|5|End|



# Example <a id='example'></a> 

cf. [list of lifecycle][lfc list]



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

# Kinds of lifecycle

A lifecycle can apply to many subjects:

| Kind | Subject | Stages |
| ---- | ------- | ------ |
| **Project lifecycle** | A project | Initiation → Execution → Closure |
| **Software lifecycle** | A software project | Development → Testing → Release |
| **Career lifecycle** | A person's career | Junior → Mid → Senior |
| **Product lifecycle** | A product | Discovery → Build → Grow → Mature |


# Todo

# From lifecycle to Entity Lifecycle and Roadmap

```
lifecycle          (exists alone)
   │
   └── attached to ──> subject  (project, software, …)
                            │
                            └── constrained ──> roadmap
```

- A subject/entity lifecycle exists as soon as you attach a lifecycle to it.
  - project lifecycle
  - software lifecycle
- A roadmap is a lifecycle constrained by **constraints**
  - constraints maybe 
    - generic
    - subject/entity-specific
    - generic-extented (same name diffrent semantic)


# Composition

A lifecycle is made of:

| Element | Role |
| ------- | ---- |
| **Stages** | The steps the thing goes through |
| **Order** | The sequence the stages follow |
| **Entry** | Where the lifecycle begins |
| **Exit** | Where the lifecycle ends |
