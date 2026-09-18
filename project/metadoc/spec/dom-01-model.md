[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">metadoc specification</h1>

# Step 03: Domain Model

This document defines the core concepts, business rules, entity models, and relationships that govern the `metadoc` problem space. It establishes a vocabulary and conceptual framework independent of specific CLI tools, parsing libraries, or file system APIs.

---

## 1. Domain Concepts

* **Master Hub:** The root directory (`/doc`) serving as the primary entry point for a domain knowledge base.
* **Sub-Hub:** A functional category directory (e.g., `concept/`, `language/`, `tool/`, `project/`) partitioning knowledge by lifecycle stability and focus.
* **Namespace:** A distinct named boundary within a Sub-Hub grouping related documentation artifacts.
* **Entry Point (`ep.md`):** A standardized root file (`whatis/ep.md`) providing primary navigation and context for a specific Namespace.
* **Taxonomy:** The structural declaration mapping Sub-Hubs and Namespaces inside the Master Entry Point (`README.md`).
* **Cross-Reference:** An explicit relative link connecting entities across different Sub-Hubs or external Master Hubs.

---

## 2. Entity Models

```text
Master Hub (/doc)
  ├── Master Entry Point (README.md)
  └── Sub-Hub
        ├── Namespace
        │     └── Entry Point (whatis/ep.md)
        └── Taxonomy Declaration

Cross-Reference Link
  ├── Source Entity
  ├── Target Entity (Internal or Federated Master Hub)
  └── Link Type (Relative Path)
```



## 3. Entity Relationships

| Subject | Relationship | Object | Rule |
| --- | --- | --- | --- |
| **Master Hub** | declares | **Taxonomy** | A Master Hub declares its active Sub-Hub taxonomy within its `README.md`. |
| **Sub-Hub** | contains | **Namespace** | A Sub-Hub partitions zero or more domain Namespaces. |
| **Namespace** | exposes | **Entry Point** | Every Namespace must provide a `whatis/ep.md` file as its direct entry point. |
| **Cross-Reference** | links | **Entry Point** | A Cross-Reference connects documents across distinct Sub-Hubs or federated Master Hubs. |

---

## 4. Domain Rules

* **Taxonomy Autonomy:** Each Master Hub defines its own valid Sub-Hub taxonomy inside its Master Entry Point (`README.md`); metadoc validates structure against this declared layout.
* **Entry Point Determinism:** Navigation into any Sub-Hub Namespace must resolve strictly through its designated `whatis/ep.md` entry target.
* **Referential Integrity:** All Cross-References between Sub-Hubs must resolve to existing relative paths without broken target references.









# DOM-01: Domain Model & Structural Architecture

## Primary Architecture (Directory Layout)
metadoc defines a generic top-level root hub directory (`/doc`) structured into functional hubs declared directly within a master entry point (`README.md`).

A standard IT/engineering repository adopts four default functional hubs:

```text
doc             <-- Master Hub Root
├── concept/    <-- Theoretical foundations, IT infrastructure, & taxonomies
├── language/   <-- Language references, idiomatic patterns, & syntax guides
├── tool/       <-- Concrete software products, runtimes, & operational tools
├── project/    <-- Ephemeral active work, portfolio roadmaps, & specs
└── README.md   <-- Master Entry Point
```

# DOM-01: Domain Model & Structural Architecture

## Primary Architecture (Directory Layout)
metadoc defines a generic top-level root hub directory (`/doc`) structured into functional hubs declared directly within a master entry point (`README.md`).

A standard IT/engineering repository adopts four default functional hubs:

```text
doc             <-- Master Hub Root
├── concept/    <-- Theoretical foundations, IT infrastructure, & taxonomies
├── language/   <-- Language references, idiomatic patterns, & syntax guides
├── tool/       <-- Concrete software products, runtimes, & operational tools
├── project/    <-- Ephemeral active work, portfolio roadmaps, & specs
└── README.md   <-- Master Entry Point

```

## Sub-Hub Taxonomy

The sub-hub structure categorizes knowledge by domain focus. This is an example of taxonomy for `/doc` (if it is an IT hub):

| Hub | Focus |
| --- | --- |
| **`concept/`** | Foundations & infrastructure |
| **`language/`** | Language standards & idioms |
| **`tool/`** | Operational tools & runtimes |
| **`project/`** | Ephemeral project state |

## Entry Points

The specification standardizes entry points (`whatis/ep.md`) across sub-hub namespaces to guarantee consistent discovery across domains:

| Hub | Direct Entry Point (`ep.md`) |
| --- | --- |
| **`concept/`** | `concept/<namespace>/whatis/ep.md` |
| **`language/`** | `language/<namespace>/whatis/ep.md` |
| **`tool/`** | `tool/<namespace>/whatis/ep.md` |
| **`project/`** | `project/README.md` |

## Domain-Specific Multi-Hub Taxonomies

Under the multi-hub model, distinct domains declare custom sub-hub structures in their respective Master Entry Points:

```text
# IT Engineering Hub (doc-it)
doc-it/
├── concept/
├── language/
├── tool/
├── project/
└── README.md   <-- Master Entry Point (Declares IT Taxonomy)

# Mathematics Hub (doc-math)
doc-math/
├── concept/
├── theorie/
├── logic/
├── tool/
└── README.md   <-- Master Entry Point (Declares Math Taxonomy)

```

```

<ElicitationsGroup message="Does splitting Vision (RFC-01) and Model (DOM-01) align better with your structure?">
  <Elicitation label="Confirm split and draft REQ-01 (Requirements)" query="Confirm the split. Now draft REQ-01 requirements in doc/project/metadoc/spec/req-01-requirements.md."/>
  <Elicitation label="Draft SPEC-01 (Architecture Specification)" query="Draft SPEC-01 architecture specification in doc/project/metadoc/spec/spec-01-architecture.md."/>
</ElicitationsGroup>

```