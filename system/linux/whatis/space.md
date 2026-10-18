[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ System][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[README]:  ./README.md

<h1 align="center">What is Linux Spaces</h1>

# Definition
- Linux divides its **memory** and **resources** into two main regions:
  - User space
  - Kernel space

# Syscall
- On every **syscall** made by a process to access a resource:
  1. the kernel do checks (UID/GID , capabilities, SELinux/AppArmor labels)
  1. Allows or Unautorized the operation.

# User space
- resource belongs to a user
- processes in user space runs on behalf of a user (real UID / effective UID).
- That UID determines what the process is allowed to touch: files, sockets, IPC, signals, etc.
- contains:
  - Your shell (bash), editors, browsers, databases, web servers
  - System daemons started as non-root (e.g. systemd-resolved as systemd-resolve)
  - Libraries (libc, libssl, …)
  - `/proc`, `/sys` are views the kernel exposes — but the files are read through **syscalls**

# Kernel space
- resource belong to the kernel
- The kernel is a single trusted program with full hardware access.
- Exposes resources to user space only through well-defined entry points: 
  - **syscalls**
  - **signals**
  - `/proc`, 
  - `/sys`
  - `ioctls`.
- contains:
  - Scheduler, memory manager (MMU), VFS, network stack
  - Device drivers (disk, NIC, GPU, USB)
  - Security modules (SELinux, AppArmor, seccomp)
  - Kernel threads — the [kworker/...], [kswapd0], [jbd2/sda1-8] ...

