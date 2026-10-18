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


<h1 align="center">Project - Phase2: Model</h1>


the **ID** identifies which instance it is (see REQ-025).


# User's intent Vs. Execution Plan

```
Intent
  ↓ decompose
ActionPlan
  ├── Action
  │    ├── Target
  │    ├── Mechanism
  │    ├── RequiredCapabilities
  │    └── Inputs / Outputs
  ├── Action
  └── Action
```

| Concept      | Responsibility                                  |
| ------------ | ----------------------------------------------- |
| `Intent`     | Expresses the desired outcome                   |
| `ActionPlan` | Describes the steps and their dependencies      |
| `Action`     | Performs one operation at a defined granularity |
| `Mechanism`  | Implements the operation against its target     |

**This is an important separation**: 
- an intent is not a mechanism
- an action is not necessarily a single command.
- **Example**, 
  - `InstallPackage` might be a high-level action that decomposes into `Download`, `Transfer`, `Install`, `Verify`
  - If the target already has access to a repository, installation may require only one package-manager action.



## 4. If you want a unified type system

I'd use this overall structure:

```
Resource
├── HostResource
│   ├── Container
│   ├── VM
│   └── BareMetal
│
├── KernelResource
│   ├── Parameter
│   ├── Module
│   ├── Feature
│   ├── Subsystem
│   └── Interface
│
├── FileResource
│   ├── Text
│   ├── Binary
│   └── Directory
│
└── AccessStrategy
    ├── LocalProcess
    ├── SSH
    ├── AgentAPI
    ├── SysctlCLI
    ├── ProcfsFile
    ├── SysfsFile
    └── ModuleCLI
```

My recommendation: 
**Res Kind**: what the resource or target is.
  - **Example**: `Parameter`, `Module`, `Feature`, and `Interface`

**Res access mechanisms** : how the action is executed or the target is reached.
  - **Example**: `sysctl`, `procfs`, `sysfs`, and `modprobe` 

**Res capabilities** : which operations are supported.
  - **Example**: `read`, `write`, `load`, and `rebuild`

**Target Wrapping**: how access mechanisms compose to reach nested targets.


This keeps the taxonomy extensible without coupling 
- **what** a resource is
- **how** you interact with it.

Separate 
- what a resource is 
- what you can do with it from the chain of mechanisms needed to reach it.

- An action belongs to the resource operation
- its execution mechanism is selected in the context of the target's access chain.


> Wrapping isn't necessarily a replacement for the three dimensions; it is a relationship that connects them.

Keep `Kind`, `Mechanism`, and `Capabilities` as the resource model, and use recursive wrapping to compose target access.

## Kind of capabilities
**Declared capabilities**: what the resource or target type can support in principle.
**Effective capabilities**: what this particular target can actually do.
**Execution constraints**: what prevents an otherwise valid operation from succeeding.

Example: lots af check before playing the intent of the agent that request actions on a resources
- wrapping a Linux OS in a container does not guarantee that `modprobe` will work. 
- The command might be absent = to check
- the container might lack the necessary privileges = to check
- The operation might be prohibited by the container runtime. = to check


Idea:
- Resource have capabilities
- the CLI/API/SYSTEM expose a subset of resources capabilities
- At execution time all checks are done
  - is the request valid
  - does the CLI exists



# Todo

# Target Model
```
Target = Wrapper(inner_target)

NestedTarget =
    SSH(
        DockerExec(
            LocalOS
        )
    )
```

```
Resource
  └── exists in → Target
                    ├── base target
                    └── wrapped target
                          ├── inner target
                          └── transport / wrapper
```


**Access chain**: The ordered sequence of mechanisms used to reach that target and perform an action.

The execution chain, from the caller toward the resource, is:


The important point is that the target is constructed recursively, but execution proceeds from the outermost wrapper inward.

The wrapper composes access; it doesn't automatically grant permissions or create capabilities.



