[//]: #(home)
[home]: ../../README.md

[//]: #(ref)
[phase whatis]: ../whatis/phase.md



[↖][home]

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a program](../whatis/program.md)      | Internal | |

<h1 align="center">What is a Lifecycle</h1>



# Definition
- can be formally defined in mathematics, in particular within **graph theory** and its extension **Petri nets**.
- Model the evolution of something (e.g. entity, system, process, activity) through a sequence of **phases** over time.

## Example

| Context | Lifecycle |
|-|-|
| Theoretical | `A` → `B` → `C` → `D` → `A` → `A` → `D`
| Software | `development` → `testing` → `deployment` → `operation` → `retirement`
| Project | `initiation` → `planning` → `execution` → `closure`
| Product | `conception` → `development` → `launch` → `maturity` → `decline`
| Organization | `creation` → `growth` → `maturity` → `transformation/dissolution`
| Biology | `birth` → `development` → `reproduction` → `death`
| Data | `creation` → `processing` → `storage` → `archival/deletion`
| Document | `draft` → `review` → `approval` → `publication` → `archival`

- each arrow represents a **transition** from one phase to another

# Terminology

| Term | Meaning |
| - | - |
| **phase**      | <li>A named stage <li>represents a state  <li>produces/creates an **output** |
| **transition** | <li>is represented by the arrow in the lifecycle <li>is caused/triggered by an event <li>has a **source** phase and a **destination** phase|
| **event**      | What triggers/permits/causes a transition |
| **output**	  | <li>is internal to a phase <li>can be the input of another phase |
| **outcome**	  | <li>The resulting state/effect after a transition <li>Answers "where are we now?" |

# Kind

| Name | Representation | Description |
|---|---|---|
| **Linear** | `A → B → C → D` | A straightforward sequence where each stage follows the previous one, with no branching or repetition. |
| **Branching** | `A → B → C`<br> `       ↘ D` | A main path continues, but an alternative path splits off at some point. |
| **Cyclic** | `A → B → A → B → ...` | The process repeats in a loop, returning to an earlier stage. |
| **Mixed** | `A → B → B → ...`<br>`    ↘ D ➚` | Combines branching and repetition: there is a loop back to an earlier stage and an alternate branch that rejoins the main flow. |




# Output vs. Outcome

When an entity (document, project, software) goes through the stages of it lifecycle. At each stage two things are true:

| | Plain question | Answer |
| - | - | - |
| **Output** | What did this stage **produce**? | <li>tool: code, tests, package… <li>doc: ... <li>project:|
| **Outcome** | What **state** is the entity in now? | <>software:estable, live… <project>: ... <li>doc: ...|



| | Output | Outcome |
| - | - | - |
| Phase concerned | the **src** phase | the **dst** phase |
| Definition | A thing **produced** by the (work of the) **src** phase | The **resulting state** of a **dst** phase |
| Answers | *"What did the phase make?"* | *"What state did we land in?"* |
| Grammatical form | a **noun** | an **adjective / condition** |
| Countable? | one or more nouns | one state per dst phase |
| Example | code, report, package | Is testable, Is live, Is closed |

- **Output** concerns the src phase.
- **Outcome** concerns the dst phase.

**todo**
- an output is often an **artifact/delivery**.
- an outcome is a resulting state or condition.


```
development → testing
```

- `development`: **output** = *source code + builded artifacts*
- `development → testing`: **outcome** = *software is testable*

```
deployment → operation
```

- `deployment`:output = the release package and config
- `deployment → operation`: **outcome** = software is live (i.e. installed and running on the production servers)

**todo**

Before that, in `deployment`, the software was *being installed*. After the transition, it is *running*. "Live" is just the short word for **"running in production."**

## Use Case: Software lifecycle

```
development → test → deployment → operation → retirement
```

- An outcome is a resulting state, status, or condition.
- An outcome describes the readiness state (or milestone) that an entity (such as software) achieves at the end of each phase.
- Adding a dedicated Status / Milestone column highlights the state the entity reaches before moving forward.

### Software Lifecycle with Readiness States

| Stage | What Happens | Output Produced | Status / Milestone | Next Stage |
| --- | --- | --- | --- | --- |
| **Development** | Write code, build initial features | Source code, compiled artifacts | Software **is testable** | Testing |
| **Testing** | Run automated & manual tests, fix bugs | Test reports, bug fixes | Software **is deployable** | Deployment |
| **Deployment** | Install release on production environment | Configuration, live environment setup | Software **is live** | Operation |
| **Operation** | Run in production, monitor, apply patches | Logs, telemetry data, hotfixes | Software **is end-of-life** | Retirement |
| **Retirement** | Turn off servers, archive remaining data | Final database archive | Software **is decommissioned** | — |

Using *"software is [state]"* creates a clear gatekeeping checklist: you don't move to **Deployment** until the software **is deployable**, and you don't move to **Operation** until the software **is live**.



| Stage | What Happens | What Goes In (Input) | What Comes Out (Output) | What Triggers the Next Step |
| --- | --- | --- | --- | --- |
| Development| <li>Write code <li>create initial features <li>fix initial bugs. | <li>Requirements <li>user stories | <li>Source code <li>compiled code <li>artifacts | <li>Code passes peer review <li> Code is ready for QA. |
| Test | Run automated and manual tests to find bugs. | Compiled build artifacts | <li>Test reports <li>bug fixes | <li>All critical tests pass <li>release is approved. |
| Deployment | Install and configure the build on live servers. | <li>Verified release package <li>config files | Live running application | Deployment completes successfully and passes smoke tests. |
| Operation | <li>Run the app in production <li>monitor <li>fix bugs. | Live application | <li>Logs <li>metrics <li>patch updates | <li>Management decides the software is outdated OR <li> Software is no longer needed. |
| Retirement | <li>Decommission servers <li>migrate user data <li>shutting down. | Live application, migration plan | Data archives, turned-off servers | The system is fully powered down (End of Life). |

| Stage | What happens | Output (produced) | What ends the stage | Next stage |
| - | - | - | - | - |
| `development`| write code        | <li>src code <li>builded artifacts| code is ready   | `testing` |
| `testing`    | run tests         | test reports, fixes  | tests pass      | `deployment` |
| `deployment` | install release   | <li>release package <li>config   | release is live | `operation` |
| `operation`  | run in production | logs, patches      | end-of-life decision | `retirement` |
| `retirement` | shut down         | final archive      | — | - |


| Phase (src) | → Transition → | Phase (dst) | Src Phase Output | Dst Phase Outcome|
| - | :-: | - | - | - |
| `development` | → | `testing` | source code, build artifacts | software *is testable* |
| `testing` | → | `deployment` | test reports, bug fixes | software *is deployable* |
| `deployment` | → | `operation` | release package, config | software *is live* |
| `operation` | → | `retirement` | logs, maintenance patches | software *is decommissioned* |



software *is testable* 
software *is deployable* 
software *is live* 
software *is decommissioned*



Arriving in `operation` → the state is **"the software is live"** (i.e. running in production).

If "live" still feels vague, a more explicit version of the outcome would be:

> ✅ **the software is running in production for real users**

Would you like me to use that longer, plainer phrasing in the table instead of the word "live"?

### Terminology
- **"Is live"** means

   | Context | meaning |
   | - | - |
   | Sotfware | is running in production and real users are using it |
   | Website | the site is reachable at its real URL |
   | App | users can download and use it |
   | API | it responds to real requests |
   | Feature | it is switched on for real users (not behind a flag) |

- **"operational"** means: is being used, day to day.

## Use Case: Project lifecycle 

| Phase (src) | → Transition → | Phase (dst) | Output — (src phase delivery) | Outcome — (dst phase state) |
| - | :-: | - | - | - |
| `initiation` | → | `planning` | charter, business case | the project *is approved* |
| `planning` | → | `execution` | schedule, budget, plan | the project *is ready to run* |
| `execution` | → | `closure` | deliverables, product | the project *is complete* |
| `closure` | → | *(end)* | final report, lessons learned | the project *is closed* |

## Use Case: Document lifecycle 

| Phase (src) | → Transition → | Phase (dst) | Output — (src phase delivery) | Outcome — (dst phase state) |
| - | :-: | - | - | - |
| `draft` | → | `review` | 
| `review` | → | `approval` | 
| `approval` | → | `publication` | 
| `publication` | → | `archival` |



# Todo

```
                 Transition
                     │
                     ▼
[src phase] ────────→ [dst phase]
     │                     │
     │                     │
   Output                Outcome
     │                     │
     ▼                     ▼
What was produced     What became true
```

```
planning
   │
   │  execute
   ▼
execution
```

The output of planning might be:

schedule + budget + project plan

The outcome of the transition is:

project is ready to run
## Transition

- **Input/output** describes what enters and leaves a transition.
- **Outcome** describes the resulting state/effect of the transition.


```
Input :   a phase
Outcome : a phase
```

Representation
```
phase A. ── transition ──> phase B.
```

## Phase

- Represents a state.
```
input → processing → outcome
```
```
        transition
   ┌──────────────────┐
   │                  │
Input ──────────────> Outcome
   │                  │
   └──────────────────┘
```
## Lifecycle
- Model the evolution of something (e.g. entity, system, process, activity) through a sequence of **phases** over time.
- May be linear, branching, or cyclic

```
Phase A. → Phase B. → Phase C.
```

```
Phase A
   │
   │ input/event
   ▼
Transition
   │
   │ outcome
   ▼
Phase B
```

A lifecycle is a model of successive state transitions, where each transition transforms an input phase into an outcome phase.

```
Draft ── submit ──> Review ── approve ──> Published
```

- `Draft` = input phase
- `submit` = transition
- `Review` = outcome phase
- `approve` = next transition
- `Published` = next outcome phase

## Output vs. Outcome
- Output is usually something produced:
```
Input: source code
Output: compiled binary
```

- Outcome is the resulting state/effect:
```
Input: draft document
Outcome: document is approved
```



# development
```
   ┌───────────────────────────────────────┐
   │ development                           │
   │                                       │
   │  inputs:  requirements, design        │
   │  work:    write, compile, build       │
   │  outputs: source code, build artifact │
   └───────────────────────────────────────┘
                    │
                    │ transition: "code complete"
                    ▼
   ┌───────────────────────────────────────┐
   │ testing                               │
   │  state (outcome): "software is        │
   │                    testable"          │
   └───────────────────────────────────────┘
```   





## Corrected framing

```
        phase (works)              transition (moves)
   ┌─────────────────────┐      ┌──────────────────┐
   │  development        │ ───> │  testing         │
   │  produces:          │      │  state:          │
   │  source code        │      │  is testable     │
   └─────────────────────┘      └──────────────────┘
        ↑ OUTPUT                     ↑ OUTCOME
        (by this phase)              (of arriving here)
```


## The clean rule


