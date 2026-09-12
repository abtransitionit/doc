[//]: #(home)
[home]: ../../README.md

[//]: #(doc)
[cert whatis]:      ../whatis/cert.md
[challenge whatis]: ../whatis/cert.md

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[How-to for Cerbot](../howto/ep.md)|internal
|[What is ACME](../whatis/acme.md)|internal
|[What is a Challenge](../whatis/challenge.md)|internal
|[What is a Certificate](../whatis/cert.md)|internal
|[What is Let's Encrypt](../whatis/letsencrypt.md)|internal

<h1 align="center">What is Cerbot</h1>

# Definition
- a CLI tool from `EFF/Let's Encrypt`
- Talks to the `ACME` API
- Proves you control a domain (name), 
- can downloads/renews [certs][cert whatis]
- convert a `HHTP` website access to `HTTPS` website access


# How it works to get a certificate

First, you install `cerbot`

## for a single specific domain
- you configure `cerbot` (for your single specific domain to be accessible via `https`)
  - e.g. `omt.ovh`
- you ask `cerbot` the certificate
- `Certbot` asks `Let's Encrypt`: "Give me a challenge to the asker for the configured domain."
- `Certbot` use the [challenge HTTP-01][challenge whatis] returned by `Let's Encrypt`
  - `Let's Encrypt` replies with a random **token**, e.g. `x7f9a2...`
  - `Let's Encrypt` says: Serve this exact string at `http://omt.ovh/.well-known/acme-challenge/x7f9a2...`
  - `Certbot` writes a file with that content into your web root (or has nginx serve it).
  - `Let's Encrypt's servers` fetch that URL from the public internet.
    - If they get back the expected string → you proved control → cert issued.

> The logic: only someone who controls the domain's DNS + web server could place that file there.
 


## for a complex domain (HTTP-01 challenge)
- you configure `cerbot` (for your complex domain to be accessible via `https`)
  - e.g. `omt.ovh` + `ww.omt.ovh`
  - e.g. `*omt.ovh`
- you ask `cerbot` the certificate
- `Certbot` asks `Let's Encrypt`: "Give me a challenge to the asker for the configured domain."
- it will use a specific [challenge][challenge whatis]






# How it works
- you install `cerbot`
- you configure it (so that your domain(s) is accessible via `https`)
  - for a single domain    (e.g. `omt.ovh`)
  - for a multiple domains (e.g. `omt.ovh` + `ww.omt.ovh`)
  - for a wildcard domain  (e.g. `*.omt.ovh`)
- you ask `cerbot` the certificate
- `Certbot` asks `Let's Encrypt`: "Give me a challenge for the configured domain the asker wants."

- you are challenge to proof your control those domains






