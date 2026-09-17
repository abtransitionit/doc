[//]: #(home)
[home]: ../../../README.md

[//]: #(doc)
[//]: #(doc)
[domain whatis]: ../whatis/domain.md
[docset whatis]: ../whatis/docset.md
[↖][home]

### Related topics

| Topic | Location | Kind |
|---|---|---|

<h1 align="center">MetaDoc</h1>


# Definition
- **`MetaDoc`** is a project concerning a [documentation platform][doc platform whatis] for an organization

# Definition
* **`MetaDoc`** is a project that defines, implements, and manages a standardized **Documentation System** for an organization.
* It provides the taxonomy, directory conventions, and authoring guidelines required to build an intuitive, scalable, extensible, discoverable **Knowledge Base**.


# System Architecture & Lifecycle

The Documentation System is designed to evolve across two primary phases:

1. **Phase 1: File-System Native (Git-Centric)**
   * Works out of the box directly inside Git platforms (GitHub/GitLab), IDEs (VS Code), or basic HTTP web servers.
   * Relies entirely on native Markdown, standard directory structures, and clean relative link trees.

2. **Phase 2: SSG Platform Transformation (Future Migration)**
   * Easily converts into a fully hosted documentation portal via a Static Site Generator (e.g., Jekyll, MkDocs, Hugo).
   * Achieved with zero content refactoring due to strict platform-neutral formatting enforced in Phase 1.

## Documentation system
...

# Key Characteristics

* **Scalable:** Handles growing content volume seamlessly over time.
* **Extensible:** Adapts to new domains and document formats easily.
* **Discoverable:** Ensures rapid, zero-guesswork navigation throughout its lifecycle.


## SSG Readiness
the git repository can later be easily converted into a documentation platform backed by an **SSG**.
* **Platform Neutral:** Uses native Markdown and clean relative links.
* **Generator Compatible:** Built for easy deployment with Static Site Generators (e.g., MkDocs, Hugo, Docusaurus, Astro, Jekyll).


# Onboarding

To start writing documentation:

1. Identify the topic you want to document (e.g., `Kubernetes`, `Linux`, `rctl`).
1. Select a matching [Domain][domain whatis] (e.g., `system`, `project`) or create one.
1. Create your [DocSet][docset whatis] if it does not exist, or contribute to an existing one.
1. Add the [DocSet][docset whatis] entry point. That's it. Start authoring.