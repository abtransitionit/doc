[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ Task][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
<div align="center">

# Project RMS — Task - Architecture - CLI

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

┌──────────────────────────────────────────────────────────────────────────┐
│                              rms <argv...>                               │
└───────────────────────────────────┬──────────────────────────────────────┘
                                    │
                                    ▼
┌──────────────────────────────────────────────────────────────────────────┐
│ STAGE 1 · DETECT GRAMMAR                             │
│                                                                          │
│                │
│                        │
└───────────────────────────────────┬──────────────────────────────────────┘
                                    │
                     ┌──────────────┴───────────────┐
                     │ no match                     │ match
                     ▼                              ▼
        ┌────────────────────────┐   ┌──────────────────────────────────────┐
        │ ERROR: invalid syntax  │   │ STAGE 2 · (next)                     │
        └────────────────────────┘   └──────────────────────────────────────┘