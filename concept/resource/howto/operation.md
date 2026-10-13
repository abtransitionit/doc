[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ resource][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[res whatis]:  /concept/resource/whatis/ep.md
[ope list]:    ../list/operation.md
[host whatis]: /concept/machine/whatis/host.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Host][host whatis]|see|
|[What is a Resource][res whatis]|see|
|[List of Operations][ope list]|see|


<h1 align="center">How-to for Operation</h1>



# How to discover Operations/Mechanisms on a resource

1. Write the goal you want to achive in plain language.
1. Name the **resource** you want to act/operate on.
1. Name all Nearer or broader **actions**
1. Fill in every column of a row.
1. Find other **ways** to do the same action => 1 per row
1. Create the tree view 
  - **Action → Target → Mechanism**
  - **Target → Action → Mechanism**
1. Done.

| Sentence | What/Resource | Action | Where/Target | How/Command | Mechanism |
| -------- | -------- | ------ | ------ | ------- | --------- |
| Install `nginx` on a VM. | a package | install | the VM | `apt install nginx` | `apt` |
| Start `nginx` on a VM. | a service | start | the VM | `systemctl start nginx` | `systemctl` |
| Delete `/etc/nginx/nginx.conf` | a file | delete | the VM | `rm /etc/nginx/nginx.conf` | `rm` |

# Use case 01

- **Step 1 — sentence**: Add a module to a Linux VM OS kernel.
- **Step 2 — Resource**: Kernel:module
- **Step 3 — Action**: add/load/install
- **Step 4 — Row**:

| Sentence | Action | What/Resource | Where/Target | How/Command | Mechanism |
| -------- | ------ | -------- | ------ | ------- | --------- |
| Load a kernel module for the whole VM (until reboot). | load | a kernel module | the Linux VM | `modprobe <module>` | `modprobe` |

- **Step 5 — Other ways**: 

| Sentence | Action | What/Resource | Where/Target | How/Command | Mechanism |
| -------- | ------ | -------- | ------ | ------- | --------- |
| Build a kernel module from source. | build | a kernel module | the Linux VM | `make -C /lib/modules/$(uname -r)/build M=$PWD` | `make` |
| Install a prebuilt kernel module package. | install | a package | the Linux VM | `apt install <module>-dkms` | `apt` |
| Load a kernel module for the whole VM (until reboot). | load | a kernel module | the Linux VM | `insmod <module>.ko` | `insmod` |
| Enable a kernel module across reboots. | enable | a kernel module | the Linux VM | `echo <module> >> /etc/modules-load.d/<name>.conf` | shell |



**Tree view**:

```sh
# Action → Target → Mechanism
Operation: make a kernel module available and active
├── Action: build
│   └── Target: a Linux VM
│       ├── Mechanism: make
│       └── ...
├── Action: install
│   └── Target: a Linux VM
│       ├── Mechanism: apt
│       └── ...
├── Action: load
│   └── Target: a Linux VM
│       ├── Mechanism: modprobe
│       └── Mechanism: insmod
└── Action: enable
    └── Target: a Linux VM
        ├── Mechanism: shell
        └── ...
```

```sh
# Target → Action → Mechanism
Resource: a kernel module
└── Target: a Linux VM     ← single
    ├── Action: build
    │   └── Mechanism: make
    ├── Action: install
    │   └── Mechanism: apt
    ├── Action: load
    │   ├── Mechanism: modprobe
    │   └── Mechanism: insmod
    └── Action: enable
        └── Mechanism: shell

# Flat Target → Action → Mechanism
Resource: a kernel module
└── Target: a Linux VM
    ├── Action: build      → Command: make -C …        → Mechanism: make
    ├── Action: install    → Command: apt install …    → Mechanism: apt
    ├── Action: load       → Command: modprobe <mod>   → Mechanism: modprobe
    ├── Action: load       → Command: insmod <mod>.ko  → Mechanism: insmod
    └── Action: enable     → Command: echo … >> …      → Mechanism: shell

Resource: a kernel module
└── Target: a local OS
    ├── Action: build      → Command: make -C …                          → Mechanism: make
    ├── Action: install    → Command: apt install …                      → Mechanism: apt
    ├── Action: load       → Command: modprobe <mod>                     → Mechanism: modprobe
    ├── Action: load       → Command: insmod <mod>.ko                    → Mechanism: insmod
    └── Action: enable     → Command: echo … >> …                        → Mechanism: shell
└── Target: VM over SSH    Mechanism: ssh + local OS

```


**Notes**

- **Availability**: `build`, `install` — the module comes into existence on disk.
- **Activation**: `load` (runtime), `enable` (persistence) — the module becomes active.
- Removed: `disable`, `remove`, `unload` — they make the module *unavailable* or *inactive*, which is the opposite of the intent.

