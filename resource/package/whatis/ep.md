[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[resource whatis]: /concept/resource/whatis/ep.md
[capability howto]: /concept/resource/howto/operation.md


<h1 align="center">What is a Package</h1>


# Definition
- cf. the concept of [Resource][resource whatis]
- cf. howto dicover [Capability][capability howto]

# Example
- A system manages 20 **files**
- Each file has Type `File` and kind `File/...`
- But the system must still distinguish one file from another.

A resource could therefore have:
- a **kind**, such as `File/...`;
- a **identity**, unique ID reagrdless the Kind;
- **attributes**:
  - size
  - Me, group, owner - `chown`
  - mode - `chmod`
  - Location = unique on the Target = eligible for functiunal id

This is the next requirement to settle.

Question: Do you want every resource to have 
- a common identity field, regardless of its kind, or 
- should identity be specific to each resource kind 
  - file path for `File`
  - endpoint for `Service`

# Kind
```
File            → capabilities → read, write, delete, copy
├── Txt         → inherited
│   ├── Json    → inherited + validate-json
│   ├── Yaml    → inherited + validate-yaml
│   └── CSV     → inherited + ...
├── Bin         → inherited
│   ├── Tgz     → inherited + ...
│   ├── zip     → inherited + ...
│   └── Artifact
│       
├── ...         
│       
└── ...

```