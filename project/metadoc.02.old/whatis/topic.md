# Todo

A concept X has its entry point at /doc/concept/X/whatis/ep.md.

If while writing X's ep.md you discover a sub-concept Y that is owned by X, it lives at /doc/concept/X/whatis/Y.md (sibling of ep.md, not a new top-level concept).

It only gets promoted to top-level /doc/concept/Y/ if it becomes a concept in its own right (with its own whatis/ howto/ list/ kind/).


# SSoT issues I already detect in this single file

You already have a working structure with these roles:

**SSoT**: **S**ingle **S**ource **o**f **T**rust

| Role | File | Purpose |
|-|-|-|
| **Hub / index** | `README.md` (home domain + home doc) | Navigation entry |
| **Whatis** (concept definition) | `whatis/*.md` | One concept per file |
| **List** (enumeration/instances) | `list/res.md` | Concrete instances, not definitions |
| **Concept deep-dive** | `/concept/repository/whatis/ep.md` | Deeper per-concept docs |

And the entry point `res.md` currently contains: **Definition, Kind, Example, Relationships**.
