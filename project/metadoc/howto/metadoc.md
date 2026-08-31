[//]: #\(home\)
[home]: ../../../README.md

[//]: #\(doc\)
[doc platform whatis]: ../whatis/doc.ptf.md

[↖][home]

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |
| [Howto for DocRoot](../howto/docroot.md) | internal | concept |
| [What is MetaDoc](../whatis/ep.md)|internal|see

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">MetaDoc</h1>


# How to bootsrap MetaDoc
The big picture is:
```
Create a MetaDoc Git repository
        ↓
Create folder: DocRoot
        ↓
Create 1 folder per domain
        ↓
Create first DocSet
```

## Create a MetaDoc Git repository

A MetaDoc documentation system is hosted in a Git repository. There are two ways to start:

### From an existing repository
Clone an existing MetaDoc Git repository.
```sh
git clone https://github.com/abtransitionit/doc.git
```

### From scratch

Create a new empty local Git repository for a **MetaDoc** documentation system.
```sh
# create the DocRoot folder 
mkdir myRootMetaDoc
cd myRootMetaDoc

# Initialize the repo
git init -b main
```
Meaning:
- you have a git repository named `myRootMetaDoc`
- The `DocRoot` is the root folder of that documentation system.
- In this example, `myRootMetaDoc` is the `DocRoot`.

