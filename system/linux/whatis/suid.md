[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ System][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[README]:  ./README.md

<h1 align="center">What is SUID</h1>


# Definition
- When a binary file has the SUID bit set, 
- anyone who runs that program executes it with the permissions of the file's owner (which is often root) 
- rather than their own user permissions.

# USage
Other SUID Use Cases (Different from "root-owned file I can't touch")

---

## 0. **The Standard Case: modify a root-owned file you can't touch**

> **Pattern:** The file belongs to root, you can't write it directly, so you use a SUID tool that writes it for you — within the limits of its code.

| Resource (root-owned) | SUID tool | What it does |
|---|---|---|
| `/etc/passwd` | `/usr/bin/passwd` | Update your password field |
| `/etc/shadow` | `/usr/bin/passwd` | Write the new hash |
| `/etc/passwd` | `/usr/bin/chsh` | Change your login shell |
| `/etc/passwd` | `/usr/bin/chfn` | Change your GECOS info |
| `/etc/group` | `/usr/bin/gpasswd` | Change group membership |
| `/etc/gshadow` | `/usr/bin/gpasswd` | Change group password |
| `/var/spool/cron/` | `/usr/bin/crontab` | Install your crontab |
| `/etc/sudoers` | `/usr/bin/sudo` (via `visudo`) | Edit sudo rules |

This is the **textbook case** — `/etc/passwd` and `/etc/shadow` are the canonical examples.

## 1. **Access a hardware device**
Not a file you edit — a **device** you need to talk to.

| Device | Owner | SUID tool | Why |
|---|---|---|---|
| `/dev/snd/*` | root/audio | (historically) | Play sound |
| raw sockets | kernel | `ping` | Send ICMP |
| `/dev/net/tun` | root | `openvpn` (sometimes) | Create VPN tunnel |

Here the "resource" is **hardware**, not a config file.

---

## 2. **Perform a privileged *operation* (no file involved)**

The resource isn't a file — it's a **kernel operation** gated by privilege.

No file is modified — the tool just needs root *capability* to do something.

| Tool | What it does as root |
|---|---|
| `ping` | Opens a raw socket (needs `CAP_NET_RAW`) |
| `mount` | Calls the `mount()` syscall |
| `su` | Switches UID |
| `newgrp` | Changes group membership |
| `unix_chkpwd` | Verifies a password for a non-root caller |

The resource isn't a file — it's a **kernel operation** gated by privilege.

---

## 3. **Read something you're not allowed to read**
Opposite of "modify" — it's **read access**.

| Tool | Reads |
|---|---|
| `sudo -l` | `/etc/sudoers` |
| `passwd -S` | `/etc/shadow` (status only) |
| `gpasswd` | `/etc/gshadow` |

---

## 4. **Act as a *different* user (not root)**
SUID doesn't have to mean root!

```bash
$ ls -l /some/tool
-rwsr-xr-x 1 games games ... /usr/games/fortune
                 ↑
        runs as 'games', not root
```

Use case: let anyone run a tool that needs to write to `/var/games/` (owned by `games`).

---

## 5. **Grant a *shared* resource among users**
Classic example: `write` / `wall` (message other users).

- `/dev/tty*` belongs to each user
- A SUID tool (owned by `tty` or root) can write to **other users' terminals**
- Without SUID, you could only write to your own

---

## 6. **Perform an action *on behalf of* a service**
Not "modify a file" — **trigger a service**.

- `systemctl` via `polkit` (not SUID, but same idea)
- `at` / `batch` — schedule a job that runs later as you
- `crontab -e` — write to `/var/spool/cron/` (root-owned)



---

## Summary Table

| # | Pattern | Canonical example |
|---|---|---|
| 0 | Modify a root file I can't write** | `/etc/passwd` via `passwd` |
| 1 | Access a device | `ping` (raw socket) |
| 2 | Perform a privileged operation | `mount` |
| 3 | Read a root-only file | `sudo -l` on `/etc/sudoers` |
| 4 | Act as another non-root user | `fortune` as `games` |
| 5 | Write to another user's tty | `wall`, `write` |
| 6 | Trigger a service / schedule | `at`, `crontab` |

## Summary: Different Axes

| Axis | Example |
|---|---|
| **What's accessed** | file vs device vs socket vs syscall vs another user's tty |
| **What's done** | write vs read vs open vs switch-user vs schedule |
| **Who it runs as** | root vs another system user vs a service account |

Your original pattern:
> "root-owned file, I need to **modify** it → SUID tool"

is just **one cell** in this bigger table.

---



## One-Line Contrasts

- **Standard pattern (0):** I can't *write* `/etc/passwd` → `passwd` writes it for me. ✅
- **Device pattern (1):** I can't *open* a raw socket → `ping` opens it for me.
- **Operation pattern (2):** I can't *call* `mount()` → `mount` calls it for me.
- **Read pattern (3):** I can't *read* `/etc/sudoers` → `sudo -l` reads it for me.
- **Other-user pattern (4):** I can't *act as `games`* → `fortune` does.
- **Shared-resource pattern (5):** I can't *write to your tty* → `wall` can.
- **Service (6):** I can't *install a cron job* → `crontab` does.