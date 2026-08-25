[//]: #(Home)
[HOME]: ../whatis/ep.md  
[Roadmap]: #roadmap

[//]: #(functional)
[rctl whatis]: ../whatis/ep.md
[res list]:    ../list/res.md
[host list]:   ../list/host.md

[←][HOME]
|||
|-|-|
|[what is rctl][rctl whatis]|see|

<h1 align="center" id="roadmap">rctl Roadmap</h1>



| Id | Phase | Duration | Outcome |
| - |-|-|-|
| 0 |[Inventory](#-phase-0--inventory) | **2–4 h** | Small Inventory of existing resources and their operations |
| 1 |[Design](#-phase-1--design) | **2–4 h** | `rctl` command model agreed |
| 2 |[Core CLI](#-phase-2--core) | **0.5–1 day** | `rctl` runs, config/help/errors work |
| 3 |[Repo resource](#-phase-3--repo) | **1–2 days** | Existing repo scripts exposed through `rctl` |
| 4 |[`doc` registry](#-phase-4--doc) | **1 day** | `rctl` reads repository metadata |
| 4M1 |[rctl v0.1](#-m1--rctl-v01) | **~4–6 days** | Useful replacement for your current aliases/tools |
| 5 |[Packaging/release](#-phase-5--distribution) | **0.5–1 day** | Install/version/upgrade |
| 6 |[Image resource](#) | **1 day** | `rctl image ...` |
| 7 |Container resource | **1 day** | `rctl container ...` |
| 8 |Relationships | **0.5–1 day** | Resources can reference each other |
| 8M2 |[rctl v0.2](#-m2--add-resources) | **~7–10 days total** | Repo + image + container |
| 9 |Cleanup/documentation | **1–2 days** | Team-ready |
| 9M3 |[v1.0](#-m3--relationships) | **~2 weeks total** | Stable everyday tool |




# [↑][Roadmap] Phase 0 — Inventory


- No code.
- List resourceto manage or expect to manage.

Take what you already have:

```text
shell scripts
Go tools
aliases
curl commands
GitHub API calls
GitLab API calls
```

and make a simple map:

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

**Deliverable:** list of resources + actions.

# [↑][Roadmap] Phase 1 — Design


Decide only:

```bash
rctl <resource> <action> [name] [options]
```

and the first vocabulary.

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

**Deliverable:** a tiny CLI specification.

No 50-page architecture document.

# [↑][Roadmap] Phase 2 — Core


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

# [↑][Roadmap] Phase 3 — Repo


This is where the project becomes useful.

Don't rewrite your existing tools.

Wrap them.

For example:

```bash
rctl repo reset-history foo
```

can initially invoke your existing shell script.

Likewise:

```bash
rctl repo create foo
```

can use the existing template mechanism.

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

**Deliverable:** you can start replacing your aliases.


# [↑][Roadmap] M1 — `rctl v0.1`

At this point I'd actually stop.

Use it for several days.

Don't immediately build containers.

You want to discover whether:

```bash
rctl repo create foo
rctl repo clone foo
rctl repo reset-history foo
```

actually feels good.

This is an important milestone because **the user experience is more important than the architecture at this stage.**


# [↑][Roadmap] Phase 4 — `doc`


Now connect the existing `doc` repository.

I'd keep this extremely simple initially.

Something like:

```yaml
repositories:
  - name: foo
    github: ...
    gitlab: ...
    template: ...
```

Then:

```bash
rctl repo list
rctl repo info foo
```

can consume it.

Don't build a database.

Don't build a service.

Don't build a synchronization engine.

It's just a **versioned registry file in Git**.


# [↑][Roadmap] Phase 5 — Distribution


Make:

```bash
rctl version
```

and provide a simple installation mechanism.

You want this:

```bash
curl ... | sh
```

to mean:

> install a specific released version of `rctl`

rather than:

> download and execute some arbitrary repository script.

That's a significant improvement over your current approach.


# [↑][Roadmap] M2 — Add resources

Now the fun part.

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

At this point we're testing whether your resource abstraction is actually useful.

And this is important:

> **Do not design the image/container architecture before implementing them.**

Implement `repo` first.

Then image.

Then container.

Let the common abstraction emerge from the three actual cases.


# [↑][Roadmap] M3 — Relationships

**½–1 day**

Only now start exploiting the fact that everything is a resource.

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

can show related resources.

This is where your `doc` repository starts becoming much more interesting.


# My recommended timeline

If you can spend a focused day or two on it:

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
     USE IT

Day 6
 └── image

Day 7
 └── container

Day 8
 └── relationships

Day 9–10
 └── cleanup / documentation / migration
```

**So I'd estimate ~5 days to get something genuinely useful, and ~10 days to get the first complete version you're describing.**

And I'd deliberately keep **v1 small**.

The biggest risk isn't that `rctl` will be technically difficult. The biggest risk is **over-designing the abstraction before you've migrated enough real commands to know what the abstraction should be.**

So our next step should be **Phase 0: inventory**. We can make a very small table of your existing tools/actions and use that to derive the first `rctl` resource model.

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
