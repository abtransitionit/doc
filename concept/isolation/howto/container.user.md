[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[namespace whatis]: ../whatis/container.namespace.md
[cgroup whatis]: ../whatis/container.cgroup.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is Cgroup][cgroup whatis]|

<h1 align="center">How-to for Container User</h1>

The concept of Container User

# The problem
For the Linux Kernel
- who you are inside a container
- who you are on the host

# Key idea
The processes in a container
- Run on the Host OS (Kernel)
- Have a different view/value of some kernel's resources (cf. [namespaces][namespace whatis])

# The problem
- Container Users and Host Users Have a different space for UID/GID
- **But** Host root user and Container root user both have UID = 0.
- Both processes do request (system call) to the same Kernel
- What if a container root process and a Host root process sends request to the Kernel
- How does the Kernel distinct Host root user from Container root user ?
- The answer depends on user namespaces and other security controls.

# Case A: No user namespace (traditional setup)

```sh
# In container
id

output > uid=0(root) gid=0(root)
```


# Container with root user inside
- Running processes as root (UID 0) inside a container is risky; 
- if an attacker breaks out, they have root on the host.
- many container images are designed to run as a **non-root** user. 

# Container with non-root user inside
- The most natural choice for this is UID 1000, because it's already recognized as a "regular user" by the system.
- **Example**:
     - The official **Ubuntu Images** Starting with version 23.04
     - Include a default ubuntu user with UID 1000 to encourage running as non-root.



# Todo