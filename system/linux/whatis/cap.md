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

<h1 align="center">What is Linux Capabilities</h1>

# Definition
- Specific capabilities granted to a process or executable file
- Aims to replace root access or SUID bit

# List of capabilities

| Name                     | Description                                 | Required to / What it allows                                                                                                                |
| ------------------------ | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `CAP_CHOWN`              | Change file ownership                       | Change the owner or group of files without being root.                                                                                      |
| `CAP_DAC_OVERRIDE`       | Bypass file permission checks               | Read, write, or execute files regardless of ordinary permission bits, subject to capability semantics.                                      |
| `CAP_DAC_READ_SEARCH`    | Bypass read and search permission checks    | Read files and search directories regardless of ordinary read/search permissions; does not grant general write access.                      |
| `CAP_FOWNER`             | Bypass certain ownership checks             | Perform operations that normally require the process to own a file, such as changing certain file attributes.                               |
| `CAP_FSETID`             | Preserve set-user-ID and set-group-ID bits  | Set or preserve set-ID bits on files in situations where they would otherwise be cleared.                                                   |
| `CAP_KILL`               | Bypass certain signal permission checks     | Send signals to processes without satisfying the usual user-ID matching rules.                                                              |
| `CAP_SETGID`             | Change group identity                       | Set GIDs and supplementary groups, subject to the applicable rules.                                                                         |
| `CAP_SETUID`             | Change user identity                        | Set real, effective, saved, and filesystem user IDs, subject to the applicable rules.                                                       |
| `CAP_SETPCAP`            | Modify capabilities                         | Modify capability sets within the restrictions imposed by the kernel and the process's permitted capabilities.                              |
| `CAP_LINUX_IMMUTABLE`    | Modify immutable and append-only flags      | Set or clear immutable and append-only file attributes.                                                                                     |
| `CAP_NET_BIND_SERVICE`   | Bind to privileged ports                    | Bind to Internet ports traditionally numbered below 1024, subject to network namespace configuration.                                       |
| `CAP_NET_BROADCAST`      | Network broadcast operations                | Reserved for a capability that is currently unused by Linux.                                                                                |
| `CAP_NET_ADMIN`          | Network administration                      | Configure interfaces, routing, firewall rules, and other network settings.                                                                  |
| `CAP_NET_RAW`            | Use raw and packet sockets                  | Create raw sockets and packet sockets, enabling tools such as `ping` and packet analyzers to perform certain operations.                    |
| `CAP_NET_BIND_SERVICE`   | Bind to privileged ports                    | Bind to traditionally privileged TCP/UDP ports without full root privileges.                                                                |
| `CAP_IPC_LOCK`           | Lock memory                                 | Lock memory into RAM and use certain shared-memory locking operations.                                                                      |
| `CAP_IPC_OWNER`          | Bypass IPC permission checks                | Bypass certain permission checks for System V IPC objects.                                                                                  |
| `CAP_SYS_MODULE`         | Manage kernel modules                       | Load and unload kernel modules.                                                                                                             |
| `CAP_SYS_RAWIO`          | Perform privileged raw I/O                  | Access certain low-level I/O resources and operations.                                                                                      |
| `CAP_SYS_CHROOT`         | Change root directory                       | Use `chroot()` to change a process's root directory.                                                                                        |
| `CAP_SYS_PTRACE`         | Trace and inspect processes                 | Perform privileged debugging and process-inspection operations, subject to other kernel restrictions.                                       |
| `CAP_SYS_PACCT`          | Manage process accounting                   | Enable or disable process accounting.                                                                                                       |
| `CAP_SYS_ADMIN`          | Broad system administration                 | Perform many administrative operations, including certain mount, namespace, and system configuration operations. It is exceptionally broad. |
| `CAP_SYS_BOOT`           | Reboot the system                           | Use privileged reboot and related system boot operations.                                                                                   |
| `CAP_SYS_NICE`           | Change scheduling and priorities            | Change certain process priorities and scheduling parameters, including real-time scheduling operations.                                     |
| `CAP_SYS_RESOURCE`       | Override resource limits                    | Override certain resource limits and perform operations such as increasing specified resource limits.                                       |
| `CAP_SYS_TIME`           | Change system time                          | Adjust the system clock and certain related time settings.                                                                                  |
| `CAP_SYS_TTY_CONFIG`     | Configure virtual terminals                 | Perform privileged virtual-terminal configuration operations.                                                                               |
| `CAP_MKNOD`              | Create special files                        | Create special files such as device nodes using `mknod()`.                                                                                  |
| `CAP_LEASE`              | Establish file leases                       | Establish file leases, which can help coordinate file access between processes.                                                             |
| `CAP_AUDIT_WRITE`        | Write audit records                         | Write records to the kernel audit log.                                                                                                      |
| `CAP_AUDIT_CONTROL`      | Control auditing                            | Enable or disable auditing and modify certain audit settings.                                                                               |
| `CAP_SETFCAP`            | Set file capabilities                       | Set file capabilities on executables, subject to kernel restrictions.                                                                       |
| `CAP_MAC_OVERRIDE`       | Override certain mandatory access controls  | Override certain restrictions imposed by Linux Security Modules that implement the relevant capability hooks.                               |
| `CAP_MAC_ADMIN`          | Administer mandatory access controls        | Configure or administer certain mandatory access control systems that support this capability.                                              |
| `CAP_SYSLOG`             | Access privileged kernel logging operations | Perform certain privileged kernel log operations and access restricted kernel information.                                                  |
| `CAP_WAKE_ALARM`         | Set alarm timers                            | Use alarm timers that can wake the system from a suspended state.                                                                           |
| `CAP_BLOCK_SUSPEND`      | Prevent system suspension                   | Use mechanisms such as wake locks to block system suspend.                                                                                  |
| `CAP_AUDIT_READ`         | Read audit logs                             | Read kernel audit records through the audit multicast interface.                                                                            |
| `CAP_PERFMON`            | Use performance monitoring features         | Perform certain privileged performance-monitoring operations, including access to some performance events.                                  |
| `CAP_BPF`                | Perform privileged BPF operations           | Perform certain BPF operations that otherwise require elevated privileges.                                                                  |
| `CAP_CHECKPOINT_RESTORE` | Perform checkpoint/restore operations       | Perform certain privileged process checkpoint/restore operations, including specific PID-related operations.                                |

