[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Repository][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |

<h1 align="center">How-to for Debian Repository</h1>

# Using a repository

**For the official Debian repository**
1. Insert the line in  `/etc/apt/sources.list`
    ```
    deb http://ftp.debian.org/debian stable main contrib non-free
    ```
1. Do `apt update`

**For third-party repository repository**

- cf. https://wiki.debian.org/DebianRepository/UseThirdParty