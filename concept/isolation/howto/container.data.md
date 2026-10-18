[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[cgroup whatis]: ../whatis/container.cgroup.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is Cgroup][cgroup whatis]|

<h1 align="center">How-to for Container Data access</h1>

The concept of Container Data access


 Great — starting **STEP 0** and **STEP 1** now. Slow and simple.


# Inside the container

The kernel (just) gives the process a **different view**.

```
🐧 LINUX KERNEL
 │
 └── 📦 CONTAINER  (a group of processes with isolation)
      │
      ├── 🔢 PID namespace   → "I'm PID 1, I see only my processes"
      │
      ├── 🌐 NET namespace   → "I have my own network"
      │
      ├── 🏷️  UTS namespace  → "I have my own hostname"
      │
      ├── 👤 USER namespace  → "I have my own users" (sometimes)
      │
      └── 📁 MNT namespace   → "I have my own filesystem view"   ← DATA ACCESS
```

**Focus on 📁 MNT namespace** — that's what controls what data the process *sees*.

```
📁 MNT NAMESPACE (inside the container)
 │
 ├── /                → container's own root (from an image)
 │    ├── /bin        → from image
 │    ├── /etc        → from image
 │    ├── /app        → the application
 │    └── /data       → MAYBE a mounted volume (we'll see in STEP 7)
 │
 └── ⚠️  The process CANNOT see:
      ├── ❌ the host's /home
      ├── ❌ the host's /var/log
      ├── ❌ other containers' filesystems
      └── ❌ the real /etc/passwd of the host
```
**Focus on 📁 USER namespace** — that's what controls 

```
📦 CONTAINER
 │
 ├── 👑 root (UID 0)         ← privileged (without a user namespace is ALSO UID 0 on the HOST)
 │
 └── 🧑‍💻 appuser (UID 1000)  ← unprivileged ← THIS STEP
      (or 1001, 1002, ... — any non-zero UID)
```

**Rule of thumb:** **UID ≠ 0 → unprivileged.** The kernel strips special powers from any non-root UID.

**This is the crucial part:** without a user namespace, **UID 0 inside = UID 0 outside**. Same number, same kernel.


**Crucial point:** the container's `/` is **not** the host's `/`. It's a **separate mount tree**. Two different worlds, one kernel.

```

   HOST view                      CONTAINER view
┌──────────────────┐          ┌──────────────────┐
│  /               │          │  /               │
│  ├── bin         │          │  ├── bin         │ 
│  ├── etc         │          │  ├── etc         │ 
│  ├── home        │          │  ├── home        │ 
│  ├── var         │          │  ├── var         │ 
│  ├── usr         │          │  ├── usr         │ 
│  ├── tmp         │          │  ├── tmp         │ 
│  └── srv         │          │  └── app         │  ← added by image
│  (real files)    │          │  (image files)   │
└──────────────────┘          └──────────────────┘
        ↑                              ↑
        └──── same NAMES, DIFFERENT FILES ────┘
```

# The Nominal process inside the container

```
🧑‍💻 PROCESS inside container
 │
 │  open("/etc/passwd")
 │
 ▼
📞 SYSCALL
 │
 ▼
🐧 KERNEL resolves the path
 │
 │  ⚠️  resolves it in the CONTAINER's MNT namespace
 │
 ▼
📂 the IMAGE's /etc/passwd   (NOT the host's)
```

# Host vs Container

```
🐧 ONE KERNEL
 │
 ├── 📁 MNT namespace of HOST      → mount tree #1
 │    └── /etc/passwd  → host's real file
 │
 └── 📁 MNT namespace of CONTAINER → mount tree #2
      └── /etc/passwd  → image's file
```



```
┌──────────────────────────────────────────────────────┐
│                    ONE KERNEL                        │
│                                                      │
│   📁 HOST mount tree        📁 CONTAINER mount tree  │
│   ┌───────────────┐         ┌───────────────┐        │
│   │ /home/you     │         │ /app          │        │
│   │ /etc/passwd   │         │ /etc/passwd   │        │
│   │ /var/log      │         │ /var/log      │        │
│   │ /srv/data     │         │ /data         │        │
│   └───────────────┘         └───────────────┘        │
│         ▲                          ▲                 │
│         │                          │                 │
│         │   ⛔ no visibility by default ⛔            │
│         └──────────────────────────┘                 │
│                                                      │
└──────────────────────────────────────────────────────┘
```


