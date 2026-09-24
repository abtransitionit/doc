[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[Inference]:     #inference
[LossFunction]:  #loss-function
[ModelResource]: #model-resource
[Operation]:     #operation
[Process]:       #process
[Resource]:      #resource
[System]:        #system
[Training]:      #training





<h1 align="center">What is AI</h1>

The concept of AI



# Acronym

| Term  | Meaning                                |
| ----- | -------------------------------------- |
| AI    | **A**rtificial **I**ntelligence        |
| AIA   | **AI** **A**gent                      |
| AIM   | **AI** **M**odel                      |
| AIS   | **AI** **S**ystem                      |
| AGI   | **A**rtificial **G**eneral **I**ntelligence|
| GenAI | **Gen**erative **AI**                  |
| GAN   | **G**enerative **A**dversarial **N**etwork|
| LLM   | **L**arge **L**anguage **M**odels.     |
| NAI   | **N**arrow **AI**                      |


# Definition

## Intelligence

a set of capabilities:

| Capability | Description                                                                 |
| ---------- | --------------------------------------------------------------------------- |
| Learn      | Acquire information, knowledge, skills, or patterns from experience or data |
| Adapt      | Adjust behavior when conditions or objectives change                        |
| Reason     | Analyze informations and derive/infer conclusions                           |
| Solve      | Find solutions to problems, including unfamiliar ones. Address new problems and situations|
| Generalize | Apply learned knowledge to new situations                                   |


## AI
- Stands for **A**rtificial **I**ntelligence
- A domain/field in computer science
- The object of study is **AIS**
- Creates **systems** performing tasks that require intelligence capabilities
- uses systems that can process information, learn, and produce outputs.


## Resource

* a thing that can be [operated][Operation] on in a [system][System]


### Resource Categories


| Category                | Description                                   | Examples                            |
| ----------------------- | --------------------------------------------- | ----------------------------------- |
| Storage Resource        | stores data or state                          | file, database                      |
| Data Resource           | informational content                         | dataset, logs                       |
| Compute Resource        | executes operations                           | service, process                    |
| Model Resource          | produces outputs from inputs using operations | rule-based system, function service |
| Runtime Resource        | active running instance of compute            | running service                     |
| Host Resource           | execution environment for compute             | VM, container                       |
| Infrastructure Resource | provides system capacity                      | physical machine, cloud node        |



### Storage Resource

* stores/persists data or system state for other resources


### Data Resource

* contains informational content
* can be **structured** or **unstructured** (eg. logs or datasets)
* input or output of an [operation][Operation] or [process][Process]


### Compute Resource

* performs execution or computation logic
* runs operations on input to produce outputs
* transforms input resources into output resources



### Model Resource

* a **compute resource** that produces outputs from inputs using learned behavior
* used for inference and prediction tasks
* transforms inputs into **structured outputs**

### Infrastructure Resource

* ensures existence of execution environments


### Host Resource

* provides an execution environment for compute resources
* compute resources run on it


### Runtime Resource

* an instance of a compute resource
* represents execution state on a host


# How it works

* Infrastructure provides Host
* Host runs Runtime
* Runtime executes Compute or Model
* Compute/Model operate on Data/Storage resources


---

# Operation

* an action applied to a [resource][Resource] or [system][System]
* transforms input resources into output resources
* cf. [process][Process]

---

# Input

* a resource **provided** to an operation or system

---

# Output

* a resource **produced** by an operation or system


---

# Process

* a sequence of [operations][Operation] [applied to resources]
* cf. [training][Training]


---

# System

* a set of [resources][resource]
* resources interact through [operations][Operation]
* defines how resources are transformed and coordinated


---

# Dataset

* a structured collection of data resources
* input or output of [processes][Process]

---

# Parameter

* a configurable value inside a [model resource][ModelResource] that influences outputs (its behavior)
* adjusted during [training processes][Training]

---

# Learning

* a [process][Process] that modifies a [model resource][ModelResource] using data and operations
* improves the model’s ability to produce desired/expected outputs
* improves the ability of a [model resource][ModelResource] to produce useful outputs
* improves future performance of the model
* composed of [training][Training] and [inference][Inference] over time



---

# Training

* a [process][Process] that applies to a [model resource][ModelResource] using a dataset
* updates a model [model resource][ModelResource] using a dataset
* modifies the [model resource][ModelResource] through repeated execution of compute processes
* improves the model’s ability to produce accurate outputs


---

# Inference

* a [process][Process] where the  [model resource][ModelResource] produces outputs from inputs
* uses defined operations of the model without modifying it
* does not modify the [model resource][ModelResource] during execution


---

# Optimization

* a [process][Process] that modifies parameters to improve outputs of a [model resource][ModelResource]
* a [process][Process] that adjusts parameters to improve output quality
* uses feedback signals such as **error** or **loss**
* uses results of [training processes][Training] to guide changes


## Loss Function

* a function 
* measures the difference between an **output** and a **desired/expected output**.
* provides information used by optimization.

## Gradient Descent

* an optimization algorithm that modifies parameters.
* modifies parameters to reduce the value of a [loss function][LossFunction].


---

# AI Model


* a [model resource][ModelResource] that produces outputs through inference on input data
* improved through training using datasets and optimization processes


# Todo

### 13. Algorithm

* aka. process
* a sequence of operations.
* transforms inputs into outputs according to rules.

### 14. Computation

* the execution of an algorithm by a system.
* transforms inputs into outputs using processes.

### 15. Function

* A function is a relationship between inputs and outputs.
* A function defines how outputs are produced from inputs.

### 16. Parameter

* A parameter is a value that influences how a function behaves.
* A parameter can be changed to modify the output of a function.

### 17. Optimization

* Optimization is a process that modifies parameters to improve an output.
* Optimization searches for parameters that produce a better result according to an objective.

### 18. Learning

* a process where a system modifies its parameters using experience or data.
* improves the ability of a system to produce desired outputs.

### 19. Machine Learning

* a computer science field where a system learns from data.
* uses algorithms and parameters to improve outputs without explicitly defining every rule.

### 20. Training

* Training is the process of applying learning to a system using data.
* Training modifies parameters so the system produces better outputs.

### 21. Dataset

* A dataset is a collection of data used by a system.
* A dataset contains examples used for training or evaluation.

### 22. Feature

* A feature is a property of data used as an input by a system.
* A feature represents information that can help produce an output.

### 23. Label

* A label is an output associated with an example in a dataset.
* A label is used to compare a system output with a desired output.

### 24. Inference

* Inference is a process where a trained system produces an output from an input.
* Inference uses parameters learned during training.

### 25. Neural Network

* A neural network is a system composed of connected components that process information.
* A neural network learns by modifying parameters of its components.

### 26. Deep Learning

* Deep learning is machine learning using neural networks with multiple layers of components.
* Deep learning learns representations from data through multiple processes.

### 27. Architecture

* An architecture is the organization of components and relationships in a system.
* An architecture defines how a system is structured.

### 28. Layer

* A layer is a component of a neural network that transforms input into output.
* A layer produces a representation that can be used by another layer.

### 29. Weight

* A weight is a parameter in a neural network.
* A weight controls the influence of an input on an output.

### 30. Activation Function

* An activation function is a function used in a neural network layer.
* An activation function transforms the output of a component.



### 33. Model

* A model is a representation of a system or process.
* A model uses parameters to produce outputs from inputs.


### 35. AI Model

* An AI model is a model used by an artificial intelligence system.
* An AI model uses data, parameters, and processes to produce outputs from inputs.

This version is the correct foundation for the next iterations.
