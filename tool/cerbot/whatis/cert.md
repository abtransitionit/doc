[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)
[cert whatis]: ../whatis/cert.md
[challenge whatis]: ../whatis/challenge.md

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Challenge][challenge whatis]|internal



<h1 align="center">What is a Cerbot Certificate</h1>

# Definition
- for a website. it allows to access it via `HTTPS` rather than `HTTP`
- has a **lifecycle** (an expiration date)
- It says 
  - that website is **"SURE"**
  - you can access it via `HTTPS`
  - we know the entity who owns it.


# Kind
|Kind|Purpose|Example|
|-|-|-|
|Single-name certificate|One specific DNS name|`omt.ovh`, `www.omt.ovh`
|Multi-domain / SAN certificate|Multiple DNS names|`omt.ovh` + `www.omt.ovh`
|Wildcard certificate|Wildcard DNS name (subdomain)|`*.omt.ovh`

- Single-name certificate can use **HTTP-01, DNS-01, or TLS-ALPN-01** [challenge][challenge whatis]
- Wildcard certificates require **DNS-01** [challenge][challenge whatis]. 


# Operation
- issue
- validate
- renew
