[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[res whatis]: /concept/resource/whatis/ep.md
[ope whatis]: /concept/resource/whatis/operation.md
[container whatis]: /concept/image/whatis/container.md
[registry container list]: /concept/image/list/registry.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a Resource][res whatis]|
|[What is an Operation][ope whatis]|
|[What is a Container][container whatis]|

<h1 align="center">What is a Repository</h1>

The concept of Repository

# Definition
- a [resource][res whatis]
- a structured store
- contains versioned artifacts

## Members
- **Parts of different kinds** → Composite
- **Sets of items (same kind)** → Collection


# Example
- git repositories
```yaml
# Every node in that tree is a resource
# git repo          → working tree, object store, refs, config
repo-git                 (Composite)
├── branches             (Collection of branch)
├── commits              (Collection of commit)
├── history              (Atomic — the log as a whole)
├── files                (Collection of file)
├── config               (Atomic)
└── refs                 (Composite)
```

- container image [regitry][registry container list]

```yaml
# Every node in that tree is a resource  - A OCI container registry holds repositories
repo-registry                         (Composite)
├── repositories                      (Collection of image repository)
├── catalogs                          (Collection of catalog)
├── config                            (Atomic)
├── policies                          (Atomic)
└── signatures                        (Collection of signature)
```

- container image **repository**

```yaml
# Every node in that tree is a resource - A repository holds container images of the same name, tagged differently 
repo-image                        (Composite)
├── tags                          (Collection of tag)   - e.g. :1.25, :latest
├── manifests                     (Collection of manifest)
├── blobs                         (Collection of blob)  - e.g. library/nginx
├── config                        (Atomic)
└── signatures                    (Collection of signature)
```
- package repositories (Debian, RPM, Dnf, Apt, Npm)

```yaml
# Every node in that tree is a resource
repo-package                      (Composite)
├── packages                      (Collection of package)
├── indexes                       (Collection of index)
├── metadata                      (Atomic)
├── signatures                    (Collection of signature)
└── config                        (Atomic)
```

# Operation

There are (at least) three levels of operation:

| Level | Acts on |
|-|-|
| Whole | the resource as a whole | `create`, `delete`, `provision`, `archive` |
| Sub-collection | a set inside it | `list` |
| Item | one member | `read`, `write`, `push`, `pull`, `publish` |

# Item-level Operations: Manage the content inside

See [Operations on Resources][ope whatis] for generic and collection operations.


## Git repository

| Level | Acts on | Examples of Operations |
|-|-|-|
| Repo | whole repo state | `commit`, `push`, `pull`, `clone`|
| Sub-collection | a set inside | `list branches`, `list tags`, `list remotes`, `list commits`, `list` |
| Item | one member | `checkout <branch>`, `read <commit>`, `read <file>` |
| All |  |  `info`, `inspect` |

**Todo: classify**
- delete repo
- delete repo:history 
- change repo:visibility
- reset-history
- rewrite branches
- change remotes
- archive
- clone remote repo
- create local repo


## Container image repository

| Level | Acts on | Examples of Operations |
|-|-|-|
| Repo | whole repo state | `delete repo`, `set visibility`, `gc` |
| Sub-collection | a set inside | `list tags`, `list images` |
| Item | one member | `push <image>`, `pull <image>`, `tag <image>`, `delete <tag>` |

> Note: `push` / `pull` here are **item-level** (they act on one image) — whereas in git they're **repo-level**. Same verb, different level, different repo kind.

## Package repository

| Level | Acts on | Examples of Operations |
|-|-|-|
| Repo | whole repo state | `delete repo`, `sync`, `reindex` |
| Sub-collection | a set inside | `list packages`, `list indexes` |
| Item | one member | `publish <pkg>`, `fetch <pkg>`, `delete <pkg>` `list versions`|


## Other repositories

**Directory**

| Level | Acts on | Examples of Operations |
|-|-|-|
| Directory | whole directory | `delete`, `move`, `rename` |
| Sub-collection | a set inside | `list files`, `list subdirs` |
| Item | one member | `read <file>`, `delete <file>`, `move <file>` |

**Cluster**

| Level | Acts on | Examples of Operations |
|-|-|-|
| Cluster | whole cluster | `join`, `leave`, `upgrade` |
| Sub-collection | a set inside | `list nodes`, `list services` |
| Item | one member | `drain <node>`, `cordon <node>`, `restart <service>` |

**Database**

| Level | Acts on | Examples of Operations |
|-|-|-|
| Database | whole database | `backup`, `restore`, `migrate` |
| Sub-collection | a set inside | `list tables`, `list views`, `list indexes` |
| Item | one member | `read <row>`, `insert <row>`, `delete <row>` |


Note: **"Whole" / "Sub-collection" / "Item"** are the general level names; **"Directory" / "Cluster" / "Database" / "Repo"** are the same level, named after the resource kind.



# Todo: Testing the Grammar Archetypes Against Repositories

Let's see how our candidate CLI patterns handle these multi-level repository operations:

## Option A: Verb-First Pattern (`<verb> <subject>`)

Focused on action first.

```bash
# Manage the repository itself
rctl create repo --type git --name my-app
rctl list repos --type container

# Manage repository content
rctl list content --repo git:my-app
rctl push item --repo container:my-image --file image.tar

```

* **Pros:** Highly intuitive for general actions (`list`, `create`).
* **Cons:** Managing items inside a repository can make flags verbose (e.g., `--repo`).

## Option B: Noun-First / Hierarchical Pattern (`<noun> <sub-noun> <verb>`)

Groups commands around objects.

```bash
# Repository management
rctl repo create --type git --name my-app
rctl repo list --type container

# Content management inside a repository
rctl repo content list my-app
rctl repo content add my-app --file artifact.tar

```

* **Pros:** Extremely clean auto-completion (`rctl repo <TAB>`) and intuitive scoping for multi-level entities.
* **Cons:** Can feel slightly deeper/more verbose for quick actions.

## Option C: Resource-Specifier Hybrid (`<verb> <resource-address>`)

Uses resource URIs to infer the target.

```bash
rctl list git:my-org/my-repo
rctl list container:registry.internal/my-image
rctl add git:my-org/my-repo --file main.go

```

* **Pros:** Unbelievably fast and concise for day-to-day power users.
* **Cons:** Requires strict, unambiguous resource syntax parsing.




