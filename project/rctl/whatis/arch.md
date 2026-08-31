[//]: #(home)
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

| Topic | Location | Kind |
|-|-|-|
|[What is rctl][rctl whatis]|internal|
|[What is a resource][res whatis]|internal
|[Howto for cli][cli howto]|internal
|[What is cli][cli whatis]|internal
|[Howto manage][manage howto]|internal




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

# CLI grammar
- the CLI canonical form is
```sh
# canonical form: comes before action
rctl <resource> <action> ...

# example
rctl repo get go-tpl-lib
rctl image get foo
rctl container get foo-dev
```
- later the cli should support
```sh
# natural form
rctl get repo/go-tpl-lib
rctl get image/foo
rctl get container/foo-dev
```  

**Canonical**:
   ```
  rctl <resource> <action> <name> [options]
   ```

**Collection**:
   ```
    rctl <resource> list [options]
   ```

**Rules (👮‍♂️)**:
- positional = resource identity
- options    = operation parameters
- provider   = normally inferred

## Rules (👮‍♂️)
- Common verbs are reused when their semantics genuinely match
- resource-specific operations stay under the resource
