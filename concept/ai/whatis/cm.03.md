[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./cm.md

[↖ Computational Model][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)





<h1 align="center">Computational Model: example 03</h1>

The concept of Computational Model: **Neural Networks (What AI Actually Uses)**

## The Problem

- You have a dataset of **images of handwritten digits** (0–9).
- Each image is **28×28 pixels** — a grid of 784 numbers.
- You want a program that can look at any new image and say which digit it is.
- The rule connecting pixels to digits is **too complex to write by hand**.
- In reality, no human can specify the exact mathematical function that maps "pixel values" → "digit".

## The Mathematical Model

```math
\hat{y} = f(x; \theta)
```

- $x$ → input (the 784 pixel values)
- $\hat{y}$ → predicted output (a probability for each digit)
- $\theta$ → **parameters** (weights and biases) — unknown at the start
- $f$ → the **architecture** (how inputs are combined)

The key difference from the money/coffee examples: we don't know **$f$** or **$\theta$**. They must be learned from data.

## The Computational Model

Turn the unknown function into a **learnable, discrete, step-by-step recipe**.

### 1. Discretization

Instead of searching for a continuous function, we **fix an architecture** (a neural network with layers) and represent it as finite matrices of numbers.

```math
\hat{y} = \sigma(W_2 \cdot \sigma(W_1 x + b_1) + b_2)
```

- $W_1, W_2$ → weight matrices (the parameters to learn)
- $b_1, b_2$ → bias vectors
- $\sigma$ → activation function (e.g., ReLU)

This is the "discretized form" — the blueprint becomes a concrete computational graph.

### 2. Algorithm

**Training**: adjust the parameters $\theta$ to minimize error on the data.

```
for epoch in range(10):
    for x, y_true in training_data:
        y_pred = forward(x)                    # compute prediction
        loss = cross_entropy(y_pred, y_true)   # measure error
        gradients = backward(loss)             # compute direction to improve
        theta = theta - learning_rate * gradients  # update parameters
```

In plain words: **repeatedly guess, measure how wrong you are, and nudge the parameters in the direction that reduces the error.**

### 3. Data Structure

The parameters live as **tensors** (multi-dimensional arrays) in memory:

```
W1 = np.random.randn(128, 784) * 0.01   # 128 neurons, 784 inputs
b1 = np.zeros(128)
W2 = np.random.randn(10, 128) * 0.01    # 10 output classes
b2 = np.zeros(10)
```

## The Simulation (The Output)

After training on 60,000 images, the model achieves ~98% accuracy on unseen test images.

| Input Image | Predicted Digit | Confidence |
|-------------|-----------------|------------|
| (pixel grid) | 7 | 0.97 |
| (pixel grid) | 2 | 0.89 |
| (pixel grid) | 1 | 0.99 |

Now you have power: feed any new image and get a digit prediction. No human wrote the rule — **the computational model learned it from data**.

## The Critical Caveat

Unlike the money/coffee examples, **there is no exact continuous math to compare against**. We cannot know the "true" function. The model is an approximation of an **unknown** target, not of a known equation.

- More layers / more neurons → more expressive, but risk **overfitting**.
- More training data → better generalization.
- **Choosing the architecture and step size (learning rate) is a core part of building the model — not an afterthought.**

## In Summary

| Layer | What it is | Example here |
|-------|-----------|--------------|
| Mathematical model | Abstract learnable function | $\hat{y} = f(x; \theta)$ |
| Computational model | Discrete architecture + training algorithm | $\hat{y} = \sigma(W_2 \cdot \sigma(W_1 x + b_1) + b_2)$ |
| Simulation | The trained model's predictions | 98% accuracy on digit classification |

## One-sentence definition

A computational model in AI is a discrete, parameterized recipe — with an architecture and a training algorithm — that a computer runs to learn a function from data.