# Use case 02

- **Step 1 — Sentence**: Read a file
- **Step 2 — Resource**: file
- **Step 3 — Action**: read/get/display
- **Step 4 — Row**:
  - one information is missing the **Possible target**: local fs, a remote host over SSH, an S3 bucket, a container, a Git repo, …

| Sentence | Action | What/Resource | Where/Target | How/Command | Mechanism |
| -------- | ------ | -------- | ------ | ------- | --------- |
| Read a file. | read | a file | local fs | `cat <file>` | `cat` |

- **Step 5 — Other ways**: 

| Sentence | Action | Resource | Target | Command | Mechanism |
| -------- | ------ | -------- | ------ | ------- | --------- |
| Read a file. | read | a file | local fs | `less <file>` | `less` |
| Read a file. | read | a file | local fs | `head <file>` | `head` |
| Read a file. | read | a file | local fs | `tail <file>` | `tail` |
| Read a file. | read | a file | local fs | `grep <pattern> <file>` | `grep` |
| Read a file. | read | a file | an S3 bucket | `aws s3 cp s3://<bucket>/<file> -` | `aws` |
| Read a file. | read | a file | an S3 bucket | `s3cmd get s3://<bucket>/<file> -` | `s3cmd` |
| Read a file. | read | a file | an S3 bucket | `curl https://<bucket>.s3.<region>.amazonaws.com/<file>` | `curl` |
| Read a file. | read | a file | a VM over SSH | `ssh <user>@<host> cat <file>` | `ssh` + `cat` |
| Read a file. | read | a file | a VM over SSH | `ssh <user>@<host> less <file>` | `ssh` + `less` |
| Read a file. | read | a file | a VM over SSH | `scp <user>@<host>:<file> -` | `scp` |
| Read a file. | read | a file | an HTTP(S) endpoint | `curl <url>` | `curl` |
| Read a file. | read | a file | an HTTP(S) endpoint | `wget -qO- <url>` | `wget` |
| Read a file. | read | a file | an HTTP(S) endpoint | `http GET <url>` | `httpie` |

**Tree view**:

```sh
# Target → Action → Mechanism
Resource: a file
├── Target: local fs
│   ├── Mechanism: cat
│   ├── Mechanism: less
│   └── Mechanism: grep
├── Target: S3 bucket
│   ├── Mechanism: aws
│   ├── Mechanism: s3cmd
│   └── Mechanism: curl
├── Target: VM over SSH
│   ├── Mechanism: ssh + local fs
│   └── Mechanism: scp
└── Target: HTTP(S)
    ├── Mechanism: curl
    ├── Mechanism: wget
    └── Mechanism: http
```

```sh
# Action → Target → Mechanism
Resource: file
└── Action: read
    ├── Target: local fs
    │   ├── Mechanism: cat
    │   ├── Mechanism: less
    │   └── ...
    ├── Target: S3 bucket
    │   ├── Mechanism: aws
    │   └── ...
    ├── Target: VM over SSH
    └── Target: HTTP(S)
```


```sh
# Flat Action → Target → Mechanism
Resource: file
└── Action: read
    ├── Target: local fs            → Command: cat <file>                     → Mechanism: cat
    ├── Target: local fs            → Command: less <file>                    → Mechanism: less
    ├── Target: local fs            → Command: head <file>                    → Mechanism: head
    ├── Target: local fs            → Command: tail <file>                    → Mechanism: tail
    ├── Target: local fs            → Command: grep <pattern> <file>          → Mechanism: grep
    ├── Target: an S3 bucket        → Command: aws s3 cp s3://<b>/<f> -       → Mechanism: aws
    ├── Target: an S3 bucket        → Command: s3cmd get s3://<b>/<f> -       → Mechanism: s3cmd
    ├── Target: an S3 bucket        → Command: curl https://<b>.s3…/<f>       → Mechanism: curl
    ├── Target: a VM over SSH       → Command: ssh <u>@<h> cat <file>         → Mechanism: ssh + cat
    ├── Target: a VM over SSH       → Command: ssh <u>@<h> less <file>        → Mechanism: ssh + less
    ├── Target: a VM over SSH       → Command: scp <u>@<h>:<file> -           → Mechanism: scp
    ├── Target: an HTTP(S) endpoint → Command: curl <url>                     → Mechanism: curl
    ├── Target: an HTTP(S) endpoint → Command: wget -qO- <url>                → Mechanism: wget
    └── Target: an HTTP(S) endpoint → Command: http GET <url>                 → Mechanism: httpie
```

**Note**
- **Action + Resource** identify the operation → the *what*.
- **Target** identifies *where*.
- **Mechanism** identifies *how*, one row per option.
- **Action** = provided, **Target** = provided => **Mechanism = deduced**


