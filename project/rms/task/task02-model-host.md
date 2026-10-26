
[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ Task][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)

<div align="center">

# Project RMS — Task - Model - Host

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

- a **Host** (where the resource lives)
- a **Transport** (how to reach it). 

The command grammar only ever names one of them, and the other is **inferred** or **defaulted**.


**Host** = an addressable execution context. It has:
|||
|-|-|
| `id` | the name you type (`local`, `o1u`, `my-nginx`, `localhost`, `win-host`)
| `kind` | what it *is*: `machine` | `container` | `endpoint`
| `address` | network/loopback locator (`127.0.0.1`, `o1u.example.com`, `localhost:9000`, `https://github.com`)
| `default_transport` |  the road you take to reach it (`local`, `ssh`, `winrm`, `docker`, `https`)
| `default_provider` | the driver used once you're there (`fs`, `tool`, `s3`, `git`, `http`)

**Transport** = the mechanism that gets you to a host. It has:

|||
|-|-|
| `name` | `local` | `ssh` | `winrm` | `docker` | `https` | `grpc` | `zmq`
| `scope` | optional narrowing (`container:my-nginx`, `host:o1u`)
| `config` | credentials, port, TLS, connection reuse, etc.
| `exec(host, command)` | the single method every transport implements

### The rule that resolves everything

```
target_token  →  resolve to (Host, Transport)
```

Resolution order:
1. If the token is a **known host alias** (`local`, `localhost`, `o1u`, `my-nginx`) → look up its `default_transport`.
2. Else if the token **carries a scheme** (`https://...`, `ssh://...`, `local:container`) → parse scheme as transport, rest as scope/address.
3. Else → treat as a **bare hostname**, default transport = `ssh` (or `https` if it looks like a URL). Overridable with `--transport`.

`--transport=X` always **overrides** the inferred one — that's your escape hatch, same role as `--provider` in your file.

### How your existing examples fall out of this model

| Token you type | Resolved Host | Resolved Transport | Why |
|---|---|---|---|
| `local` (omitted) | host `local` (machine, loopback) | `local` | default for `local` |
| `localhost` | host `localhost` (machine, loopback) | `local` | special-case loopback → no travel |
| `o1u` | host `o1u` (machine, remote) | `ssh` | bare host → ssh default |
| `local:my-nginx` | host `my-nginx` (container) | `docker` (local daemon) | scheme `local` + scope `container` |
| `my-nginx` | host `my-nginx` (container, local) | `docker` | container kind → docker default |
| `win-host` | host `win-host` (machine, windows) | `winrm` | OS hint on host |
| `https://ip` | host `ip` (endpoint) | `https` | scheme is the identity |
| `https://github.com` | host `github.com` (endpoint) | `https` | scheme is the identity |
| `my-config-bucket` | host `my-config-bucket` (endpoint, s3) | `https` (s3 endpoint) | endpoint kind → https to S3 API |

> Notice: **you never write the transport except when it *is* the target identity** (`https://`) or when you need to override (`--transport=...`). That matches your file exactly — you only ever wrote `https://` because the HTTP endpoint *is* the address.

### The data model (pseudo-struct)

```
Host {
  id:               string          // "o1u", "local", "my-nginx", "localhost"
  kind:             machine|container|endpoint
  address:          string          // "127.0.0.1", "o1u.example.com", "localhost:9000"
  os_hint:          linux|windows|any
  default_transport: TransportName
  default_provider:  ProviderName
}

Transport {
  name:    local|ssh|winrm|docker|https|grpc|zmq
  scope:   optional string          // "container:my-nginx", "host:o1u"
  config:  { creds, port, tls, reuse, timeout, ... }
  exec(host, cmd) -> Result        // the one method everything funnels through
}
```

The command carries **Host** (as the target token) and **Provider** (as verb-driver). **Transport is a property of the Host** (its `default_transport`), optionally overridden per-invocation by `--transport`. That's the whole model.

### Why this survives your stress test

- `localhost` → host kind `machine` + loopback address → `local` transport. No self-SSH bug.
- `local:container` → parsed as `scope=container`, `transport=docker`, host=`my-nginx`. Transport is **structured**, not a flat enum — so it doesn't break.
- `win-host` → host `os_hint=windows` → `winrm` default. One attribute, no grammar change.
- `o1u` with `--transport=docker` → same host, different road. Proves transport is swappable.
- `https://ip` → scheme is the *target identity*, so it becomes `host=ip, transport=https` — consistent with your file.
- S3 bucket → `host=my-config-bucket (endpoint), transport=https`, provider `s3`. Bucket is a host, key is the address, creds live in `transport.config`.

### One-liner for your spec

> **A Host is where the resource lives; a Transport is how the CLI gets there. The command names a Host (the target token) and a Provider (the verb driver); the Transport is inferred from the Host — unless `--transport` overrides it — and it's always structured as `road[:scope]`, never a flat enum.**

That single sentence is enough to implement resolution, keep `localhost`/`local:container` sane, and leave room for `winrm`, `docker`, `grpc`, `zmq` later without touching the grammar.


# Wrapped host