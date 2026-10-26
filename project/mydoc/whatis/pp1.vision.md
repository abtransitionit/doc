[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ The System][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[blue whatis]: /project/blueprj/whatis/ep.md
[agent whatis]: ../whatis/pp1.term.md#agent

<div align="center">

# Project MyDoc — Phase1: Overview

MyDoc. A Markdown Documentation Hub

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>




# Problem Statement

**Statement**

Publishing documentation from Markdown across multiple static-site servers involves different:
- **Tools**: Software used to build or serve the documentation.
- **Interfaces**: How the documentation tree and its configuration are exposed to each tool.
- **Procedures**: Sequences of actions required to build and serve a site.
- **Representation**: How pages, links, assets, and navigation are represented across tools.

**Examples**:

- Serving: a set of `.md` files can be served live by `algernon` or built into a static site by `jekyll`.
- Linking: internal links may be resolved by a live server or rewritten at build time.
- Front matter: `jekyll` consumes YAML front matter; `algernon` ignores or renders it differently.
- Navigation: `jekyll` uses layouts, includes, and collections; `algernon` serves files as-is.
- Extensions: `algernon` renders Markdown on request; `jekyll` renders it ahead of time.

These examples illustrate how the same Markdown source behaves differently depending on the server, requiring tool-specific conventions.

**The problems**:


These challenges highlight the need for a single Markdown source that behaves predictably under both servers.

# The solution

The project addresses these problems. It provides one static set of Markdown files that can be served, without modification, by both `algernon` and `jekyll`. The same source:
- Renders on `algernon` as a live Markdown server.
- Builds under `jekyll` into a static site.
- Keeps links, assets, and navigation consistent across both.

Concretely, MyDoc simplifies documentation publishing by defining conventions that both servers honor:

Example of **Tools**:

- `algernon` — serve Markdown files directly over HTTP.
- `jekyll` — build a static site from the same files.

Example of **Interfaces**:

- Markdown files — the single source of truth.
- Front matter — agnostic yaml file that ...

Example of **Procedures**:

- Preview locally: run `algernon` against the source tree.
- Build statically: run `jekyll build` against the same tree.


# How it works
1. Author writes Markdown files.
1. Add yaml file agonstic to both server but with semantic.
1. algernon:lua uses this yaml to ...
1. Jekyll uses this yaml to ...
1. Algernon serves the tree directly for preview.
1. Jekyll builds the same tree into static output.


# Intended Users

The anticipated users include:

- **Writers:** author and maintain documentation in Markdown.
- **Maintainers:** keep the source compatible with both servers.
- **Site operators:** choose to serve live or deploy a built site.
- **Readers:** consume the documentation through either server.

<details>
<summary><h1>Document Metadata</h1></summary>

**Information**

| Property | Value |
|:--|:--|
| **Doc-ID** | `PP1-VIEW-01-MYDOC` |
| **Project** | `MyDoc` |
| **Path** | `pp1.vision.md` |
| **Last Updated** | 2026-10-26 |

**Revision History**

| Date | Version | Author | Summary |
|:--|:--|:--|:--|
| 2026-10-26 | `v0.1` | — | Initial draft |

</details>