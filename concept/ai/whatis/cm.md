[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ AI][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[cm 01 whatis]: ./cm.01.md
[cm 02 whatis]: ./cm.02.md
[cm 03 whatis]: ./cm.03.md




<h1 align="center">What is a Computational Model</h1>

The concept of Computational Model

# Definition
A computational model is a mathematical representation, implemented in software, that processes inputs and produces outputs according to 
  - rules
  - parameters
  - learned patterns


| Phrase | What it means | Money ([CM 01][cm 01 whatis]) | Coffee ([CM 02][cm 02 whatis]) | Neural net ([CM 03][cm 03 whatis]) |
|--------|---------------|---------------|----------------|--------------------|
| a mathematical representation | An abstract rule, written in symbols | `dM/dt = rM` | `dT/dt = -k(T - T_env)` | `ŷ = f(x; θ)` |
| implemented in software | Translated into executable steps | `M = M * 1.1` in a loop | `T = T - 0.1*(T - 20)` in a loop | forward + backward pass |
| processes inputs | Reads its current state | reads `M` | reads `T` | reads `x` (pixels) |
| produces outputs | Emits the new state | prints the new `M` | prints the new `T` | prints `ŷ` (digit probabilities) |
| according to rules / parameters / learned patterns | The values that govern the update | `r = 0.10` | `k = 0.1`, `T_env = 20` | `θ` (weights), learned from data |

## Mathematical Model

- A set of equations that describe a phenomenon.
- Examples:
  - cf. [CM 01][cm 01 whatis]
  - cf. [CM 02][cm 02 whatis]
  - cf. [CM 03][cm 03 whatis]
- It is the **blueprint** — the abstract theory.

## Computational Model

- The **translation** of a Mathematical Model into something a computer can execute.
- This translation involves three concrete steps:
  1. **Discretization** — chopping continuous time and space into small, distinct steps.
  2. **Algorithm** — a step-by-step procedure to solve the equations at each step.
  3. **Data Structure** — deciding how to store the numbers in the computer's memory.

- It is the **building** — the executable recipe.

## Simulation

- The **result** of running the Computational Model.
- Example: cf. [CM 01][cm 01 whatis]

---

**In Summary**

| Layer | What it is |
|-------|-----------|
| Mathematical model | Abstract continuous rule (theory) |
| Computational model | Discrete step-by-step recipe (implementation) |
| Simulation | The numbers produced (output) |

**One-sentence definition:**

A computational model is a discrete, step-by-step recipe — built from a mathematical rule — that a computer runs to approximate how a system behaves.

