[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Resource][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[res whatis]:  ../whatis/ep.md
[repo whatis]: /concept/repository/whatis/ep.md
[ope whatis]:  ../whatis/operation.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Resource][res whatis]|see|
|[What is a Repo][repo whatis]|see|
|[What is an Operation][ope whatis]|see|


<h1 align="center">List of Resource Operations</h1> <a id='ope'></a>



# List of Resource Operations

| Operation | Class      | Notes |
|-|-|-|
| inspect   | Generic    |
| info      | Generic    |
| create    | Generic    |
| delete    | Generic    |
| init      | Generic    |
| list      | Collection |
| add       | Collection |
| remove    | Collection |
| read      | Atomic     |
| modify    | Atomic     |

# List of Resource Operations

|resource|operation|
|-|-|
|go:module|init, list|
|repo:git|add, update, delete|
|container|start, stop, configure|
|container image|start, stop, configure|
