<h1 align="center">MetaDoc</h1>

# Definition

* **`MetaDoc`** is a governance project that defines, implements, and manages a standardized **Documentation System** for an organization.
* It provides the taxonomy, directory conventions, and authoring guidelines required to build an intuitive, scalable **Knowledge Base**.

---

# System Architecture & Lifecycle

The Documentation System is designed to evolve across two primary phases:

1. **Phase 1: File-System Native (Git-Centric)**
   * Works out of the box directly inside Git platforms (GitHub/GitLab), IDEs (VS Code), or basic HTTP web servers.
   * Relies entirely on native Markdown, standard directory structures, and clean relative link trees.

2. **Phase 2: SSG Platform Transformation (Future Migration)**
   * Easily converts into a fully hosted documentation portal via a Static Site Generator (e.g., Jekyll, MkDocs, Hugo).
   * Achieved with zero content refactoring due to strict platform-neutral formatting enforced in Phase 1.


---
---
---
---
---
---
---

# Definition

* **`MetaDoc`** is the project that defines, manages, and governs the **Documentation System** for an Organization
**`abtransitionit`**.
* It establishes the repository taxonomy, directory standards, and authoring guidelines to maintain an organized, scalable **Knowledge Base**.

---

# Architecture Overview

* **Knowledge Base:** The repository containing all operational, architectural, and procedural IT knowledge.
* **Documentation System:** The structural framework (Domains, DocSets, Intents, Entry Points) governing how knowledge is stored and navigated.
* **MetaDoc:** The governing project enforcing these standards across all DocSets.

---

# Key Characteristics

* **Scalable:** Handles growing content volume seamlessly over time.
* **Extensible:** Adapts to new domains and document formats easily.
* **Discoverable:** Ensures rapid, zero-guesswork navigation throughout its lifecycle.

## SSG Readiness

The git repository can later be easily converted into a documentation platform backed by an **SSG**:
* **Platform Neutral:** Uses native Markdown and clean relative links.
* **Generator Compatible:** Built for easy deployment with Static Site Generators (e.g., MkDocs, Hugo, Docusaurus, Astro, Jekyll).

---

# Onboarding

To start writing documentation:

1. Identify the topic you want to document (e.g., `Kubernetes`, `Linux`, `rctl`).
2. Select a matching [Domain][domain whatis] (e.g., `system`, `project`) or create one.
3. Create your [DocSet][docset whatis] if it does not exist, or contribute to an existing one.
4. Add the canonical `whatis/ep.md` entry point file to begin authoring.






- DocSet: A custom documentation tree. 
  - has a Name
  - has a Domain
- Domain: qualify the the doamin of a DocSet: project, tool, system, os, platform (The category)
- DomainType: qualify the the doamin of a DocSet: project, tool, system, os, platform (The category)
- Topic: project/doc, tool/kubernetes (The directory tree/subject)
- Intent: whatis/, howto/, list/ (The operational purpose)
- Page: whatis/ep.md, howto/kubectl.md (The individual Markdown file)




# Key Responsibilities

`doc` Maintainers & Automated Controls enforce governance across the repository using the following concepts:

* Every directory tree is a **[DocSet][docset whatis]** containing a canonical [entry point][ep whatis] (`whatis/ep.md`).
* Every DocSet belongs to a specific [domain][domain whatis] (**Project**, **Tool**, **OS**, **System**, **Platform**).
* Every file inside a DocSet is an individual **Page** that fulfills a single, explicit [intent][intent whatis] (`whatis/`, `howto/`, `list/`).



# Key Responsibilities

`doc` Maintainers & Automated Controls enforce governance across the repository using the following concepts:

* Every directory tree is a **[DocSet][docset whatis]** containing a canonical [entry point][ep whatis] (`whatis/ep.md`).
* Every DocSet belongs to a specific [domain][domain whatis] (**Project**, **Tool**, **OS**, **System**, **Platform**).
* Every file inside a DocSet is an individual **Doc** that fulfills a single, explicit [intent][intent whatis] (`whatis/`, `howto/`, `list/`).