```
Resource
├── Kind
├── Capabilities
└── Target
    ├── BaseTarget
    │   ├── Kind
    │   └── Mechanisms
    └── WrappedTarget
        ├── InnerTarget
        └── Wrapper
            ├── Kind
            ├── Parameters
            └── Constraints
```

- An action can then be resolved against the resource's capabilities
- An action is executed using a mechanism chain appropriate to its target.

**TODO**
- I would not yet decide whether `Target` should be a first-class resource, a separate abstraction, or simply an execution context. Your idea works under any of those designs.

Decisioon: 
- keep recursive wrapping. 
- It is a strong candidate for a general mechanism-composition model, **not just for hosts**. 
- The next test should be a resource that is accessed through several layers but whose actions differ substantially across those layers. 
- That will help establish whether wrapping is truly generic or whether we need to distinguish target navigation from action execution.


# Example: a Linux OS inside a container

|Key|value|
|-|-|
|Resource|a kernel module named `nf_conntrack`|
|Target|a Linux OS inside a container|
|Chain|SSH → Docker exec → operation(modprobe)|




```
Caller
  → SSH to VM
    → docker exec into container
      → execute action
```


```
ssh user@vm 'docker exec container modprobe nf_conntrack'
```

# Example: a Bastion

```
SSH(
    SSH(
        RemoteOS
    )
)
```

- a real SSH bastion often uses `ProxyJump`
- `ProxyJump` routes the SSH connection through the intermediary rather than launching a separate interactive SSH session. 
- The abstract target composition can remain the same while the concrete execution strategy differs.

## 4. One important correction: inherited mechanisms aren't necessarily valid

**Requirement**: 
- A wrapped target inherits the base target's potential operations and mechanisms, subject to the effective capabilities and constraints of the resulting target.



## What should count as an atomic action?

an action should be atomic at the level of abstraction where it has one well-defined 
- responsibility
- inputs
- outputs 
- and success criteria.

For example:

```
InstallPackage
├── ResolveDependencies
├── DownloadArtifact
├── TransferArtifact
├── InstallArtifact
└── VerifyInstallation
```

- Some of these actions might themselves be decomposed. 
- **Example**
  - `TransferArtifact`, could use `SCP`, `SFTP`, an agent `API`, or an object-storage transfer.

That gives you recursive decomposition without requiring every action to be split to the smallest imaginable operation.

## One refinement: plans need dependencies and conditions

A simple ordered list is enough for many cases, but a general action plan should also support:

- **Dependencies**: install only after the artifact is transferred.
- **Conditions**: transfer only if the artifact isn't already available remotely.
- **Outputs**: pass the downloaded artifact path to the installation action.
- **Failure handling**: stop if verification fails; clean up temporary files if appropriate.
- **Execution context**: run an action with the required permissions and target access chain.

Actions may also run in parallel when their dependencies permit it.

## 5. Does this resolve the multi-target problem?

Intent: Load a kernel module inside a container on a remote VM

```
Action: LoadModule
└── Target: Container OS
    └── Wrapper: DockerExec
        └── Inner target: Remote VM
            └── Wrapper: SSH
                └── Base target: Local execution context
```

- The **action** plan handles what needs to happen. 
- The **wrapped target** handles how the relevant execution context is reached.

**One caveat**: the target composition must reflect the actual topology and execution direction. 
  - **Example**
    - an SSH connection to a VM followed by `docker exec` inside that VM
    - Is different from a container runtime accessed directly through a remote Docker API.

## My recommendation

**Decision**: `Intent → ActionPlan → Action` is used with every executable action declaring its
- Target
- Required capabilities
- Mechanism selection
- Inputs
- outputs
- And success criteria.


That gives us a promising foundation for a general automation system without forcing multi-step workflows, remote access, or resource-specific logic into the same abstraction.

**The next question** 
- Is an `Action` a universal concept shared by every resource
- Some resource families need specialized action types that still follow the same common contract.

