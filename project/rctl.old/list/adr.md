[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[forge whatis]: ../whatis/forge.md
[res list]:     ../list/res.md
[host list]:    ../list/host.md

[←][home]

<a  id='list'></a>
<h1 align="center">List of Forge ADR</h1>

# Index

- [ADR-0001 — Project bootstrap](#-adr-0001--project-bootsrap)
- [ADR-0002 — Source Of Trust](#-adr-0002--sot)
- [ADR-0003 — CLI grammar](#-adr-0003--technical)



# [↑](#list--idlist) ADR-0001 — Project Bootsrap
ChatGpt prompt is
```
Context

1. I have a lot of repositories on Gitlab and Github (\~50)
2. They are both private and Public
3. There is a special repo named doc on both gitlab and github that documents
   1. git repositories available
   2. link between all the repo
4. I have a lot of different tools  (go, shell script, ..) to mange these repo
5. these tool are helpful for example
   1. cloning a repo from a template
   2. removing git history on remote repo
   3. ...

I'm often do things like
alias mx.git.repo.create='curl -fsSL "https\://api.github.com/repos/abtransitionit/go-tpl-lib/contents/bin/init.sh?ref=${lVERSION:-v1.0.0}" | jq -r '.content' | base64 -d | cat | sh -s'



My Needs

- how do i manage all these different tools  (go, shell script, ..) that manage git repo in a coherent way so that anyone can use them accurately
- they can evolve 

- what if later the tool also manage container, container image and other things. Is the evolution easy ?
```

# [↑](#list--idlist) ADR-0002 — `SOT`

The bigger architectural question I'd explore next is whether your doc repository should become a declarative inventory/registry (almost like a tiny internal catalog) and whether mx should support both imperative operations (mx repo create) and declarative reconciliation (mx sync). That choice has a big impact on how well this scales from 50 repositories to 200+.

# [↑](#list--idlist) ADR-0003 — Technical

- the CLI grammar canonical form is
```sh
rctl <resource> <action> ...

# example
rctl repo get go-tpl-lib
rctl image get foo
rctl container get foo-dev
```
- The resource comes before action
- later the cli should support
```sh
rctl get repo/go-tpl-lib
rctl get image/foo
rctl get container/foo-dev
```