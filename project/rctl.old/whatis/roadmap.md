[//]: #(home)
[home]: ../whatis/ep.md  
[top]: #

[//]: #(planing)
[roadmap whatis]: #roadmap

[//]: #(functional)
[roadmap log whatis]: ../whatis/roadmap.log.md
[res list]:        ../list/res.md
[host list]:       ../list/host.md

[←][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is the roadmap progression log][roadmap log whatis]|see|functiunal

# Index
- [Roadmap](#roadmap)
- [Roadmap Timeline](#roadmap-timeline)
- [Risk](#-risk)


<h1 align="center">rctl Roadmap</h1>

# Roadmap <a  id="roadmap"></a>

| Id | Status |Phase | Estimated |Duration| Outcome |
| - |-|-|-|-|-|
| 0 | [✅](./roadmap.log.md#-phase-0) | [Inventory](#-phase-0--inventory) | **2–4 h** |½ day| Small Inventory of existing resources and their operations/actions |
| 1 | [🟡](./roadmap.log.md#-phase-1) |[Design](#-phase-1--design) | **2–4 h** || <li>`rctl` command model agreed  <li> a tiny CLI specification.||
| 2 | ⬜ |[Core CLI](#-phase-2--core) | **0.5–1 day** || <li>`rctl` runs, config/help/errors work|
| 3 | ⬜ |[Repo resource](#-phase-3--repo) | **1–2 days** || <li>Existing repo scripts exposed through `rctl` <li>Start replacing all aliases.|
| 4 | ⬜ |[`doc` registry](#-phase-4--doc) | **1 day** || `rctl` reads repository metadata |
| 4M1 | ⬜ |[rctl v0.1](#-m1--rctl-v01) | **~4–6 days** || Useful replacement for your current aliases/tools |
| 5 | ⬜ |[Packaging/release](#-phase-5--distribution) | **0.5–1 day** || <li>Install/version/upgrade <li> `run version` works <li>`rctl` is distribuable/installable in a specific release|
| 6 | ⬜ |[Image resource](#) | **1 day** || `rctl image ...` |
| 7 | ⬜ |Container resource | **1 day** || `rctl container ...` |
| 8 | ⬜ |Relationships | **0.5–1 day** || Resources can reference each other |
| 8M2 | ⬜ |[rctl v0.2](#-m2--add-resources) | **~7–10 days total** || Repo + image + container |
| 9 | ⬜ |Cleanup/documentation | **1–2 days** || Team-ready |
| 9M3 | ⬜ |[v1.0](#-m3--relationships) | **~2 weeks total** || Stable everyday tool |




## [↑][roadmap whatis] Phase 0 — Inventory

|||
|-|-|
|Outcome|<li>a small inventory <li>List of the tool/resource and their actions to be managed by `rctl`
|Purpose|<li>understand what already exists without changing anything <li>derive from that table the first `rctl` resource model and design from reality rather than from theory|


Take what you already have:

```text
shell scripts
Go tools
aliases
curl commands
GitHub API calls
GitLab API calls
```

and make a simple map resource/actions per resource:

```text
repo
 ├── create
 ├── clone
 ├── delete
 ├── reset-history
 └── ...

image
 ├── build
 ├── push
 └── ...

container
 ├── run
 ├── exec
 └── ...
```

```
resource/tool
  ├── purpose
  ├── implementation
  ├── dependencies
  ├── dangerous?
  ├── versioned?
  └── replacement
```  

**Deliverable:** list of resources + actions.

## [↑][roadmap whatis] Phase 1 — Design
Do not freeze yet the concepts of **action**
- it may be a workflow (set of operation)
- it may be a single operation

Define a small universal vocabulary set for **actions**, with resource-specific actions layered on top.
```
get, list, create, delete, etc.
```


Define the grammar:

```bash
rctl <resource> <action> ...
rctl <resource> <action> [name] [options]
```


For example:

```bash
rctl repo list
rctl repo create foo
rctl repo clone foo

rctl image build foo
rctl image push foo

rctl container run foo
rctl container exec foo
```

Also decide:

* configuration location
* output conventions
* errors
* exit codes
* versioning

**Deliverable:** 
- a tiny CLI specification.
- Not 50-page architecture document.

Define information like (only for one resource to not waste to much time)
- resource naming
- action naming
- arguments
- options
- common actions (list, get, delete, etc.)
- resource-specific actions
- how providers are selected
- configuration
- output
- errors
- exit codes

### Todo




## [↑][roadmap whatis] Phase 2 — Core


Build the skeleton:

```text
rctl
├── command dispatch
├── configuration
├── logging/output
├── errors
└── version
```

At the end:

```bash
rctl --help
rctl version
```

works.

## [↑][roadmap whatis] Phase 3 — Repo

- Don't rewrite existing tools.
- Only Wrap them.

For example:

```bash
# Invoke the existing shell script.
rctl repo reset-history foo
```


Likewise:

```bash
# Invoke the existing template mechanism.
rctl repo create foo
```


The architecture becomes:

```text
rctl
 │
 └── repo reset-history
          │
          ▼
    existing script
```

Later:

```text
rctl
 │
 └── repo reset-history
          │
          ▼
     Go implementation
```

**Deliverable:** Start replacing your aliases.

Start with 5 actions for the git/repo resource:
```
git/repo
  ├── list
  ├── info
  ├── clone
  ├── create
  ├── tpl
  └── reset-history
```  

### Todo
Don't rewrite them immediately. Wrap them:
```
mx repo reset-history
       │
       └── existing reset-history.sh
```


## [↑][roadmap whatis] M1 — `rctl v0.1`

- At this point:stop.
- This is an important milestone because **the user experience is more important than the architecture at this stage.**
- Use `rctl` for several days.
- Don't immediately build containers.
- Discover whether the grammar and the code feels good:

```bash
rctl repo create foo
rctl repo clone foo
rctl repo reset-history foo
```


## [↑][roadmap whatis] Phase 4 — `doc`

- Create the machine-readable repository **manifest** in **sot** repository and make the documentation generated from it.
- connect the existing `SOT` (i.e. `doc`) repository.
- Keep this extremely simple initially.

Something like:

```yaml
repositories:
  - name: foo
    github: ...
    gitlab: ...
    template: ...
```

Then check the following cde can consume it.:

```bash
rctl repo list
rctl repo info foo
```

- Don't build a database.
- Don't build a service.
- Don't build a synchronization engine.
- It's just a **versioned registry file in Git**.



## [↑][roadmap whatis] Phase 5 — Distribution


Run:

```bash
rctl version
```

Provide a simple installation mechanism.

You want this:

```bash
curl ... | sh
```

to mean:

> install a specific released version of `rctl`

rather than:

> download and execute some arbitrary repository script.

That's a significant improvement over your current approach.

### Todo
move from
```sh
curl | jq | base64 | sh
```

to
```
mx repo create ...
```


## [↑][roadmap whatis] M2 — Add resources
- Test whether the resource abstraction is actually useful.
- **Do not design the image/container architecture before implementing them.**
- Implement `repo` first then **image**, then **container**
- Let the common abstraction emerge from the three actual cases.

### Image

**~1 day**

```bash
rctl image build foo
rctl image tag foo
rctl image push foo
```

### Container

**~1 day**

```bash
rctl container run foo
rctl container exec foo
rctl container stop foo
```

### Todo
- Have the **sot** repository validate the whole ecosystem.

## [↑][roadmap whatis] M3 — Relationships
- Start exploiting the fact that everything is a resource.

**½–1 day**


For example:

```text
repo/foo
   │
   └── produces
         │
         ▼
image/foo:1.2
         │
         └── runs as
                │
                ▼
          container/foo-dev
```

Then perhaps:

```bash
rctl repo info foo
```

- can show related resources.
- This is where the `SOT` repository (i.e. `doc`)  starts becoming much more interesting.


# [↑][roadmap whatis] Roadmap Timeline

```text
Day 1
 ├── inventory
 ├── CLI design
 └── core skeleton

Day 2–3
 └── repo resource

Day 4
 └── doc registry

Day 5
 └── packaging + polish

       ↓

     M1 / v0.1
      └── USE rctl
       ↓
     

Day 6
 └── image

Day 7
 └── container

Day 8
 └── relationships

Day 9–10
 └── cleanup / documentation / migration
```

- ~5 days to get something genuinely useful
- ~10 days to get the first complete described version
- **v1.0** is deliberately kept **small**.





# [↑][top] Risk
- wasting time **over-designing** the abstraction before migrated enough real commands to know what the abstraction should be.
- reduce this risk => start coding soon after [phase 0](#-phase-0--inventory) with one resource.

# Todo - old

| Phase | Duration | Milestone |
| ---------------------------------- | --------------: | ---------------------------------------------- |
| 0. Discovery & inventory | 1 week | We understand what exists |
| 1. Architecture & UX | 1 week | `rctl` design is frozen enough to implement |
| 2. Core CLI foundation | 1–2 weeks | `rctl` executable + command framework |
| 3. Repository resource | 2–3 weeks | Existing repo operations usable through `rctl` |
| 4. Registry / `doc` integration | 2 weeks | Repository inventory becomes machine-readable |
| 5. Distribution & release | 1–2 weeks | Anyone can install/use a known version |
| **Milestone: rctl v0.1** | **~8–11 weeks** | **Useful daily tool** |
| 6. Resource abstraction validation | 1 week | Architecture proven against real usage |
| 7. Image resource | 2 weeks | Images manageable through `rctl` |
| 8. Container resource | 2–3 weeks | Containers manageable through `rctl` |
| 9. Relationships / graph | 1–2 weeks | Resources can describe dependencies |
| 10. Hardening & documentation | | |