# Resource Kind

- A Hierarchical path
- Identifies what type of a resource
- Txt representation is  `Type/Subtype/…`. 

```
Resource
├── Kernel
│   ├── module
│   └── param
├── Package
│   ├── repo
│   └── package
├── File            → capabilities → read, write, delete, copy
│   ├── Txt         → capabilities → read, write, delete, copy
│   │   ├── Json    → capabilities → read, write, delete, copy, validate-json
│   │   ├── Yaml    → capabilities → read, write, delete, copy, validate-yaml
│   │   └── ...
│   └── Bin
│       ├── tgz
│       ├── zip
│       └── ...
└── ...

```
## Form
- Written as `Type/Subtype/Sub-subtype/…`.
- Any depth is valid; **no depth limit**. e.g. `Kernel`, `Kernel/module`, `File/Txt/Json`
- A kind at any depth is valid: `Kernel`, `Kernel/module`, `File/Txt/Json` are all kinds.
- The **Type** is the first segment
- Each deeper segment refines the previous.

## Assignment
- Every resource is assigned **exactly one kind** (mandatory).


- A kind inherits the capabilities of its parent.
- For each inherited capability, a kind may:
  - extend it (keep the parent's behaviour and add to it)
  - override it (replace the parent's behaviour) or leave it unchanged.
- A kind may also add new capabilities.

## Capabilities
- A kind **inherits** the capabilities of its parent.
- For each inherited capability, a kind may:
  - **extend** it — keep the parent's behaviour and add to it,
  - **override** it — replace the parent's behaviour,
  - **leave it unchanged**.
- A kind may also **add** new capabilities.

**Example**  — File
```
File                  → capabilities: read, write, delete, copy
└── File/Txt          → inherits: read, write, delete, copy
    └── File/Txt/Json → inherits: read, write, delete, copy
                      → adds:     validate-json     (new)
                      → extends:  read              (parse after read)
                      → overrides: copy             (re-serialize on copy)            
```
**Example** — kernel module

```
Kernel/module
├── capabilities: build, install, load, enable, disable, unload, remove
└── inherited by:
    ├── Kernel/module/dkms
    │   └── adds: dkms-install, dkms-remove
    └── Kernel/module/out-of-tree
        └── overrides: build   (out-of-tree build)
```

## Notes

- The **inheritance rule** is what makes the hierarchical kind useful: 
  - shared capabilities are defined once at the parent, 
  - refinements stay local.
- **Extend / override / leave** keeps the parent as the single source of truth
  - Bo restating of unchanged capabilities.
  - **No depth limit** means the tree can grow as the taxonomy evolves; nothing needs to be pre-declared.

## Cross-references

| From | To |
| ---- | -- |
| REQ-027 | Hierarchical kind — the path form |
| REQ-028 | Kind assignment — exactly one per resource |
| REQ-017 | Capability discovery — capabilities come from the kind |
| REQ-018 | Capability exposure — a subset or all become operations |
| Model Resource identity | ID + identity attributes |
| Model Request | requests operate on resources of a given kind |




#  Resource identity

Every resource instance has:

- a **unique ID** — assigned by the model; unique across all resources.
- **identity attributes** — kind-specific fields that locate the resource within its target.

## ID

- Assigned by the system, not by the resource.
- Unique across all resources, regardless of kind.
- Stable: it does not change when the resource is renamed, moved, or reconfigured.
- Format: opaque to the operator; not derived from the kind or the attributes.

## Identity attributes

- Kind-specific: the fields depend on the kind.
- They locate the resource in its **target**, i.e. they are what the **mechanism** needs to reach it.

| Kind | Identity attributes |
| ---- | ------------------- |
| `File` | `path` |
| `Service` | `endpoint` |
| `Package/package` | `name`, `version`, `repository` |
| `Kernel/module` | `name` |
| `Database` | `host`, `port`, `name` |

## Example

```
Resource
├── ID:        res-42
├── Kind:      File/Txt/Json
└── Identity attributes:
    └── path:  /etc/app/config.json
```

## Contrast

- The **ID** says *which* resource. Distinguish 2 instances regardless of the kind
- The **identity attributes** say *where* it is. Distinguish 2 instances of the same kind on the target.
- The **kind** says *what* it is. Distinguish type of resource

## Cross-references

| From | To |
| ---- | -- |
| REQ-025 | Unique resource ID |
| REQ-026 | Identity attributes |
| Model Kind | the kind determines which attributes apply |

---


## Request
- An expression of intent
- Sent by an agent to the system
- Ask for an operation on a resource.
- Has a Lifecycle states (draft):

**Spaces**

| Space | Meaning |
| ----- | ------- |
| **Agent space** | the requester |
| **System space** | the system that receives, validates, and executes |
| **Resource space** | the target/resource where execution happens |

**Diagram**


```ini
AGENT SPACE                SYSTEM SPACE                     RESOURCE SPACE
───────────                ────────────                     ──────────────

requested ──────► requested
                       │
                       ├──► rejected      (terminal)
                       │
                       ├──► ignored       (terminal)
                       │
                       └──► accepted
                                │
                                ▼
                             running ──────────────────────► running
                                                                │
                                                                ├──► succeeded
                                                                └──► failed
                                ◄──────────────────────────────┘
                             completed
                                │
                                ▼
                           succeeded / failed
                                │
                                ▼
agent sees result ◄──── result

# all paths
requested ──► accepted ──► running ──► succeeded
requested ──► accepted ──► running ──► failed
requested ──► rejected
requested ──► ignored
```

- A requested operation must correspond to a capability of the resource.
- Acceptance ≠ success. Acceptance means the request was valid and admitted; success depends on execution.
- **TODO: *Open*: is `ignored` a chosen state or the absence of a response?**



#  Request

A **request** is an expression of intent sent by an agent to the system, asking for an operation on a resource.

## Structure

A request carries, at minimum:

- the **agent** that issued it,
- the **resource** it targets (by ID),
- the **operation** it asks for,
- any **parameters** the operation requires.

## Lifecycle

```
AGENT SPACE                     SYSTEM SPACE
───────────                     ────────────

requested ─────────────────►    requested
                                     │
                                     ├──► rejected     (terminal)
                                     ├──► ignored      (terminal)
                                     │
                                     └──► accepted
                                              │
                                              ▼
                                           running ─────►  resource
                                              │            (mechanism)
                                              ├──► succeeded
                                              └──► failed
                                              │
                                              ▼
agent sees result ◄────────────  result
```

## States

| State | Meaning | Terminal? |
| ----- | ------- | --------- |
| `requested` | the agent has emitted the request | no |
| `accepted` | the system admitted the request | no |
| `rejected` | the system refused the request | yes |
| `ignored` | the system did not respond | yes |
| `running` | the operation is executing | no |
| `succeeded` | execution finished with the intended result | yes |
| `failed` | execution finished without the intended result | yes |

## Rules

- A requested operation must correspond to a **capability of the resource** (see REQ-021).
- **Acceptance** means the request is valid and admitted
- **success** depends on execution (see REQ-024).
- `rejected` and `ignored` are terminal: no further transitions.
- `accepted` always leads to `running` (never directly to a terminal state).

## TODO > Open

- Is `ignored` a state the system **enters**, or the **absence** of a transition (the request stays in `requested`)?
- Can a `running` request be **cancelled**? If so, `cancelled` becomes a terminal state alongside `succeeded`/`failed`.

## Cross-references

| From | To |
| ---- | -- |
| REQ-021 | Operation–capability match |
| REQ-022 | Request lifecycle |
| REQ-023 | Request outcome |
| REQ-024 | Execution outcome |
| Model Kind | capabilities are inherited from the kind |
| Model Resource identity | the resource is referenced by ID |

---

## Model phase — current contents

| Section | Status |
| ------- | ------ |
| Kind | ✅ written |
| Resource identity | ✅ written |
| Request | ✅ written |
| Wrapped target | ⏳ earlier draft — needs the nesting rule |
| Resource vs Target | ⏳ earlier note — operation-relative |
| Operation / Mechanism | ⏳ exist in Terminology, structure may be needed here |


# Wrapped target

A **wrapped target** is a base target reached through a transport mechanism.
>
```
Resource: a kernel module
└── Target: a local OS
    ├── Action: build   → Command: make -C …   → Mechanism: make
    ├── Action: install → Command: apt install … → Mechanism: apt
    ├── Action: load    → Command: modprobe <mod→ Mechanism: modprobe
    ├── Action: load    → Command: insmod <mod>.ko → Mechanism: insmod
    └── Action: enable  → Command: echo … >…  → Mechanism: shell
└── Target: VM over SSH
    └── derives from: local OS
        transport: ssh
```
>
- Inherits the base target's actions, commands, and mechanisms.
- Prefixes each mechanism with the transport: `ssh + make`, `ssh + apt`, `ssh + modprobe`, …
- *Open*: can a wrapped target itself be wrapped? (e.g. jump host + VM over SSH)


**A wrapped target can itself be wrapped.**

**Example — a container inside a VM over SSH:**

```
Base target:        local OS (inside the container)
Wrap 1:             docker exec   → container
Wrap 2:             ssh           → VM
Full target:        "container on a VM over SSH" - (local os → ssh → remote VM over SSH → container)
Mechanism:          ssh + docker exec + <action mechanism>
```

Concretely, to load a kernel module *inside a container running on a remote VM*:

```
ssh <user>@<vm> docker exec <container> modprobe <module>
 └─ wrap 2 ─┘   └──── wrap 1 ────┘ └ action mechanism ┘
```

**Example — Kubernetes pod via `kubectl exec` on a remote cluster:**

```
Base target:        local OS (inside the pod)
Wrap 1:             kubectl exec   → pod
Wrap 2:             ssh            → cluster node
Full target:        "pod on a remote Kubernetes cluster" - (local os → ssh → remote VM over SSH → container)
Mechanism:          ssh + kubectl exec + <action mechanism>
```

So the rule generalizes:

```
Wrapped target = base target + N transports, applied in order
```
**Example — Accessing a VM over SSH via a Bastion**

**Example — jump host + VM over SSH**


## Phase 03 — Requirements (additions)

| ID | Group | Version | Status | Kind | Priority | Title | Statement | Source | Rationale |
| -- | ----- | ------- | ------ | ---- | -------- | ----- | --------- | ------ | --------- |
| REQ-027 | Model | 0.1 | draft | functional | must | Hierarchical kind | represent a resource's kind as a hierarchical path of one or more segments. | <your statement| Kinds are refined by depth, not fixed at two levels. |
| REQ-028 | Model | 0.1 | draft | functional | must | Kind assignment | assign each resource exactly one kind. | <your statement| Ambiguity about what a resource is must be excluded. |

**Register count:** 26 → **28 rows.**

## What I did *not* add

- No `Kind` entry in Phase 02.
- No `Capability` entry in Phase 02 (you said it belongs where `kind` is used — it's covered by REQ-017/018 and the Model).
- No changes to REQ-001…REQ-026.

## Open points carried forward

- `Kind` inheritance from parent — decide, then either add a Model note or a REQ.
- `Kind` depth limit — decide.
- `ignored` — chosen state or absence of response?
- `Wrapped target` — can it be nested?
- REQ-019…REQ-024 — `Source` placeholders still unresolved.

---

**Next:** want me to output the full **28-row register** as one clean table, or move to the **Model phase** and write it out in full?