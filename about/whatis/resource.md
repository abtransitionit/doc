[//]: #(home)


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is operating ](../whatis/operate.md) |concept
|[What is provisioning](../whatis/provision.md)|concept


<h1 align="center">Resource</h1>




# Definition
- May be physical, virtual or abstract
- Can be [provisioned](../whatis/provision.md)
- can be [operated](../whatis/operate.md) on

# Example
- [List of resource][res list]



## Operation on resource
Operation on a resources are often resource-specifics. Example of operation on resource are:

|resource|operation|
|-|-|
|gom|init, list|
|git:repo|add, update, delete|
|container|start, stop, configure|
|container image|start, stop, configure|





# Resource Model


## Resource Relationships

```text
Execution Environment
└── operates on → Resource

Host
├── provides/runs → Execution Environment
└── can be provisioned with → Resource
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