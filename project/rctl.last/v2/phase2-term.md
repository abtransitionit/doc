[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[res whatis]: #
[res kind whatis]: #
[ope whatis]: #
[res cap whatis]: #
[host whatis]: #
[res mechanism whatis]: #
[host wrap whatis]: #
[action whatis]: #
[plan whatis]: #
[intent whatis]:
[request whatis]; #
[system whatis]: #
[target context whatis]: #
[target composition whatis]: #

Related topics

| Topic                            | Location | Kind |
| -------------------------------- | -------- | ---- |


<h1 align="center">Project RMS - Phase2: Terminology</h1>

RMS aka. Resource Management System


Its purpose is to establish a shared, precise vocabulary before writing the **requirements**. It should be concise, with one definition per concept and no implementation details.


|Param|value|
|-|-|
| Document ID | PP2-RMS  
| Path | `phase2-term.md`  
| Status | Draft  
| Version | 0.1 |

| Term | Definition |
|---|---|
| Resource | An entity the system manages. A resource exists on a target. |
| Kind | The classification of a resource. |
| Capability | Something a resource supports or can do. |
| Operation | A functionality exposed by the system to act on a resource. That functionality is based on one or more capabilities of that resource. |
| Mechanism | A means by which the system accesses or manages a resource. |
| Interface | A means through which a client or system interacts with the system. |
| Target | An entity or execution context on which resources are managed or actions are executed. A target may itself be a resource. |
| Wrapper | A layer that provides access to, or changes the execution context of, another target. |
| Wrapped Target | A target composed of an inner target and one or more wrappers. |
| Intent | A high-level goal submitted to the system by an agent (user, script, etc.) to be achieved. |
| Action | A unit of work. |
| Execution Plan | A set of actions and their execution relationships. |
| Request | A request created by the system to track the progress and completion of an operation or intent. |
| Execution | The attempt to perform an action. An action may be executed more than once if retries are supported. |
| Result | The outcome of an execution. |



# TDOD: Idea
## Ope vs. Cap
- a capability is what a resource supports
- an operation is what the system allows you to request. 
- The system may expose only some of a resource's capabilities
- One operation may require several capabilities.

## Wrapper 
can wrapped resource exists as it exists wrapped target