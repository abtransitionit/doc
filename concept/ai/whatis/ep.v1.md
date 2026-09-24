[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)





<h1 align="center">What is AI</h1>

The concept of AI

# 1. Definition

**AI** stands for **Artificial Intelligence**.

In simple terms:

> **AI is software designed to perform tasks that normally require some form of human intelligence.**

That can include things like:

* understanding language
* recognizing images
* recognizing speech
* learning from examples
* making predictions
* solving problems
* generating content
* making decisions

The important word is **intelligence**.

Not because the machine necessarily thinks like a human.

But because it can perform tasks that we normally associate with intelligent behavior.

---

# 2. Traditional software

Traditionally, software works roughly like this:

```text
Human
  │
  │ gives instructions
  ▼
Software
  │
  │ follows programmed rules
  ▼
Result
```

For example:

You might write:

```text
IF temperature > 30°C
THEN turn on the air conditioning
```

The software doesn't need to understand temperature.

It simply follows the rule.

Another example:

```text
IF username and password are correct
THEN allow login
ELSE reject login
```

The programmer explicitly defines what should happen.

This is the traditional programming model:

```text
Rules + Data → Program → Result
```

---

# 3. So what makes AI different?

AI changes the relationship between **rules** and **behavior**.

Instead of programming every rule manually, we can give an AI system:

```text
Data
+
Examples
+
Learning method
```

and allow it to learn patterns.

Conceptually:

```text
                    DATA
                      │
                      ▼
              ┌───────────────┐
              │   AI MODEL    │
              │               │
              │ learns        │
              │ patterns      │
              └───────┬───────┘
                      │
                      ▼
                   PREDICTION
                   / DECISION
                   / OUTPUT
```

The programmer doesn't necessarily tell the system every rule.

The system learns a model from data.

---

# 4. Machine Learning

A large part of modern AI is based on **Machine Learning**.

Instead of saying:

> "Here are all the rules."

we can say:

> "Here are many examples. Learn the patterns."

For example, imagine we want a system to recognize cats.

Traditional programming might try to describe:

```text
IF animal has
    two ears
    four legs
    whiskers
    certain eye shapes
    certain body proportions
THEN
    cat
```

But real animals don't follow such simple rules.

Instead, with machine learning, we can provide many examples:

```text
Image → CAT
Image → CAT
Image → DOG
Image → CAT
Image → DOG
...
```

The model learns patterns from those examples.

Then we can give it a new image:

```text
             New image
                 │
                 ▼
            ┌─────────┐
            │ AI model│
            └────┬────┘
                 │
                 ▼
             "Probably
                a cat"
```

The important idea is:

> **The system learned a pattern instead of being explicitly programmed with every rule.**

---

# 5. Neural Networks

Modern AI often uses **neural networks**.

A neural network is a mathematical model loosely inspired by the structure of biological brains.

It consists of many interconnected computational units.

Very roughly:

```text
Input
  │
  ▼
┌───┐ ┌───┐ ┌───┐
│ ● │─│ ● │─│ ● │
└───┘ └───┘ └───┘
   \    │    /
    \   │   /
     ▼  ▼  ▼
   ┌───────────┐
   │   Model   │
   └─────┬─────┘
         │
         ▼
       Output
```

During training, the model adjusts enormous numbers of internal parameters.

These parameters allow the model to represent patterns found in the training data.

Modern models can contain **millions, billions, or even trillions of parameters**.

---

# 6. Training

An AI model usually starts without knowing the task it will eventually perform.

It is trained using data.

A simplified training process looks like:

```text
                 DATA
                   │
                   ▼
              AI MODEL
                   │
                   ▼
               PREDICTION
                   │
                   ▼
              compare with
              expected result
                   │
                   ▼
               ERROR
                   │
                   ▼
          adjust model parameters
                   │
                   └───────────┐
                               │
                               ▼
                         repeat millions
                          / billions of
                            times
```

The model makes a prediction.

The prediction is compared with what was expected.

The model is adjusted.

Then the process repeats.

Again.

And again.

And again.

Eventually, the model becomes capable of representing increasingly complex patterns.

