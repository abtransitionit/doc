[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[↖][home]

### Related topics

| Topic | Location | Kind |
|---|---|---|
|[What is a Domain](../whatis/docset.md)|internal|functional
|[Howto for Domain](../howto/domain.md)|internal|functional
|[What is a DocSet](../whatis/docset.md)|internal|see

<h1 align="center">MetaDoc DocSet</h1>

# Create a DocSet for a topic
## Use case
1. Suppose you want to write a documentation about the **topic** `Kubernetes`
1. You decide the [domain](../whatis/domain.md) of the documentation is **platform**
1. create the folder `<DocRoot>/<domain>/<topic>` i.e. `<DocRoot>/system/kubernetes`
1. create the entry-point `<DocRoot>/<domain>/<topic>/whatis/ep.md` i.e. `<DocRoot>/system/kubernetes/whatis/ep.md`
1. That's it. You can start authoring.

## Use case
1. You start working on a **project** that create a CLI named `rctl` and want to document the project lifecycle
1. create the folder `<DocRoot>/<domain>/<topic>` i.e. `<DocRoot>/project/rctl`
1. create the entry-point `<DocRoot>/<domain>/<topic>/whatis/ep.md` i.e. `<DocRoot>/project/rctl/whatis/ep.md`
1. That's it. You can start authoring the project.
1. The next time you document a project, you just create a **DocSet** under `<DocRoot>/project/
1. That's it. You can start authoring that new project.
`
