[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ System][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[capability whatis]: https://man7.org/linux/man-pages/man7/capabilities.7.html

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a Capability][capability whatis]|externel

<h1 align="center">What is Linux Syscall</h1>

# Definition
- Aka. **Sys**tem **Call**
- a **request** made by a **process** to the Linux Kernel

# The nominal process

```
       USER PROCESS             SYSCALL INTERFACE             LINUX KERNEL              FILE / STORAGE
      (user space)                  (boundary)                (kernel space)

             |                           |                           |                          |
             |  open("/etc/passwd")       |                           |                          |
             |-------------------------->|                           |                          |
             |                           |  Enter kernel mode        |                          |
             |                           |-------------------------->|                          |
             |                           |                           |  Resolve file path       |
             |                           |                           |  Check permissions      |
             |                           |                           |                          |
             |                           |                           |  Access file if allowed |
             |                           |                           |------------------------->|
             |                           |                           |  File data / metadata   |
             |                           |                           |<-------------------------|
             |                           |  Return file descriptor   |                          |
             |                           |<--------------------------|                          |
             |  fd = 3 (example)         |                           |                          |
             |<--------------------------|                           |                          |
             |                           |                           |                          |
             |  read(fd, buffer, size)   |                           |                          |
             |-------------------------->|                           |                          |
             |                           |  Enter kernel mode        |                          |
             |                           |-------------------------->|                          |
             |                           |                           |  Obtain requested bytes |
             |                           |                           |------------------------->|
             |                           |                           |  Data (if needed)       |
             |                           |                           |<-------------------------|
             |                           |                           |  Copy bytes to buffer   |
             |                           |  Return byte count        |                          |
             |                           |<--------------------------|                          |
             |  Use data in buffer       |                           |                          |
             |<--------------------------|                           |                          |
             |                           |                           |                          |
```
**Responsability**

|Resource||
|-|-|
|USER PROCESS|Requests open() and read(); uses returned data.
|SYSCALL|Provides the entry mechanism into the kernel.
|LINUX KERNEL|<li>Resolves paths <li>checks access <li>manages file descriptors, <li>coordinates I/O, <li>returns results.
|FILE / STORAGE|<li>Holds file contents <li>data may come from cache


**Notes**
- If opening is denied, the kernel returns an error (e.g. EACCES) instead of a file descriptor. The process receives the error.
- `open()` 
    - opens the file and returns a descriptor; 
    - Does not read the contents. 
- `read()`: requests the contents through that descriptor.


```
🧑‍💻 USER (a process)
 │
 │  request → "open /etc/passwd and read it"
 │
 ▼
📞 SYSCALL  (open, read, write, ...)
 │
 │  process asks the KERNEL to do it
 │
 ▼
🐧 LINUX KERNEL
 │
 │  checks: does this process have permission?
 │
 ▼
📂 DATA (file, device, socket, memory)
```

The kernel's decision is based on:
```
🐧 KERNEL checks access
 │
 ├── 👤 WHO is requesting access?
 │      → Process credentials: UID, GID, supplementary groups
 │
 ├── 📁 WHAT operation is requested, on which object?
 │      → Read /etc/passwd
 │      → File identity and access-control metadata: owner, group, permission bits, ACLs
 │
 └── 🔐 WHAT/DO additional security rules allow it?
        │
        ├── Linux Capabilities → 
        ├── SELinux  → Is this access allowed by policy?
        ├── AppArmor → Does the process's profile allow it?
        └── Other LSMs → Apply their relevant security checks
```