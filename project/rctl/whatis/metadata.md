[//]: #(Home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[cli howto]:        ../howto/cli.md
[res list]:         ../list/res.md
[res whatis]:       ../whatis/res.md
[host concept]:     ../list/concept.md#
[rctl whatis]:      ../whatis/ep.md
[provision whatis]: ../whatis/provision.md
[resource list]:    ../list/res.md
[manage howto]:     ../howto/manage.md
[architecture whatis]: ../whatis/arch.md

[←][home] 

Related topics
|||
|-|-|
|[what is rctl][rctl whatis]|internal|
|[what is a resource][res whatis]|internal
|[what is a architecture][architecture whatis]|internal
|[howto for cli][cli howto]|see
|[howto manage][manage howto]|internal




<h1 align="center">rctl metadata</h1>



# Definition
- yam lfiles **rctl** have access (relies on)

# Example

# 💡 source of truth for metadata
expose this yaml
```yaml
repositories:
  - kind: git
    name: go-tpl-lib
    hosting:
      github: abtransitionit/go-tpl-lib
      gitlab: abtransitionit/go-tpl-lib
    visibility: public
    type: library
    template: true
    related:
      - go-lib-a
      - go-lib-b

  - kind: git
    name: go-core
    hosting:
      gitlab: abtransitionit/go-core
    visibility: private
    type: library

  - kind: git
    name: go-app-test
    hosting:
      gitlab: abtransitionit/go-core
    visibility: private
    type: application
```

# Example
```yaml
templates:
  go-tpl-lib:
    repository: github.com/abtransitionit/go-tpl-lib
    version: v1.0.0
```
allow **cli** to do (by reading the metadata)

```sh
rctl repo create # ---internally---> mx repo create --template go-tpl-lib@v1.0.0
```

# Example: a git repo manifest

```yaml
name: my-project

hosting:
  github: abtransitionit/my-project
  gitlab: abtransitionit/my-project

template:
  name: go-service
  version: v2.1.0

dependencies:
  - go-tpl-lib
  - common-ci

documentation:
  - architecture
  - deployment
```

allow to answer

```sh
rctl repo dependents go-tpl-lib
rctl repo children go-service
rctl repo graph
rctl template update go-service
```

# Example
```
repositories:
  - name: foo
    github: abtransitionit/foo
    gitlab: abtransitionit/foo

    images:
      - name: foo
        registry: ghcr.io
        repository: abtransitionit/foo
        tags:
          - latest
          - "1.4"

    containers:
      - name: foo-dev
        image: foo:1.4
```