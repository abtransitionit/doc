[//]: #(home)
[home domain]:    ../../../../README.md
[home doc]:    /README.md
[home topic]: ../howto/ep.md
[home index]: #index

[↖ Project][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]


# Lifecycle

Canonical definition of the project lifecycle used across all projects.

Each project links to this file — never copies it.

## Flow
```
Vision → Terminology → Requirements → Design → Implementation → Testing → Maintenance
```

Each stage must produce at least one **output** (artifact) and one **outcome** (result).

---

## 1. Vision

**Outcome:** Team aligned on the goal — everyone knows what we're building and why.

| Field | Value |
|---|---|
| File | `vision.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | goal + target user + success metric written |

---

## 2. Terminology

**Outcome:** Shared language — no ambiguity in later stages.

| Field | Value |
|---|---|
| File | `glossary.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | every key term defined once, no duplicates |

---

## 3. Requirements

**Outcome:** Clear scope of what to build — nothing missing, nothing extra.

| Field | Value |
|---|---|
| File | `requirements.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | each requirement is testable and tagged poc/mvp |

---

## 4. Design

**Outcome:** Blueprint ready to code — decisions made before implementation.

| Field | Value |
|---|---|
| File | `design.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | architecture, components, and data flow described |

---

## 5. Implementation

**Outcome:** Feature exists and runs.

| Field | Value |
|---|---|
| File | source code |
| Location | `/src/<project>/` |
| Format | code (language per project) |
| Done when | code runs and meets requirements |

---

## 6. Testing

**Outcome:** Confidence it works correctly.

| Field | Value |
|---|---|
| File | `test-report.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | all test cases pass or failures documented |

---

## 7. Maintenance

**Outcome:** Product stays usable over time.

| Field | Value |
|---|---|
| File | `changelog.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | fixes and updates recorded per release |

---

## Rules

- Stages run in order — no skipping.
- Each stage has at least 1 output and 1 outcome.
- POC and MVP are **not** stages — they are **tags** applied inside each stage.
- Projects apply this lifecycle, they do not redefine it.

---

## POC / MVP tagging

Inside each stage, notes distinguish POC from MVP:

    poc: <choice for proof of concept>
    mvp: <choice for minimum viable product>

If identical: `poc: same as mvp`

---

## Related

- [Project README template](./_templates/project/README.md)
- [Constraints template](./_templates/project/constraints.md)
- [Glossary template](./_templates/project/glossary.md)