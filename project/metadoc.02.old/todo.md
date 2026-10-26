
A concept X has its entry point at /doc/concept/X/whatis/ep.md.

If while writing X's ep.md you discover a sub-concept Y that is owned by X, it lives at /doc/concept/X/whatis/Y.md (sibling of ep.md, not a new top-level concept).

It only gets promoted to top-level /doc/concept/Y/ if it becomes a concept in its own right (with its own whatis/ howto/ list/ kind/).

# Rules
- r1: Every concept has an entry point file named ep.md inside its whatis/ folder.
```
# generic
Path = <concept path>/whatis/ep.md

# example
/doc/concept/project/whatis/ep.md
/doc/concept/lifecycle/whatis/ep.md
/doc/concept/roadmap/whatis/ep.md
/doc/concept/project/kind/software/whatis/ep.md
/doc/concept/lifecycle/kind/software/whatis/ep.md
```

- A concept owns everything related to it
- **the folder** is the namespace
- **whatis/ep.** is the door
- sibling files are the room.



Yes. Understood.

**The `ep.md` + sibling-files rule is not concept-specific — it's the universal pattern for all three domains:**

| Domain | Entry point | Related files |
|---|---|---|
| `concept/<topic>/whatis/` | `ep.md` | siblings (`phase.md`, …) |
| `concept/<topic>/howto/` | `ep.md` | siblings |
| `tool/<name>/whatis/` | `ep.md` | siblings |
| `tool/<name>/howto/` | `ep.md` | siblings |
| `project/<name>/whatis/` | `ep.md` | siblings |
| `project/<name>/howto/` | `ep.md` | siblings |

And the same for `list/`, `kind/`, and the `kind/software/` specialization — **everywhere, every domain**.

**One rule. Three domains. Folder = namespace, `ep.md` = door, siblings = room.**

---

## Next step (what I'll produce, nothing else)

The **filled-in tree** with:
- `doc/` root
- `concept/`, `tool/`, `project/` branches
- every concept topic (`project`, `lifecycle`, `roadmap`) with `whatis/ howto/ list/ kind/`
- `kind/software/` under each topic, with its own `whatis/ howto/`
- `ep.md` placed as entry point everywhere
- `tool/` and `project/` populated for **rpro**, **rctl**, **metadoc**
- no prose

---

**Confirm two things and I output the tree:**

1. For `tool/rpro` and `project/rpro` — should they follow the **same topic pattern** (`whatis/ howto/ list/ kind/`) as concepts, or a **simpler shape**?
2. Same question for `list/` — does `tool/` and `project/` also get `list/`?

Reply briefly (e.g. "same pattern, yes list") and I produce the tree.
## The rule, unified

For any concept `X` (project, lifecycle, roadmap, …):

| Folder | Entry point | Related files |
|---|---|---|
| `X/whatis/` | `ep.md` | sibling `.md` files, one per related sub-concept (e.g. `phase.md`) |
| `X/howto/` | `ep.md` | sibling `.md` files, one per related how-to (e.g. `phase.md`) |

And the **software specialization** follows the same pattern under `X/kind/software/`:

| Folder | Entry point |
|---|---|
| `X/kind/software/whatis/` | `ep.md` |
| `X/kind/software/howto/` | `ep.md` |

- `list/` → lists of **tools / terms / acronyms**
- `kind/` → holds the `software/` specialization (only where relevant)

**One rule, applied everywhere. The folder is the namespace, `ep.md` is the door, siblings are the room.**

---

## What I'll do next

Produce the **filled-in tree only** — every file placed, `ep.md` everywhere it belongs, no prose.

Before I do, one last confirmation so I don't waste a round-trip:

- **`kind/` currently only has `software/`** — correct? No other kinds for now?
- **`roadmap/`** gets the full `whatis / howto / list / kind` treatment too (you said yes earlier) — and therefore also `roadmap/kind/software/`?

Reply **"yes"** (or corrections), and I'll output the tree.