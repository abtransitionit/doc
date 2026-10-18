[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[caddy github whatis]:       https://github.com/caddyserver/caddy
[caddy howto]:        ../howto/ep.md
[caddy usecase]:    ../usecase/ep.md
[cerbot whatis]:    /tool/cerbot/whatis/ep.md
[challenge whatis]: ../whatis/challenge.md

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |
| [What is Caddy on Github][caddy github whatis]|external|github
| [What is Cerbot][cerbot whatis]|
| [How-to for Caddy][caddy howto]|
| [Use-case for Caddy][caddy usecase]|
| [What is Challenge][challenge whatis]|



<h1 align="center">What is Caddy</h1>

# Definition
- add `HTTPS` protocol to a running `HTTP` site
- Automatically obtains and renews an HTTPS certificate for a domain
- Forwards requests to backend/downstream server


# How it works

```
             INTERNET
                 |
                 | URL (e.g. https://omt.ovh)
                 v
+---------------------------------------+
|             VM (e.g. OVH vps)         |
|                                       |
|  +-------------------caddy:80/443--+  |
|  | container                       |  |
|  |                                 |  |
|  | HTTPS + reverse proxy           |  |
|  +----------------+----------------+  |
|                   |                   |
|           Podman network              |
|                   |                   |
|                   v                   |
|  +--------------------jekyll:4000--+  |
|  |container                        |  |
|  |                                 |  |
|  | web server                      |  |
|  +---------------------------------+  |
|                                       |
+---------------------------------------+
```

1. Agent/Client (browser/CLI/API) create request `https://omt.ovh`
1. The DNS system resolves domain (`omt.ovh`) to the VM public IP.
1. The request hit the host on port 443/80
1. The host ports 443/80 are mapped to the same caddy container (where `Caddy` server listen)
1. request hit the caddy server inside the container
1. `Caddy` presents its TLS certificate and decrypts the HTTPS request.
1. `Caddy` forwards request over the `Podman` network to the `Jekyll` container (e.g.`http://jekyll:4000`).
1. `Jekyll` processes the request and returns the webpage to `Caddy`.
1. `Caddy` sends the response back to the visitor over the `encrypted HTTPS connection`.

## Key idea
- `Caddy` is the public entry point
- `Jekyll` serves the actual website. 
- The two containers communicate privately over the Podman network.


# Configuration

Caddy uses data to reuse its existing certificate
- certificate
- private-key files. 

# 2. Kind of certificates

- simple
- wildcard

cf. [cerbot][cerbot whatis]