**Notes**

- `CAP_SYS_ADMIN` is especially powerful. It covers a wide range of operations and should not be treated as a narrow permission.
- Capabilities do not automatically override every security control. Filesystem permissions, Linux Security Modules (such as SELinux or AppArmor), namespaces, seccomp, and other restrictions can still apply.
- The exact behavior depends on the kernel and configuration. Some capabilities are unused or have specialized semantics.
- Capabilities are not all assigned to users directly. Linux tracks them in process capability sets and can also associate file capabilities with executables.

# Kind

- e = Effective: The capability is actively enabled and in use when the program runs.
- p = Permitted: The program is allowed to use this capability.

# Howto
```sh
# List all files having Linux capabilities explicitly assigned to them.
sudo getcap -r  /

#  output
/usr/bin/mtr-packet cap_net_raw=ep
/usr/bin/ping cap_net_raw=ep
/usr/lib/x86_64-linux-gnu/gstreamer1.0/gstreamer-1.0/gst-ptp-helper cap_net_bind_service,cap_net_admin,cap_sys_nice=ep
/usr/lib/snapd/snap-confine cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_setgid,cap_setuid,cap_sys_chroot,cap_sys_ptrace,cap_sys_admin,cap_sys_resource=p
ubuntu@vps-9c33782a:~$ 

# inspect the process capabilities inside a container
grep '^Cap' /proc/1/status
```

# Cap with docker
```sh
docker run -d \
  --name web \
  --cap-drop=ALL \
  --cap-add=NET_BIND_SERVICE \
  -p 80:80 \
  nginx
```

## Best practice
For a security-sensitive application, a good starting point is:
```
docker run --rm \
  --cap-drop=ALL \
  --security-opt=no-new-privileges \
  your-image
```

Then add only the capability that is needed. Avoid `--privileged` and be particularly cautious with `SYS_ADMIN` cap, because these can break container isolation. 

# Cap with K8S
```sh

apiVersion: v1
kind: Pod
metadata:
  name: network-tool
spec:
  containers:
    - name: app
      image: alpine:3.22
      command: ["sh", "-c", "sleep 3600"]
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        allowPrivilegeEscalation: false
        capabilities:
          drop:
            - ALL
          add:
            - NET_RAW

```