```
🧑‍💻 PROCESS inside container          🧑‍💻 PROCESS on host
 │                                      │
 │ open("/etc/passwd")                  │ open("/etc/passwd")
 ▼                                      ▼
📞 syscall                             📞 syscall
 │                                      │
 ▼                                      ▼
🐧 KERNEL resolves in                  🐧 KERNEL resolves in
   CONTAINER MNT namespace                HOST MNT namespace
 │                                      │
 ▼                                      ▼
📂 image's file                        📂 host's real file
```

Here's **STEP 3**.


# Unprivileged user *inside* the container


## What unprivileged user CAN do

```
🧑‍💻 appuser (UID 1000)
 │
 ├── ✅ read/write files it OWNS in the container
 │      e.g. /app/data written by appuser
 │
 ├── ✅ read files marked world-readable in the image
 │      e.g. /etc/passwd, /usr/bin/*
 │
 ├── ✅ use the network (if the container has one)
 │
 ├── ✅ open ports > 1024
 │
 └── ✅ run processes as long as cgroup limits allow
```

---

## What unprivileged user CANNOT do

```
🧑‍💻 appuser (UID 1000)
 │
 ├── ❌ read /etc/shadow          (needs root)
 │
 ├── ❌ write to /etc, /usr, /bin (owned by root)
 │
 ├── ❌ chown files to another user
 │
 ├── ❌ mount filesystems
 │
 ├── ❌ load kernel modules
 │
 ├── ❌ access raw devices (/dev/sda)
 │
 ├── ❌ open ports < 1024
 │
 └── ❌ use privileged capabilities (CAP_SYS_ADMIN, ...)
```

**Why?** The kernel's **capability system** gives those powers only to **root** (or to processes explicitly granted them).


## kernel decision for an unprivileged user

```
🧑‍💻 appuser (UID 1000) inside container
 │
 │  open("/etc/shadow")
 │
 ▼
📞 syscall
 │
 ▼
🐧 KERNEL decides:
 │
 ├── 👤 WHO?   → UID 1000, not root, no CAP_DAC_READ_SEARCH
 │
 ├── 📁 WHAT?  → /etc/shadow, mode 0640, owner root:shadow
 │
 └── 🔐 RULES? → unprivileged user cannot read it
 │
 ▼
❌ DENIED
```


```
📁 MNT namespace → "Can I SEE this path?"       (visibility)
👤 UID / caps    → "Can I OPEN this path?"       (permission)
```



## 📊 Table — unprivileged user inside the container

| Target | Visible? (MNT ns) | Accessible? (UID/caps) | Result |
|--------|-------------------|------------------------|--------|
| `/app/data` (owned by appuser) | ✅ | ✅ | 🟢 allowed |
| `/etc/passwd` (readable, in image) | ✅ | ✅ | 🟢 allowed |
| `/etc/shadow` (root-only, in image) | ✅ | ❌ | 🔴 denied |
| `/home/you` on the **host** | ❌ | — | 🔴 denied (not even visible) |
| `/var/log/syslog` on the **host** | ❌ | — | 🔴 denied (not even visible) |



# Root inside the container (no user namespace)

- the container runs as **UID 0 inside**, 
- **no user namespace** is in play. This is the default for most containers.



## 🧱 The kernel's decision for root inside

```
👑 root (UID 0) inside container
 │
 │  open("/etc/shadow")
 │
 ▼
📞 syscall
 │
 ▼
🐧 KERNEL decides:
 │
 ├── 👤 WHO?   → UID 0 → has ALL capabilities
 │
 ├── 📁 WHAT?  → /etc/shadow in container's mount tree
 │
 └── 🔐 RULES? → root can read it
 │
 ▼
✅ ALLOWED
```

Root inside the container **can do almost anything inside its own mount tree**:

