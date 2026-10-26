[//]: #(home)
[home]: ../../../README.md

[//]: #(doc)

[↖][home]

Related topics

| Topic | Location | Kind |
|---|---|---|
|[How-to for MetaDoc](../howto/metadoc.md)|internal|
|[What is MetaDoc](../whatis/ep.md)|internal|see
|[rule list](../list/rule.md)|internal|

<h1 align="center">List of MetaDoc Rules</h1>

# DocRoot entry point
Each `MetaDoc` repository MUST have a README to index the topics. Example of `README.md`
```md
[//]: #(Reference)
[doc std]:       ./governance/doc.std.md
[project ep]:    ./project/README.md
[system ep]:     ./system/README.md
[domain ep]:     ./domain/README.md
[reference ep]:  ./reference/README.md
[kubernetes ep]: ./system/k8s/README.md
[linux ep]:      ./system/linux/README.md
[security ep]:   ./reference/concept/security/README.md




<h1 align="center">doc</h1>


# Purpose
- This Git repository powered by MetaDoc is a centralized IT knowledge base, and the single source of truth for the organization.

# Index of Key Documentation

**Systems**

- [Kubernetes][kubernetes ep]
- [Linux][linux ep]
- [Other system][system ep]

**Projects**

- [MetaDoc](./project/metadoc/whatis/ep.md)
- [Forge](./project/forge/whatis/ep.md)
- [rctl](./project/rctl/whatis/ep.md)
- [All Projects][project ep]

**Reference**

- [Security][security ep]
- [Terminology](reference/terminology.md)
- [Other Reference][reference ep]

**Governance**

- [Documentation Standard][doc std]

**Other**

- [Domains][domain ep]

```

# Domain Folder
- A `MetaDoc` repository contains a collection of [Domains](../whatis/domain.md) under its `DocRoot`.
