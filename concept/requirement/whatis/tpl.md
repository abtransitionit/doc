[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Requirement][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[tool whatis]: /concept/tool/whatis/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a software][tool whatis]

<h1 align="center">What is a Requirement Template</h1>

The concept of Software Requirement

# Requirements Register

|Key|value|
|-|-|
|Project|<name>
|Vision|<link or path to vision doc>
|Last updated|<YYYY-MM-DD>

**Legend**

|attribute|possible values|
|-|-|
|Status|draft · proposed · agreed · implemented · verified · rejected · obsolete
|Kind|functional · non-functional
|Priority|must · should · could · won't (MoSCoW)

## Register

| ID | Version | Status | Kind | Priority | Title | Statement | Source | Rationale |
| -- | ------- | ------ | ---- | -------- | ----- | --------- | ------ | --------- |
| REQ-001 | 0.1 | draft | functional | must | <short title> | The system shall <do X>. | vision §1 | <why it exists> |
| REQ-002 | 0.1 | draft | non-functional | should | <short title> | The system shall <meet quality Y>. | vision §2 | <why it exists> |

## Filled example (to show the shape)

| ID | Version | Status | Kind | Priority | Title | Statement | Source | Rationale |
| -- | ------- | ------ | ---- | -------- | ----- | --------- | ------ | --------- |
| REQ-001 | 0.1 | draft | functional | must | User login | The system shall allow a user to authenticate with email and password. | vision §3.1 | Protect personal data; only known users may access the app. |
| REQ-002 | 0.1 | draft | non-functional | should | Login latency | The system shall complete login in under 2 seconds (p95). | vision §3.1 | Users abandon slow logins. |
| REQ-003 | 0.1 | draft | functional | must | Password reset | The system shall let a user reset a forgotten password by email. | vision §3.2 | Avoid support tickets; standard expectation. |

## What changed vs vxxx

| Before | After |
| ------ | ----- |
| REQ-001 "Single model" — *represent resources through a single common model* | REQ-001 "Resource model" — *represent resources through a resource model* |
| REQ-002 "Model targets" — *represent targets in the common model* | REQ-002 "Target model" — *represent targets through a target model* |
| — | **REQ-003 "Distinct models"** — *keep the resource model and the target model distinct* (new) |
| REQ-003 "Model relationships" | REQ-004 (renumbered) |
| REQ-004…016 | shifted +1 → REQ-005…017 |

## Rules to keep it clean

1. **ID** — one per row, never reused, never renumbered. `REQ-###` is enough at this stage.
2. **Version** — `0.1` = first draft; bump to `0.2`, `0.3` … on each edit; `1.0` = agreed.
3. **Status** — move it forward only when the criterion is met: `draft` → `proposed` (reviewed) → `agreed` (signed off).
4. **Source** — always point to where it came from (`vision §X`, `stakeholder: <name>`, `law: <ref>`). If you can't name a source, it's not a requirement yet.
5. **Rationale** — one sentence: *why this exists*. If you can't write it, the requirement is probably a wish.
6. **One requirement per row.** No "and" / "or" inside a statement if avoidable.
7. **Statement** — **Start** with *"The system shall …"*. Testable, unambiguous.
