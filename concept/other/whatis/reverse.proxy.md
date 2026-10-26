[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md


[//]: #(ref)
[poc whatis]:     ../whatis/poc.md
[mvp whatis]:     ../whatis/mvp.md

[↖ Concept][home domain] · [↖ Doc][home doc]

<div align="center">

# What is a Reverse Proxy

The Concept of Reverse Proxy

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>



# Definition

A reverse proxy is a middleman between the visitor and your website.

### TXT figure

```
       VISITOR
          |
          | 1. Visits https://omt.ovh
          v
   +------------------+
   |  REVERSE PROXY   |
   |     (Nginx)      |
   +------------------+
          |
          | 2. Forwards request to port 4000
          v
   +------------------+
   | YOUR WEBSITE     |
   | localhost:4000   |
   +------------------+
          |
          | 3. Sends response back
          v
       VISITOR
```

### In simple words

Imagine a receptionist in an office:

- Visitor: Wants to see your website.
- Reverse proxy (Nginx): Receptionist who receives the visitor.
- Website on port 4000: The person inside the office who does the actual work.

The visitor talks to the receptionist, and the receptionist passes the request to the right person.

### Without vs. with a reverse proxy

Without a reverse proxy:
`
```
Visitor ---> omt.ovh:4000 ---> Your website
```

The visitor needs to access port `4000` directly.

With a reverse proxy:

```
Visitor ---> https://omt.ovh ---> Nginx ---> localhost:4000
```

The visitor uses the normal HTTPS address. Nginx forwards requests internally to your website.

The main benefit: Your website can keep running on port `4000`, while visitors access it through `https://omt.ovh` without specifying the port. Nginx can also handle HTTPS encryption for you.