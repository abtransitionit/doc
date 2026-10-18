[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[project whatis]: ../../../concept/project/whatis/ep.md
[caddy whatis]: /tool/caddy/whatis/ep.md
[nginx whatis]: #

Related topics

| Topic | Location | Kind |
|---|---|---|
|[caddy whatis][caddy whatis]
|[nginx whatis][nginx whatis]


<h1 align="center">Project: Caddy</h1>

Add `HTTPS` to a working public `HTTP` service


# Problem

When building a public service, you don't want to focus on `HTTPS` first. so you build a running service that works under `HTTP`. Then, you want it to make iut accessible via `HTTPS`. That's when you deal with `nginx`, **rever proxy**, **certificate**, and so on. I want a very simple easy and flexible solution to manage HTTPS for ythat service I built.


# Core vision

Build a system that simply convert **HTTP** public access to a service into **HTTPS**

# Strategy

- Do it fifst for a **dev** environment using tool like [Caddy][caddy whatis]
- Do it then  for anoter env let say **test** using tool like [Caddy][caddy whatis] and [nginx][nginx whatis]
- Do it finally for anoter **prod** env
