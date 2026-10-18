[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md
[home uc]:      ../usecase/ep.md

[↖ Caddy USe Case][home uc] · [↖ Caddy][home topic] · [↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[podman whatis]: /tool/podamn/whatis/ep.md
[reverse proxy whatis]: /concept/other/whatis/reverse.proxy.md

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |
| [What is Podman][podman whatis]|
| [What is a Reverse Proxy][reverse proxy whatis]|



<h1 align="center">How-to Caddy: Use case 1</h1>

# Purpose
1. instanciate and configure a caddy container
1. `caddy` act as a reverse proxy
    1. Receives HTTPS requests from internet client 
    1. Forward them to existing `jekyll` containers
    1. Send back responses to Client

# Prerequisit checks
```sh
# podamn is installed
command -v podman

# get Podman version - 5.7.0
podman --version

# get PUBIC IP
# 1. Public DNS truth — what the internet sees
dig +short omt.ovh A    # 51.210.10.195
dig +short omt.ovh AAAA # empty

# 2. Local resolver — what this VPS will actually use
getent ahostsv4 omt.ovh # 51.210.10.195 for all

# 3. Confirm they match your VPS public IP
curl -4 ifconfig.me     # 51.210.10.195
ip -4 addr show scope global # 51.210.10.195

# 4. (Optional) Check against a specific public resolver
dig +short @1.1.1.1 omt.ovh A # 51.210.10.195

# get fireall status
sudo ufw status # for debian


```

# Create a reverse proxy

- Use Caddy in a [Podman][podman whatis] container
- Use Caddy as a [reverse proxy][reverse proxy whatis]

## 1. The architecture you are building toward

One VM · Podman containers · one public entry point

```
            INTERNET
                |
                | URL (e.g. https://omt.ovh)
                v
+---------------------------------------+
|             VM (e.g. OVH vps)         |
|                                       |
|  +--------------------caddy:80/443-+  |
|  | cont                            |  |
|  |                                 |  |
|  |                                 |  |
|  | HTTPS certificates              |  |
|  | reverse proxy                   |  |
|  +-----------------+---------------+  | 
|                    |                  |
|        +-----------+-----------+      |
|        |                       |      |
|        v                       v      |
|                                       |
|  +--jekyll:4000--+ +--jekyll:4001--+  |
|  | cont          | |cont           |  |
|  |               | |               |  |
|  | server DEV    | | server prod   |  |
|  +---------------+ +--------------+   |
|                                       |
+---------------------------------------+
```

Caddy routes requests according to the requested hostname:

- `omt.ovh` → your initial Jekyll site.
- `dev.jekyll.omt.ovh` → your future development site.
- `jekyll.omt.ovh` → your future production site.







# Strategy

Start with one hostname and let Caddy obtain its certificate. Later, add your DEV and PROD hostnames to the Caddyfile and let Caddy obtain the additional certificates as needed.

The crucial thing for your frequent VPS rebuilds is to persist Caddy's data directory in a Podman volume or a directory that survives the rebuild. That way, Caddy can reuse its existing certificates rather than repeatedly requesting new ones.

For Podman, I would also plan to use a shared container network for Caddy and your Jekyll containers when you migrate them into containers. If Jekyll stays installed directly on Ubuntu for now, Caddy can proxy to the host instead.

One further detail: if you choose rootless Podman, binding public ports 80 and 443 needs extra configuration on Linux. We should account for that in the installation design rather than discover it when starting Caddy.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://github.com\&sz=32)

GitHub

+1
