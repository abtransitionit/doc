[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[concept list]:     ../list/concept.md
[res list]:         ../list/res.md
[host concept]:     ../list/concept.md#
[forge whatis]:     ../whatis/ep.md
[provision whatis]: ../whatis/provision.md
[resource list]:    ../list/res.md

[←][home] 

Related topics
|||
|-|-|
- [What is forge][forge whatis]
- [List of concepts][concept list]
- [List of resources][resource list]
- [concept of Host][host concept]




<h1 align="center">Forge Resource</h1>



# Definition
- may be physical, virtual or abstract
- can be [provisioned][provision whatis]
- can be operated on / managed in an **Execution Environment**

# Example
- [List of resource][res list]



## Operation on resource
the operation is resource-specifics. Example of operation on resource are:

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