[//]: #(home)
[home]: ../whatis/ep.md
[list res]: #list
[//]: #(functional)
[res whatis]: ../whatis/res.md
[res howto]:  ../howto/res.md 
[cli whatis]:  ../whatis/cli.md 

[←][home] 

Related topics

| Topic | Location | Kind |
|-|-|-|
|[Howto for resource][res howto]|see|
|[What is a resource][res whatis]|see|
|[What is cli][cli whatis]|see|

<h1 align="center">List of rctl Resource</h1>

<p id='list'></p>

# List

[Example list](#phase-0-outcome) for the phase 0 of the roadmap 

|Res type||Description|Provider|Example|
|-|-|-|-|-|
|[git authentication](#-git-authentication)|[gitrepo](#git-repository)|github, gitlab, local||
|[git repository](#git-repository)|[gitrepo](#git-repository)||github, gitlab, local|
|go module|gomod|
|[container registry](#-container-registry)|contrepo|
|[container image](#-container-image)|cim|
|[container](#-container)|| (instance of container image)
|[environment variable](#-environment-variables)|envar|
|[cli](#-cli)|||VSCode, Browser
|[Shell History](#-shell-history)|list|
|[Other](#-other)|


```
                 Resource
                    │
        ┌───────────┼───────────┐
        │           │           │
      Repo        Image      Container
        │           │           │
        ▼           ▼           ▼
    operations   operations   operations
```

```
                  Resource framework
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
        repo           image        container
          │              │              │
          └──────────────┼──────────────┘
                         │
              common infrastructure
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
       config          output          auth
       logging         errors          state
       discovery       plugins         docs
```
## [↑][list res] Git

### Git repository
- git/repository can be **local** or *remote*
- remote git/repository can be provided by `github `or `gitlab`
- remote git/repository can be provided by `public `or `private`

```
GitHub
  └── repositories
        ├── list
        ├── create
        └── delete
```

Grammar could be:
```sh
rctl github repo [list | delete | create]
```

---
---

| Resource | Action          | Type                   | Provider |
| -------- | --------------- | ---------------------- | -------- |
| repo     | reset-history   | workflow / destructive | Git      |
| repo     | clone           | primitive              | Git      |
| repo     | inspect-history | diagnostic             | Git      |
| repo     | reinitialize    | primitive              | Git      |
| repo     | set-remote      | primitive              | Git      |
| repo     | commit          | primitive              | Git      |

---
---

Std operation could be
```yaml
- list remote|local repo:history
- clone remote repo locally
- clone remote repo template locally # clone + placeholder
- archive remote|local repo
```

Other risked operation could be
```yaml
- delete remote|local repo
- delete local|remote repo:history
- change repo:visibility # from private to public
```
Other operation
```yaml
- change remote
- rewrite branche
```

**Todo**

| Resource | Action | Provider | Current implementation        |
| -------- | ------ | -------- | ----------------------------- |
| git/repo | list   | GitHub   | `gh`                          |
| git/repo | create | GitHub   | GitHub API → remote `init.sh` |
| git/repo | delete | GitHub   | `gh`                          |

```
repo create
    │
    └── fetch versioned file init.sh
            │
            └── execute shell script locally
````

### [↑][list res] Git authentication

- git/authentication can be provided by `github` or `gitlab`
```
GitHub
  └── authentication
        ├── status
        ├── login
        ├── logout
        └── setup-git
```

Grammar could be:
```sh
rctl github auth [status | login | logout | setup-git]
```
### Example workflow
```sh
# what user enter
rctl repo reset-history foo
```

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


### Kind
- git/repo can be public or private
- git/repo can be local or remote
- git/repo remote can be provided by `github` or `gitlab`
- git/authentication can be provided by `github` or `gitlab`



### possible flags
```sh
--remote
--local
--public
--private
--all
--github
--gitlab
```

### Sumary
```
GitHub
 ├── authentication
 │    ├── status
 │    ├── login
 │    ├── logout
 │    └── setup-git
 │
 └── repositories
      ├── list
      ├── create
      └── delete
```


## Example
```sh
mx repo create foo --template go-lib@v1.4.0
```
Meaning:
- Use version 1.4.0 of the go-lib template to create foo.

## Example

``` sh
rctl repo github list --all
# list all public repo of github:user:ab
rctl repo github list ab
# list all public repo of user:ab - try first on gitlab then on github
rctl repo list ab
rctl repo list abtransitionit --public
rctl repo list abelgacem --private
# clone a repo
rctl repo clone abtransitionit/go-core
# clone a templated repo - based on the repo name do some stuff
rctl repo clone tpl abtransitionit/go-tpl-lib
# delet remote repo abelgacem/foo - try first on github then on gitlab
rctl repo delete abelgacem/foo
# delet remote repo github:abelgacem/foo
rctl repo github delete abelgacem/foo
# delet remote repo history github:abelgacem/foo
rctl repo github history reset abelgacem/foo
rctl repo github history-reset  abelgacem/foo
```

## [↑][list res] Container registry
**Kind**
- local
- remote

**Kind**
- public
- private
## [↑][list res] Container image
|res|action/operation|description|
|-|-|-|
|cimage|list|
|cimage|build|
|cimage|tag|
|cimage|retag|
|cimage|push|
|cimage|pull|from registry
|cimage|delete|from local or remote registry

```yaml
cim:
  actions:
   - list
   - build
   - tag
   - retag
   - push
   - pull
   - delete
````

```sh
rctl image build foo
rctl image push foo
```

## [↑][list res] Container
|res|action/operation|description|
|-|-|-|
|cont|start|
|cont|exec|

```yaml
container:
  actions:
   - create
   - start
   - stop
   - exec
   - delete
````

```sh
rctl container start foo
rctl container exec foo
```

## [↑][list res] Shell History

## [↑][list res] Environment Variables
|res|action/operation|description|
|-|-|-|
|envar|list|list SHELL envar (env)
|envar|list|list GO ENV (go env)

```
MxHome
 └── MxHome_Apps
      ├── MxHome_Go
      │    └── MxBinary_Go
      └── MxHome_VsCode
           └── MxBinary_Vscode
```
> 💡 could eventually become `rctl` configuration,

## [↑][list res] CLI
### `go` cli
- 
### `vscode` cli
```yaml
cli
 ├── vscode
 │    ├── start
 │    └── welcome
 │
 ├── gh
 │    ├── create repo
 │    └── ...
 │    
 ├── awscli
 │    ├── ...
 │    └── ...
 │    
 │    
 ├── browser
 │    ├── open frame
 │    ├── open window
 │    └── ...
 │    
 ├── ...
 │    ├── ...
 │    └── ...
 │
 └── go
      ├── list module
      ├── list go envar
      ├── list module installed version
      ├── list remote module version
      └── list cached module

cli/vscode
  └── start
      └──  MxHome_Go
      │    └── MxBinary_Go
      └── MxHome_VsCode
           └── MxBinary_Vscode
`
```
### `browser` cli
|res|action/operation|description|
|-|-|-|
|cli/vscode|start vscode|
|cli/vscode|Edit a file in vscode
|cli/vscode|Display vscode welcome

## [↑][list res] Other
|res|action/operation|description|
|-|-|-|
|project|list|
|project|status|
|volume|list|
|namespace|list|
|registry|list, add, delete|
|registry|list, add, delete|


# Phase 0 outcome

**The list**
```yaml
repo
  list
  create
  delete

GitHub/auth
  status
  login
  logout
  setup-git

Go/environment
  env

Go/module
  version
  cache.list

Go/CLI
  list

shell/history
  list

VSCode
  start
  welcome
```

**The same list ordered**
```yaml
CORE rctl
  repo
  GitHub authentication

POSSIBLE rctl
  Go
  image
  container
  ...

OUTSIDE / LOW PRIORITY
  shell configuration
  shell history
  VSCode
````

# Todo
* File, Directory
* Package, User, Service
* Network configuration
* Disk
* Container
* Database
* Configuration
* Volume mount
* VM, Cluster
* ...


