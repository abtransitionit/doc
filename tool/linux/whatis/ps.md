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

<h1 align="center">What is sudo</h1>


# Howto
```sh
# list all users having process running
ps -eo user= | sort -u

# list all users having process running and count them
ps -eo uid,user --no-headers | sort | uniq -c | sort -rn
```
