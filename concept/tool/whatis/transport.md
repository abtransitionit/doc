[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Tool][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[language list]:   /language/README.md
[language whatis]: /concept/language/whatis/ep.md
[ssg list]: ../list/ssg.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Language][language whatis]|internal| 
|[List of languagess][language list]|internal| list |



<h1 align="center">What is Transport</h1>

The concept of tool

---

# Node Reachability / addressing

How that node is reached or looked up. whether 
- that's an SSH
- that's an alias in ~/.ssh/config ("o1u")
- that's a hostname
- that's a IP
- that's a local access.

# Transport 

The execution mechanism itself
- local (exec.CommandContext)
- ssh (running the ssh binary)

Notice that if you already created tr for "o1u", attaching Transport: tr to target.Node is essentially binding a transport instance to that node — which is why passing "o1u" to ssh.New(...) and setting Address: "o1u" on target.Node felt redundant or confused.

# Example

Here is a broad, practical breakdown of transport / execution mechanisms across systems management, orchestration, and remote execution tools:

| Transport Mechanism | How It Works | Typical Use Cases & Trade-offs |
| --- | --- | --- |
| **Local (`os/exec` / syscalls)** | Runs commands directly in the current host OS process/namespace | Local CLI execution, single-host agents, default fallback |
| **OpenSSH CLI (`ssh` binary)** | Spawns system `ssh` client, honoring `~/.ssh/config`, keys, agents, `ProxyJump` | Ops/infra automation, reusing existing SSH config & bastion hops |
| **Go Native SSH (`golang.org/x/crypto/ssh`)** | Speaks SSH protocol directly in-process in Go (channels, sessions, SFTP) | Embedded SSH clients, programmatic auth/forwarding without spawning `ssh` |
| **SSH Multiplexing / ControlMaster** | Reuses an existing persistent SSH control socket across many commands | High-frequency command execution over SSH to avoid repeated handshakes |
| **Container Runtimes (`docker exec`, containerd, CRI)** | Enters a running container's namespaces via daemon API or CLI | Sidecar/container inspection, debugging or mutating inside containers |
||
||
||
| **Kubernetes API (`kubectl exec` / SPDY / WebSockets)** | Streams stdin/stdout/stderr to a Pod container via API server | Cloud-native workload/node operations inside Kubernetes clusters |
||
||
| **PowerShell Remoting over SSH** | Runs PowerShell subsystems over SSH transport | Cross-platform PowerShell management, modern Windows/Linux remoting |
||
||
| **WinRM (HTTP/HTTPS / WS-Man)** | Sends XML/SOAP or PowerShell remoting payloads over HTTP/HTTPS (5985/5986) | Windows targets, agentless Windows configuration management |
||
||
| **eBPF / Kernel Ringbuf / Netlink / Syscall IPC** | Kernel-to-user-space or user-to-kernel structured channels | Low-overhead telemetry, network/firewall/route/module inspection |
||
||
| **mosh (Mobile Shell)** | UDP-based roaming session over an initial SSH handshake | Unstable networks, roaming laptops, high-latency interactive links |
| **gRPC / HTTP(S) / REST RPC** | Structured RPC or JSON/Protobuf calls to a remote daemon/service | Agent-based fleet control, microservices, typed control planes |
| **Message Queues / Brokers (MQTT, AMQP, NATS, Kafka)** | Publishes commands/jobs to topics/queues consumed by remote workers | Asynchronous jobs, disconnected/edge fleets, fan-out commands |
| **Hypervisor / Guest Agents (QEMU Guest Agent, VMware tools, virtio-serial)** | Communicates over virtio-serial/vsock/hypervisor RPC without host IP networking | VM provisioning, IP discovery, guest commands when network isn't up |
| **Serial Console / IPMI / iDRAC / iLO / Redfish** | Out-of-band BMC/serial/HTTPS APIs independent of host OS state | Bare-metal power control, BIOS/firmware, recovery when OS is down |
| **Cron / systemd / Salt / Ansible Pull / GitOps Agent** | Target periodically pulls desired state or runs scheduled local units | Drift reconciliation, disconnected/NAT-ed nodes, declarative convergence |


# Usage

Here is a concrete view of how each transport mechanism actually looks in practice when running a command or operation:

