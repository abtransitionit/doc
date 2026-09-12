[//]: #(home)
[home]: ../whatis/ep.md


[//]: #(functional)
[chain whatis]: ../whatis/chain.md

[←][home] 


Related topics

| Topic | Location | Kind |
|---|---|---|
|[What is Tool chain][chain whatis]|internal|


**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">How-to Omt Ovh</h1>




# Configure the chain of tool
this configuration consist of allowing a client request to hit a server installed on a OVH VPS by configuring each tool on the [chain of tool][chain whatis].

**Define the inputs**:
- domain name is `omt.ovh`
- vps ip is : `51.210.10.195`
- server `algernon` listen on port `3000`

Create the following path for a request:

```
client request to domainName/... → OVH DNS Server → Vps → local web server → App
```

Configure the following:

||Src|→|Dst|||
|-|-|-|-|-|-|
|1|client request to ${domainName}/...||OVH DNS Server|
|2|OVH DNS Server||Vps|<li>create a "A" DNS record|
|3|Vps||Local web server|
|4|Local web server||App|




# step 1: get the Vps IP
```
51.210.10.195
```

# step 2: Update the DNS zone of the domain name

| Type | Sub-domaine | Cible           | Note |
| ---- | ------------ | -------------- | - |
| A    | `@`          | `${VPS_IP}` | request to `${domainName}` is captured
| A    | `www`        | `${VPS_IP}` | `www.${domainName}` is captured

# step 3: Check the path

- `ping [www.]omt.ovh`
- `nslookup [www.]omt.ovh`
- `dig [www.]omt.ovh`

# Step 4: check the port locally
**is the port listened by a server (on the Vps) ?**

```sh
# on the VPS - list all ports that are listened by a server
sudo ss -tlnp
```


Meaning:
|     Port | Service                                | Internet-accessible? | who can acees it | Note                       |
| -------: | -------------------------------------- | ---------------------| ---------------------- | -|
|   **22** | SSH (`sshd`)                           | ⚠️ Yes | world     | if tools/config/firewall/security group allows it |
|   **53** | Local DNS resolver (`systemd-resolve`) | ❌ No  | Localhost | |
| **3000** | `algernon` application                 | ⚠️ Yes | world     | if tools/config/firewall/security group allows it |

**Is a firewall allowing or blocking a port (on the Vps) ?**

```sh
# on the VPS - list all ports that are listened by a server
sudo ufw status
```

output:
```sh
# the firwall UFW is not activated - no port is blocked unless another port or tool do this job
Status: inactive
```

sudo iptables -L -n -v

# Step 4: check the port remotely
- is the port accessible from external world ?

```sh
# on an external client - test a port is accessible via TCP
nc -zv omt.ovh 80
nc -zv omt.ovh 443
nc -zv omt.ovh 3000

# on an external client - test a port is accessible via TCP
curl -v http://omt.ovh
curl -v https://omt.ovh
```

example output
```powershell
> nc -zv omt.ovh 80 # no listening or firewall blocked
nc: connectx to omt.ovh port 80 (tcp) failed: Connection refused

> nc -zv omt.ovh 443 # no listening or firewall blocked
nc: connectx to omt.ovh port 443 (tcp) failed: Connection refused

> nc -zv omt.ovh 3000 # no listening or firewall blocked
Connection to omt.ovh port 3000 [tcp/hbci] succeeded!
```

