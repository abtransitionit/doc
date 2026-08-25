[//]: #(Home)
[HOME]: ../whatis/ep.md

[//]: #(functional)
[res whatis]: ../whatis/res.md
[res howto]:  ../howto/res.md 
[cli whatis]:  ../whatis/cli.md 

[←][HOME] 

Related topics
|||
|-|-|
|[howto for resource][res howto]|see|
|[what is a resource][res whatis]|see|
|[what is cli][cli whatis]|see|

<h1 align="center">List of rctl Resource</h1>

# List
|Res type|Description|Example|
|-|-|-|
|git repository|github, gitlab, local|
|go module|
|container image|
|container| (instance of container image)
|environment variable|
|cli|



## Git repository
|res|action/operation|description|
|-|-|-|
|repo/git|create|
|repo/git|list|list all or some github/gitlab:repo (abtransitionit and abelgacem)
|repo/git|history|
|repo/git|history-reset|delete history on remote/local
|repo/git|clone, create|locally
|repo/git|clone-tpl|clone + placeholder
|repo/git|create|on remote
|repo/git|delete|remote
|repo/git|archive|remote

Example/Kind of operations
- deleting history
- changing visibility
- archiving repositories
- deleting repositories
- rewriting branches
- changing remotes

# Kind
- repo can be public or private
- repo can be local or remote

# possible flags
```sh
--public
--private
--all
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

## Container registry
**Kind**
- local
- remote

**Kind**
- public
- private
## Container image
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

## Container
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

## Cli
|res|action/operation|description|
|-|-|-|
|cli/vscode|start vscode|
|cli/vscode|Edit a file in vscode
|cli/vscode|Display vscode welcome

## Other
|res|action/operation|description|
|-|-|-|
|project|list|
|project|status|
|volume|list|
|namespace|list|
|registry|list, add, delete|
|registry|list, add, delete|

### Variable
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


