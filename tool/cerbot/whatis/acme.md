[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)
[ca whatis]: #
[cert whatis]: ../whatis/cert.md
[challenge whatis]: ../whatis/challenge.md

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Challenge][challenge whatis]|internal
|[What is a Certificate][cert whatis]|internal



<h1 align="center">What is ACME</h1>

# Definition
- An API to request
- A Protocol (set of rules)
- As a protocol, automate (without a human filling out forms or a [CA][ca whatis] employee manually checking anything) to
  - actions/operations on [Certificate][cert whatis]
  - communication between
    - a client that ask for a [Certificate][cert whatis]
    - a certificate authority that operate that [Certificate][cert whatis]
- A program (via API/CLI) that can now 
  - request a `cert`, 
  - prove control, receive it, renew it 

# History
Before ACME (~2015), getting a cert meant:

1. Generate a `CSR`.
1. Go to a `CA`'s website, create an account, pay.
1. Paste the `CSR`.
1. Wait for a human or slow system to validate you.
1. Download the cert.
1. Repeat every 1–2 years (and usually forget, then panic when it expires).


# Security Best practice

automation is *why* Let's Encrypt can issue **90-day**, **1-day** certs for free
- they're short-lived precisely because renewal is now **painless** in terms of cost.

# Todo

## Who plays which role

| Role | In your case | What it does |
|------|-------------|--------------|
| ACME client | Certbot | <li>Runs on your server <li> Speaks ACME **language** to the **automated** CA |
| ACME server | Let's Encrypt (Boulder) | The [CA][ca whatis] <li> validates and issues [certs][cert whatis] |
| ACME Domain | `omt.ovh` | What's being certified and validated |

Other clients: `acme.sh`, `lego`, Caddy (built-in), Traefik (built-in). Other servers: ZeroSSL, Buypass, and internal CAs like **Step CA** and **Pebble** (a test server).

## What ACME actually holds (its moving parts)

The protocol defines several concepts. Here are the ones that matter:

**1. Account**
You register a key pair with the CA. This identifies "you" to the CA across requests. Not a username/password — a cryptographic key.

**2. Order**
"Please issue me a cert for these names (`omt.ovh`, `www.omt.ovh`)." The server responds with what you must do to complete it.

**3. Authorization**
Per domain name. "To prove you control `omt.ovh`, complete this challenge." Each authorization contains one or more challenges.

**4. Challenge** (the thing from before)
The proof-of-control test — HTTP-01, DNS-01, TLS-ALPN-01. You pick one, satisfy it, and tell the CA "done, go check."

**5. Validation**
The CA server independently checks the challenge (fetches the token, looks up the DNS record, etc.). Pass → authorization becomes *valid*.

**6. Certificate issuance**
Once all authorizations are valid, the order completes and the CA hands you the signed certificate (and chain).

**7. Renewal**
Just... do the whole thing again, automatically, before expiry. There's no special "renew" verb — a renewal is simply a fresh order.

## A rough walkthrough in ACME verbs

```
1. Register account (once)
2. New order for [omt.ovh, www.omt.ovh]
3. Fetch authorizations for each name
4. For each, pick a challenge and satisfy it (write file / set DNS TXT)
5. Tell the CA: "challenge ready"
6. CA validates from the public internet
7. Finalize order with your CSR
8. Download the certificate
9. Install + reload nginx
... (later, automatically) repeat 2–9 before expiry
```

That entire loop is what `certbot --nginx -d omt.ovh` collapses into one command.

## Why it's called a "protocol" and not just "a tool"

Because it's **standardized** (IETF **RFC 8555**). That means:

- Any client can talk to any ACME server.
- You aren't locked into Let's Encrypt — swap in ZeroSSL or an internal CA and the same client works.
- The security model (proof of control, short-lived certs, automation) is defined by the spec, not by one company.

## The neat consequence

ACME turned certificates from a **manual, periodic, human chore** into **infrastructure** — something your server just... does. That's why phrases like "the cert renews itself" are normal now, and why the old "oh no, the cert expired on a Friday" horror stories have largely faded.

So when I said "the ACME server fetches the URL" earlier — the ACME server is Let's Encrypt's side of this protocol, and that fetch is the **validation** step defined by ACME. Certbot is just the client speaking ACME on your behalf.







# todo


This is a great thread to pull on, because it explains the exact pain you lived through as an SRE/DevOps person. Let me answer the two questions directly.

## "Should an organization have an ACME server?"

