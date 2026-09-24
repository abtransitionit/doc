[//]: #(home)
[home domain]:    ../../../../README.md
[home doc]:    /README.md
[home topic]: ../howto/ep.md
[home index]: #index

[//]: #(ref)
[poc whatis]: /concept/test/whatis/ep.md

[↖ Project][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

<h1 align="center">Example: a Software Lifecycle</h1>


This section define a lifecycle that can for a software projects.


# The sequence
```
Vision → Terminology → Requirements → Design → Implementation → Testing → Maintenance
```

# Rules and Conventions 

**Global rules**

- Each stage produces at least one **output** (artifact) and one **outcome** (result).
- The Project apply this lifecycle, they do not redefine it.
- The Project creates a [POC and MVP][poc whatis].

**File conventions**


| Stage | Output Artifact | Note
| - | - | - |
| Vision | 1 file|
| Terminology | 1 file |
| Requirements | 1 file | but grows |
| Design | 1 |+ many ADRs 
| Implementation | many task docs |
| Testing | 1 report| per-release 
| Maintenance | 1 changelog|per-release 



**Naming conventions**

| Type | Convention | Example |
|---|---|---|
| Single doc | `noun.md` | `vision.md` |
| ADR | `adr/NNNN-title.md` | `adr/0001-use-postgres.md` |
| Task doc | `tasks/NNNN-title.md` | `tasks/0001-setup-db.md` |
| Test report | `test-reports/YYYY-MM-DD.md` | `test-reports/2026-09-23.md` |
| Changelog | `CHANGELOG.md` | standard |

**POC / MVP tagging**

Inside each stage, notes distinguish POC from MVP:

    poc: <choice for proof of concept>
    mvp: <choice for minimum viable product>

If identical: `poc: same as mvp`


# Convention for Phases artifacts
## 1. Phase → Vision

**Outcome:** Team aligned on the goal — everyone knows what we're building and why.

| Field | Value |
|---|---|
| File | `vision.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | goal + target user + success metric written |


## 2. Phase → Terminology

**Outcome:** Shared language — no ambiguity in later stages.

| Field | Value |
|---|---|
| File | `glossary.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | every key term defined once, no duplicates |


## 3. Phase → Requirements

**Outcome:** Clear scope of what to build — nothing missing, nothing extra.

| Field | Value |
|---|---|
| File | `requirements.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | each requirement testable + tagged poc/mvp |


## 4. Phase → Design

**Outcome:** Blueprint ready to code — decisions made before implementation.

| Field | Value |
|---|---|
| File | `design.md` + `adr/NNNN-*.md` |
| Location | `/doc/project/<project>/` and `/doc/project/<project>/adr/` |
| Format | markdown |
| Done when | architecture described + each key decision has an ADR |


## 5. Phase → Implementation

**Outcome:** Feature exists and runs.

| Field | Value |
|---|---|
| File | source code + `tasks/NNNN-*.md` |
| Location | `/src/<project>/` and `/doc/project/<project>/tasks/` |
| Format | code + markdown |
| Done when | code runs, each task documented |


## 6. Phase → Testing

**Outcome:** Confidence it works correctly.

| Field | Value |
|---|---|
| File | `test-reports/YYYY-MM-DD.md` |
| Location | `/doc/project/<project>/test-reports/` |
| Format | markdown |
| Done when | all cases pass or failures documented |


## 7. Phase → Maintenance

**Outcome:** Product stays usable over time.

| Field | Value |
|---|---|
| File | `CHANGELOG.md` |
| Location | `/doc/project/<project>/` |
| Format | markdown |
| Done when | fixes and updates recorded per release |






## Project layout

```
/doc/project/<project>/
├── README.md
├── spec/
│   ├── vision.md
│   ├── glossary.md
│   ├── requirements.md
│   └── design.md
├── constraints.md
├── adr/
│   ├── 0001-use-postgres.md
│   └── 0002-auth-strategy.md
├── tasks/
│   ├── 0001-setup-db.md
│   └── 0002-login-endpoint.md
├── test-reports/
│   └── 2026-09-23.md
└── CHANGELOG.md
```

Code lives separately at `/src/<project>/`.


## Related

- [Project README template](./_templates/project/README.md)
- [Constraints template](./_templates/project/constraints.md)
- [Glossary template](./_templates/project/glossary.md)
```

