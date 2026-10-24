[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Resource][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[res whatis]:  ../whatis/ep.md
[res hardware whatis]:  ../whatis/hardware.md
[repo whatis]: /concept/repository/whatis/ep.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Resource][res whatis]|see|
|[What is a Repo][repo whatis]|see|


<h1 align="center">List of Resources</h1> <a id='res'></a>



# List of Resources

| Resource              | Composition | Nature   | Models    | Notes |
|-|-|-|-|-|
| Machine               | Composite   | Physical | —         | CPU + disk + memory |
| VM                    | Atomic      | Virtual  | a machine |       |
| Container             | Atomic      | Virtual  | a machine |       |
| Cluster               | Collection  | Virtual  | ?         | a set of hosts / VMs |
| File                  | Atomic      | Abstract | data      |       |
| Directory             | Collection  | Abstract | a set     | a set of files |
| Filesystem            | Composite   | Abstract | ?         | blocks + inodes + layout |
| Volume mount          | ?           | ?        | ?         | resource or relation? |
| [Repository][repo whatis]            | Composite   | Abstract | ?         | files + history + config |
| [Hardware][res hardware whatis] |
| Process               | Atomic      | Abstract | an execution |    |
| Package               | Atomic      | Abstract | a distribution unit | |
| User                  | Atomic      | Abstract | an identity |      |
| Service               | Atomic      | Abstract | a capability |      |
| Database              | Composite   | Abstract | ?         | tables + indexes + logs |
| Configuration         | Atomic      | Abstract | a state   |       |
| Network               | Composite   | ?        | ?         | nodes + links |
| Network configuration | Atomic      | Abstract | a topology |      |
| Permission            | Atomic      | Abstract | a right   |       |
| Quota                 | Atomic      | Abstract | a limit   |       |
| Namespace             | Collection  | Abstract | ?         | a set of names |

# Todo - Infrastructure
is physical or virtual
  - Computing infrastructure
  - Load balancer
  - network
  - Virtual machines
  - Storage
  - Networks
  - Databases
  - Load balancers
  - Kubernetes
  - Physical servers
  - Object storage
  - etc.



# List of Hardware Resources <a id="hardware"></a>

| Resource              | Composition | Nature   | Models    | Notes |
|-|-|-|-|-|
| Disk                  | Atomic      | Physical | —         |       |
| vNIC                  | Atomic      | Virtual  | a NIC     |       |
| vDisk                 | Atomic      | Virtual  | a Disk    |       |

## Kind

| Name| Semantic | Examples |
| - | - | - |
| Compute Resource | A resource that performs computation | CPU core, CPU thread, GPU, TPU, NPU |
| Memory Resource | Volatile working storage directly accessible during computation| RAM, vRAM |
| Storage Resource | Persistent capacity for storing data | HDD, SSD, NVMe, SAN volume|
| Network Resource | Connectivity and data-transfer capacity| NIC, bandwidth, IP address|
| Device Resource | A hardware device exposed to or usable by computation| USB device, GPU, FPGA, TPM|




| Term | Full English Term | What QEMU Handles |
| --- | --- | --- |
| **vDisk** | Virtual Disk / Drive | Emulates the storage controller and interfaces with host storage files. <li>backed by disk image files like `.qcow2` or `.raw`|
| **vNIC** | Virtual Network Interface Card | Emulates the network controller and connects the VM to host networks. <li>E.g. VirtIO-net, e1000, rtl8139|
| **vUSB** | Virtual USB Controller / Device | Emulates USB ports/buses or forwards host physical USB devices. |
| **vCPU** | Virtual CPU | Handled by KVM (for hardware speed) or QEMU's TCG engine (for software emulation). |
| **vGPU** |Virtual Graphics| Emulated display adapters <li>Ee.g., VirtIO-GPU, QXL, VGA) or PCI pass-through devices.

---

