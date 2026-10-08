[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Tool][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[hres whatis]: ../../../concept/machine/whatis/hres.md
[term list]: ../list/term.md
[system whatis]: #
[artifact whatis]: #
[prj software whatis]: /concept/project/kind/software/whatis/ep.md
[software whatis]: ../whatis/software.md
[tool list]:       /tool/README.md
[language list]:   /language/README.md
[language whatis]: /concept/language/whatis/ep.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Language][language whatis]|internal| 
|[What is a Hardware Resource][hres whatis]|internal| kind |
|[What is a Software Project][prj software whatis]|internal|
|[List of tools][tool list]|internal| list |
|[List of languagess][language list]|internal| list |



<h1 align="center">How-to for Tool</h1>

The concept of tool ([software][software whatis])


# Design the Grammar of a CLI

It consist of defining the synatx a CLI will use


| Step | Phase | Note |
|------|------|------|
| 1 | Identify Core Verbs & Nouns |<li>Map operations users perform daily to determine the essential verbs and nouns.
| 2 | Evaluate Grammar Archetypes (3 Models) |<li>Verb-Noun <li>Noun-Verb <li>Action-Oriented
| 3 | Test Models Against Real-World Scenarios |<li>edge cases <li>complex flags <li>multi-resource operations.
| 4 | Select Winner & Draft ADR-004 |<li>Record the selected grammar as (ADR) <li> with concrete examples


## Step 1: Identify Core Intentions (What do users want to do?)

| Intent Category | What It Means | Typical Verbs | Example Commands / Nouns | CLI Pattern Style |
|-----------------|---------------|---------------|--------------------------|-------------------|
| **Declarative** | <li>Make the world match this file <li>desired-state, idempotent, file-driven  <li>no specific resource named | `apply`, `sync`, `reconcile`, `deploy`, `provision` | <li>`apply -f config.yaml` <li>`sync ./manifests/` <li>`reconcile cluster.json` | <li>Verb + File/Manifest|
| **Imperative / Ad-hoc** | <li>Run this single action on this specific resource <li> one-off, targeted | `create`, `run`, `exec`, `restart`, `scale`, `invoke`, `trigger` | <li>`run job my-job` <li>`restart pod api-7f9` <li>`scale deploy web --replicas=3` | <li>Verb + Resource + Name + flags |
| **State & Discovery** | <li>Show me what exists <li>import, or remove things | `get`, `list`, `describe`, `show`, `import`, `delete`, `remove` | <li>`get pods`, <li>`describe svc api` <li>`import db legacy-db` <li>`delete job old-job` | <li>Verb + Resource (+ optional Name) |

A few notes on categorization:

- **Declarative verbs are usually resource-agnostic** — the resource is implied by the file, not the command line.
- **Imperative verbs almost always take a named resource** — the target is explicit and singular.
- **State & Discovery verbs split into two sub-flavors:**
  - *Read-only:* `get`, `list`, `describe`, `show`
  - *Mutating:* `import`, `delete`, `remove`
  
  You may want to treat those as separate sub-categories if your grammar treats read vs. write differently (e.g., different flag sets).

**Edge cases to watch for:**
- `create` can feel imperative *or* declarative depending on whether it takes a file (`create -f x.yaml`) or inline args (`create pod foo`). Decide which bucket it belongs to and enforce it.
- `apply` is technically "upsert," so it blurs declarative and imperative — usually grouped with declarative because it's file-driven.
- `delete` is imperative in form but state-oriented in intent — most CLIs (kubectl, etc.) group it with `get`/`describe` under "resource operations."




## Step 2: Compare 3 Grammar Archetypes

Evaluate candidate syntaxes across three proven CLI design patterns:


| Pattern | Structure | Example (1) | Example (2) | Pros / Cons |
|---------|-----------|-------------|-------------|-------------|
| **Verb-Noun** (kubectl, git) | `rctl <verb> <noun/target>` | `rctl apply -f manifest.yaml` | `rctl run reset-history --resource repo` | ✅ Highly familiar; clear action-first focus. |
| **Noun-Verb** (docker, aws, gh) | `rctl <noun> <verb>` | `rctl stack apply -f manifest.yaml` | `rctl repo reset-history` | ✅ Great for discoverability (`rctl repo --help`). <br> ❌ Harder for cross-resource manifests. |
| **Object-Action Hybrid** (custom) | `rctl <target-scope>:<action>` | `rctl manifest:apply -f ...` | `rctl repo:run-action ...` | ✅ Explicit. <br> ❌ Can feel rigid or unusual. |

## Step 3: Stress-Test with Real-World Examples

Draft side-by-side comparisons using your actual project use cases:

* Applying a multi-resource YAML manifest.
* Resetting history on a remote GitHub repository.
* Provisioning a single local file.
* Adopting an existing OVH Virtual Machine.
* Listing resources filtering by lifecycle (`dev`) vs substrate (`bare-metal`).

## Step 4: Decision & Decision Record (ADR-X)

Find the most natural and readable syntax and codify it into **ADR-X: CLI Grammar & UX Pattern** so it becomes the official specification for engine development.


## Ready to Start Step 1?

To launch **Step 1**, do you have specific CLI tools whose feel/syntax you particularly enjoy (or hate)? For example: `kubectl`, `docker`, `gh`, `terraform`, or `git`?


