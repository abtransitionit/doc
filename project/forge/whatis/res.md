[//]: #(Reference)
[HOME]:  ../whatis/forge.md
[concept list]:   ../list/concept.md
[resource list]:  ../list/res.md
[host concept]:   ../list/concept.md#

# Related topics
- [list of concepts][concept list]
- [list of resources][resource list]
- [concept of Host][host concept]

---



# [←][HOME] Resource

## Definition
A Resource is something that can be provisioned or operated on within an **Execution Environment**.

cf. the [list of resources][resource list]

## Relationship

```
Execution Environment
└── Container

Host
├── can contain/run → Execution Environment
│                      └── operate on → Resource
└── can be provisioned with → Resource
```  


## Operation on resource
the operation is resource-specifics. Example of operation on resource are:

|resource|operation|
|-|-|
|file|read, write|
|Package|add, update, delete|
|service|start, stop, configure|
|file system|read, write
|volume|access
|GPU|use
|network|configure, communicate over|
|memory|consume allocated 
|CPU|consume, allocated 
|device|access




# Resource Model


## Resource Relationships

```text
Execution Environment
└── operates on → Resource

Host
├── provides/runs → Execution Environment
└── can be provisioned with → Resource