---

# 7. From recognizing things to generating things

Early AI systems were often designed to recognize or classify things.

For example:

```text
Is this an email spam?

Is this a cat?

What language is this?

What number is this?

Will this customer probably buy?
```

But modern AI can also **generate** things.

For example:

```text
Text
Images
Audio
Video
Code
Music
```

This is called **Generative AI**.

Instead of only answering:

> "What is this?"

the system can produce:

> "Create something like this."

---

# 8. Generative AI

A generative AI model learns patterns in existing data and can use those patterns to produce new outputs.

For example:

```text
             Your prompt
                  │
                  ▼
           ┌────────────┐
           │ AI Model   │
           └─────┬──────┘
                 │
       ┌─────────┼─────────┐
       ▼         ▼         ▼
      Text      Image     Code
```

You could ask:

```text
Write a Python program
that reads a CSV file.
```

The model can generate code.

Or:

```text
Write an explanation
of quantum computing.
```

The model can generate text.

Or:

```text
Create an image of
a spaceship above Mars.
```

The model can generate an image.

---

# 9. Large Language Models

One of the most important types of modern AI is the **Large Language Model**, or **LLM**.

Examples include models such as:

* GPT
* Claude
* Gemini
* Llama

An LLM is trained on very large amounts of text and learns statistical patterns in language.

At a simplified level, when you give it:

```text
The capital of France is
```

the model predicts what should come next:

```text
Paris
```

But modern language models can represent much more complicated relationships.

For example:

```text
Explain why the sky is blue
```

The model can generate an explanation.

Or:

```text
Translate this paragraph into French
```

It can generate a translation.

Or:

```text
Write a Python function that sorts a list
```

It can generate code.

This makes the LLM feel like a general-purpose interface to intelligence.

---

# 10. The LLM is not a database

An important distinction:

An AI model is **not simply a database containing answers**.

If you ask:

```text
What is 2 + 2?
```

the model doesn't necessarily look up a stored document containing:

```text
2 + 2 = 4
```

Instead, it generates an answer based on patterns represented inside the model.

This is one reason AI systems can sometimes produce incorrect information.

They can generate something that **looks correct** without actually having verified it.

This is commonly called a:

> **hallucination**

So:

```text
AI output ≠ guaranteed truth
```

AI can be extremely useful while still being imperfect.

---

# 11. AI has limitations

AI systems can make mistakes.

For example:

```text
AI

├── can recognize patterns
├── can generate content
├── can summarize information
├── can write code
├── can translate
├── can reason about some problems
│
└── can also
    ├── misunderstand instructions
    ├── generate incorrect information
    ├── miss important context
    ├── make reasoning errors
    └── behave unpredictably in unusual situations
```

This is important because intelligence and reliability are not the same thing.

A system can produce an impressive answer and still be wrong.

---

# 12. AI does not necessarily "think" like a human

When we say:

> "AI understands."

or:

> "AI thinks."

we are often using human language to describe the behavior.

An AI model is not necessarily experiencing the world the way a human does.

It does not automatically have:

* consciousness
* emotions
* desires
* personal experiences
* human common sense
* an understanding of the world identical to ours

Different AI systems may have very different capabilities.

So it is useful to distinguish:

```text
Human intelligence

        ≠

Artificial intelligence
```

AI can reproduce some behaviors associated with intelligence without necessarily reproducing the entire human experience of intelligence.

---

# 13. AI is becoming multimodal

Language is only one type of information.

Modern AI systems can work with multiple modalities:

```text
             ┌───────────────┐
             │   AI MODEL    │
             └───────┬───────┘
                     │
        ┌────────────┼────────────┐
        ▼            ▼            ▼
      TEXT         IMAGE        AUDIO
        │            │            │
        └────────────┼────────────┘
                     │
                     ▼
                  OUTPUT
```

For example, an AI can potentially:

```text
Look at an image
        ↓
Understand what is happening
        ↓
Explain it in text
        ↓
Listen to your voice
        ↓
Respond with speech
```

This creates a much more natural interface between humans and computers.

---

# 14. AI as an interface

