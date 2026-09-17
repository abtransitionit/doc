# Step 01: The Project's Vision

## Executive Summary
metadoc is a documentation specification, methodology, and set of guidelines designed to standardize how teams structure, interlink, and maintain knowledge bases across distributed repositories. 

By establishing clear domain boundaries and cross-referencing conventions, metadoc transforms disconnected Markdown files into an interconnected, fully navigable knowledge ecosystem.

## Core Problems Addressed
* **Unstructured Knowledge Bases:** Teams default to ad-hoc folder structures, making knowledge discovery inconsistent across projects.
**Information Drift**: Documentation becomes outdated, contradictory, or inaccurate over time because it is scattered across different places without clear ownership.
* **Information Drift:** Operational guides, technical concepts, and active project tasks drift apart when stored without domain boundaries. For example, someone changes how a tool works during a project, but they update the project ticket and forget to update the user guide or the architecture doc.
* Over time, the actual software, the project notes, and the theoretical guides no longer agree with each other.
* **Broken Cross-References:** Lack of linking standards between theoretical concepts, tool guides, and execution plans leads to decaying documentation networks.

### Solution (move this section to the right place)
By enforcing strict domain boundaries (concept/, tool/, project/), metadoc prevents this: when you update a tool, you know exactly which sub-hub holds its documentation, making it obvious what needs to be updated.

## Strategic Vision

### 1. Short-Term Vision (Standardized Local Repository)
Establish a deterministic layout methodology, standardizing entry points and cross-linking rules within a single repository to ensure 100% structural predictability.

### 2. Long-Term Vision (Multi-Hub Ecosystem)
Enable metadoc to connect distinct hubs across different domains and repositories. Each hub declares its own tailored sub-hub taxonomy directly within its Master Entry Point (`README.md`), allowing specialized domains to interlink seamlessly while maintaining their unique structural requirements.












---
---
---
---

# Step 01: The Project's Vision

## Executive Summary
metadoc is a documentation specification, methodology, and set of guidelines designed to standardize how teams structure, interlink, and maintain knowledge bases across distributed repositories. 

By establishing clear domain boundaries and cross-referencing conventions, metadoc transforms disconnected Markdown files into an interconnected, fully navigable knowledge ecosystem.

## Primary Architecture (Directory Layout)
metadoc defines a generic top-level root hub directory (`/doc`) structured into functional hubs declared directly within a master entry point (`README.md`). 

A standard IT/engineering repository with four functional hubs:

```text
doc             <-- Master Hub Root
├── concept/    <-- Theoretical foundations, IT infrastructure, & taxonomies
├── language/   <-- Language references, idiomatic patterns, & syntax guides
├── tool/       <-- Concrete software products, runtimes, & operational tools
├── project/    <-- Ephemeral active work, portfolio roadmaps, & specs
└── README.md   <-- Master Entry Point
```

### Sub-Hub Taxonomy

The sub-hub structure categorizes knowledge by **domain**. This is an example of taxonomy for `/doc` (e.g. an IT hub documentation system):

| Hub | Focus |
| --- | --- |
| **`concept/`** | Foundations & infrastructure |
| **`language/`** | Language standards & idioms |
| **`tool/`** | Operational tools & runtimes |
| **`project/`** | Ephemeral project state |

### Entry Points

The specification standardizes entry points (`whatis/ep.md`) across sub-hub namespaces to guarantee consistent discovery across domains:

| Hub | Direct Entry Point (`ep.md`) |
| --- | --- |
| **`concept/`** | `concept/<namespace>/whatis/ep.md` |
| **`language/`** | `language/<namespace>/whatis/ep.md` |
| **`tool/`** | `tool/<namespace>/whatis/ep.md` |
| **`project/`** | `project/README.md` |

## Core Problems Addressed

* **Unstructured Knowledge Bases:** Teams default to ad-hoc folder structures, making knowledge discovery inconsistent across projects.
* **Information Drift:** Operational guides, technical concepts, and active project tasks drift apart when stored without domain boundaries.
* **Broken Cross-References:** Lack of linking standards between theoretical concepts, tool guides, and execution plans leads to decaying documentation networks.

## Strategic Vision

### 1. Short-Term Vision (Standardized Local Repository)

Establish a deterministic layout methodology, standardizing entry points and cross-linking rules within a single repository to ensure 100% structural predictability.

### 2. Long-Term Vision (Multi-Hub Ecosystem)

Enable metadoc to connect distinct hubs across different domains and repositories. Each hub declares its own tailored sub-hub taxonomy directly within its Master Entry Point (`README.md`), allowing specialized domains to interlink seamlessly while maintaining their unique structural requirements.

#### Example: Domain-Specific Hub Taxonomies

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

<ElicitationsGroup message="RFC-01 (rfc-01-vision.md) has been updated with these structural divisions. What would you like to generate next?">
  <Elicitation label="Draft REQ-01 (Requirements)" query="Give me the content for doc/project/metadoc/spec/req-01-requirements.md based on this updated vision."/>
  <Elicitation label="Draft DOM-01 (Domain Model)" query="Give me the content for doc/project/metadoc/spec/dom-01-domain-model.md."/>