| Transport Mechanism | Concrete Real Usage Example |
| --- | --- |
| **Local (`os/exec` / syscalls)** | `exec.CommandContext(ctx, "cat", "/proc/modules").Output()` — executes directly on the machine running your Go binary with no network hop. |
| **OpenSSH CLI (`ssh` binary)** | `exec.CommandContext(ctx, "ssh", "-o", "BatchMode=yes", "o1u", "cat /proc/modules")` — delegates connection setup, `~/.ssh/config`, keys, and `ProxyJump` to your system `ssh` client. |
| **Go Native SSH (`golang.org/x/crypto/ssh`)** | `client, _ := ssh.Dial("tcp", "51.210.10.195:22", cfg); sess, _ := client.NewSession(); out, _ := sess.Output("cat /proc/modules")` — speaks the SSH wire protocol directly inside your Go process without spawning `ssh`. |
| **SSH Multiplexing / ControlMaster** | `~/.ssh/config` sets `ControlPath ~/.ssh/cm-%r@%h:%p` & `ControlPersist 10m`, then repeated `ssh o1u "cat /proc/modules"` calls reuse the already-authenticated TCP/SSH session instead of handshaking every time. |
| **Container Runtimes (`docker exec`, containerd, CRI)** | `docker exec my-nginx-container cat /proc/modules` (or CRI `ExecSync` RPC to `containerd`) — enters the running container's process/mount/network namespaces to run the command inside it. |
| **Kubernetes API (`kubectl exec` / SPDY / WebSockets)** | `kubectl exec -n prod pod/api-7d9c -- cat /proc/modules` — sends an authenticated HTTPS/SPDY/WebSocket stream to `kube-apiserver` -> `kubelet` -> container runtime to run inside the Pod. |
| **PowerShell Remoting over SSH** | `ssh -o Subsystem=powershell o1u "Get-Service"` or `Invoke-Command -HostName o1u -ScriptBlock { Get-Service }` — uses SSH as the encrypted tunnel while speaking PowerShell remoting/serialization on the remote side. |

Notice the key takeaway across all seven: **the command/intent (`cat /proc/modules`, `Get-Service`) stays the same, while the transport changes *how* bytes get there and execute.**

# Usage

Here is the 3-column table with the concrete prerequisites needed for each transport mechanism to actually work in practice:

| Transport Mechanism | Concrete Real Usage Example | Prerequisites ("So It Works") |
| --- | --- | --- |
| **Local (`os/exec` / syscalls)** | `exec.CommandContext(ctx, "cat", "/proc/modules").Output()` — executes directly on the machine running your Go binary with no network hop. | Target binary/file (`cat`, `/proc/modules`) exists locally; process has required OS permissions/capabilities. |
| **OpenSSH CLI (`ssh` binary)** | `exec.CommandContext(ctx, "ssh", "-o", "BatchMode=yes", "o1u", "cat /proc/modules")` — delegates connection setup, `~/.ssh/config`, keys, and `ProxyJump` to your system `ssh` client. | `ssh` binary in `PATH`; reachable target & SSH daemon (`sshd`); `~/.ssh/config` alias configured; key/agent auth working (or `BatchMode=no` if interactive); host key trusted (`known_hosts`). |
| **Go Native SSH (`golang.org/x/crypto/ssh`)** | `client, _ := ssh.Dial("tcp", "51.210.10.195:22", cfg); sess, _ := client.NewSession(); out, _ := sess.Output("cat /proc/modules")` — speaks the SSH wire protocol directly inside your Go process without spawning `ssh`. | Direct TCP reachability to `host:port` (or manually chained dialer); explicit `HostKeyCallback` (e.g., parsed `known_hosts`); loaded private key / `ssh-agent` socket or password; Go code parses `~/.ssh/config` itself if using aliases. |
| **SSH Multiplexing / ControlMaster** | `~/.ssh/config` sets `ControlPath ~/.ssh/cm-%r@%h:%p` & `ControlPersist 10m`, then repeated `ssh o1u "cat /proc/modules"` calls reuse the already-authenticated TCP/SSH session instead of handshaking every time. | Everything in **OpenSSH CLI** plus `ControlMaster` & `ControlPath` configured in `~/.ssh/config` (or `-o` flags); writable control socket directory (`~/.ssh` or `/run/user/...`); an initial connection established to open the master socket. |
| **Container Runtimes (`docker exec`, containerd, CRI)** | `docker exec my-nginx-container cat /proc/modules` (or CRI `ExecSync` RPC to `containerd`) — enters the running container's process/mount/network namespaces to run the command inside it. | Container runtime running (`dockerd` / `containerd`); target container in `running` state; permission to access Docker socket / CRI endpoint (`root` or `docker` group / TLS certs); target binary (`cat`) present inside the container image. |
| **Kubernetes API (`kubectl exec` / SPDY / WebSockets)** | `kubectl exec -n prod pod/api-7d9c -- cat /proc/modules` — sends an authenticated HTTPS/SPDY/WebSocket stream to `kube-apiserver` -> `kubelet` -> container runtime to run inside the Pod. | Valid `kubeconfig` / bearer token / client cert; reachability to `kube-apiserver`; RBAC permission (`pods/exec` `create` on namespace/pod); Pod in `Running` phase with container ready; command binary present inside the container. |
| **PowerShell Remoting over SSH** | `ssh -o Subsystem=powershell o1u "Get-Service"` or `Invoke-Command -HostName o1u -ScriptBlock { Get-Service }` — uses SSH as the encrypted tunnel while speaking PowerShell remoting/serialization on the remote side. | All **OpenSSH CLI** prerequisites on client; PowerShell (`pwsh` or Windows PowerShell) installed on remote host; remote `sshd_config` defines `Subsystem powershell ...` (and `pwsh` remoting module available for `Invoke-Command`). |

