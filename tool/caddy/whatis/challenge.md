[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Caddy][home topic] · [↖ Tool][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[caddy github whatis]:       https://github.com/caddyserver/caddy
[caddy howto]:        ../howto/ep.md
[cerbot whatis]:      /tool/cerbot/whatis/ep.md

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |
| [What is caddy on Github][caddy github whatis]|external|github
| [What is cerbot][cerbot whatis]
| [How-to for Caddy][caddy howto]|



<h1 align="center">What is Caddy Challnege</h1>

# Definition
- Occurs when Caddy request a `HTTPS` cert to Let's Encrypt for your domain.
- Temporary test that **Let's Encrypt** asks your server or DNS provider to complete.
- If the test succeded it proves that you control the domain.
- therefore **Let's Encrypt** issues the `HTTPS` certificate.

## 1. HTTP validation — normal certificate

Example: `omt.ovh`

Let's Encrypt checks that you control the domain by asking your server for a special temporary file over HTTP.

```
    YOUR VPS                  LET'S ENCRYPT              OVH DNS
   (Caddy server)             (Certificate authority)    (DNS provider)
        |                              |                       |
        |                              |                       |
        |                     1. Looks up omt.ovh              |
        |                              |---------------------->|
        |                              |<----------------------|
        |                              |    VPS public IP       |
        |                              |                       |
        |<-----------------------------|                       |
        | 2. HTTP challenge on port 80 |                       |
        |                              |                       |
        | 3. Caddy answers challenge   |                       |
        |----------------------------->|                       |
        |                              |                       |
        |                     4. Verification succeeds          |
        |                              |                       |
        |<-----------------------------|                       |
        | 5. Certificate issued        |                       |
        |                              |                       |
```

What you need:

- DNS for `omt.ovh` pointing to your VPS.
- Port 80 accessible from the internet.
- Caddy running and configured for `omt.ovh`.

Caddy handles the challenge automatically. You don't need to create a file yourself.

## 2. DNS validation — wildcard certificate

Example: `*.omt.ovh`

A wildcard certificate covers all subdomains at one level, such as `jekyll.omt.ovh` and `dev-jekyll.omt.ovh`.

Let's Encrypt cannot verify a wildcard using the HTTP challenge. Instead, it asks you to prove control of your DNS.

```
  YOUR VPS                  OVH DNS                  LET'S ENCRYPT
  (Caddy container)         (DNS provider)           (Certificate authority)
       |                          |                           |
       |                          |                           |
       | 1. Request certificate   |                           |
       |    for *.omt.ovh         |                           |
       |----------------------------------------------------->|
       |                          |                           |
       |<-----------------------------------------------------|
       | 2. Must create a TXT record                           |
       |                          |                           |
       | 3. Call OVH DNS API      |                           |
       |------------------------->|                           |
       |                          |                           |
       |                          | 4. Publish temporary TXT  |
       |                          |    _acme-challenge.omt.ovh|
       |                          |                           |
       |                          |<--------------------------|
       |                          | 5. Let's Encrypt checks   |
       |                          |    the TXT record         |
       |                          |-------------------------->|
       |                          |                           |
       |<-----------------------------------------------------|
       | 6. Certificate issued                                |
       |                          |                           |
```

What you need:

- DNS for `omt.ovh` configured correctly.
- An OVH API credential that permits the required DNS changes.
- A Caddy build containing the OVH DNS plugin.
- The API credential securely available to the Caddy container.

Caddy can then create and remove the temporary TXT record automatically.

## 3. What does each certificate cover?

```
CERTIFICATE A: omt.ovh
|
+-- https://omt.ovh                 YES
|
+-- https://jekyll.omt.ovh          NO
|
+-- https://dev-jekyll.omt.ovh      NO
```

With a wildcard certificate:

```
CERTIFICATE B: omt.ovh + *.omt.ovh
|
+-- https://omt.ovh                 YES
|
+-- https://jekyll.omt.ovh           YES
|
+-- https://dev-jekyll.omt.ovh       YES
|
+-- https://dev.jekyll.omt.ovh       NO
```

The root domain `omt.ovh` must be included explicitly; `*.omt.ovh` alone does not cover it.

## 4. What I recommend for your Podman setup

Start with normal HTTP validation and an individual certificate for `omt.ovh`:

```
INTERNET
   |
   | HTTPS :443
   v
+----------------------------------+
| OVH VPS                          |
|                                  |
|  +----------------------------+  |
|  | Caddy container            |  |
|  | Ports 80 and 443           |  |
|  | Automatic HTTPS            |  |
|  +-------------+--------------+  |
|                |                 |
|                v                 |
|  +----------------------------+  |
|  | Jekyll on port 4000         |  |
|  +----------------------------+  |
+----------------------------------+
```

Later, add your development and production hostnames to Caddy's configuration. Caddy can obtain separate certificates for them without needing DNS API credentials.

If you want a wildcard certificate in the future, you can switch to DNS validation through OVH's API. Either way, persist Caddy's data directory outside the container so its certificates survive container replacement and VPS rebuilds.