# Files and Objects
- **Local filesystem**: files, directories, symlinks, permissions, ownership.
- **Remote filesystem**: NFS, SMB/CIFS, SSHFS, rsync targets, SFTP.
- **Object storage**: AWS S3, GCS, Azure Blob, MinIO, Ceph RADOS Gateway, Backblaze B2.
- **Content-addressed stores**: Git LFS, IPFS, OCI registries (for blobs).
- **Structured stores**: databases, key-value stores, secrets managers (Vault, AWS Secrets Manager).
- **Concerns**: atomicity, partial writes, large files, streaming, encryption at rest, versioning, eventual consistency, presigned URLs, multipart uploads.

# Virtual Machines
- **Cloud providers**: AWS EC2, GCP Compute, Azure VM, OVH, Hetzner, DigitalOcean, Scaleway.
- **Private virtualization**: VMware vSphere, Proxmox, XCP-ng, Hyper-V, KVM/libvirt.
- **Local virtualization**: QEMU, VirtualBox, Multipass, Lima, Colima.
- **Bare-metal provisioning**: MAAS, Tinkerbell, iPXE, Foreman.
- **Edge/embedded**: Raspberry Pi, ESP32, IoT fleets.
- **Concerns**: images/AMIs, flavors/sizes, networking (VPC, security groups, floating IPs), storage volumes, cloud-init/user-data, SSH key injection, lifecycle (start/stop/reboot/terminate), pricing models, quotas, spot vs. on-demand.

# Clusters
- **Kubernetes on VMs**: kubeadm, k3s, RKE2, Talos, Kubespray.
- **Kubernetes in containers**: kind, k3d, minikube (docker driver), Podman-based.
- **Managed Kubernetes**: EKS, GKE, AKS, OVH Managed K8s, DigitalOcean DOKS.
- **OpenStack**: DevStack, Kolla-Ansible, OpenStack on bare metal, TripleO.
- **Other orchestrators**: Nomad, Docker Swarm, HashiCorp Consul clusters.
- **Data/ML clusters**: Spark, Ray, Hadoop, Slurm, Dask.
- **Concerns**: bootstrap, join tokens, CNI, CSI, ingress, RBAC, upgrades, node pools, autoscaling, multi-tenancy, federation.

# Git Repositories
- **Hosting platforms**: GitHub, GitLab, Bitbucket, Gitea, Forgejo, Codeberg.
- **Self-hosted**: bare Git over SSH, Gitolite, GitLab CE, Gitea.
- **Local**: working trees, bare repos, worktrees, submodules.
- **Operations**:
  - Create/delete repository.
  - Initialize from template (GitHub template repos, Cookiecutter, Copier).
  - Mirror / fork / import.
  - Reset history (orphan branch, squash, `git filter-repo`).
  - Branch/tag management, protection rules.
  - Webhooks, deploy keys, collaborators, teams.
  - CI/CD wiring (Actions, Pipelines, Runners).
  - Submodules, LFS, sparse checkout.
- **Concerns**: authentication (SSH keys, PATs, OAuth apps, GitHub Apps), rate limits, pagination, idempotency of "create if not exists," atomic multi-repo operations.



## Resource Categories


| Category                | Description                                   | Examples                            |
| ----------------------- | --------------------------------------------- | ----------------------------------- |
| Storage Resource        | stores data or state                          | file, database                      |
| Data Resource           | informational content                         | dataset, logs                       |
| Compute Resource        | executes operations                           | service, process                    |
| Infrastructure Resource | provides system capacity                      | physical machine, cloud node        |
| Model Resource          | produces outputs from inputs using operations | rule-based system, function service |
| Host Resource           | execution environment for compute             | VM, container                       |
| Runtime Resource        | active running instance of compute            | running service                     |



## Storage Resource

* stores/persists data or system state for other resources


## Data Resource

* contains informational content
* can be **structured** or **unstructured** (eg. logs or datasets)
* input or output of an [operation][Operation] or [process][Process]


## Compute Resource

* performs execution or computation logic
* runs operations on input to produce outputs
* transforms input resources into output resources






