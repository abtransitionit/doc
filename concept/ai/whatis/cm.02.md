[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./cm.md

[↖ Computational Model][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)





<h1 align="center">Computational Model: example 02</h1>

The concept of Computational Model


# The Problem

- You have a cup of coffee at **90 °C**.
- The room is at **20 °C**.
- The coffee cools down over time — faster when it's hot, slower as it approaches room temperature.
- You want to know its temperature after many minutes.
- In reality, the temperature changes **continuously** — every instant.
- A computer can't handle **"every instant"**. So we simplify.

# The Mathematical Model

```math
\frac{dT}{dt} = -k \left(T - T_{\text{env}}\right)
```

- `T` → coffee temperature (°C)
- `T_env` → room temperature = **20 °C**
- `k` → cooling constant = **0.1 per minute**
- Start: `T(0) = 90 °C`

# The Computational Model

Turn the continuous rule into a **discrete, step-by-step recipe**.

## 1. Discretization

Instead of "every instant," update **once per minute** (`Δt = 1 minute`).

```math
\frac{T_{n+1} - T_n}{\Delta t} = -k \left(T_n - T_{\text{env}}\right)
```

## 2. Algorithm

Rearrange into a simple update:

```math
T_{n+1} = T_n + \Delta t \cdot \left(-k \left(T_n - T_{\text{env}}\right)\right)
```

Since `Δt = 1`, `k = 0.1`, and `T_env = 20`:

```math
T_{n+1} = T_n - 0.1 \left(T_n - 20\right)
```

In plain words: **each minute, subtract 10% of the gap between the coffee and the room.**

## 3. Data Structure

One number in memory, updated each minute:

```
T = 90                 # start at 90 °C
for minute in range(60):
    T = T - 0.1 * (T - 20)   # lose 10% of the gap
    print(minute + 1, T)
```

**The Simulation (The Output)**

Running this gives concrete numbers:

| Minute | Temperature (°C) |
|--------|------------------|
| 0      | 90.0             |
| 1      | 83.0             |
| 2      | 76.7             |
| 3      | 71.0             |
| 4      | 65.9             |
| …      | …                |
| 60     | 20.2             |

Now you have power: change `k` to test a different cup, change `T_env` to test a cold room, or update twice per minute for more precision.

**The Critical Caveat**

The computational model is an **approximation**. Because we update only once per minute, we miss the cooling happening *during* the minute.

- Update **once per minute** → 20.2 °C after 60 minutes.
- Update **twice per minute** (smaller steps) → slightly closer to the truth.
- The exact continuous math → 20.2 °C as well (here the gap is tiny, but that's luck — with a larger `Δt` it breaks).

Set `Δt = 30` and the result drifts badly. The smaller your steps, the closer you get. **Choosing the step size is a core part of building the model — not an afterthought.**

**In Summary**

| Layer | What it is | Example here |
|-------|-----------|--------------|
| Mathematical model | Abstract continuous rule | `dT/dt = -k(T - T_env)` |
| Computational model | Discrete step-by-step recipe | `T = T - 0.1·(T - 20)` |
| Simulation | The numbers produced | 90 → 83 → 76.7 → … |


**Two things to verify before publishing:**

1. **The 60-minute value.** With `Δt = 1`, `k = 0.1`, the update gives `T_60 ≈ 20.18 °C`. The *exact* continuous solution is `T(60) = 20 + 70·e^(-6) ≈ 20.17 °C`. So "20.2" is fine for both — but if you want to be precise, write **20.18 °C (discrete)** vs **20.17 °C (exact)**.
2. **The "twice per minute" claim.** With `Δt = 0.5`, you get `T_60 ≈ 20.17 °C` — closer to the exact value. Good. But avoid implying it's *always* more accurate; that's only true for this kind of stable equation.