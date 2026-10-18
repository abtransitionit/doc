[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Linux Tool][home topic] · [↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[aft whatis]: https://aft.dev/docs/
[aft git]:    https://github.com/akumansley/aft

Related topics

| Topic | Location | Kind    |
| - | - | - |
|[What is aft][aft whatis]|external| 
|[aft on github][aft git]|external| 

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">What is scp</h1>


# Howto
```sh
# define var
SRC_FOLDER="$HOME/wkspc/ssg" # cannot use ~ as var but works if directly pass to scp
DST_FOLDER="~/wkspc"         # works
DST_VM_NAME="o1u"

# remote copy src folder to dest
scp -r "${SRC_FOLDER}" "${DST_VM_NAME}:${DST_FOLDER}"
```
> **~** is expanded correctly on remote.
