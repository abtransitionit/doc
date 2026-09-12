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
- A test internally one asker must pass that varies based on the kind of kind of certificate asked.
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

