[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(ref)
[phase whatis]: ../whatis/phase.md
[roadmap whatis]: ../whatis/roadmap.md
[methodology list]: ../list/meth.ep
[prj howto]: ../howto/ep.md
[product lfc whatis]: ../whatis/lfc.product.md
[roadmap whatis]: ../whatis/roadmap.md

[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Phase][phase whatis]|internal
|[What is a Roadmap][roadmap whatis]|internal
|[What is a product lifecycle][product lfc whatis]|internal
|[How-to for project][prj howto]|internal


<h1 align="center">Project Lifecycle</h1>


# Definition
- The sequence of [phases][phase whatis] that a [project][home] passes through from its **initiation** to its **closure**.
- Exists, regardless of its [methodology][methodology list] (Waterfall, Agile, etc.).
- The [roadmap][roadmap whatis] add constraints to this sequence.



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
          ├── Phase 7 — Delivery
          └── Phase 8 — Closure
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


# A Generic Universal Framework <a id='cycle'></a>

- A simple sequence of phases
- Works for any project (software, events, etc.)
- Based on answering a core set of questions in order


| Phase | Name | Answer |
|----|------|----|
| 1 | [Vision](#vision) / Goal | Why? 
| 2 | [Model](#model) | 
| 3 | [Requirements](#req) | What? |
| 4 | [Roadmap](#roadmap) / Planned Work | When & Who?
| 5 | [Implementation](#implementation) |  How |
| 6 | [Verification](#verification) & Validation | Does it work? |
||
| 7 | [Operations](#operation) | How to run it? |
| 8 | [Measurement](#improvement) & Improvement | How well? |
| 9 | [Feedback](#feedback) Loop | What's next? |




## Visual Lifecycle

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





## [↑](#cycle) Vision  <a id='vision'></a>

- **Core Question:** Why?
- Define the name, purpose, and objectives
- Idea, Discovery, Vision, Goal
- Aligns with business / project objectives
- What problem are you solving? (e.g., "Make knowledge easy to share.") |



## [↑](#cycle) Requirements  <a id='requirement'></a>

- **Core Question:** What?
- Define what is needed (product or service)
- Focus on *what*, not *how* (e.g., "Must support document search," not "Use Elasticsearch.")
- Aligns with product / service definition
- Capture what’s needed to achieve the goal. Focus on *what*, not *how*.  |


## [↑](#cycle)  Roadmap  <a id='roadmap'></a>

- **Core Question:** When & Who?
- Outline planned work and timeline
- Sets strategic direction and milestones
- Break the work into a timeline and assign responsibilities. (e.g., "Phase 1: MVP," "Phase 2: Add Search.") 


## [↑](#cycle) Implementation  <a id='implementation'></a>

- **Core Question:** How?
- The construction/development process
- Build, create, or execute the planned work. (e.g., Write code, construct a building, deliver training.) 

## [↑](#cycle) Verification  <a id='verification'></a>

- **Core Question:** Does it work?
- Test and validate deliverables
- Quality assurance (ensure correctness + fitness for purpose)
- Test and review the output to ensure it meets the requirements and satisfies stakeholders.

## [↑](#cycle) Operations  <a id='operation'></a>

- **Core Question:** How to run it?
- Deploy, launch, maintain the product/service/output (e.g., Hosting a website, staffing a service.)
- Covers ongoing support and maintenance


## [↑](#cycle) Improvement  <a id='improvement'></a>

- **Core Question:** How well?
- Measure performance and identify improvements
- Continuous refinement and optimization
- Track performance data and feedback to identify what can be better. 

## [↑](#cycle) Feedback  <a id='feedback'></a>

- **Core Question:** What's next?
- Feed insights back to the beginning
- Continuous cycle for ongoing alignment
- Use insights from measurement
- Update the Vision and start the cycle again
- Ensure continuous improvement.

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

