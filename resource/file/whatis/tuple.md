[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[resource whatis]: /concept/resource/whatis/ep.md
[capability howto]: /concept/resource/howto/operation.md


<h1 align="center">What is File Tuple</h1>


# Definition


## 1. Kind — what is a file?

```
File
├── Text
│   ├── PlainText
│   ├── JSON
│   ├── YAML
│   ├── CSV
│   └── XML
├── Binary
│   ├── Archive
│   │   ├── ZIP
│   │   └── TAR
│   ├── Compressed
│   │   └── GZIP
│   ├── Executable
│   └── Artifact
└── ...
```

**Example**, 
- a `.tar.gz` file is both an archive and compressed, so multiple classifications may be useful.

## 2. Mechanism — how do we access or manage a file?

```
Mechanism
├── LocalFilesystem
│   ├── Path
│   └── FileDescriptor
├── RemoteFilesystem
│   ├── NFS
│   ├── SMB
│   └── SSHFS
├── RemoteAccess
│   ├── SFTP
│   ├── SCP
│   └── FTP
├── API
│   ├── REST
│   └── ObjectStorageAPI
└── Agent
    ├── CLI
    └── API
```

- The mechanism describes how the file is reached. 
- A `JSON` file, for example, could be read through a 
  - local filesystem
  - SFTP
  - an object-storage API without changing its kind.

## 3. Capabilities — what can we do with it?

```
FileCapabilities
├── Inspect
├── Read
├── Write
├── Create
├── Delete
├── Copy
├── Move
├── Rename
├── Append
├── Watch
├── Validate
├── Hash
├── Compress
└── Decompress
```

- Capabilities should be assigned according to what the mechanism and permissions actually allow. 
- **Example**:
- an object-storage resource may support `Read`, `Write`, and `Delete`, but not `Append` in the same sense as a regular file.

## 4. Test with concrete files

| Resource                      | Kind                     | Mechanism                | Capabilities                |
| ----------------------------- | ------------------------ | ------------------------ | --------------------------- |
| Local JSON configuration      | `Text → JSON`            | `LocalFilesystem → Path` | Read, Write, Validate, Hash |
| Remote log file               | `Text → PlainText`       | `SFTP`                   | Read, Copy                  |
| ZIP archive in object storage | `Binary → Archive → ZIP` | `ObjectStorageAPI`       | Read, Write, Delete, Copy   |
| Generated build artifact      | `Binary → Artifact`      | `Agent → API`            | Read, Write, Hash           |
| Open local file               | `File`                   | `FileDescriptor`         | Read, Write, Append         |

## 5. Candidate representation

```
kind: File
type: JSON
mechanism:
  type: LocalFilesystem
  interface: Path
capabilities:
  - read
  - write
  - validate
  - hash
```

- The `type` field could be omitted if `JSON` is represented directly as a subtype of `File`.

### What this example reveals

Three potential issues to keep in mind:

1. Classification can overlap. A file can be JSON and a configuration file, or compressed and an archive.
    - **Answer**: I define at the request time the kind of the file
2. Mechanism can be layered. A file might be accessed through an agent API, which then accesses a remote filesystem over SSH.
    - **Answer**: already answered somewhere: composition of transport layer. It is known at request time
3. Capabilities can depend on state and permissions. A read-only file or an immutable object may not support all operations exposed by its access mechanism.
    - **Answer**: don't understand

For now, I'd keep the three dimensions and avoid introducing extra abstractions until another resource demonstrates that they're necessary.

Next resource: we can apply the same exercise to `KernelParameter` or `KernelModule` and see whether the model holds up.