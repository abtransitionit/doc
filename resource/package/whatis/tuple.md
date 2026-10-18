[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[resource whatis]: /concept/resource/whatis/ep.md
[capability howto]: /concept/resource/howto/operation.md


<h1 align="center">What is a Package Tuple</h1>


A package can be 
  - A package file
  - An installed software package
  - A package in a repository

## 1. Kind — what is a package?

```
Package
├── SoftwarePackage
│   ├── SystemPackage
│   │   ├── Deb          (Debian / Ubuntu)
│   │   ├── Rpm          (Fedora / RHEL)
│   │   ├── Apk          (Alpine)
│   │   └── ...
│   ├── LanguagePackage
│   │   ├── Python       (PyPI)
│   │   ├── Node         (npm)
│   │   ├── Rust         (Cargo)
│   │   └── ...
│   └── ApplicationPackage
├── PackageArtifact
│   ├── DebFile
│   ├── RpmFile
│   ├── Wheel
│   ├── Tarball
│   └── ...
└── PackageRepository
    ├── AptRepository
    ├── DnfRepository
    ├── NpmRegistry
    └── ...
```

**Important distinction**: 
- `PackageArtifact` is a distributable file
- `SoftwarePackage` is the software package being described or managed
- `PackageRepository` is a source of packages. They may be modeled as related resource kinds rather than forced into a single inheritance tree.

## 2. Mechanism — how do we access or manage packages?

```
Mechanism
├── PackageManager
│   ├── Apt
│   ├── Dpkg
│   ├── Dnf
│   ├── Rpm
│   ├── Apk
│   ├── Pacman
│   ├── Pip
│   ├── Npm
│   └── Cargo
│
├── RepositoryClient
│   ├── HTTP
│   └── RegistryAPI
│
├── ArchiveTool
│   ├── Tar
│   └── Unzip
│
└── DirectExecution
    ├── CLI
    └── API
```

- The mechanism depends on the operation
- **Example**, 
  - `apt` installs and removes Debian packages
  - `dpkg` operates directly on Debian packages and package databases
  - `dpkg` does not provide the same dependency-resolution behavior.

## 3. Capabilities — what can we do with a package?

```
PackageCapabilities
├── Inspect
├── Search
├── QueryInstalled
├── Install
├── Uninstall
├── Upgrade
├── Downgrade
├── Configure
├── Verify
├── ResolveDependencies
├── Download
├── Publish
├── Build
└── Purge
```

- Not every package kind supports every capability
- **Example**
  - A repository supports **searching** and **downloading** packages
  - An installed package supports **querying**, **configuring**, **upgrading**, or **uninstalling**.

## 4. Concrete examples

| Resource                   | Kind                                | Mechanism            | Capabilities                         |
| -------------------------- | ----------------------------------- | -------------------- | ------------------------------------ |
| Installed `curl` on Ubuntu | `SoftwarePackage → SystemPackage`   | `Apt` / `Dpkg`       | Inspect, Upgrade, Uninstall          |
| Local `.deb` file          | `PackageArtifact → DebFile`         | `Dpkg`               | Inspect, Install                     |
| Python `requests` package  | `SoftwarePackage → LanguagePackage` | `Pip`                | Inspect, Install, Upgrade, Uninstall |
| npm package in a registry  | `SoftwarePackage → LanguagePackage` | `Npm` / Registry API | Search, Download, Inspect            |
| Internal APT repository    | `PackageRepository → AptRepository` | `Apt` / HTTP         | Search, Download, Publish\*          |

- **Publishing** depends on the repository implementation
- It is not a standard capability of the ordinary `apt` client.

## 5. Example: install `curl` on a remote VM.

```
Resource: SoftwarePackage(curl)
└── Target: Linux OS
    └── WrappedTarget: SSH
        └── BaseTarget: Remote Linux OS
            └── Mechanism: apt
                └── Action: install
```

```
ssh user@vm 'sudo apt install -y curl'
```

- The package kind remains `SoftwarePackage`
- Regardless of whether the OS is local or reached through SSH. 
- The **target determines** where the package manager runs, 
- The **wrapping determines** how that target is reached.

## 5. Example: install a `.deb` file that already exists on your local machine


```
Resource: PackageArtifact(curl.deb)
├── Source target: Local filesystem
│   └── Mechanism: LocalFilesystem
└── Destination target: Remote Linux OS
    └── WrappedTarget: SSH
        └── Mechanism: dpkg
            └── Action: install
```

- This operation involves two targets
  - one for reading the artifact
  - Another for installing it. 

The file may need to be transferred before installation, unless the remote package manager can access it through another mechanism.


## Decomposition of intent into Execution/Action Plan
- Intent = Install package on remote VM
- Action plan
  1. Locate artifact: Target: local filesystem · Mechanism: filesystem
  1. Transfer artifact: Source: local filesystem · Destination: remote VM · Mechanism: SCP
  1. Install package: Target: remote Linux OS · Mechanism: dpkg
  1. Verify installation: Target: remote Linux OS · Mechanism: dpkg query

Each action has 
- its own target
- mechanism
- required capabilities. 

The overall intent doesn't need to know how every step is implemented.




## 6. Candidate representation

For an installed system package:

```
kind: SoftwarePackage
type: SystemPackage
identity:
  name: curl
  version: "8.x"
target:
  kind: LinuxOS
  wrapper:
    type: SSH
    parameters:
      host: vm.example.net
      user: admin
capabilities:
  - inspect
  - install
  - upgrade
  - uninstall
mechanism:
  type: Apt
```

- This is illustrative rather than a finalized schema. 
- The exact version, effective capabilities, and supported operations should be discovered from the actual target.

## 7. Questions

Package management reveals three useful modeling questions:

1. Is the package **installed**, **available** in a repository, or **represented** by an artifact? These are different resource identities and states.
2. Does the mechanism belong to the package or to the target? 
  - `apt` is a mechanism available on the target
  - It is not an intrinsic property of the package.
3. Can an operation span multiple targets? 
  - Downloading, transferring, and installing a package may involve a repository, a local filesystem, and a remote OS.

My current recommendation is to keep `Package` as a resource family, model package artifacts and repositories distinctly, and associate package-manager mechanisms with the target on which they execute.

The third question is particularly valuable for testing our model: a single resource operation may involve multiple targets, not just one wrapped target. We should keep that in mind without adding another abstraction until we've tested more resources.



# Example, install a package on a remote VM from a local artifact:

1. Locate the artifact — local filesystem.
2. Transfer the artifact — SCP over SSH.
3. Install the artifact — `dpkg` on the remote VM.
4. Verify the installation — query the remote package manager.

**Decomposition**
- **intent**:InstallPackage. 
- **plan** handles the coordination.

**One nuance**: 
- **decomposition** answers the structural question, but not every execution question. 

We still need to define action dependencies, success criteria, failure handling, and whether a failed plan can resume or compensate for completed actions.

So I would consider the structural question resolved provisionally, without locking down those details yet.

My next question: should an action always be executable on its own, or can an action itself contain a subplan and be decomposed further when needed? My recommendation is the latter: allow recursive decomposition, with execution eventually reaching actions that the system can execute directly.