# Key Responsibilities

`doc` Maintainers & Automated Controls enforce governance across the repository using the following concepts:

* Every subject belongs to a clearly defined [domain][domain whatis]:
  * **Project:** Managed initiatives or internal software.
  * **Tool:** Individual utilities, binaries, or applications.
  * **OS:** Operating systems and platform kernels.
  * **System:** Interconnected services functioning together.
  * **Platform:** Infrastructure hosting systems and workloads.
* Every file serves a single, specific [intent][intent whatis] (e.g., `whatis`, `howto`, `list`).


# Key Responsibilities
* Every **subject** belongs to a clearly defined [domain][subject whatis]:
  * **Project:** Managed initiatives or internal software.
  * **Tool:** Individual utilities, binaries, or applications.
  * **OS:** Operating systems and platform kernels.
  * **System:** Interconnected services functioning together.
  * **Platform:** Infrastructure hosting systems and workloads.
* Every **file** serves a single, specific [intent][intent whatis] (e.g., `whatis`, `howto`, `list`).


# Key Responsibilities

`doc` Maintainers & Automated Controls enforce governance across the repository using the following concepts:

* Every directory includes a canonical [entry point][ep whatis] (`whatis/ep.md`).
* Every document belongs to a clearly defined [subject][subject whatis] domain:
  * **Project:** Managed initiatives or internal tools (e.g., `doc`, `rctl`).
  * **Tool:** Individual CLI utilities, binaries, or apps.
  * **OS:** Operating systems and core environments.
  * **System:** Interconnected components working as a whole (e.g., `k8s`).
  * **Platform:** Foundations hosting multiple systems or services.
* Every document serves a single, specific [intent][intent whatis] (e.g., definition via `whatis`, procedure via `howto`).








* Every directory includes a canonical [entry point][ep whatis] (i.e. a file `whatis/ep.md`).
* Every document has a uniq [subject][subject whatis] and is defined by several [intents][intent whatis]


# Key Responsibilities

`doc` Maintainers & Automated Controls enforce governance across the repository using the following concepts:

* Every directory includes a canonical [entry point][ep whatis] (i.e. a file `whatis/ep.md`).
* Every document belongs to a single [subject][subject whatis] and addresses a specific [intent][intent whatis].










# Key Responsibilities

`doc` Maintainers & Automated Controls enforce governance across the repository using the following concepts:

* **Entry Point:** Every directory includes a canonical [`whatis/ep.md`][ep whatis] file to serve as its primary landing page.
* **Taxonomy:** Every document follows a [2D matrix][matrix whatis] model separating subject domains ([**DocType**][doctype whatis]) from document intents ([**ContentType**][contenttype whatis]).



Key Responsibilities

`doc` Maintainers & Automated Controls enforce governance across the repository using the following concepts:

* **Entry Point:** Every [subject directory][subject whatis] includes a canonical `whatis/ep.md` file.
* **Taxonomy:** Every kind of document follows a [2D matrix][matrix whatis] model separating subject domains (**DocType**) from document intents (**ContentType**).


# Key Responsibilities

`doc` Maintainers & Automated Controls enforce the following governance across the repository using the following concepts:

* **Entry Point:** Every [subject directory][subject whatis] includes a canonical `whatis/ep.md` file

* **Taxonomy:** Every kind of document follows a [2D matrix][matrix whatis] model separating subject domains (**DocType**) from document intents (**ContentType**).


* **Contributor Onboarding:** Provide clear authoring guidelines and step-by-step procedures (`howto/`) to keep documentation standards consistent.
* **SSG Compatibility:** Verify that relative paths and Markdown references remain clean and build-ready for static site publishing.



# Key Responsibilities

* **Taxonomy Governance:** Maintains the 2D matrix model separating subject domains (**DocType**) from document intents (**ContentType**).
* **Entry Point Standard:** Enforces the canonical `whatis/ep.md` convention across all subjects for zero-guesswork navigation and SSG routing.
* **Onboarding & Standards:** Provides step-by-step guidance for contributors to create and maintain documentation efficiently.
