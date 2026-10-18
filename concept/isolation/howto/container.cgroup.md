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

<h1 align="center">How-to for Cgroup</h1>

The concept of Cgroup


# Check the version
```sh
# using cat
$ cat /proc/filesystems | grep cgroup

nodev	cgroup
nodev	cgroup2

# using stat
$ stat -fc %T /sys/fs/cgroup/

cgroup2fs
```
# Create a Cgroup
```sh
# define var
lGROUP_NAME="demo"

# do
sudo mkdir /sys/fs/cgroup/${lGROUP_NAME}
```
**Meaning**
- create a **cgroup**
- the kernel auto-generates control files
  - `cgroup.procs`
  - `cgroup.controllers`
  - `controller-specific` ...

# Create a name process
```sh
# define var
sleep 300 &

# define var
echo $!

# Move the process into the cgroup - write its pid to the file
echo 12345 | sudo tee /sys/fs/cgroup/demo/cgroup.procs

# check the pid
cat /sys/fs/cgroup/demo/cgroup.procs

# shows controllers available at the root
cat /sys/fs/cgroup/cgroup.controllers

#shows controllers enabled for distribution to child cgroups
cat /sys/fs/cgroup/cgroup.subtree_control

echo +memory | sudo tee /sys/fs/cgroup/cgroup.subtree_control
# Check the configured limit:
cat /sys/fs/cgroup/demo/memory.max
```

> The kernel enforces this memory limit for the cgroup. 

> If its memory usage reaches the limit, **out-of-memory** handling may occur.

```sh
# create that child with:
sudo mkdir /sys/fs/cgroup/demo/worker

#Delete the cgroup
kill 12345

# remove the directory:
sudo rmdir /sys/fs/cgroup/demo
```


# cheat sheet

| Goal                             | Command or file                                       |
| -------------------------------- | ----------------------------------------------------- |
| Create a cgroup                  | `mkdir /sys/fs/cgroup/demo`                           |
| List its control files           | `ls /sys/fs/cgroup/demo/`                             |
| List its processes               | `cat /sys/fs/cgroup/demo/cgroup.procs`                |
| Read memory usage                | `cat /sys/fs/cgroup/demo/memory.current`              |
| Set a memory limit               | Write a byte value to `memory.max`                    |
| Enable a controller for children | Write `+memory` or `+cpu` to `cgroup.subtree_control` |
| Delete an empty cgroup           | `rmdir /sys/fs/cgroup/demo`                           |
