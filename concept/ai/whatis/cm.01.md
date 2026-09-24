[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./cm.md

[↖ Computational Model][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)





<h1 align="center">Computational Model: example 01</h1>

The concept of Computational Model

# The Problem

- You have **100 euros**.
- Every day, you earn **10% interest** on whatever you currently have.
- You want to know how much money you'll have after many days.
- In reality, interest grows **continuously** — every instant.
- A computer can't handle **"every instant"**. So we simplify.

# The Mathematical Model

```math
\frac{dM}{dt} = rM
```

- `M` → your money (€)
- `r` → interest rate = **0.10 per day**
- Start: `M(0) = 100 €`

# The Computational Model

Turn the continuous rule into a **discrete, step-by-step recipe**.

## 1. Discretization

Instead of "every instant," update **once per day** (`Δt = 1 day`).

```math
\frac{M_{n+1} - M_n}{\Delta t} = r M_n
```

You're right to question it — that line is **wrong** as written.

`M_{n+1} = M_n(1 + 0.10)` means `M_{n+1} = 1.10 · M_n`, which is correct **only because Δt = 1**.

The problem is: once you substitute `r = 0.10` and `Δt = 1`, you should also substitute fully. Writing `(1 + 0.10)` keeps `r` half-substituted and `Δt` invisible. It's confusing.

**Two clean options:**

**Option A — substitute everything:**
```math
M_{n+1} = 1.10 \, M_n
```

**Option B — keep the general form, skip the substitution:**
```math
M_{n+1} = M_n \left(1 + r\,\Delta t\right)
```
Then say in words: *"With r = 0.10 and Δt = 1, each step multiplies M by 1.10."*

Option A is cleaner for your doc. Here's the fixed Algorithm section:

---

## 2. Algorithm

Rearrange into a simple update:

```math
M_{n+1} = M_n \left(1 + r\,\Delta t\right)
```

Since `r = 0.10` and `Δt = 1`:

```math
M_{n+1} = 1.10 \, M_n
```

In plain words: **each day, multiply your money by 1.10** (i.e., add 10%).


## 3. Data Structure

One number in memory, updated each day:

```
M = 100                # start with 100 €
for day in range(5):
    M = M * 1.1        # add 10%
    print(day + 1, M)
```

**The Simulation (The Output)**

Running this gives concrete numbers:

| Day | Money (€) |
|-----|-----------|
| 0   | 100.00    |
| 1   | 110.00    |
| 2   | 121.00    |
| 3   | 133.10    |
| 4   | 146.41    |
| 5   | 161.05    |

Now you have power: change `r` to test a better bank, change the starting money, or update twice a day for more precision.

**The Critical Caveat**

The computational model is an **approximation**. Because we update only once per day, we miss the growth happening *during* the day.

- Update **once per day** → 161.05 € after 5 days.
- Update **twice per day** (smaller steps) → slightly more.
- The exact continuous math → 164.87 €.

The smaller your steps, the closer you get. **Choosing the step size is a core part of building the model — not an afterthought.**

**In Summary**

| Layer | What it is | Example here |
|-------|-----------|--------------|
| Mathematical model | Abstract continuous rule | `dM/dt = r · M` |
| Computational model | Discrete step-by-step recipe | `M = M + 0.10 · M` |
| Simulation | The numbers produced | 100 → 110 → 121 → … |

