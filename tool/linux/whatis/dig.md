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

<h1 align="center">What is dig</h1>


# Definition
- DNS lookup CLI
- Query DNS (Domain Name System).

# Howto
```sh
# requests the domain's IPv4 address(es).
dig +short A omt.ovh

# requests the domain's IPv6 address(es).
dig +short AAA omt.ovh

```
