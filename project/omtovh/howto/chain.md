[//]: #(home)
[home]: ../../README.md


[//]: #(functional)

[↖][home]


Related topics

| Topic | Location | Kind |
|---|---|---|
|[What is Tool chain](../whatis/chain.md)|internal|


**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">How-to for Tool Chain</h1>


# Check a server process exists
```
# on the (server) machine running the server app
# check the server app process exists
ps -ef | grep alger
pgrep -a alger
```

# Check the server app process port and adress binding
```
# on the (server) machine running the server - check the server is listening
ss -tulpn
ss -tlpn
```
example output:
| State  | Recv-Q | Send-Q | Local Address:Port | Peer Address:Port | Process                       |
| ------ | -----: | -----: | ------------------ | ----------------- | ----------------------------- |
| LISTEN |      0 |   4096 | 127.0.0.53%lo:53   | 0.0.0.0:*         | —                             |
| LISTEN |      0 |   4096 | 0.0.0.0:22         | 0.0.0.0:*         | —                             |
| LISTEN |      0 |   4096 | 127.0.0.54:53      | 0.0.0.0:*         | —                             |
| LISTEN |      0 |   4096 | [::]:22            | [::]:*            | —                             |
| LISTEN |      0 |   4096 | *:3000             | *:*               | `algernon` (PID 209006, FD 7) |

Meaning:

|port|server app||
|-|-|-|
|53  |local DNS resolver| (127.0.0.53 / 127.0.0.54)
|22  |SSH|listening on IPv4 and IPv6
|3000|algernon application|listening on all interfaces (*:3000)

| Listening address | Meaning | Who can reach it? | Can Internet clients reach it? |
| - | - | - | - |
| `127.0.0.54:53`   | Listen only on the loopback interface | **Only processes** on the same machine                    | ❌ No                           |
| `*:3000`          | Listen on all network interfaces      | **Local** processes + machines that can reach the machine | ✅ Yes, potentially             |

# check server respond to local request
```
curl -I http://localhost:3000
curl -I http://127.0.0.1:3000
```

# Check OS kernel firewall
```
# check os firewall
sudo ufw status verbose
# Output
Status: inactive
```

```
# check os firewall
sudo firewall-cmd --list-all
# Output maens - awaited response for a non rhel os
'firewall-cmd': command not found
```

```sh
sudo nft list ruleset
# produces no output → means, no tables, chains, or rules defined
```

# Check `iptables` rules
```sh
# ckeck on server machine running the server app
sudo iptables -L INPUT -n -v
sudo iptables -L INPUT -n
```

Meaning
| Flag | Meaning |
|-|-|
| `-L` | **List** the rules in the specified chain |
| `INPUT` | The chain to list (traffic destined *for* this machine - **inbound** traffic) |
| `-n` | **Numeric** output — don't resolve hostnames/services - show IPs and ports as numbers |
| `-v` | **Verbose** — show packet/byte counters and interface names |

Output:
```sh
# Output means → the Host OS is 100% open and not blocking any traffic.
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
```


# Check client can sends request to server machine port
## using `nc`
```
# on the client machine running the client app
nc -zv -w 5 51.210.10.195 3000
nc -zv -w 5 51.210.10.195 3000 80 443
```

Meaning:

| Flag | Meaning |
|-|-|
| `-z`            | **Zero-I/O mode** — just scan for listening daemons, don't send any data |
| `-v`            | **Verbose** — print connection status messages |
| `-w 5`          | **Timeout** of 5 seconds — give up if no response in that time |
| `51.210.10.195` | Target machine  IP (server machine's public IP) |
| `3000`          | Server TCP port on target machine (often Node.js / Grafana / dev servers) |


Output:
```sh
# only server app's process listening on port 3000 is accessible to that client
Connection to 51.210.10.195 3000 port [tcp/*] succeeded!
nc: connect to 51.210.10.195 port 80 (tcp) failed: Connection refused
nc: connect to 51.210.10.195 port 443 (tcp) failed: Connection refused
```

## using `curl`
```sh
curl -i http://51.210.10.195:3000 # header + body
curl -I http://51.210.10.195:3000 # only header only
curl -sI http://51.210.10.195:3000 | grep -i server # only server app id 

```

Meaning: send an HTTP request to the server 

| Flag | Meaning |
|-|-|
| `-i`            | **Include** response headers in the output (normally curl only shows the body) |
| `http://`       | Use HTTP (not HTTPS) |
| `51.210.10.195` | Target machine  IP (server machine's public IP) |
| `:3000`         | Server TCP port on target machine (often Node.js / Grafana / dev servers) |

Output:
```sh
# server app's process listening on port 3000 is accessible to that client.
# and this client can send request
<HTML content>
```

## using `dig`
```sh
# Resolve the name (into an IP)
dig +short omt.ovh # **D**omain **I**nformation **G**roper — a DNS query tool
```

Meaning: get the IP from that name (performs a DNS lookup)

| Flag | Meaning |
|-|-|
| `+short`    | Show **only the answer** (IP addresses / targets), no headers, no stats |
| `omt.ovh`   | The domain to look up |
| *(default)* | Query type **A** (IPv4 address) |

### todo : variations

```bash
# Full output — see TTL, authoritative servers, query time
dig omt.ovh

# Specific record types
dig +short omt.ovh A        # IPv4 (default)
dig +short omt.ovh AAAA     # IPv6
dig +short omt.ovh MX       # mail servers
dig +short omt.ovh TXT      # SPF, DKIM, verification tokens
dig +short omt.ovh NS       # nameservers
dig +short omt.ovh CNAME    # canonical name
dig +short omt.ovh ANY      # try all (often refused these days)

# Query a specific resolver
dig +short @1.1.1.1 omt.ovh
dig +short @8.8.8.8 omt.ovh

# Reverse lookup (IP → hostname)
dig +short -x 51.210.10.195

# Trace the delegation chain
dig +trace omt.ovh
```