# Operation on resources <a id='ope'></a>
- [repo/git](#repo-git)

## [↑](#ope) repo/git
|Res type||Description|Provider|Example|
|-|-|-|-|-|
|[git authentication](#git-authent)|[gitrepo](#git-repository)|github, gitlab, local||
|[git repository](#git-repo)|[gitrepo](#git-repository)||github, gitlab, local|
|go module|gomod|
|[container registry](#-container-registry)|contrepo|
|[container image](#-container-image)|cim|
|[container](#-container)|| (instance of container image)
|[environment variable](#-environment-variables)|envar|
|[cli](#-cli)|||VSCode, Browser
|[Shell History](#-shell-history)|list|
|[Other](#-other)|


```
                 Resource
                    │
        ┌───────────┼───────────┐
        │           │           │
      Repo        Image      Container
        │           │           │
        ▼           ▼           ▼
    operations   operations   operations
```

```
                  Resource framework
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
        repo           image        container
          │              │              │
          └──────────────┼──────────────┘
                         │
              common infrastructure
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
       config          output          auth
       logging         errors          state
       discovery       plugins         docs
```

# [↑][top] Git <a id='git'></a>
## [↑](#res) Git authentication <a id='git-authent'></a>

- git/authentication can be provided by `github` or `gitlab`
```
GitHub
  └── authentication
        ├── status
        ├── login
        ├── logout
        └── setup-git
```

Grammar could be:
```sh
rctl github auth [status | login | logout | setup-git]
```

## [↑](#res) Git repository <a id='git-repo'></a>
- A git repository can be **local** or **remote**
- remote git/repository can be provided by `github `or `gitlab`
- remote git/repository can be`public `or `private`

```
GitHub
  └── repositories
        ├── list
        ├── create
        └── delete
```

Grammar could be:
```sh
rctl github repo [list | delete | create]
```


| Resource | Action          | Type                   | Provider |
| -------- | --------------- | ---------------------- | -------- |
| repo     | reset-history   | workflow / destructive | Git      |
| repo     | clone           | primitive              | Git      |
| repo     | inspect-history | diagnostic             | Git      |
| repo     | reinitialize    | primitive              | Git      |
| repo     | set-remote      | primitive              | Git      |
| repo     | commit          | primitive              | Git      |


Std operation could be
```yaml
- list remote|local repo:history
- clone remote repo locally
- clone remote repo template locally # clone + placeholder
- archive remote|local repo
```

Other risked operation could be
```yaml
- delete remote|local repo
- delete local|remote repo:history
- change repo:visibility # from private to public
```
Other operation
```yaml
- change remote
- rewrite branche
```

**Todo**

| Resource | Action | Provider | Current implementation        |
| -------- | ------ | -------- | ----------------------------- |
| git/repo | list   | GitHub   | `gh`                          |
| git/repo | create | GitHub   | GitHub API → remote `init.sh` |
| git/repo | delete | GitHub   | `gh`                          |

```
repo create
    │
    └── fetch versioned file init.sh
            │
            └── execute shell script locally
```
### Example
```sh
mx repo create foo --template go-lib@v1.4.0
```
Meaning:
- Use version 1.4.0 of the go-lib template to create foo.

### Example

``` sh
rctl repo github list --all
# list all public repo of github:user:ab
rctl repo github list ab
# list all public repo of user:ab - try first on gitlab then on github
rctl repo list ab
rctl repo list abtransitionit --public
rctl repo list abelgacem --private
# clone a repo
rctl repo clone abtransitionit/go-core
# clone a templated repo - based on the repo name do some stuff
rctl repo clone tpl abtransitionit/go-tpl-lib
# delet remote repo abelgacem/foo - try first on github then on gitlab
rctl repo delete abelgacem/foo
# delet remote repo github:abelgacem/foo
rctl repo github delete abelgacem/foo
# delet remote repo history github:abelgacem/foo
rctl repo github history reset abelgacem/foo
rctl repo github history-reset  abelgacem/foo
```

### Kind
- git/repo can be public or private
- git/repo can be local or remote
- git/repo remote can be provided by `github` or `gitlab`
- git/authentication can be provided by `github` or `gitlab`



### Flags management 

**possible flags**
```sh
--remote
--local
--public
--private
--all
--github
--gitlab

--template
--provider
```
**example usage**
```sh
# create local repo from remote template repo
rctl repo create --template go-tpl-lib foo
```

```sh
# create remote repo on github/gitlab
rctl repo create foo --provider github
rctl repo create foo --provider gitlab

# create remote repo on xxx (defaulted to what is defined in conf/context)
rctl repo create foo 

```


## Summary
```
GitHub
 ├── authentication
 │    ├── status
 │    ├── login
 │    ├── logout
 │    └── setup-git
 │
 └── repositories
      ├── list
      ├── create
      └── delete
```



## [↑][list res] Container registry
**Kind**
- local
- remote

**Kind**
- public
- private
## [↑][list res] Container image
|res|action/operation|description|
|-|-|-|
|cimage|list|
|cimage|build|
|cimage|tag|
|cimage|retag|
|cimage|push|
|cimage|pull|from registry
|cimage|delete|from local or remote registry

```yaml
cim:
  actions:
   - list
   - build
   - tag
   - retag
   - push
   - pull
   - delete
````

```sh
rctl image build foo
rctl image push foo
```

### Flags management 
**possible flags**
```sh
--tag
```

**example usage**
```sh
rctl image build foo --tag 1.2.0
rctl image push foo --tag 1.2.0
```
```sh
rctl image push foo --provider ghcr
rctl image push foo --provider gitlab
```

## [↑][list res] Container
|res|action/operation|description|
|-|-|-|
|cont|start|
|cont|exec|

```yaml
container:
  actions:
   - create
   - start
   - stop
   - exec
   - delete
````

```sh
rctl container start foo
rctl container exec foo
```
### Flags management 
**possible flags**
```sh
--tag
```

**example usage**
```sh
# instanciate container from image
rctl container create foo-dev --image foo:1.2


rctl container exec foo-dev -- /bin/sh
```





## [↑][list res] Shell History

## [↑][list res] Environment Variables
|res|action/operation|description|
|-|-|-|
|envar|list|list SHELL envar (env)
|envar|list|list GO ENV (go env)

```
MxHome
 └── MxHome_Apps
      ├── MxHome_Go
      │    └── MxBinary_Go
      └── MxHome_VsCode
           └── MxBinary_Vscode
```
> 💡 could eventually become `rctl` configuration,

## [↑][list res] CLI
### `go` cli
- 
### `vscode` cli
```yaml
cli
 ├── vscode
 │    ├── start
 │    └── welcome
 │
 ├── gh
 │    ├── create repo
 │    └── ...
 │    
 ├── awscli
 │    ├── ...
 │    └── ...
 │    
 │    
 ├── browser
 │    ├── open frame
 │    ├── open window
 │    └── ...
 │    
 ├── ...
 │    ├── ...
 │    └── ...
 │
 └── go
      ├── list module
      ├── list go envar
      ├── list module installed version
      ├── list remote module version
      └── list cached module

cli/vscode
  └── start
      └──  MxHome_Go
      │    └── MxBinary_Go
      └── MxHome_VsCode
           └── MxBinary_Vscode
`
```
### `browser` cli
|res|action/operation|description|
|-|-|-|
|cli/vscode|start vscode|
|cli/vscode|Edit a file in vscode
|cli/vscode|Display vscode welcome

## [↑][list res] Other
|res|action/operation|description|
|-|-|-|
|project|list|
|project|status|
|volume|list|
|namespace|list|
|registry|list, add, delete|
|registry|list, add, delete|


# Phase 0 outcome

**The list**
```yaml
repo
  list
  create
  delete

GitHub/auth
  status
  login
  logout
  setup-git

Go/environment
  env

Go/module
  version
  cache.list

Go/CLI
  list

shell/history
  list

VSCode
  start
  welcome
```

**The same list ordered**
```yaml
CORE rctl
  repo
  GitHub authentication

POSSIBLE rctl
  Go
  image
  container
  ...

OUTSIDE / LOW PRIORITY
  shell configuration
  shell history
  VSCode
````

# Todo
* File, Directory
* Package, User, Service
* Network configuration
* Disk
* Container
* Database
* Configuration
* Volume mount
* VM, Cluster
* ...