```
👑 root inside container
 │
 ├── ✅ read/write ANY file in the container's mount tree
 │      (even root-owned ones)
 │
 ├── ✅ chown, chmod anything
 │
 ├── ✅ mount filesystems (within its namespace)
 │
 ├── ✅ open ports < 1024
 │
 ├── ✅ use capabilities (CAP_CHOWN, CAP_NET_ADMIN, ...)
 │
 └── ✅ kill any process it can see (its own PID namespace)
```


```
👑 root inside container
 │
 ├── 🚧 Still can't SEE the host's files
 │      → MNT namespace still hides /home/you
 │
 ├── 🚧 Still can't SEE host processes
 │      → PID namespace hides them
 │
 ├── 🚧 Still can't SEE host network
 │      → NET namespace isolates it
 │
 └── 🚧 Still capped by cgroups
      → CPU/memory limits still apply
```

So root inside is **king of its own small world** — but that world is **isolated by namespaces**.

```
👑 root inside container
 │
 ├── INSIDE:  feels like real root
 │      → can do anything in its mount tree
 │      → can use capabilities
 │
 └── OUTSIDE: is real UID 0 on the host kernel
      → ⚠️  if it escapes the namespaces,
          it IS root on the host
```

**This is why the escape risk matters.** The namespaces are the *only* thing standing between "root in a box" and "root on your machine."


Root inside can't see host files by default — but if **anything bridges the two**, root inside gets full power over it:

```
👑 root inside container
 │
 ├── 🔗 bind mount:  /host/data → /data  (mounted at container start)
 │      → root inside can read/write /host/data as root
 │
 ├── 🔗 volume:      named volume mounted at /var/lib/app
 │      → root inside owns it fully
 │
 ├── 🔗 docker socket: /var/run/docker.sock mounted
 │      → ⚠️  root inside can control the host's container runtime
 │
 └── 🔗 host PID namespace shared (--pid=host)
      → root inside sees and can signal host processes
```

- **Without** a bridge → no access. 
- **With** a bridge → root inside


## 📊 Table — root inside the container (no user namespace)

| Target | Visible? | Accessible? | Result |
|--------|----------|-------------|--------|
| Any file in the container's mount tree | ✅ | ✅ | 🟢 full access |
| `/etc/shadow` in the image | ✅ | ✅ | 🟢 readable |
| `/home/you` on the **host** | ❌ | — | 🔴 not visible |
| A bind-mounted host folder | ✅ | ✅ | 🟢 full root access |
| Host processes | ❌ (PID ns) | — | 🔴 not visible |
| Host processes with `--pid=host` | ✅ | ✅ | 🟢 can signal/kill them |

---

## 🆚 Unprivileged vs root inside — side by side

```
🧑‍💻 appuser (UID 1000)          👑 root (UID 0)
 │                               │
 ├── ✅ own files                ├── ✅ ANY file in container
 ├── ✅ world-readable           ├── ✅ chown / chmod anything
 ├── ❌ /etc/shadow              ├── ✅ mount
 ├── ❌ mount                   ├── ✅ ports < 1024
 ├── ❌ ports < 1024            ├── ✅ all capabilities
 ├── ❌ capabilities            └── ✅ kill any visible process
 └── ❌ chown
```

**Root inside is dramatically more powerful *inside* — but still boxed by namespaces for the *outside*.**

---

## 🔑 The key insight of STEP 4

```
🔑 Root inside (no userns):
   ├── UID 0 inside  =  UID 0 on the host kernel
   ├── Namespaces still box it in
   └── ⚠️  Any bridge to the host → root inside = real root
```

This is why "run as non-root inside" is a common security recommendation — it removes the second half of the risk **even if a bridge exists**.

---

## ✅ Recap of STEP 4

```
👑 Root inside = UID 0, all capabilities
🧱 Still trapped by namespaces (MNT, PID, NET) and cgroups
🚪 Any bridge to host (volume, bind mount, socket) → full root power over it
⚠️  Without a user namespace, UID 0 inside = UID 0 on the host
```

---

**Next — STEP 5:** 👑 + 👤 **Root inside WITH a user namespace** — where "UID 0 inside" maps to a *non-zero* UID on the host. This is the modern rootless / userns-remap case.

Say **go** and I'll continue. 👍