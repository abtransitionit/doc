[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)
[challenge whatis]: ../whatis/letsencrypt.md

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Cerbot](../whatis/ep.md)|internal


<h1 align="center">How-to for Cerbot</h1>


# Install
## Install `cerbot` alone
```
sudo apt install certbot
```

gives you `certonly` / `--standalone` (it spins up its own web server on port 80) or manual DNS


## Install `cerbot` whith `nginx` plugin
```
sudo apt install certbot python3-certbot-nginx
```

- Uses your existing nginx to answer the challenge (no downtime, no port conflict).
- Knows which `server {}` block matches the domain, so it edits the *right* one.
- Can install the cert for you (`--nginx` does both obtain + configure).

Meaning:
- install OS package: `certbot`
- install OS packages (plugin for `cerbot`): `python3-certbot-nginx` (so `certbot --nginx` works)
- A systemd timer `certbot.timer` that renews certs automatically (usually installed/enabled by the package)

What you get:
- it writes to `/etc/letsencrypt`, `/etc/nginx`, and systemd
- `/usr/bin/certbot` (the CLI)
- Certs land in `/etc/letsencrypt/live/<domain>/` (`fullchain.pem`, `privkey.pem`, etc.)


### What is `python3-certbot-nginx`
- A **plugin** for `cerbot`
- allows to 
  - read your nginx config, 
  - find the right `server_name`, 
  - add the `ACME` [challenge][challenge whatis] handling
  -  rewrite your config to point at the new cert.

# Configure

## prerequisit
- You have a domain (e.g `omt.ovh`) on a provider (e.g `OVH`)
- This domain is accessible from the outside.
  - The DNS is configured at the provider level to point to an IP
  - That IP is a VM's public IP
  - The machine runs a server app process
  - The server app process listen on a port

## Configure
```sh
sudo certbot --nginx -d omt.ovh -d www.omt.ovh
```

Meaning:
1. Do an HTTP-01 [challenge][challenge whatis] (writes a token under `/.well-known/acme-challenge/`).
1. Get the cert.
1. **Edit the nginx config in place**
1. updtae the config with `listen 443 ssl`, `ssl_certificate`, a redirect from 80→443, etc.
1. Reload nginx.

