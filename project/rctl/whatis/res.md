[//]: #(Home)
[HOME]:  ../whatis/ep.md

[//]: #(functional)
[concept list]:     ../list/concept.md
[res list]:         ../list/res.md
[host concept]:     ../list/concept.md#
[metadata whatis]:  ../whatis/mtd.md
[provision whatis]: ../whatis/provision.md
[resource list]:    ../list/res.md
[manage howto]:     ../howto/manage.md

[←][HOME] Related topics
|||
|-|-|
|[list of resources][resource list]|see
|[howto manage][manage howto]|internal
|[what is metadata][metadata whatis]|internal




<h1 align="center">rctl Resource</h1>



# Definition
- can be operated on 
- have a kind

# Kind
Example
- git repo
- container image repo
# Example
- [List of resource][res list]

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

```yaml

Container
    Resource
    Creator
    Deleter
    Starter
    Stopper
    Executor

```

```