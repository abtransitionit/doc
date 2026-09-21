[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[lifecycle whatis]: ../whatis/lfc.md
[concept list]:     /concept/README.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[List of Concepts][concept list]|internal|





<h1 align="center">What is a Concept</h1>

The concept of concept: a meta concept


# Definition
- **At first**, a concept invokes in mind a representation of the world or part of the world.
- This representation can be something real, concrete, abstract or virtual.
- **Then** this "internal mind representation" starts to exist through a **string** (a sequence of char).
- Finally that string gives birth to **definitions**, **examples**, and so on or even a **model**.
- It may be polymorphic — it has different semantics depending on its context of usage.

## Example 01
- The word "language" may invoke different representations and meanings for 2 persons.
- As soon as the concept is defined, explained, and disambiguated, its (correct) meaning is shared.

## Example 02
- The term "class" is polymorphic — it carries several meanings.
- Setting the context/lexical field to "IT, object-oriented programming", allows disambiguating the correct semantic.
- From then on, a set of other concepts arises: class, instance, object, model, etc., that can be defined, explained and knowledge is shared.

# Key characteristics
- Always specifying the primary or the different contexts of usage of a concept is important.
- Even when a concept is defined in one context, its usage can extend to other contexts, allowing quick integration of knowledge.


---
---
---
---
---
---


# Definition
- A concept first appears as a representation in the mind — of the world, 
  or of some part of it. It may be real, concrete, abstract, or virtual.
- To travel from one mind to another, that representation must be carried 
  by a **string** (a sequence of characters) — a shared handle.
- The string alone means nothing. It acquires meaning through its 
  **articulation**: definitions, examples, boundaries, models.
- The label and the articulation are co-dependent: the label makes the 
  concept referenceable, the articulation makes it meaningful.

## Example 01
- The word "language" may invoke different representations in two minds.
- Once the concept is articulated (defined, exemplified, bounded), the 
  two understandings **converge enough** to be used the same way.
- "Shared" does not mean identical — it means *sharp enough to disambiguate*.

## Example 02
- The word "class" is polymorphic — it carries several meanings.
- Setting the context (e.g. IT, object-oriented programming) selects one 
  meaning and makes the others irrelevant.
- Within that context, a family of related concepts becomes articulable: 
  class, instance, object, model, ...

# Key characteristics
- Specifying the context of use is therefore essential to sharing it.
- A concept is **shared** when its articulation is sharp and accurate 
  enough that two readers apply it identically (same inclusions, same 
  exclusions, same predictions) — for a given purpose.




---
---
---
---
---
---

# Definition
- **At first**, a concept invokes in mind, a representation of the world or part of the world
- this representation can be something real, concrete, abstract or virtual
- **Then** this "internal mind representation" start to exists through a **string** (a sequence of char)
- Finally that string gives birth to **definitions**, **examples**, and so on or even a **model** 
- May be polymorphioc - have different semantics depending on it context of usage.

## Example 01
- the word "language" may invoke different representations and meanings for 2 persons
- As soon as the concept is defined, explained, and disambiguated, its (correct) meaning is shared.

## Example 02
- The term "class" is polymorphic — it carries several meanings.
- Setting the context/lexical field (e.g. IT, object-oriented programming) allows to disambiguated the correct semantic.
- From then on a set of other concepts arise: class, instance, object, model, etc that can be defined, explain and share other knowledges.

# Key chararcteristic
- Always specifying the primary or the different contexts of usage of a concept is important.
- Even when a concept is defined in one context, its usage can extend to other contexts, allowing quick integration of knowledge.

# Kind


| Layer | Contains | Example |
|---|---|---|
| **Meta** | How the doc system works | "What is a concept", "How to read this doc" |
| **Core Concepts** | Foundational definitions | "Language", "Project", "System" |
| **Instances** | Concrete things | "Python", "Jira", "Project Phoenix" |


# Todo




You've hit a classic problem in knowledge organization: the **self-referential definition**. It's the same trap as a dictionary defining "word" or an ontology trying to define "entity" within itself.

Here's how I'd think about it, both philosophically and practically for your documentation system.

## The core problem

You're using "concept" as a **category label** for a set of things (language, project, system...), but you haven't defined what makes something a member of that category. Without that, "concept" is just a section header, not a defined term.

## What a concept actually is (working definition)

A useful, documentation-friendly definition:

> A **concept** is an abstract, reusable unit of meaning that groups together things that share common characteristics, purposes, or behaviors — independent of any specific instance.

Key properties:
- **Abstract** — it's not a physical thing; it's a mental/organizational model
- **Reusable** — it applies across many instances
- **Defined by criteria** — membership is determined by shared characteristics
- **Named** — it has a label so it can be referenced
- **Bounded** — it has a scope (what's in, what's out)

## But here's the important nuance for your system

In documentation, you actually have **two related but distinct things**:

1. **The concept** — the abstract idea (e.g., "what a project is in general")
2. **The concept definition** — the document that articulates it

Your "Concept" section is really a **glossary of foundational definitions**. That's a well-established pattern (see: ISO/IEC/IEEE 24765, DAMA-DMBOK, domain glossaries).

## A pragmatic structure

Consider whether your "Concept" section should instead be called something like **"Foundational Definitions"** or **"Core Concepts"**, and whether your definition of "concept" belongs there or in a meta-section about the documentation system itself.

Suggested split:

## Suggested entry for "What is a concept"

```markdown
## Concept

**Definition:** An abstract, reusable unit of meaning that groups 
things sharing common characteristics, purposes, or behaviors, 
independent of any specific instance.

**Properties:**
- Abstract (not a physical artifact)
- Reusable across instances
- Defined by explicit criteria
- Named for reference
- Scoped (has boundaries)

**Examples in this documentation:**
- The concept of "language"
- The concept of "project"
- The concept of "system"

**Non-examples (these are instances, not concepts):**
- Python (an instance of "language")
- Project Phoenix (an instance of "project")

**See also:** [Glossary], [Ontology model]
```

## One more thing to consider

If your four top-level categories are IT tool, IT system, IT project, IT language — those are **your domain's core concepts**. So "concept" is doing double duty: it's both a *category* in your doc and a *meta-term*. You may want to make that explicit, otherwise readers will wonder why "language" is a concept but "Python" isn't listed as one.

Want me to help draft the actual "What is a concept" page, or sketch how the four categories relate as concepts?