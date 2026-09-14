[//]: #(home)
[home]: ../whatis/lfc.prj.md

[//]: #(ref)
[lifecycle whatis]: ../whatis/lfc.md



[↖][home]



<h1 align="center">Project Lifecycle's phases in detail</h1>

This section describes:
  - what the project
  - why it exists

This section does not descibes any implementation

# Vision phase <a id='vision'></a>

## 1. Context

- Why this project ?
- The context of it creation ?

## 2. Problem

- Quel problème cherche-t-on à résoudre ?
- Pourquoi ce problème est-il important ?

## 3. Vision

- Quelle transformation veut-on apporter ?
- À quoi ressemble le monde si le projet réussit pleinement ?

## 4. Objectives

Quels sont les objectifs principaux du projet ?

## 5. Scope

### In scope

- Ce que le projet cherche à couvrir.

### Out of scope

- Ce que le projet ne cherche volontairement pas à couvrir.

## 6. Target Users

- Qui sont les utilisateurs ou bénéficiaires du projet ?

## 7. Value Proposition

- Quelle valeur le projet apporte-t-il à ses utilisateurs ?

## 8. Success Criteria

- Comment saura-t-on que le projet a réussi ?



Ça permet de garder cette section stable même si, plus tard, toute l'architecture ou la technologie change.

Pour ton projet de CLI, par exemple, **« permettre de décrire, provisionner et gérer n'importe quelle ressource, sur n'importe quel environnement, au travers d'un modèle unique, cohérent et extensible »** irait directement dans **3. Vision**.


# Todo

- **00 Vision**: 
  - qu'est-ce qu'on veut
  - pourquoi
- **01 Modèle**: de domaine
  - glossaire
  - les invariants, 
  - concepts
    - resource
    - host
    - provider
    - state
  - relations
- **02 Exigences**:
  - cas d'usage
  - exigences fonctionnelles
  - exigences non fonctionnelles
- **03 Roadmap**: 
  - phases
  - versions
  - priorités
- **04 Architecture**
  - principes, architecture logique, 
  - architecture technique, 
  - journal d'évolution. 
  - décisions d'architecture et 
  - architecture logique
  - architecture technique
  - composants
  - interfaces
  - ADR
- **05 Implémentation** 
  - structure du code
  - standards
  - tests
  - CI/CD
- **06 Operations**
  - exploitation
  - monitoring
  - maintenance
  - sécurité
  - documentation
- **07 Évolution**
  - historique
  - décisions
  - dettes techniques
  - idées



## [↑](#cycle) [Vision][phase vision whatis]  <a id='vision'></a>

- **Core Question:** Why? (What problem does it solve?)
- Define the name, purpose, goal, objective
- Idea, Discovery, Vision, Goal
- Aligns with business / project objectives
- example of answers
  - Make knowledge easy to share.



## [↑](#cycle) Requirements  <a id='requirement'></a>

- **Core Question:** What?
- Define what is needed (product or service)
- Focus on *the what*, not *the how* (e.g., "Must support document search," not "Use Elasticsearch.")
- Aligns with product / service definition
- Capture what’s needed to achieve the goal.


## [↑](#cycle)  Roadmap  <a id='roadmap'></a>

- **Core Question:** When & Who?
- Outline planned work and timeline
- Sets strategic direction and milestones
- Break the work into a timeline and assign responsibilities. (e.g., "Phase 1: MVP," "Phase 2: Add Search.") 


## [↑](#cycle) Implementation  <a id='implementation'></a>

- **Core Question:** How?
- The construction/development process
- Build, create, or execute the planned work. (e.g., Write code, construct a building, deliver training.) 

## [↑](#cycle) Verification  <a id='verification'></a>

- **Core Question:** Does it work?
- Test and validate deliverables
- Quality assurance (ensure correctness + fitness for purpose)
- Test and review the output to ensure it meets the requirements and satisfies stakeholders.

## [↑](#cycle) Operations  <a id='operation'></a>

- **Core Question:** How to run it?
- Deploy, launch, maintain the product/service/output (e.g., Hosting a website, staffing a service.)
- Covers ongoing support and maintenance


## [↑](#cycle) Improvement  <a id='improvement'></a>

- **Core Question:** How well?
- Measure performance and identify improvements
- Continuous refinement and optimization
- Track performance data and feedback to identify what can be better. 

## [↑](#cycle) Feedback  <a id='feedback'></a>

- **Core Question:** What's next?
- Feed insights back to the beginning
- Continuous cycle for ongoing alignment
- Use insights from measurement
- Update the Vision and start the cycle again
- Ensure continuous improvement.

