[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Caddy][home topic] · [↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[podman whatis]: /tool/podamn/whatis/ep.md
[reverse proxy whatis]: /concept/other/whatis/reverse.proxy.md

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |
| [What is Podman][podman whatis]|
| [What is a Reverse Proxy][reverse proxy whatis]|



<h1 align="center">How-to Caddy: Use case 1</h1>

# Create a reverse proxy

- Use Caddy in a [Podman][podman whatis] container
- Use Caddy as a [reverse proxy][reverse proxy whatis]

## 1. The architecture you are building toward

One VPS · Podman containers · one public entry point

```
 INTERNET
    |
    | HTTPS :443
    v
+--------------------------------------------------+
| OVH VPS — Ubuntu                                 |
|                                                  |
|  +--------------------------------------------+  |
|  | Caddy container                            |  |
|  | Ports 80 and 443 published on the VPS      |  |
|  | HTTPS certificates + reverse proxy         |  |
|  +----------------------+---------------------+  |
|                         |                        |
|             +-----------+-----------+            |
|             |                       |            |
|             v                       v            |
|  +-------------------+  +---------------------+  |
|  | Jekyll DEV        |  | Jekyll PROD         |  |
|  | Port 4000         |  | Port 4001 (example) |  |
|  +-------------------+  +---------------------+  |
|                                                  |
+--------------------------------------------------+
```

Caddy routes requests according to the requested hostname:

- `omt.ovh` → your initial Jekyll site.
- `dev.jekyll.omt.ovh` → your future development site.
- `jekyll.omt.ovh` → your future production site.


## 2. Kind of certificates

Request 1 certificate that covers both hostanme: `omt.ovh` and `*.omt.ovh`


### What I recommend for you

Start with one hostname and let Caddy obtain its certificate. Later, add your DEV and PROD hostnames to the Caddyfile and let Caddy obtain the additional certificates as needed.

The crucial thing for your frequent VPS rebuilds is to persist Caddy's data directory in a Podman volume or a directory that survives the rebuild. That way, Caddy can reuse its existing certificates rather than repeatedly requesting new ones.

For Podman, I would also plan to use a shared container network for Caddy and your Jekyll containers when you migrate them into containers. If Jekyll stays installed directly on Ubuntu for now, Caddy can proxy to the host instead.

One further detail: if you choose rootless Podman, binding public ports 80 and 443 needs extra configuration on Linux. We should account for that in the installation design rather than discover it when starting Caddy.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://github.com\&sz=32)

GitHub

+1
