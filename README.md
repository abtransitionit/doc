# Documentation System

Welcome to the central knowledge portal. This workspace is organized into four distinct spaces to keep permanent reference separate from active project work.

---

## 🏛️ Reference & Evergreen Knowledge

| Space | Focus | Entry Point |
| :--- | :--- | :--- |
| **Concept** | Domain theory, system models, host/machine taxonomy, and shared IT infrastructure standards. | [`/concept/README.md`](../concept/README.md) |
| **Language** | Idiomatic code patterns, syntax rules, and reference guides (Go, Bash, etc.). | [`/language/README.md`](../language/README.md) |
| **Tool** | Operating manuals, configurations, and reference docs for products and runtimes (`algernon`, `certbot`, `jelly`, etc.). | [`/tool/README.md`](../tool/README.md) |

---

## 🚀 Execution & Lifecycle

| Space | Focus | Entry Point |
| :--- | :--- | :--- |
| **Project** | Active work, roadmaps, design specs (RFCs), and sprint backlogs for in-flight initiatives. | [`/project/README.md`](../project/README.md) |

---

### 📂 Active Projects Dashboard

Quick links to in-flight work streams and active specs inside `/project`:

* **[gotest](../project/gotest/README.md)** — Go testing framework & suite development
* **[omtovh](../project/omtovh/README.md)** — Infrastructure migration to OVH
* **[rctl](../project/rctl/README.md)** — Remote control CLI utility
* **[rpro](../project/rpro/README.md)** — Resource provisioning engine
* **[metadoc](../project/metadoc/README.md)** — Meta-documentation system improvements

---

> **Golden Rule:** Permanent definitions live in `concept/`, `language/`, and `tool/` using the `whatis/`, `howto/`, and `list/` pattern. In-flight designs and task tracking live exclusively under `project/`.