# Idea


| Target Case | What It Means | How You Reach It & Transport Chain |
| --- | --- | --- |
| **Local VM** | The host OS running your CLI/tool itself | **Direct (`local`):** runs straight on the host via `os/exec` (no SSH hop). |
| **Remote VM** | Another VM/host reached over SSH | **SSH (`ssh`):** runs on the target via `ssh <alias> <cmd>` (using `~/.ssh/config` aliases like `o1u`, `o2a`). |
| **Local Container** | A container running on the same host as your CLI | **Local + Container runtime:** runs locally on the host using the container runtime (`docker exec ...`, etc.). |
| **Remote Container** | A container running inside a remote VM | **SSH + Container runtime:** first reaches the remote VM over SSH, then runs the container exec command on that VM (`ssh <alias> docker exec <container> <cmd>`). |

### Why This Clarifies Node Access vs. Transport

* **Target / Node describes *what* you are targeting:**
* Kind/type: VM vs. Container
* Location/scope: Local vs. Remote (e.g., alias `o1u`, optional container name/ID when targeting a container)


* **Transport describes *how* the command is carried:**
* `local` (`os/exec`)
* `ssh` (system `ssh` binary)
* `container` runtime (`docker exec` / runtime CLI), either directly on the local host or chained after `ssh` on a remote VM.



Notice that **Remote Container** is just composing two steps you already have: `ssh` to get to the remote VM, and container exec to step into the container on that VM.

# Transport as Chain

**`sdk/target`** = **Who / what / where** you are addressing.  No connection mechanics or execution details.
- identity + logical target shape: 
- should stays declarative and clean:
    - A target describes **what** you want to reach, **not whether** you're using OpenSSH CLI, ControlMaster, `docker exec`, or `nerdctl exec`.
        - `o1u` a VM
        - `web-1` on `o1u`
    - Local VM: `local`
    - Remote VM : `ssh` (target alias `o1u`)
    - Local Container : `local` + container exec (target container `web-1`)
    - Remote Container : `ssh` (target alias `o1u`) + container exec (target container `web-1`)

**`sdk/transport`** = **How** bytes/commands move and execute 
- should stays composable
- `local`
- `ssh`
- composing/chaining like `ssh` -> `container` for a Remote Container.

**`sdk/drivers`** = **How** bytes/commands move and execute. (`drivers/kernel/module`, etc.)
- should stay untouched
- They should never import `sdk/target` or `sdk/transport`.

## Where Each Piece Lives

| Concept | Belongs In | Concrete Example |
| --- | --- | --- |
| **Target definition** (`Kind`: VM vs. Container, `Host`/alias like `o1u`, optional `Container` name/ID) | **`sdk/target`** | A target representing <li>a container named `web-1` on remote VM `o1u` <li>a VM `o1u`<li> local host/container. |
| **Execution mechanism** (`local` via `os/exec`, `ssh` via system `ssh` binary, container exec) | **`sdk/transport`** | <li>`local` runs `cmd` directly <li> `ssh` runs `ssh o1u <cmd>` <li> remote container combines SSH to `o1u` + container exec for `web-1`. |
| **Connection parameters** (`HostName`, `User`, `Port`, `IdentityFile`, `ProxyJump`) | **`~/.ssh/config`** (consumed by `sdk/transport/ssh`) | Never duplicated in `sdk/target` structs or `main.go`. |

