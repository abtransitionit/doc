[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)

[←][home] 




<h1 align="center">rctl Action</h1>

# Definition
- The operation that apply to a resource

# Kind
- common action
- specific actions

## common action
An action whose semantic make sense for many resources

|Term|Semantic|Note|
|-|-|-|
|list|collection of resource|
|get|one resource
|delete|one resource
|create|one resource
|update|one resource

**Example**
|CLI|Semantic|Note|
|-|-|-|
|rctl repo create foo|create a repository from a template and initialize it.|
|rctl repo create foo|create a remote repository|
|rctl cim create foo|builmd a container image|better choose `build`
|rctl container create foo|create an empty container|
## specific action
An action whose semantic is resource-specific

**Example**

```yaml
repo
  list
  get
  create
  delete
  clone
  reset-history

container image
  list
  get
  build
  push
  pull
  tag

container
  list
  get
  create
  start
  stop
  exec
  logs
  delete
```

## Todo
- 🚧 freeze semantics, for verb, action, operation, workflow



# Key points
- an action on a resource can be a workflow

## Example
- Resource: git/repo
- Action: reset-history
```sh
rctl repo reset-history foo
```
Is convert into a sequence of several actions on the git/repo resource
```sh
# what happnes internally
rctl repo reset-history foo
              │
              ▼
       ResetHistory()
              │
       ┌──────┼──────┐
       ▼      ▼      ▼
     clone   clean   init
                     │
                  remote
                     │
                  commit
```


# Semantic
## `get`
- returns one specific resource (individual resource)
```sh
rctl repo get go-tpl-lib
rctl image get foo
rctl container get foo-dev

# it allow
rctl repo get foo --output json
```

## `list`
- returns multiple resources (collection of resource)
```sh
rctl repo list
rctl image list
rctl container list

# it allow
rctl repo list --output json
```

## Example of complex actions

```sh
# what user enter
rctl repo reset-history foo
```

```sh
# what happens internally
rctl repo reset-history foo
              │
              ▼
       ResetHistory()
              │
       ┌──────┼──────┐
       ▼      ▼      ▼
     clone   clean   init
                     │
                  remote
                     │
                  commit
```

