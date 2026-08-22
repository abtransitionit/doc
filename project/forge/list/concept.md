[//]: #(Reference)
[HOME]:  ../whatis/forge.md
[forge howto]: ../howto/forge.md
[acro list]:   ../list/acro.md
[res whatis]:  ../whatis/res.md
[host whatis]: ../whatis/host.md

# Related topics
- [list of acronym][acro list]

# [←][HOME] List


|Term|kind|meaning|Example|
|-|-|-|-|
|OS|acro|<li>mac <li>Linux <li>windows
|CS|acro|a system capable of running an **OS**|<li>Host <li>Container
|EE |acro|<li> **where** software programs execute and interact with/operate on resources<li> it does not necessarily have its own OS/kernel|<li>Host <li>Container
|[Host][host whatis]|infra|<li>a CS with an EE <li>Can be physical or virtual <li>A target that can be provisioned with resources<li> **where/how** a resource is made available|<li>physical host <li>virtual host <li>container host
|Physical host |infra| a host implemented by physical hardware|Server, laptop, Raspberry Pi
|Virtual host |infra| <li>a host implemented virtually <li>has its own OS/kernel|<li>VM <li>microVM
|[Resource][res whatis]|concept|<li>Can be physical, virtual, or abstract <li>something that can be provisioned <li>something that can be operated on/act upon <li>something an EE can operate on| <li>File, Directory <li>Package, User, Service <li>VM, Cluster
|Operation|concept|<li>is resource-specific <li>a resource-specific action <li>an action exposed by a resource.|
|Role||<li>An entity may fulfill different roles depending on its relationship to other entities.|<li>A resource may fulfill the role of a host.<li>A host may be treated as a resource.

<!-- |Host|<li>Something capable of running an OS<li>anything **physical** or **virtual** capable of running an operating system<li>a **physical** or **virtual** computing |Resource|<li>Something that can be provisioned on/in a host|File, Package, User, Service -->

