[//]: # (home)
[home doc]:    ../../../README.md
[home domain]: ../../README.md
[home topic]:  ../whatis/ep.md

[↖ Project][home topic] · [↖ Projects][home domain] · [↖ Doc][home doc]

[//]: # (doc)

<div align="center">

# Project RMS - Manifest


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# Resource in manifest

## A single resource
.  fs.file-max or path means; it just passes  map to the respective driver.
```yaml
type: maps directly to a driver plugin
attributes: The core engine doesn't need to know what the attributes mean. It just passes them to the driver
```

## A single file
```yaml
type: file/text
name: secure-motd
attributes:
    path: /etc/motd
    content: "Authorized access only.\n"

```
```yaml
type: file/text/json
name: app-config-file
attributes:
  path: /etc/myapp/config.json
  mode: "0644"
  owner: root
  content: |
    {
      "environment": "production",
      "timeout": 30
      "service": "api",
      "port": 8080
    }
```

## A single kernel parameter
```yaml
type: kernel/param
name: max-open-files
attributes:
  key: fs.file-max
  value: 2097152
```  

## A single kernel module
```yaml
type: kernel/module
name: overlay-module
attributes:
  module: overlay
  options: "nexus_enabled=1"
```  
# ResourceSet in manifest
## An example
```yaml
name: base-system-hardening
defaults:
  owner: root

resources:
  - type: kernel_param
    name: tcp-syncookies
    attributes:
      key: net.ipv4.tcp_syncookies
      value: 1

  - type: file
    name: secure-motd
    attributes:
      path: /etc/motd
      content: "Authorized access only.\n"

  - type: kernel_module
    name: br-netfilter
    attributes:
      module: br_netfilter
      state: loaded
```      