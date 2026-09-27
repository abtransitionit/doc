[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[project whatis]: ../../../concept/project/whatis/ep.md
[project software lfc whatis]: #
[phase log status whatis]: ../log/phase.log.md

Related topics

| Topic | Location | Kind |
|---|---|---|
|[Santiago Siri linked-IN][santiago whatis]|axternal|
|[El Primer Feca whatis][feac whatis]|axternal|


<h1 align="center">Project: Feca</h1>

An Agent for Rpro


# Definition

## Agent
Un agent est très bon pour **comprendre une intention et décider quelles actions effectuer**.


# Le projet
Pour ton projet **RPRO**, une idée serait :

> **Go = moteur déterministe de provisioning**
> **Agent IA = couche d’orchestration / interface intelligente au-dessus**


```text
                  ┌─────────────────────┐
                  │      Agent IA       │
                  │                     │
                  │ "Crée-moi un EKS   │
                  │ avec ces contraintes"│
                  └──────────┬──────────┘
                             │
                   plan / appels d'outils
                             │
                  ┌──────────▼──────────┐
                  │        RPRO         │
                  │      en Go          │
                  │                     │
                  │ providers            │
                  │ state               │
                  │ validation          │
                  │ idempotence         │
                  │ policy              │
                  │ execution           │
                  └──────────┬──────────┘
                             │
             ┌───────────────┼────────────────┐
             ▼               ▼                ▼
           AWS             Azure            K8s
```

### Pourquoi ?

Si tu fais **RPRO entièrement en agent**, tu risques d'avoir un système difficile à rendre :

* déterministe ;
* idempotent ;
* testable ;
* auditable ;
* sécurisé ;
* prévisible en production.

Go est très bon pour **exécuter ces actions de manière contrôlée**.


### Idée: construire RPRO en 3 couches

**1. Core Go**

Le moteur :

```text
Resource
Provider
Plan
State
Dependency
Policy
Action
Execution
```

Par exemple :

```text
rpro plan
rpro apply
rpro destroy
rpro import
rpro status
```

**2. Tool/API layer**

Expose RPRO comme des outils utilisables par un agent :

```text
rpro.list_resources()
rpro.get_resource()
rpro.plan()
rpro.apply()
rpro.delete()
rpro.get_status()
```

L'agent **ne manipule jamais directement AWS/Azure/Kubernetes**: Il passe par RPRO.

**3. Agent**

L'agent devient ton interface :

> « J'ai besoin d'un environnement de staging avec une DB PostgreSQL, un cluster Kubernetes et un bucket S3. »

L'agent transforme ça en :

```text
requirements
    ↓
resource graph
    ↓
rpro plan
    ↓
validation
    ↓
approval
    ↓
rpro apply
```

Et là, tu obtiens quelque chose de beaucoup plus intéressant qu'un simple outil Go.

## Path

Je ne passerais **pas 6 mois à développer RPRO traditionnellement puis ajouter l'IA**.

Je commencerais directement avec : **Go + architecture agent-ready.**

Mais je construirais d'abord **le moteur déterministe**, puis un proto-agent très simple par-dessus.

Ton premier objectif pourrait même être :

> **"Est-ce qu'un LLM peut utiliser RPRO correctement comme un ensemble de tools pour provisionner un environnement ?"**

Si oui, tu as une direction très intéressante.

Et surtout : **ne construis pas un "agent DevOps qui fait tout". Construis un excellent moteur de provisioning que les agents savent utiliser.**

C'est une distinction importante.
