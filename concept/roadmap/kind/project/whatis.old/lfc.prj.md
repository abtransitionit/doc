[//]: #(home)
[home]: ../whatis/lfc.md

[//]: #(ref)
[phase whatis]:        ../whatis/phase.md
[rm whatis]:      ../whatis/roadmap.md
[methodology list]:    ../list/meth.ep
[prj howto]:           ../howto/ep.md
[product lfc whatis]:  ../whatis/lfc.product.md
[rm whatis]:      ../whatis/roadmap.md
[phase vision whatis]: ../whatis/phase.md#vision
[phase requirement whatis]: ../whatis/phase.md#requirement
[phase improve whatis]: ../whatis/phase.md#improve
[phase impl whatis]: ../whatis/phase.md#implementation
[phase ope whatis]: ../whatis/phase.md#operation
[phase feedback whatis]: ../whatis/phase.md#feedback
[phase check whatis]: ../whatis/phase.md#check
[phase roadmap whatis]: ../whatis/phase.md#roadmap
[phase model whatis]: ../whatis/phase.md#model

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Phase][phase whatis]|internal
|[What is a Roadmap][rm whatis]|internal
|[What is a product lifecycle][product lfc whatis]|internal
|[How-to for project][prj howto]|internal


<h1 align="center">Project Lifecycle</h1>


# Definition
- A sequence of [phases][phase whatis] that a [project][home] passes through from its **initiation** to its **closure**.
- Exists, regardless of its [methodology][methodology list] (Waterfall, Agile, etc.)
- Exists, regardless of the kind of project (software, events, etc.)
- The [rm][rm whatis] add constraints to this sequence.


# Examples of project's lifecycle  <a id='lifecycle'></a>


Example 01:

```
Project
   │
   └── Lifecycle
          │
          ├── Phase 1 — Vision
          ├── Phase 2 — Definition
          ├── Phase 3 — Design
          ├── Phase 4 — Implementation
          ├── Phase 5 — Validation
          ├── Phase 6 — Delivery
          └── Phase 7 — Closure
```  

Example 02:


```
Project
   │
   └── Lifecycle
          │
          ├── 1. Vision
          ├── 2. Requirements
          ├── 3. Roadmap
          ├── 4. Implementation
          ├── 5. Verification & Validation
          ├── 6. Operations
          ├── 7. Measurement & Improvement
          └── 8. Feedback Loop
```


Example 03:

```
                    ┌─────────────────────────────────────┐
                    │          8. FEEDBACK LOOP           │
                    │   (What's next? Adapt & evolve)     │
                    └────────────────┬────────────────────┘
                                     ↑
                                     │
┌────────────────────────────────────┼─────────────────────────────────────┐
│                                    │                                     │
│  ┌───────────────────┐             │             ┌───────────────────┐   │
│  │ 1. VISION / GOAL  │─────────────┼────────────▶│  7. MEASUREMENT & │   │
│  │ (Why?)            │             │             │  IMPROVEMENT      │   │
│  └─────────┬─────────┘             │             │  (How well?)      │   │
│            │                       │             └─────────┬─────────┘   │
│            ↓                       │                       ↑             │
│  ┌───────────────────┐             │                       │             │
│  │ 2. REQUIREMENTS   │             │        ┌──────────────┴──────────┐  │
│  │ (What?)           │             │        │                         │  │
│  └─────────┬─────────┘             │        │  ┌───────────────┐      │  │
│            │                       │        │  │ 6. OPERATIONS │      │  │
│            ↓                       │        │  │(How to run?)  │      │  │
│  ┌───────────────────┐             │        │  └───────┬───────┘      │  │
│  │ 3. ROADMAP /      │             │        │          ↑              │  │
│  │ PLANNED WORK      │             │        │          │              │  │
│  │ (When & Who?)     │             │        │  ┌───────┴────────────┐ │  │
│  └─────────┬─────────┘             │        │  │ 5. VERIFICATION &  │ │  │   
│            │                       │        │  │    VALIDATION      │ │  │    
│            ↓                       │        │  │                    │ │  │
│  ┌───────────────────┐             │        │  │ (Does it work?)    │ │  │
│  │ 4. IMPLEMENTATION │─────────────┼───────▶│  └───────┬────────────┘ │  │
│  │ (How?)            │             │        │          ↑              │  │
│  └───────────────────┘             │        └──────────┼──────────────┘  │
│                                    │                   │                 │
└────────────────────────────────────┴───────────────────┼─────────────────┘
                                                         │
                                             (Output flows forward)
```


Example 04:

| Phase | Name | Answer | Description |
| - | - | - | -| 
| 1 | [Vision][phase vision whatis] / Goal | Why? | define the project
| 2 | [Model][phase model whatis] | 
| 3 | [Requirements][phase requirement whatis] | What? |
| 4 | [Roadmap][phase roadmap whatis] / Planned Work | When & Who?
| 5 | [Implementation][phase impl whatis] |  How |
| 6 | [Verification][phase check whatis] & Validation | Does it work? |
||
| 7 | [Operations][phase ope whatis] | How to run it? |
| 8 | [Measurement][phase improve whatis] & Improvement | How well? |
| 9 | [Feedback][phase feedback whatis] Loop | What's next? |








### Visual Flow (Linear + Loop)

```
INPUT
│
▼
1. WHY?    →   2. WHAT?    →   3. WHEN/WHO?    →   4. HOW?
                                                      │
                                                      ▼
5. DOES IT WORK?    →   6. HOW TO RUN?    →   7. HOW WELL?
                                                      │
                                                      ▼
8. WHAT'S NEXT?    →   (back to 1)
│
▼
OUTPUT    →    VALUE
```

```
INPUT ──▶ 1. WHY? ──▶ 2. WHAT? ──▶ 3. WHEN/WHO? ──▶ 4. HOW?
                    │
                    ▼
              5. DOES IT WORK? ──▶ 6. HOW TO RUN? ──▶ 7. HOW WELL?
                    │
                    ▼
              8. WHAT'S NEXT? ──▶ (back to 1)
                    │
                    ▼
                 OUTPUT ──▶ VALUE
```

