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


<h1 align="center">Project: RCtl — Task: Design CLI Syntax</h1>

Follows the [How-to: Design the Grammar of a CLI][cli howto].

| Field | Value |
|---|---|
| **Status** | Draft |
| **Assignee** | Lead Engineer |
| **Target Package** | `src/pkg/cli` |
| **Governing Specs** | [REQ-01], [SPEC-01], [ADR-02] |
| **Deliverable** | ADR-004 (CLI Grammar Specification) |

---

## Step 1 — Identify Core Verbs & Nouns

`rctl` should manage several kind of [repositories][repo whatis]

- `git`
- `container` (images)
- `pkg` (dnf, apt, npm, …)

### Cross-resource verbs

Generic verbs that should apply to all repositories

| Verb | Meaning |
|---|---|
| `list` | List repositories or items inside a repo |
| `add` | Insert an item into a repository |
| `get` / `inspect` | Inspect the state of a resource |

### Resource-specific verbs

Verbs that should apply to, only, some kind of repositories

| Resource | Verbs |
|---|---|
| `git`, `container` | `push`, `commit`, `branch`, `reset-history` |
| `pkg` | `publish`, `yank` |

---

## Step 2 — Evaluate Grammar Archetypes

Three candidates were evaluated.

### Option A — `<subject> <verb>`
```sh
# <verb> <resource-target>
rctl list git:my-repo
rctl push container:my-image

# <res> <verb>
rctl git:my-repo list
rctl container:my-image push

```

### Option B — `<verb> <subject>`

```bash
# resoure level
rctl create repo --type git       --name my-app
rctl list   repo --type container

# item level
rctl list content --repo git:my-app
rctl push item    --repo container:my-image --file image.tar
```

- ✅ Intuitive for general actions.
- ❌ Flags become verbose when scoping into a repository (`--repo …`).

### Option C — `<noun> <sub-noun> <verb>`

```bash
# resoure level
rctl repo create --type git --name my-app
rctl repo list   --type container

# item level
rctl repo content list my-app
rctl repo content add my-app --file artifact.tar
```

- ✅ Clean auto-completion, good scoping.
- ❌ Deeper and more verbose for quick actions.

### Option D — `<verb> <resource-address>`

```bash
# resoure level
rctl list git:my-org/my-repo # remote repo
rctl list git:my-repo        # local repo
rctl list container:registry.internal/my-image # docker, podaman, ...

# item level
rctl add git:my-org/my-repo --file main.go
```

- ✅ Concise and fast for power users.
- ❌ Requires strict, unambiguous resource-address parsing.


### Option E — Sub-item Scope
```sh
# Path style
rctl list git:my-repo/branches
rctl list container:my-image/tags

# Flag/Sub-command style
rctl list git:my-repo         --items // list branches
rctl list container:my-image  --items // list tags

```
**Decision:** 
- **Option D**
- use Cross-resource verbs
- use resource-specific verbs
- **Option E**: path-style:

```bash
# Resource-level generic operations
rctl container:registry.internal/my-app list
rctl git:my-org/my-app list
rctl pkg:npm/my-lib    list

# Sub-resource level (collection) operations
rctl git:my-org/my-app/branches              list
rctl container:registry.internal/my-app/tags list


# Item-level operations
rctl git:my-org/my-app       inspect
rctl git:my-org/my-app/files add --file ./config.json
rctl pkg:npm/my-lib/v1.2.0   add --file ./dist/bundle.tgz
rctl container:registry.internal/my-app inspect
```

When an operation only makes sense for a specific resource type, the (domain-specific) verb is appended directly to the target.

```sh
# resource level operation - Git-specific operation
rctl git:my-org/my-app push          --branch main
rctl git:my-org/my-app reset-history --force

# resource level operation - Container-specific operation
rctl container:registry.internal/my-app:v1.0.0 push

# resource level operation - Package-specific operation
rctl pkg:npm/my-lib/v1.0.0 publish
rctl pkg:npm/my-lib/v1.0.0 yank
```

**Rationale:** target-first ordering makes the *object of the operation* the primary mental anchor, unifies resource and sub-resource addressing under one path grammar, and leaves room for domain-specific verbs without special-casing.


## Step 3 — Stress-Test Against Other Resource Types

Validates that the pattern generalizes beyond repositories (resources defined in Phase 01).

| Resource Type | Command | Action |
|---|---|---|
| Files | `rctl file:/etc/app/config.json inspect` | Inspect local file properties |
| Files (S3) | `rctl s3:my-bucket/logs/app.log get` | Retrieve S3 object |
| VMs | `rctl ovh:instance-12345 restart` | Reboot a cloud VM |
| Clusters | `rctl k8s:prod-cluster/nodes list` | List nodes in a K8s cluster |
| Manifests | `rctl manifest:dev-env.yaml apply` | Apply a declarative manifest |

**Result:** the grammar holds across all resource classes without modification.

---

## Step 4 — Deliverable: Draft ADR-004

Write **ADR-004 — CLI Grammar Specification** recording:

1. The chosen pattern (target-first, `resource-address [sub-path] verb [flags]`).
2. Resource-address syntax (`type:path[:version]`).
3. Cross-resource vs. domain-specific verb placement.
4. The stress-test table above as validation evidence.


