[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[caddy whatis]:        ../whatis/ep.md
[podman whatis]: /tool/podamn/whatis/ep.md
[reverse proxy whatis]: /concept/other/whatis/reverse.proxy.md

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |
| [What is Podman][podman whatis]|
| [What is a Reverse Proxy][reverse proxy whatis]|



<h1 align="center">How-to Caddy</h1>

# Index

# Backup Caddy config <a id='backup'></a>
For a standard Caddy installation. In order to re-use the certificate, back up these items:

| Item                        | Location                             | Purpose                                       |
| --------------------------- | ------------------------------------ | --------------------------------------------- |
| Caddy certificates and keys | `/var/lib/caddy/.local/share/caddy/` | Remembers certificates and related data       |
| Caddy configuration         | `/etc/caddy/Caddyfile`               | Tells Caddy to proxy `omt.ovh` to port `4000` |


**backup and save caddy files**

```
sudo tar -czf /root/caddy-backup.tar.gz \
  /var/lib/caddy/.local/share/caddy \
  /etc/caddy/Caddyfile
```

Important: This archive contains private keys. Download it to a safe location outside the VPS, and keep it private.




# Restore Caddy config <a id='restore'></a>

1. Install Caddy again.
2. Restore the backup to the same locations, preserving file ownership and permissions.
3. Start Caddy with the same domain and configuration.

> ⚠️ If Caddy can read its old data and the certificate is still valid, it should reuse that certificate rather than request a new one.

> 🔆 Even better, consider keeping Caddy's certificate data on a persistent external volume.

See the [official Caddy HTTPS documentation](https://caddyserver.com/docs/automatic-https) for details.
# Install Caddy for Jekyll <a id='install'></a>

Creae an access to a URL accessible via the protocol `HTTPS` and no more via the HTTP protocol

|Key|Value|Notes|
|-|-|-|
|dev URL|`https://doc.dev.omt.ovh:4000`|
|prod URL|`https://doc.prod.omt.ovh:4000`|


## Current Configuration

|Key|Value|Notes|
|-|-|-|
|Domain|`omt.ovh`|points to the VM public IP|
|Server| Jekyll|runs on the VM at port `4000`|
|current URL|`http://omt.ovh:4000`|public and accessible


Goal: build access to a `dev` and `prod` URL.


## Check Prerequisits

1. DNS for the **domain** points to the VM IP.
1. Ports 80 and 443 are open in the VM firewall and any provider firewall.
1. Nothing else is already using ports `80` and `443`.
1. Caddy is installed on the VM where the **server** runs

## Configuration

Create a Caddy configuration file with:

```toml
omt.ovh {
    reverse_proxy localhost:4000
}
```

## What to back up before rebuilding Ubuntu



## 3. Constraints

Wildcard certificates require DNS-based validation with Caddy.


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


## Strategy

- Start with one hostname and let Caddy obtain its certificate. 
- Then add a DEV and PROD hostnames to the Caddyfile and let Caddy obtain the additional certificates as needed.
- To cover frequent VPS rebuilds, persists Caddy's data directory in a Podman volume or a directory that survives the rebuild.
- That way, Caddy can reuse its existing certificates rather than repeatedly requesting new ones.
- For Podman, Plan to use a shared container network for `Caddy` and `Jekyll` containers
- For rootless Podman, binding public ports 80 and 443 needs extra configuration on Linux. 
- We should account for that in the installation design rather than discover it when starting Caddy