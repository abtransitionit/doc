[//]: #(home)
[home]:               ../whatis/ep.md
[letsencrypt whatis]: ../whatis/letsencrypt.md
[//]: #(doc)
[cert whatis]: ../whatis/cert.md

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Certificate][cert whatis]|internal
|[What is a Let's Encrypt][letsencrypt whatis]|internal


<h1 align="center">What is a Cerbot Challenge</h1>

# Definition
- A test internally one asker must pass that varies based on the kind of certificate asked.
- The action of checking that a [asker](#) who ask for a [cert][cert whatis] for a domain is the official owner and controls that domain. 
- It's a test named "proof-of-control" that is certificate-kind-specific
- the test is kind of: "Show me you can do something only the real owner of this domain could do."
- There is several kind of challenge based on the kind of certificate asked:
  -  `HTTP-01 challenge`
  -  `DNS-01`
  -  `TLS-ALPN-01`

# Kind

- The challenge type used by Let’s Encrypt depends on how you can prove control of the domain. 
- non-wildcard certificates use `HTTP-01`, 
- `DNS-01`, or `TLS-ALPN-01`, wildcard certificates require DNS-01.

Let’s Encrypt supports several challenge types to verify that you control a domain, each suited to different network configurations and certificate requirements.


| kind | How you prove control | When you use it |
|------|----------------------|-----------------|
| **HTTP-01** | Serve a token file over port 80 | Default; needs port 80 open |
| **DNS-01** | Create a `_acme-challenge.omt.ovh` TXT record with a token | When port 80 is blocked, or for **wildcard** certs (`*.omt.ovh`) |
| **TLS-ALPN-01** | Serve a special cert on port 443 | Less common |




# How the challenge works (the common one)

- The plugin: `python3-certbot-nginx` uses **HTTP-01** by default.
- It relies on **nginx answering on port 80** so Let's Encrypt's **bot** can fetch the token file.
- If `omt.ovh` is behind a CDN, or port 80 is firewalled, or DNS points elsewhere → Let's Encrypt can't reach the token → challenge fails → **no certificate**.

## Key points

- You **never do any of this by hand**. 
- Certbot handles the entire challenge dance
  - requesting the token
  - serving it
  - cleaning up afterward

You just run:

```sh
# Challenge consideration happens behind the scenes. 
sudo certbot --nginx -d omt.ovh
```




## Caveats worth knowing

- **Port 80 must be reachable from the internet** for HTTP-01. If `omt.ovh` is behind a proxy/CDN or port 80 is closed, the challenge fails — use `--dns-*` plugins or `--webroot` instead.
- The plugin **modifies your nginx files**. Back them up (`cp -r /etc/nginx /etc/nginx.bak`) if you're cautious — it's usually fine but occasionally reorders things.
- Requires nginx already installed and the site already configured with a matching `server_name`.
- On very old Ubuntu you'd need `ppa:certbot/certbot`; on modern (20.04+) the default repos are fine.


If you'd rather not let Certbot touch your config, use `certbot certonly --nginx` and wire the cert paths into nginx yourself.


Then test renewal:

```bash
sudo certbot renew --dry-run
```

## Why the nginx plugin specifically (vs `certbot` alone)

Plain `certbot` gives you `certonly` / `--standalone` (it spins up its own web server on port 80) or manual DNS. The `--nginx` plugin instead:

- Uses your existing nginx to answer the challenge (no downtime, no port conflict).
- Knows which `server {}` block matches the domain, so it edits the *right* one.
- Can install the cert for you (`--nginx` does both obtain + configure).


