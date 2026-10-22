[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[concept list]:     ../list/concept.md
[res list]:         ../list/res.md
[host concept]:     ../list/concept.md#
[metadata whatis]:  ../whatis/metadata.md
[provision whatis]: ../whatis/provision.md
[resource list]:    ../list/res.md
[manage howto]:     ../howto/manage.md

[←][home] 

Related topics

| Topic | Location | Kind |
|-|-|-|
|[List of resources][resource list]|see
|[How-to manage][manage howto]|internal
|[What is metadata][metadata whatis]|internal




<h1 align="center">rctl Resource</h1>



# Definition
- something can be operated on 
- have a kind

# Kind

Example
- a repo can be a **git** repo, a **package** repo, a **container** image repo

# Example
- repositories, container images and instances and many more).
- Cf. this exhaustive [List of resource][res list]

# The model

what is resource for [rctl][rctl whatis]
```
Resource
├── kind
├── name
└── metadata
```

Example
```
repo/foo
image/foo:1.2
container/foo-dev
```
# The model
```
Resource
├── identity
│   └── name
├── metadata
├── state
├── relationships
└── resource-specific actions
```

Example
| Resource   | Identity  | Actions                               |
| ---------- | --------- | ------------------------------------- |
| repository | `foo`     | create, clone, archive, reset-history |
| Container image      | `foo:1.2` | build, tag, push, pull                |
| container  | `foo-dev` | create, start, stop, exec, remove     |

## 💡 Impl
```
type Resource interface {
    Name() string
}

type Creator interface {
    Create(...)
}

type Deleter interface {
    Delete(...)
}

type Starter interface {
    Start(...)
}

type Pusher interface {
    Push(...)
}
```


# Operation on resource
Operations are resource-specifc. The [metadata files][metadata whatis] could be consumed by the **CLI**
```sh
rctl repo list
rctl repo info go-tpl-lib
rctl repo clone go-tpl-lib
rctl repo graph
```

# 💡 CRI
Introduce a **CRI** (**C**anonical **R**esource **I**dentifier):
```
repo/foo
image/foo
container/foo-dev
```


# 💡 Implementation
```go
type Resource interface {
    Name() string
}

type Creator interface {
    Create(...)
}

type Deleter interface {
    Delete(...)
}

type Starter interface {
    Start(...)
}

type Pusher interface {
    Push(...)
}
```

Then
```yaml
Repository
    Resource
    Creator
    Deleter

Image
    Resource
    Deleter
    Pusher
    Puller
    Builder

Container
    Resource
    Creator
    Deleter
    Starter
    Stopper
    Executor
```