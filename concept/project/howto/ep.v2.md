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



<h1 align="center">How-to for Project</h1>





# bootsrap a sofware project

how to build a software project from an initial idea to its first usable release, then continue with subsequent releases.

## Step 00: Project's lifecycle

- adopt or define a project's [lifecycle][lfc whatis] to document the project. Example [this one][prj lfc whatis]:
```
vision → domain → model → prototype → implementation → validation → release → operation
```

- adopt or define a [roadmap][roadmap whats] to plan what will be delivered. Example [this one][prj roadmap whatis]:

  - explain 

The idea: follow tvhis steps: `Ìdea → Lifecycle → Roadmap → Implementation → Release → Next release`

# Step 01: define the vision phase of the lifecycle

Define what the software should achieve, why it is needed, and who will use it.

# Step 02: Define the domain
- Now that we know **what we want to achieve**, we identify the concepts that exist in the problem space.
- For our provisioning system, the key domain concepts are:
  - xxxx
  - yyyy
  - ...
- The important point is that we are **not designing the software yet**.
- We are identifying and understanding the concepts

- document the domain concepts and their relationships



# Todo

- **The Logic is Stable:** The sequence of questions (Why? → What? → When/Who? → How? → Check → Run → Measure → Adapt) remains the same for any project.
- **Separate the "What" from the "How":** Your **Requirements** (Phase 2) should describe the problem and needs, not the specific technology or solution. This makes your project more flexible and resilient to change.

# Todo

```
Design
  ├── Domain
  ├── Prototype
  ├── ADR
  └── Model
```
```
Domain
  → What exists?

Design / Architecture
  → How does the system make it happen?
```  