**Short answer: increasingly yes, but it's not mandatory** — and for most of your career it *wasn't even an option*, which is precisely why certs were a nightmare.

There are really two worlds:

**1. Public certs (the classic world)**
- The ACME server is **Let's Encrypt / ZeroSSL / DigiCert**, etc. You don't host it; you consume it.
- You run a **client** (Certbot, acme.sh, lego, Caddy, Traefik) on your side.
- This is what we've been talking about.

**2. Internal / private certs (the world you probably suffered in)**
- Certs for `*.internal.corp`, service-to-service mTLS, internal APIs, databases, etc.
- These **cannot** use Let's Encrypt (it only signs publicly reachable names).
- Historically you had **no ACME server** — you had a corporate CA, a PKI team, a ticket queue, a Jira workflow, a guy named Dave, and a 1–2 year expiry you'd forget.

**That second world is exactly why certs were "a big, big problem."**

## Why certs were hell (the honest SRE/DevOps version)

You remember it correctly. It was bad for **structural** reasons:

| Problem | Why it hurt |
|---------|-------------|
| **Manual issuance** | Ticket → PKI team → CSR → wait days/weeks → download → deploy by hand |
| **No standard API** | Every CA had its own portal, its own format, its own process |
| **Long-lived certs (1–2 yrs)** | You'd forget, then get paged at 3am on a Friday when prod expired |
| **Decentralized ownership** | 400 services, each team doing it their own way, no inventory |
| **Manual renewal** | No automation → an actual calendar reminder and a runbook |
| **Spreadsheets of doom** | "Cert inventory" was a wiki page updated by hope |
| **mTLS everywhere** | Internal service meshes needed certs *per service* — thousands of them |
| **Short expiry irony** | The more secure you got (shorter certs), the more renewals, the more pain |

The expiry-at-3am incident was practically a rite of passage. You weren't bad at your job — the tooling and process genuinely didn't exist in a usable form.

## What changed: ACME came to the internal world

The same ACME protocol that powers Let's Encrypt can be **run by your own organization**. This is the piece that wasn't around (or wasn't mature) in your earlier career:

- **Step CA** (Smallstep) — a self-hosted ACME server for internal certs
- **Vault** (HashiCorp) — PKI secrets engine, now speaks ACME
- **cert-manager** (Kubernetes) — automates cert issuance/renewal against ACME servers, internal or public
- **CFSSL** (Cloudflare) — internal CA
- **EJBCA / Venafi** — enterprise PKI with ACME support

Now an org **can** run its own ACME server and get the same "cert renews itself" magic internally:

```
cert-manager (client)  ←→  internal ACME server (Step CA / Vault)  ←→  your services
```

Every internal service gets a cert, auto-issued, auto-renewed, short-lived, no tickets, no Dave.

## So the mental model shift

Your past pain was because these two things were true:

1. **No ACME server existed in your org** (internal PKI was manual).
2. **The public world wasn't automated either** until Let's Encrypt (2015) normalized it.

Today both worlds have ACME:

| | Then (your pain) | Now |
|--|------------------|-----|
| Public certs | Manual CA portal | Certbot / Caddy / Traefik, auto |
| Internal certs | Manual PKI, tickets | Step CA / Vault / cert-manager, auto |
| Lifetime | 1–2 years | 90 days (public), often 24h (internal mTLS) |
| Renewal | Calendar + runbook | Automated, days before expiry |
| Inventory | Spreadsheet | API / CRD state |

## Why shorter certs *helped* rather than hurt

Counterintuitive but true: **short-lived certs forced automation**, and automation removed the pain. The 90-day Let's Encrypt cert isn't harder than a 2-year cert — it's *easier*, because you're not supposed to renew it by hand. The expiry nightmare only existed because lifetime was long enough to forget but renewal was manual. Kill the manual part, and short lifetimes become a security win with zero operational cost.

## Direct answer to "should an org have an ACME server?"

- **If you have internal services needing certs** (mTLS, internal TLS, mesh): **yes, strongly consider it.** Step CA, Vault, or cert-manager against an internal ACME server is the modern default.
- **If you only need public certs**: **no**, you just run a client and consume Let's Encrypt. No server to host.
- **Either way**: the goal is that **no human touches a cert**. That's the whole game.

The reason your past life was miserable is that you lived through the exact window — after PKI was mandatory everywhere, but before ACME made it automatable. You were paying the "manual PKI tax" on infrastructure that assumed automation that didn't exist yet. That tax is mostly gone now, if you set it up right.