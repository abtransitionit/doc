[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[lifecycle whatis]: ../whatis/lfc.md





<h1 align="center">What is a Model</h1>

The concept of model

# Definition

## Lexical field
- blueprint, class
- individual, instance
- simplification
- abstraction

## Model
- a simplified version of something real, abstract or virtual
- abstracts away the complexity of an initial entity to **focus** on a specific desired aspect
- defines a simplified version (the model) of a complex entity
- **"something"** includes anything: entities, relations between entities, processes, ...

## Modeling
- the action of creating a model
- it **deliberately** preserves some aspects of the original and drops others
- the simplification is directed: a model is always **a model of X, for Y, for purpose Z**

# Key point
- one complex entity can have an infinite number of simplified versions
- the specific version is purpose-dependent





# Example


## Example 01

- **Sentence**: "a car is made of 4 wheels, a seat and a steering wheel."
- **Goal**: focus on a representation of a car.

| Aspect | Value |
|---|---|
| Model (of)| the real car (a complex physical entity)
| for | you, the reader, who wants to focus on a representation of the car |
| purpose | highlight certain parts and ignore the rest (engine, price, color…) |
| what's preserved | wheels, seat, steering wheel |
| what's abstracted away | everything not mention: engine, chassis, electronics, brand…  |

## Example 02


**Sentence**: "a container is an instance of a container image", 
- **Goal**: focus on the relation `container image` → `container`.

| Aspect | Value |
|---|---|
| Model (of)| the real car (a complex physical entity)
| for | you, the reader, who wants to focus on a representation of the car |
| purpose | expose the instance-of relation |
| what's preserved | the `image → container` dependency |
| what's abstracted away | everything not mention: container runtime, filesystem, network, lifecycle  |



# Todo : Note on "class"
- A class is a template — it defines what instances are.
- A model is a representation — it describes what something is.
- A class **can be** a model (when used to represent something in the world, for a purpose).
- Modeling is broader than classing.

# Todo : Note on polymorphy
The same word "model" is used in two ways above
  - as a representation of a thing, 
  - as a representation of a relation. Both fit the same frame (of X / for Y / for Z); 
they differ only in what X is.