This may be one of the biggest changes introduced by modern AI.

Traditional software asks:

> **"Which interface do you know how to use?"**

AI increasingly allows you to say:

> **"What do you want to accomplish?"**

For example, instead of manually navigating through a complicated application:

```text
Open application
    ↓
Find menu
    ↓
Click settings
    ↓
Find option
    ↓
Change value
    ↓
Save
```

you might eventually say:

```text
Configure the system
for next month's campaign.
```

The AI interprets your intent.

But there is an important limitation.

Understanding what you want is not the same as being able to **do** it.

---

# 15. This is where tools become important

Imagine an AI model that can understand:

```text
"Find all invoices from last month."
```

That's useful.

But the model itself may not have access to your email.

So we give the AI tools.

For example:

```text
                 AI MODEL
                     │
       ┌─────────────┼─────────────┐
       ▼             ▼             ▼
     Email          Files         Web
       │             │             │
       ▼             ▼             ▼
     search         read         browse
     emails         files        websites
```

Now the AI can interact with the outside world.

This changes the system from:

```text
AI → answer
```

into:

```text
AI → action → result
```

---

# 16. AI + Tools

This gives us a useful progression:

```text
Traditional software

Human → Software → Result
```

Then:

```text
AI

Human → AI → Answer
```

Then:

```text
AI + Tools

Human → AI → Tools → Result
```

And eventually:

```text
Human
   │
   ▼
  Goal
   │
   ▼
   AI
   │
   ├── Web
   ├── Email
   ├── Files
   ├── Database
   ├── APIs
   └── Computer
        │
        ▼
      Result
```

Now the AI is no longer limited to generating text.

It can potentially **interact with systems**.

---

# 17. And this leads to AI agents

This is where the concept of an **AI agent** begins.

An AI model can answer:

```text
"How can I organize my invoices?"
```

An AI agent could potentially:

```text
Find the invoices
      ↓
Read them
      ↓
Identify dates
      ↓
Rename files
      ↓
Move files
      ↓
Update accounting records
      ↓
Report missing invoices
```

The difference is not simply that one is "smarter."

The difference is that the agent has additional capabilities around the model:

```text
AI Model
   +
Tools
   +
Instructions
   +
Goal
   +
Memory / State
   +
Feedback
   =
AI Agent
```

So:

> **AI provides intelligence.**

> **Tools provide capabilities.**

> **An agent combines them to pursue a goal.**

---

# 18. The bigger picture

You can think about the evolution like this:

```text
                 ARTIFICIAL INTELLIGENCE
                          │
                          ▼
                   Machine Learning
                          │
                          ▼
                   Neural Networks
                          │
                          ▼
                    Deep Learning
                          │
                          ▼
                  Generative AI
                          │
                          ▼
               Large Language Models
                          │
                          ▼
                    AI + Tools
                          │
                          ▼
                    AI Agents
                          │
                          ▼
                 Multi-Agent Systems
```

These aren't perfectly strict historical stages, and the categories overlap.

But they provide a useful mental model.

---

# 19. The key idea

At the most basic level:

```text
Traditional software
= explicitly programmed behavior

Machine learning
= behavior learned from data

Generative AI
= AI that can generate new content

AI + tools
= AI that can interact with systems

AI agent
= AI that can pursue a goal using those capabilities
```

And that gives us a simple way to understand the whole field:

```text
                    AI

       "Can the machine perform
        something intelligent?"

                     │
                     ▼

              Generative AI

       "Can it create something?"

                     │
                     ▼

                 AI + Tools

       "Can it do something?"

                     │
                     ▼

                AI Agents

       "Can it pursue a goal?"

                     │
                     ▼

             Multi-Agent Systems

       "Can several AI systems
        coordinate to achieve goals?"
```

The interesting question therefore changes.

It starts with:

> **"Can a machine be intelligent?"**

Then becomes:

> **"What can AI understand and generate?"**

Then:

> **"What can AI do?"**

And eventually:

> **"What can we safely allow AI to do by itself?"**

That is the bridge from **AI** to **AI agents**.

And that is where the next concept begins:

> **What is an AI Agent?**
