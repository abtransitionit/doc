[//]: #(Home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[cli howto]:        ../howto/cli.md
[cli whatis]:        ../whatis/cli.md
[res list]:         ../list/res.md
[res whatis]:       ../whatis/res.md
[host concept]:     ../list/concept.md#
[rctl whatis]:      ../whatis/ep.md
[provision whatis]: ../whatis/provision.md
[resource list]:    ../list/res.md
[manage howto]:     ../howto/manage.md
[metadata whatis]:  ../whatis/metadata.md

[←][home] 

Related topics
|||
|-|-|
|[what is rctl][rctl whatis]|internal|
|[what is a resource][res whatis]|internal
|[howto for cli][cli howto]|internal
|[what is cli][cli whatis]|internal
|[howto manage][manage howto]|internal




<h1 align="center">rctl Architecture</h1>

```
repository
    │
    │ builds
    ▼
  image
    │
    │ runs as
    ▼
container
```

```
repository
    │
    ├── depends-on ──► repository
    │
    ├── produces ────► image
    │
    └── deployed-as ─► container
```

```
                 rctl
                  │
             Resource API
                  │
      ┌───────────┼────────────┐
      │           │            │
     repo        image      container
      │           │            │
      └───────────┼────────────┘
                  │
             relationships
                  │
                  ▼
             doc registry
```
> 💡 Share the resource lifecycle/identity/command framework

> 💡 keep the domain operations specific to each resource.


# Action
- an action on a resource can be a workflow

**Example**:
- Resource: git/repo
- Action: reset-history
```sh
rctl repo reset-history foo
```
Is convert into a sequence of several actions on the git/repo resource
```sh
# what happnes internally
rctl repo reset-history foo
              │
              ▼
       ResetHistory()
              │
       ┌──────┼──────┐
       ▼      ▼      ▼
     clone   clean   init
                     │
                  remote
                     │
                  commit
```

# Provider
Providers/implementations should be separate

**Example**:
- Resource: git/repo
- Providers: github, gitlab, local
```
repo
  ├── GitHub
  ├── GitLab
  └── local Git
```

# SOT
- the **SOT** (**S**ource **O**f **T**ruth) repository (i.e. `doc` repository) is the resource registry 
- It can provide via [metadata files][metadata whatis]:
  - names
  - relationships
  - templates
  - providers
  - etc.