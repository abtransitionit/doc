[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[README]:  ./README.md

<h1 align="center">What is File</h1>


Examples:

```
Resource
 ├── Kernel
 |      ├── module
 |      └── param
 ├── Package
 |      ├── repo
 |      └── package
 ├── File
 |      ├── Txt
 |      |   ├── Json
 |      |   ├── Yaml
 |      |   └── package
 |      └── Bin
 |          ├── tgz
 |          ├── zip
 |          └── ...
 └── ...

```


Examples:

| Resource   | Kind      | Classification   |
| ---------- | --------- | ---------------- |
| A file     | `File`    | Specific type    |
| A database | `DB`      | Specific type    |
| A CPU      | `Compute` | Broader category |
| An API     | `Service` | Broader category |


| Category | Type | Kind path |
| -------- | ---- | --------- |
| `Kernel` | `module` | `Kernel/module` |
| `Kernel` | `parameter` | `Kernel/parameter` |
| `Package` | `repository` | `Package/repository` |
| `Package` | `package` | `Package/package` |


| Term | Level | Example | Answers |
| ---- | ----- | ------- | ------- |
| **Category** | broad family | `Kernel`, `Package` | *What family?* |
| **Type** | specific | `module`, `repository` | *What specifically?* |
| **Kind** | the pair | `Kernel/module` | *The full designation.* |

| Resource | Type | Category |
| -------- | ---- | -------- |
| CPU | `CPU` | `Compute` |
| File | `File` | `Storage` |
| API | `API` | `Service` |
| PostgreSQL database | `PostgreSQL` | `Database` |

- **(ii)** Always use the path form: scales better
- `Storage/File`
- `Compute/CPU`
- `Service/API`
- `Database/PostgreSQL`.
- `Kernel/module`, 
- `Package/repository`


## Question

To lock this down, one decision:

**Is `Kind` = `Category/Type` (family/subkind), or is `Kind` = `Type` and `Category` sits above it?**

In other words, pick one:

| Option | Category | Type | Kind |
| ------ | -------- | ---- | ---- |
| **A** | `Kernel` | `module` | `Kernel/module` |
| **B** | `Kernel` | `Kernel/module` | `Kernel/module` (same as Type) |
| **C** | `Kernel` | `module` | `module` (Kind = Type) |

Which one?

