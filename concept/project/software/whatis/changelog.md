[//]: #(home)
[home]: ../whatis/ep.md
[lfc whatis]:         ../../../concept/lifecycle/whatis/ep.md
[prj roadmap whats]:  ../../../concept/lifecycle/whatis/roadmap.md
[prj lfc whatis]:     ../../../concept/lifecycle/whatis/ep.md#sproject
[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Lifecycle][lfc whatis]|internal



<h1 align="center">What is a Changelog</h1>

# Definition
- log changes

# Kind


| # | What it tracks | Trigger | Scope | Example entry |
|---|---------------|---------|-------|---------------|
| **A** | Changes to the **software itself** | A release | Between release N and N+1 | "v2.0 — Added SSO, fixed login bug" |
| **B** | Changes to the **documentation** | Any doc edit | Between doc revisions | "User guide — rewrote install section" |


## Now you have three distinct timelines

Once you separate them, it becomes clear:

```
1. Project timeline   → milestones       (Project Hub)
2. Software timeline  → releases         (Software Hub → Changelog A)
3. Doc timeline       → doc revisions    (Software Hub → Changelog B)
```

They are **parallel but linked** — and the links are few, not many. That's the key insight that stops the sinking feeling.

## Do you actually need Changelog B?

Here's the honest answer: **usually no**, and this is where most teams over-engineer.

| Option | When to use it |
|--------|---------------|
| **No doc changelog** (rely on Git history / Notion page history / Confluence version history) | Almost always — the tool already tracks it |
| **Lightweight doc changelog** (a "Recently updated" page) | If your hub tool doesn't show history well |
| **Full doc changelog** (manual, per-doc) | Rarely worth it — high maintenance, low value |

Your tools (Notion, Confluence, Markdown + Git) **all have built-in version history**. So Changelog B is mostly redundant — you'd be duplicating what the tool already does. This is the same "without duplicating work" principle from your step 4.

## The clean model

So the whole picture simplifies to **one real changelog + built-in history**:

```
Project Hub
└── Milestones ──────────────┐
                             │ (linked when a milestone ships)
                             ▼
Software Hub                 
├── Reference guide  ─┐
├── User guide        ├── doc history (automatic, per tool)
├── Admin guide      ─┘
└── Changelog  ◀──── releases only (Changelog A)  ← the one real changelog
```

- **One changelog** = releases (Changelog A). Hand-curated, meaningful.
- **Doc changes** = tracked automatically by Notion/Confluence/Git. No separate changelog.
- **Milestones** = project hub. Linked to a release *only when the milestone actually ships one*.

## So, to answer your two bullets directly

> the changelog in the software hub reflect changes in any of its doc.

That's **Changelog B** — and you probably **don't need it**, because your tools already track doc history. Don't build it manually.

> i thought changelog is the change between release?

Correct — that's **Changelog A**, and that's the one worth keeping.

## The one sentence to remember

> **There is one changelog (releases). Doc history is free (the tool does it). Milestones link to releases only when they ship one.**

That's the whole thing. The "lots of changelogs" feeling came from trying to manually track doc changes that the tool already handles.

Want me to rewrite your step 4 ("The Linkage Strategy") to reflect this — one changelog, auto doc history, conditional milestone→release link?
