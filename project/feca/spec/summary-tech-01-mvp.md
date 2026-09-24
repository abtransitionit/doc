[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Project Feca : Summary for a MVP</h1>

# 1. Architecture générale

Architecture modulaire orientée workflow :

```text
Frontend
Next.js / React / TypeScript
        ↓
Backend API
Python / FastAPI
        ↓
Orchestrateur
Celery + Redis
        ↓
Agents IA
        ↓
Services externes
LLM / Search / TTS / Avatar
        ↓
PostgreSQL + Object Storage
```

Le backend est le point central. Les agents ne s'appellent pas directement entre eux : **l'orchestrateur gère leur exécution et leurs dépendances.**


# 2. Frontend

**Stack**

* Next.js
* React
* TypeScript
* Tailwind CSS

**Fonctions principales**

* Dashboard
* Création d'un sujet
* Suivi d'un workflow
* Consultation/modification du script
* Choix voix/avatar
* Prévisualisation vidéo
* Historique des productions

Le frontend communique uniquement avec l'API backend.


# 3. Backend

**Stack**

* Python
* FastAPI
* Pydantic
* SQLAlchemy
* PostgreSQL

Responsabilités :

* authentification ;
* gestion des projets ;
* gestion des workflows ;
* communication avec les agents ;
* gestion des fichiers ;
* gestion des erreurs ;
* logs et métriques.


# 4. Orchestration

**MVP : Celery + Redis**

Chaque étape longue est exécutée comme une tâche asynchrone.

```text
Workflow
  ↓
Task 1 → Recherche
  ↓
Task 2 → Analyse
  ↓
Task 3 → Script
  ↓
Task 4 → Vérification
  ↓
Task 5 → Audio
  ↓
Task 6 → Avatar
  ↓
Task 7 → Montage
  ↓
Task 8 → Contrôle qualité
```

Chaque tâche possède un état :

`PENDING → RUNNING → SUCCESS / FAILED`

En cas d'erreur : retry automatique puis passage en `FAILED` si le nombre maximal de tentatives est atteint.


# 5. Agents

Chaque agent expose une interface standardisée.

```python
class Agent:
    async def execute(self, input) -> output:
        ...
```

Agents MVP :

```text
NewsAgent
ResearchAgent
ScriptAgent
QualityAgent
VoiceAgent
AvatarAgent
VideoAgent
```

Chaque exécution doit enregistrer :

* agent ;
* provider ;
* modèle ;
* durée ;
* input/output ;
* statut ;
* erreur ;
* coût estimé.


# 6. Abstraction des fournisseurs

Ne jamais dépendre directement d'un fournisseur dans les agents.

Exemple :

```text
LLMProvider
SearchProvider
TTSProvider
AvatarProvider
StorageProvider
```

Cela permet de remplacer un fournisseur sans modifier la logique métier.


# 7. Base de données

## Tables principales

```text
users
projects
topics
sources
scripts
workflows
agent_runs
audios
videos
```

## Relations principales

```text
User
 └── Projects
      └── Topics
           ├── Sources
           └── Workflows
                └── AgentRuns
                     ├── Scripts
                     ├── Audios
                     └── Videos
```

PostgreSQL stocke uniquement les **données structurées**.


# 8. Stockage des fichiers

Les fichiers lourds sont stockés dans un stockage objet :

**AWS S3 / Cloudflare R2 / GCS**

Exemples :

```text
/projects/{project_id}/
    /sources/
    /scripts/
    /audio/
    /avatars/
    /videos/
```

La base de données conserve uniquement les métadonnées et références vers les fichiers.


# 9. API REST

Endpoints principaux :

```text
POST   /auth/login

GET    /projects
POST   /projects

GET    /projects/{id}

POST   /topics
GET    /topics/{id}

POST   /workflows
GET    /workflows/{id}

GET    /workflows/{id}/status

GET    /scripts/{id}
PATCH  /scripts/{id}

GET    /videos/{id}
POST   /videos/{id}/publish
```

Documentation automatique via **OpenAPI / Swagger**.


# 10. Workflow de production

```text
CREATE_TOPIC
     ↓
SEARCH
     ↓
RESEARCH
     ↓
GENERATE_SCRIPT
     ↓
FACT_CHECK
     ↓
[Validation humaine]
     ↓
GENERATE_AUDIO
     ↓
GENERATE_AVATAR
     ↓
ASSEMBLE_VIDEO
     ↓
QUALITY_CONTROL
     ↓
READY
```

Chaque étape reçoit les résultats de l'étape précédente et produit un résultat versionné.


# 11. Gestion des erreurs

Pour les services externes :

* timeout ;
* retry automatique ;
* backoff ;
* limitation du nombre de tentatives ;
* fallback fournisseur si disponible.

Une erreur d'un agent ne doit pas faire perdre l'ensemble du workflow.

# 12. Sécurité

* Authentification JWT/session sécurisée.
* Gestion des rôles.
* Clés API uniquement côté backend.
* Secrets dans des variables d'environnement / secret manager.
* URLs temporaires pour les fichiers privés.
* Isolation des données entre utilisateurs.
* Validation des fichiers entrants.

Les contenus récupérés sur le web sont considérés comme **non fiables** et ne doivent jamais pouvoir modifier les instructions système des agents.


# 13. Observabilité

Chaque workflow doit permettre de connaître :

```text
Workflow
├── état
├── durée
├── étapes exécutées
├── erreurs
├── modèles utilisés
├── tokens
├── coûts
└── fichiers générés
```

Prévoir dès le départ des logs structurés et un système de monitoring.


# 14. Tests

Minimum :

* **Unit tests** : agents et logique métier.
* **Integration tests** : API + base de données.
* **Workflow tests** : chaîne complète.
* **E2E** : création d'un sujet jusqu'à la vidéo finale.


# 15. Déploiement

Trois environnements :

```text
Development
     ↓
Staging
     ↓
Production
```

Chaque service doit être containerisé avec **Docker**.

CI/CD :

```text
Git push
  ↓
Tests
  ↓
Build
  ↓
Deploy staging
  ↓
Validation
  ↓
Production
```


# 16. Structure backend

```text
backend/
├── app/
│   ├── api/
│   ├── agents/
│   │   ├── news/
│   │   ├── research/
│   │   ├── script/
│   │   ├── quality/
│   │   ├── voice/
│   │   ├── avatar/
│   │   └── video/
│   ├── workflows/
│   ├── providers/
│   ├── models/
│   ├── repositories/
│   ├── services/
│   └── core/
├── tests/
└── Dockerfile
```


# 17. Priorités de développement

## V1 — MVP

* Authentification
* Projets
* Recherche
* Script
* Vérification
* TTS
* Avatar
* Montage vidéo
* Dashboard
* Workflow asynchrone

## V2

* Veille automatique
* Multi-avatars
* Multilingue
* B-roll automatique
* Publication automatique
* Analytics

## V3

Transformation en véritable **content factory multi-formats** : vidéos longues, shorts, réseaux sociaux, podcasts, articles, etc.


# Principe technique

Le système doit privilégier **la modularité, l'orchestration et le remplacement facile des fournisseurs**.

Un nouvel agent ou un nouveau fournisseur doit pouvoir être ajouté sans modifier l'ensemble de l'application.


# POC vs; MVP

Pas besoin de construire les 7 agents dès le départ. On peut chercher à démontrer **la chaîne de valeur complète avec le minimum de code** :

**1 sujet → 1 recherche → 1 script → 1 voix → 1 avatar → 1 vidéo.**

Une fois cette chaîne fonctionnelle, on saura exactement **quelles parties méritent d'être industrialisées pour le MVP**.

👉 Donne-moi maintenant ta vision du **POC en mode dev**, même si elle est très brute. On pourra ensuite la transformer en **plan de développement extrêmement court et concret**.