</ElicitationsGroup>

```




---
---
---
---
---
---
---
---


### Sub-Hub Taxonomy & Entry Points

The specification standardizes entry points (`whatis/ep.md`) across sub-hub namespaces to guarantee consistent discovery across domains:

| Hub | Focus | Direct Entry Point (`ep.md`) |
| --- | --- | --- |
| **`concept/`** | Foundations & infrastructure | `concept/<namespace>/whatis/ep.md` |
| **`language/`** | Language standards & idioms | `language/<namespace>/whatis/ep.md` |
| **`tool/`** | Operational tools & runtimes | `tool/<namespace>/whatis/ep.md` |
| **`project/`** | Ephemeral project state | `project/README.md` |

## Core Problems Addressed

* **Unstructured Knowledge Bases:** Teams default to ad-hoc folder structures, making knowledge discovery inconsistent across projects.
* **Information Drift:** Operational guides, technical concepts, and active project tasks drift apart when stored without domain boundaries.
* **Broken Cross-References:** Lack of linking standards between theoretical concepts, tool guides, and execution plans leads to decaying documentation networks.

## Strategic Vision

### 1. Short-Term Vision (Standardized Local Repository)

Establish a deterministic layout methodology, standardizing entry points and cross-linking rules within a single repository to ensure 100% structural predictability.

### 2. Long-Term Vision (Multi-Hub Federation & Domain Flexibility)

Enable metadoc to connect distinct hubs across different domains and repositories. Each hub declares its own tailored sub-hub taxonomy directly within its Master Entry Point (`README.md`), allowing specialized domains to interlink seamlessly while maintaining their unique structural requirements.

#### Example: Domain-Specific Hub Taxonomies

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

<ElicitationsGroup message="RFC-01 (rfc-01-vision.md) is fully updated. How would you like to proceed?">
  <Elicitation label="Draft REQ-01 (Requirements)" query="Give me the content for doc/project/metadoc/spec/req-01-requirements.md based on this updated vision."/>
  <Elicitation label="Draft DOM-01 (Domain Model)" query="Give me the content for doc/project/metadoc/spec/dom-01-domain-model.md."/>
</ElicitationsGroup>

```





---
---
---
---
---
---
---

## Executive Summary
metadoc is a documentation specification, methodology, and set of guidelines designed to standardize how teams structure, interlink, and maintain knowledge bases across distributed repositories. 

By establishing clear domain boundaries and cross-referencing conventions, metadoc transforms disconnected Markdown files into an interconnected, fully navigable knowledge ecosystem.

## Primary Architecture (Directory Layout)
metadoc defines a generic top-level root hub directory (`/doc`) structured into four core functional hubs alongside a root index:

```text
doc             <-- Master Hub Root
├── concept/    <-- Theoretical foundations, IT infrastructure, & taxonomies
├── language/   <-- Language references, idiomatic patterns, & syntax guides
├── tool/       <-- Concrete software products, runtimes, & operational tools
├── project/    <-- Ephemeral active work, portfolio roadmaps, & specs
└── README.md   <-- Master Entry Point
```


## 2. Long-Term Vision

`metadoc` is able to connect different hub. each defining the taxonomy of each sub-hub in the Master entry point

example:
```markdown
# hub 1 
doc-it
├── concept/
├── language/
├── tool/
├── project/
└── README.md   <-- Master Entry Point

# hub 1 
doc-math
├── concept/
├── theorie/
├── logic/
├── tool/
└── README.md   <-- Master Entry Point
``` 





---
---
---
---
---


### Sub-Hub Taxonomy & Entry Points

The specification standardizes entry points (`whatis/ep.md`) across sub-hub namespaces to ensure consistent discovery:

| Hub | Focus | Direct Entry Point (`ep.md`) |
| --- | --- | --- |
| **`concept/`** | Foundations & infrastructure | `concept/<namespace>/whatis/ep.md` |
| **`language/`** | Language standards & idioms | `language/<namespace>/whatis/ep.md` |
| **`tool/`** | Operational tools & runtimes | `tool/<namespace>/whatis/ep.md` |
| **`project/`** | Ephemeral project state | `project/README.md` |

## Core Problems Addressed

* **Unstructured Knowledge Bases:** Teams default to ad-hoc folder structures, making knowledge discovery inconsistent across projects.
* **Information Drift:** Operational guides, technical concepts, and active project tasks drift apart when stored without domain boundaries.
* **Broken Cross-References:** Lack of linking standards between theoretical concepts, tool guides, and execution plans leads to decaying documentation networks.

## Strategic Vision

### 1. Short-Term Vision (Standardized Local Repository)

Establish a deterministic layout methodology, standardizing entry points and cross-linking rules within a single repository to ensure 100% structural predictability.

### 2. Long-Term Vision (Multi-Hub Ecosystem)

Define federation standards allowing distinct `metadoc`-compliant hubs across different repositories to link with one another, forming a unified, multi-repository knowledge network.

