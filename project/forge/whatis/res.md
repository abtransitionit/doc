[//]: #(Reference)
[HOME]:  ../whatis/forge.md

[concept list]:     ../list/concept.md
[res list]:         ../list/res.md
[host concept]:     ../list/concept.md#
[forge whatis]:     ../whatis/forge.md
[provision whatis]: ../whatis/provision.md

[←][HOME] Related topics
- [what is forge][forge whatis]
- [list of concepts][concept list]
- [list of resources][resource list]
- [concept of Host][host concept]




<h1 align="center">Resource</h1>



# Definition
- may be physical, virtual or abstract
- can be [provisioned][provision whatis]
- can be operated on / managed in an **Execution Environment**

# Example
- [List of resource][res list]

# Relationship

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