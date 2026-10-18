[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]


<h1 align="center">What is Secret</h1>

The concept of Secret

# Definition
- xxx


# From Request to Response

```
[ Internet client ]
        │
        │  DNS lookup: omt.ovh → <your VPS public IP>
        ▼
┌──────────────────────────────────────────────────────┐
│ 1. DNS (registrar / DNS provider)                    │
│    - A record for omt.ovh must point to VPS IP       │
│    - Checked with: getent ahostsv4 omt.ovh           │
└──────────────────────────────────────────────────────┘
        │
        ▼
┌──────────────────────────────────────────────────────┐
│ 2. VPS provider network / cloud firewall             │
│    - Some providers (Hetzner, Oracle, AWS, etc.)     │
│      have a firewall BEFORE the VM's OS.             │
│    - Must allow inbound TCP 80 and 443.              │
│    - NOT visible from inside the VM.                 │
│    - Checked in the provider's web console.          │
└──────────────────────────────────────────────────────┘
        │
        ▼
┌──────────────────────────────────────────────────────┐
│ 3. Host OS firewall (UFW / iptables / nftables)      │
│    - This is what `sudo ufw status` shows.           │
│    - Right now: INACTIVE → nothing blocked here.     │
│    - When enabled: must allow 22, 80, 443.           │
└──────────────────────────────────────────────────────┘
        │
        ▼
┌──────────────────────────────────────────────────────┐
│ 4. Host kernel → port binding                        │
│    - Podman publishes ports via iptables/nftables    │
│      rules it inserts automatically.                 │
│    - `-p 80:80 -p 443:443` binds host 80/443.        │
│    - Rootless Podman cannot bind <1024 unless         │
│      net.ipv4.ip_unprivileged_port_start is lowered. │
│    - Rootful Podman (sudo) can bind them directly.   │
└──────────────────────────────────────────────────────┘
        │
        ▼
┌──────────────────────────────────────────────────────┐
│ 5. Podman network (CNI or netavark)                  │
│    - Container gets a veth pair + internal IP.       │
│    - If using a named network (e.g. proxy-net),      │
│      containers resolve each other by name.          │
│    - Port publishing (step 4) forwards host:port     │
│      → container:port.                               │
└──────────────────────────────────────────────────────┘
        │
        ▼
┌──────────────────────────────────────────────────────┐
│ 6. Container                                      │
│    - Caddy listens on 80 and 443 inside the          │
│      container namespace.                            │
│    - Terminates TLS, then reverse_proxy to backends. │
└──────────────────────────────────────────────────────┘
        │
        ▼
   [ Response back up the chain ]
```


# The barriers

| # | Barrier | Visible from inside VM? | What to check |
|---|---------|------------------------|----------------|
| 1 | DNS A record | ✅ `getent ahostsv4 omt.ovh` | Must equal VPS public IP |
| 2 | **Cloud provider firewall** | ❌ No | Provider web console — allow 80, 443 |
| 3 | UFW / host firewall | ✅ `sudo ufw status` | Right now: inactive (not blocking) |
| 4 | Privileged port binding | ✅ error at `podman run` | Rootless can't bind 80/443 without sysctl tweak |
| 5 | Podman network config | ✅ `podman network ls` | We'll create `proxy-net` |
| 6 | Container config | ✅ `podman logs caddy` | Caddyfile must list `omt.ovh` |

