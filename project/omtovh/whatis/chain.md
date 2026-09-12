[//]: #(home)
[home]: ../../README.md


[//]: #(functional)
[packet inline]: #packet
[↖][home]


Related topics

| Topic | Location | Kind |
|---|---|---|
|[How-to for OmtOvh](../howto/ep.md)|internal|
|[How-to for Tool chain](../howto/chain.md)|internal|


**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">OmtOvh Tool Chain</h1>


# Context
- When an app (in a machine) sends a request to a server (in another machine)
- The request goes from the app (that act as a client) to another app (that act as a server) through a chain of tools/systems.
- Each tool/system in the chain has the capability to either forward/block/drop the request's paquets.
- tool/system include: network infrastructures, firewalls, OS components.

# Definition

## The request
- The request originates inside an application (e.g. a web browser, curl, or another [client] app) running on the client machine.
- The request is alaways sent to a server app process (`IP:port`). if `Port` or `IP` is missing then at a moment it is injected.
- The client sends a request, while the server receives a request
- [https://example.com/api](https://example.com/api)

## The tool chain


**simplified diagram**

```
Client application
      │
      │ request
      ▼
DNS resolution
      │
      │ IP address
      ▼
Internet Network
      │
      ▼
Provider cloud infrastructure
      │
      ├── Security rules
      └── Provider firewall
      │
      ▼
Server machine
      │
      ├── Network interface (NIC)
      ├── Routing
      └── Host firewall
      │
      ▼
Listening socket
      │
      ▼
Server application
      │
      └── Authentication / authorization
```


**full diagram**


```
┌──────────────────────────────────────────────────────────────────┐
│ 1. CLIENT MACHINE                                                │
│                                                                  │
│  ┌────────────────────┐                                          │
│  │ Client App         │                                          │
│  └─────────┬──────────┘                                          │
│            │ (1) Generates HTTP/TCP request payload              │
│            ▼                                                     │
│  ┌────────────────────┐                                          │
│  │ Client Request     │                                          │
│  └─────────┬──────────┘                                          │
│            │ (2) Queries/Resolve domain name                     │
│            ▼                                                     │
│  ┌────────────────────┐                                          │
│  │ Client DNS         │                                          │
│  │ Resolution         │ (Local cache lookup / OS resolver)       │
│  └─────────┬──────────┘                                          │
│            │                                                     │
│            │ (3) IP address resolved                             │
│            ▼                                                     │
│  ┌────────────────────┐                                          │
│  │ Packet Transmission│ (OS encapsulates TCP/IP packets)         │
│  └────────────────────┘                                          │
└────────────────┬─────────────────────────────────────────────────┘
                 │
                 │ (4) Outbound DNS queries & TCP packets
                 ▼
┌──────────────────────────────────────────────────────────────────┐
│ 2. INTERNET  NETWORK                                            │
│                                                                  │
│  ┌────────────────────────────┐                                  │
│  │ External DNS Infrastructure│ (Recursive & Authoritative DNS)  │
│  └─────────┬──────────────────┘                                  │
│            │                                                     │
│            │ Returns resolved IP / Routes traffic                │
│            ▼                                                     │
│  ┌────────────────────────────┐                                  │
│  │ Internet Routing           │ (ISPs, BGP routing, Backbones)   │
│  └────────────────────────────┘                                  │
└────────────────┬─────────────────────────────────────────────────┘
                 │
                 │ (5) Inbound packets hit provider cloud edge
                 ▼
┌──────────────────────────────────────────────────────────────────┐
│ 3. PROVIDER CLOUD INFRA                                          │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │ Edge Network, Datacenter Routers & Provider Firewall       │  │
│  └─────────────────────────────┬──────────────────────────────┘  │
│                                │                                 │
│                                │ (6) Traffic allowed to instance │
│                                ▼                                 │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │ 4. SERVER MACHINE                                          │  │
│  │                                                            │  │
│  │  ┌────────────────────┐                                    │  │
│  │  │ Host NIC           │ Physical/Virtual                   │  │
│  │  │                    │ Network Interface Card             │  │
│  │  │                    │ (eth0, ens3, packet ingestion)     │  │
│  │  └─────────┬──────────┘                                    │  │
│  │            │                                               │  │
│  │            ▼                                               │  │
│  │  ┌────────────────────┐                                    │  │
│  │  │ Host OS            │ Linux Kernel Networking Stack      │  │
│  │  │                    │ ├─ Routing Tables                  │  │
│  │  │                    │ ├─ Host Firewall (iptables/ufw)    │  │
│  │  │                    │ └─ Listening Sockets (IP:Port)     │  │
│  │  └─────────┬──────────┘                                    │  │
│  │            │                                               │  │
│  │            ▼                                               │  │
│  │  ┌────────────────────┐                                    │  │
│  │  │ Host App           │ Server Process                     │  │
│  │  │                    │ └─ Auth & Business Logic           │  │
│  │  └────────────────────┘                                    │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘
```

# What can forward/allow/drop/reject request'packets <a id='packet'></a>


| Tool / System | Blocking & Forwarding Capability | Diagnostic & Inspection CLI Tools |
| --- | --- | --- |
| [Client App](#client) | <li>Initiates requests <li>can block outbound connections locally via app settings or client security policies. | `curl`, `wget`, `postman`, `httpie` |
| [Client DNS Resolution](#client-dns) | <li>Resolves domains to IP addresses <li> can block traffic using local hosts files (`/etc/hosts`) or local DNS sinkholes/ad-blockers. | `dig`, `nslookup`, `host`, `systemd-resolve --status` |
| **Packet Transmission (Client OS)** | <li> Encapsulates packets <li> forwards them <li>can drop egress traffic via local client firewalls, proxy constraints <li> can disable NIC. | `ping`, `traceroute` (`tracert`), `netstat`, `ip route` |
| **External DNS Infrastructure** | <li> Resolves external hostnames <li> can drop queries via DNS filtering, sinkholing, or unreachable upstream resolvers. | `dig +trace`, `whois` |
| **Internet Routing (ISPs & Backbones)** | <li> Routes packets across transit networks <li>can drops them due to ISP filtering, BGP routing blackholes, or network path outages. | `mtr`, `traceroute -T` (TCP traceroute), `pathping` |
| [Edge Network & Provider Firewall](#provider) | <li> Forwards incoming traffic to the server <li> can block/drops packets using Cloud Security Groups, Network ACLs, and Anti-DDoS filters. | `nc -zv` (netcat), `nmap -p`, `ovh-cli`, `aws ec2 describe-security-groups` |
| **Host NIC (Physical/Virtual)** | <li>Ingests frames into the server hardware <li>can drops packets if the interface is down, misconfigured, or experiencing driver errors. | `ip link`, `ip addr`, `ethtool`, `tcpdump -i eth0` |
| [Host OS (Linux Kernel Stack)](#server-os) | <li> Routes packets to listening sockets <li>can drops/rejects traffic via host firewalls (`iptables`, `nftables`, `ufw`) and reverse-path filtering (`rp_filter`). | `iptables -L -v -n`, `ufw status verbose`, `nft list ruleset`, `ss -tuln` |
| [Host App (Server Process)](#server-app) | <li> Accepts socket connections and processes requests <li>can reject them using application-level authentication, ACLs, and authorization rules. | `ss -tulpn`, `journalctl -u <service>`, `tail -f /var/log/nginx/error.log` |



## [↑][packet inline] Client <a id='client'></a>
The client request originates inside a client application'process (a web browser, curl, or a custom app) running on the client machine.

**How Traffic is Allowed**: 
- Local OS
- outbound network policy
- local NAT
- corporate proxy 

permit outbound connections to destination ports (e.g., port 80 for HTTP, port 443 for HTTPS).

**How Traffic is Blocked**: 
- Local anti-virus software
- corporate egress firewalls
- missing proxy configurations
- disabled NIC 

prevent the request from leaving the machine.
## [↑][packet inline] Client DNS resolution <a id='client-dns'></a>
The domain name (e.g., api.example.com) is translated into a routable IP address (e.g., 192.0.2.1).

**How Traffic is Allowed**: 
- The client queries a local resolver or public DNS server (e.g. Cloudflare 1.1.1.1 or Google 8.8.8.8)
- The resolver returns a valid IPv4 or IPv6 address.

**How Traffic is Blocked**: 
- DNS lookup failures (NXDOMAIN)
- DNS-based ad blockers/Pi-hole dropping the domain
- misconfigured DNS A/AAAA records break the path before connection attempts begin.


## [↑][packet inline] Provider infra <a id='provider'></a>

Once the destination IP address is known, packets traverse public routers to reach the hosting infrastructure (such as OVH, AWS, or DigitalOcean).

**How Traffic is Allowed**: 
- Cloud security groups
- Provider Network ACLs
- cloud edge firewalls 

explicitly permit inbound traffic on the targeted destination port.

**How Traffic is Blocked**: 
- Cloud firewalls drop incoming packets if rules do not permit traffic on that port (e.g., port 3000 left closed at the provider level).


## [↑][packet inline] Server Os <a id='server-os'></a>

Packets arriving at the physical or virtual network interface card (NIC) enter the server's Linux kernel networking stack.

**How Traffic is Allowed**:
- The host firewall (ufw, iptables, or nftables) contains an explicit rule allowing traffic on the destination port.
- The Linux routing table accepts the packet.
- A server process (like nginx, sshd, or algernon) is bound to 0.0.0.0:port or 127.0.0.1:port and listening on an open socket.

**How Traffic is Blocked**:
- Host firewall drops or rejects packets (Connection refused or Connection timed out).No service is bound to the target port
- The service is bound to 127.0.0.1 (localhost) while receiving external interface traffic.
- Reverse-path filtering (rp_filter)
- kernel routing policy issues 

drop the connection.


### todo

Here are the specific host OS mechanisms that can drop or block traffic:

- Raw `iptables` or `nftables` rules: 
- `UFW` is just a user-friendly frontend to `iptables` or `nftables` (veruify the sentence). 
- Linux Security Modules (`SELinux` (rhel os))/ `AppArmor`(debian os)): Mandatory access control policies can prevent the process from accepting network sockets on non-standard ports.
- TCP Wrappers (/etc/hosts.deny): **Legacy** host access control files can reject incoming socket connections based on IP or service.
- Kernel Routing / Reverse Path Filtering (`rp_filter`): The kernel drops packets if strict reverse path filtering determines the route back to the source client is invalid.

## [↑][packet inline] Server App <a id='server-app'></a>

Once the socket connection is accepted, the server application receives the HTTP request payload or SSH handshakes.

**How Traffic is Allowed**: 
- The application validates HTTP headers, API tokens, session cookies
- The SSH keys, granting access to the requested route or process.

**How Traffic is Blocked**: 
- The application returns HTTP status codes like 401 Unauthorized or 403 Forbidden and terminates or denies the request.

### todo
Here are the specific Server Application mechanisms that can drop or block traffic:

Network Binding Restrictions: the server (e.g. `algernon`, `nginx`, `caddy`) might be bound to `127.0.0.1` (loopback interface) instead of `0.0.0.0` (all public interfaces).


# Security Audit Matrix

Evaluating whether a port exposure configuration represents good operational hygiene or a security risk:

| Config Stage      | Status / rule                          | Security Assessment                    |
| ----------------- | -------------------------------------- | -------------------------------------- |
| Provider Firewall | Port `22` allowed | ✅ **Good** (if required for SSH access with key authentication) |
| Provider Firewall | Port `3000` exposed to `0.0.0.0/0` | ⚠️ **Risk** (Internal/dev application ports should not be publicly accessible) |
| Host Firewall      | Port `22` allowed | ✅ **Good** (allows access to system administration) |
| Host firewall      | `3000` blocked                         | ✅ Good **if 3000 shouldn't be public** |
| Host Firewall      | Port `3000` blocked on host | ✅ **Good** (prevents direct public access; forces traffic through a reverse proxy) |
| Network Interface  | Port reaches server interface | 🟡 **Neutral** (Standard transport behavior) |
| Listening Service  | Process actively listening | 🟡 **Neutral** (Requires authentication hardening) |
| App Authentication | Strict key/token requirement | ✅ **Good** (Zero-trust approach) |
| App Authentication | No authentication required | 🔴 **Critical Risk** (Publicly accessible unauthenticated service) |




# Todo

| Stage/Tool/System | Component | What can **ALLOW** the port/traffic | What can **BLOCK/DROP** the port/traffic |
| - | - | - | - |
| **Internet Client** | Client-side network | Outbound firewall/NAT allows connection | <li>Client firewall <li>corporate proxy <li>NAT <li>routing <li>ISP filtering |
| **VPS / Provider firewall** | Cloud/provider network firewall | Security Group / Network ACL / Provider Firewall rule allows destination port | <li>Provider firewall / Security Group / Network ACL denies or drops |
| **VPS Host firewall**              | Linux kernel firewall           | <li>`nftables`, `iptables` <li>firewall: `ufw` rule accepts packet | <li>`nftables`, `iptables` <li>firewall: `ufw` rule drops/rejects packet|
| **Network interface**              | NIC + Linux networking stack    | Packet arrives on the interface and routing accepts it | <li>Interface down <li>routing issue <li>policy routing <li>reverse-path filtering <li>etc. |
| **Listening service**              | <li>`sshd` <li>`algernon` <li>etc.        | Process is listening on the destination `IP:port` | <li>Nothing listening <li>wrong bind address <li>process unavailable → connection refused/timeout depending on path |
| **Authentication / authorization** | Service itself                  | Valid credentials/key/token + authorization rules | <li>Invalid credentials <li>denied user <li>ACL/application authorization |
| **Access granted**                 | Application/session             | Service establishes the session| Service rejects the request/session|
