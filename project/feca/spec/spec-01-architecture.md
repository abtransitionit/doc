[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Feca Specification</h1>

This section provide un **cahier des charges technique**, for 
  - an MVP
  - une montée en charge progressive.

# 1. Cahier des charges technique

Plateforme multi-agents IA de génération automatisée de vidéos d’actualité

- **Version :** 1.0
- **Statut :** Spécification fonctionnelle et technique
- **Objectif :** MVP puis industrialisation


# 2. Objectifs

## 2.1 Objectif principal

Permettre à un utilisateur de sélectionner un thème ou de laisser le système détecter automatiquement un sujet d'actualité, puis de générer une vidéo courte prête à être publiée.

## 2.2 Objectifs secondaires

La plateforme devra permettre :

source

* surveiller automatiquement plusieurs sources d'information ;
* identifier les sujets intéressants ;
* récupérer plusieurs sources pour un même événement ;

texte
* générer un script court ;
* conserver les sources utilisées ;

audio
* générer une narration audio ;

videao
* générer une vidéo avec avatar ;
* générer des sous-titres ;

* contrôler automatiquement le contenu ;
* conserver l'historique de production ;

evolution
* relancer une étape sans recommencer tout le pipeline ;
* gérer plusieurs formats vidéo ;
* gérer plusieurs langues à terme.


# 3. Utilisateurs

## 3.1 Administrateur

L'administrateur peut :

* gérer les utilisateurs ;
* configurer les agents ;
* modifier les prompts ;
* configurer les fournisseurs IA ;
* gérer les sources ;
* consulter les logs ;
* consulter les coûts ;
* relancer des workflows ;
* activer/désactiver des agents.

## 3.2 Créateur de contenu

Le créateur peut :

* créer un sujet ;
* sélectionner une catégorie ;
* lancer une génération ;
* modifier le script ;
* choisir un avatar ;
* choisir une voix ;
* prévisualiser la vidéo ;
* valider ou rejeter une production ;
* télécharger/exporter la vidéo.


# 4. Architecture générale

L'architecture recommandée est la suivante :

```text
                         FRONTEND
                            │
                            ▼
                     API Gateway
                            │
              ┌─────────────┴─────────────┐
              │                           │
              ▼                           ▼
        Application API             Auth Service
              │
              ▼
       Workflow Orchestrator
              │
       ┌──────┼────────┬────────┬─────────┐
       ▼      ▼        ▼        ▼         ▼
    Search  Research  Script   Media     QA
    Agent    Agent    Agent    Agents    Agent
       │       │        │        │         │
       └───────┴────────┴────────┴─────────┘
                       │
                       ▼
                Message Queue
                       │
          ┌────────────┼─────────────┐
          ▼            ▼             ▼
       PostgreSQL    Object        Redis
                      Storage
          │            │
          └────────────┴─────────────┐
                                     ▼
                              External APIs
                         ┌───────────┼───────────┐
                         ▼           ▼           ▼
                       LLM        TTS       Avatar/Video
```

---

# 5. Stack technique recommandée

## Frontend

- **mvp**: markdown + algernon
- **cible**: **Next.js + React + TypeScript**

Responsabilités :

* interface utilisateur ;
* dashboard ;
* gestion des projets ;
* suivi des workflows ;
* éditeur de scripts ;
* prévisualisation vidéo ;
* gestion des avatars et voix.

UI recommandée :

* Tailwind CSS ;
* shadcn/ui ;
* React Query / TanStack Query.

---

# 6. Backend

## API

**Python + FastAPI**

Python est particulièrement adapté au projet grâce à son écosystème IA.

Responsabilités :

* authentification ;
* API REST ;
* gestion des projets ;
* gestion des agents ;
* gestion des workflows ;
* communication avec les fournisseurs IA ;
* gestion des tâches ;
* gestion des fichiers.

Structure possible :

```text
backend/
├── app/
│   ├── api/
│   ├── agents/
│   │   ├── news/
│   │   ├── research/
│   │   ├── script/
│   │   ├── voice/
│   │   ├── avatar/
│   │   ├── video/
│   │   └── quality/
│   ├── workflows/
│   ├── models/
│   ├── services/
│   ├── providers/
│   ├── repositories/
│   └── core/
├── tests/
└── main.py
```

---

# 7. Base de données


- **mvp**: sqlite.
- **cible**: PostgreSQL sera la base principale.

Elle stockera :

* utilisateurs ;
* projets ;
* sujets ;
* sources ;
* scripts ;
* agents ;
* exécutions ;
* vidéos ;
* avatars ;
* voix ;
* workflows ;
* erreurs ;
* coûts ;
* historiques.

## Modèle de données simplifié

```text
USER
 │
 ├── PROJECT
 │      │
 │      ├── TOPIC
 │      │      │
 │      │      ├── SOURCE
 │      │      └── SCRIPT
 │      │
 │      ├── WORKFLOW
 │      │      │
 │      │      └── AGENT_RUN
 │      │
 │      └── VIDEO
 │             ├── AUDIO
 │             └── AVATAR
```

## Tables principales

### users

```text
id
email
password_hash
role
created_at
updated_at
```

### projects

```text
id
user_id
name
description
status
created_at
updated_at
```

### topics

```text
id
project_id
title
category
summary
status
created_at
```

### sources

```text
id
topic_id
url
title
publisher
published_at
content
reliability_status
created_at
```

### scripts

```text
id
topic_id
version
content
language
duration_seconds
status
created_at
updated_at
```

### workflows

```text
id
project_id
topic_id
status
current_step
started_at
completed_at
error
```

### agent_runs

```text
id
workflow_id
agent_type
status
input
output
model
provider
tokens_input
tokens_output
cost
started_at
completed_at
error
```

### videos

```text
id
workflow_id
script_id
avatar_id
voice_id
video_url
thumbnail_url
duration
format
resolution
status
created_at
```

---

# 8. Stockage des fichiers

Les fichiers lourds ne doivent pas être stockés directement dans PostgreSQL.

- **mvp**: filesystem
- **cible**: Utiliser un stockage objet compatible S3 :

* AWS S3 ;
* Cloudflare R2 ;
* Google Cloud Storage ;
* ou équivalent.

Arborescence :

```text
/projects/{project_id}/
    /sources/
    /scripts/
    /audio/
    /avatars/
    /videos/
    /thumbnails/
    /subtitles/
```

---

# 9. Architecture des agents IA

Chaque agent doit être considéré comme un service indépendant.

Un agent doit avoir :

```text
INPUT
  ↓
Validation
  ↓
Traitement
  ↓
OUTPUT
  ↓
Validation
  ↓
Persistance
```

Chaque agent doit retourner un résultat structuré.

Exemple :

```json
{
  "status": "success",
  "data": {},
  "metadata": {
    "model": "model-name",
    "duration_ms": 2400,
    "cost": 0.02
  }
}
```


## 9.1 Agent 1 — Veille / News Agent

### Rôle

Détecter des sujets d'actualité pertinents.

### Entrées

```json
{
  "categories": [
    "technology",
    "science"
  ],
  "languages": ["fr"],
  "max_results": 10
}
```

### Fonctionnement

1. Interroger les sources.
2. Récupérer les articles récents.
3. Dédupliquer les articles.
4. Regrouper les articles parlant du même événement.
5. Identifier les sujets.
6. Enregistrer les sources.

### Sortie

```json
{
  "topic": "Nouveau lancement technologique",
  "sources": [
    {
      "title": "...",
      "url": "...",
      "publisher": "..."
    }
  ]
}
```


## 9.2 Agent 2 — Research Agent

### Rôle

Approfondir un sujet avant la rédaction.

L'agent doit rechercher plusieurs sources et construire une synthèse structurée.

### Objectif

Éviter qu'un script soit généré à partir d'une seule source.

### Sortie

```json
{
  "topic": "...",
  "facts": [
    "...",
    "...",
    "..."
  ],
  "sources": [
    {
      "url": "...",
      "supports": [
        "fact_1"
      ]
    }
  ],
  "uncertainties": []
}
```

Chaque affirmation importante du script devra idéalement pouvoir être reliée à une source.


## 9.3 Agent 3 — Script Agent

### Rôle

Transformer les informations en script vidéo.

Paramètres :

```text
Langue : français
Durée : 30-60 secondes
Style : informatif
Public : général
```

Exemple de structure :

```text
HOOK
↓
CONTEXTE
↓
INFORMATION PRINCIPALE
↓
EXPLICATION
↓
CONCLUSION
```

Sortie :

```json
{
  "title": "...",
  "hook": "...",
  "script": "...",
  "estimated_duration": 45,
  "sources": []
}
```

Le script doit rester distinct des métadonnées et des sources.


## 9.4 Agent 4 — Fact Checking / Quality Agent

### Rôle

Cet agent constitue une étape importante du système.

Il reçoit :

```text
Script
+
Sources
+
Research report
```

Il vérifie notamment :

* cohérence factuelle ;
* présence de sources ;
* contradictions ;
* dates ;
* chiffres ;
* noms propres ;
* formulations excessives ;
* informations non présentes dans les sources.

Résultat :

```json
{
  "status": "approved",
  "score": null,
  "issues": [],
  "required_changes": []
}
```

Il est préférable de ne pas utiliser un simple score global : le système doit retourner des **problèmes explicites et traçables**.


## 9.5 Agent 5 — Voice Agent

### Rôle

Transformer le script en audio.

Le backend communique avec un fournisseur de Text-To-Speech.

Le fournisseur pourra être remplacé sans modifier le reste de l'application.

Interface interne :

```python
generate_audio(
    text,
    voice_id,
    language,
    speed
)
```

Sortie :

```json
{
  "audio_url": "...",
  "duration": 42.3,
  "provider": "...",
  "voice_id": "..."
}
```


## 9.6 Agent 6 — Avatar Agent

### Rôle

Créer une vidéo dans laquelle un avatar prononce le script.

Entrées :

```text
audio
+
avatar
+
format vidéo
```

Sortie :

```json
{
  "video_url": "...",
  "duration": 42,
  "resolution": "1080x1920"
}
```

Le système doit être conçu avec une abstraction permettant de remplacer le fournisseur d'avatars.

```text
AvatarProvider
      │
      ├── Provider A
      ├── Provider B
      └── Provider C
```


## 9.7 Agent 7 — Video Assembly Agent

Cet agent réalise le montage final.

Il peut assembler :

* avatar ;
* audio ;
* sous-titres ;
* images ;
* vidéos d'illustration ;
* logo ;
* musique ;
* transitions ;
* titres.

Technologie possible :

**FFmpeg**

Exemple :

```text
Avatar video
      +
Subtitles
      +
Images
      +
Logo
      ↓
FFmpeg
      ↓
Final video
```

Formats initiaux :

```text
1080 × 1920
9:16
MP4
H.264
AAC
```


# 9.8 Agent 8 — Final Quality Agent

Avant de considérer la vidéo comme terminée :

```text
Video
 ↓
Technical checks
 ↓
Content checks
 ↓
Metadata checks
 ↓
Final status
```

Contrôles :

* vidéo lisible ;
* durée correcte ;
* audio présent ;
* résolution correcte ;
* sous-titres présents ;
* absence de fichier corrompu ;
* correspondance script/audio ;
* présence des métadonnées.


# 10. Orchestration des agents

Le workflow doit être géré par un orchestrateur.

Deux approches sont possibles :

### MVP

**Celery + Redis**

Simple à mettre en place.

### Architecture Cible

Utiliser un moteur de workflow durable comme **Temporal**.

Temporal devient particulièrement intéressant lorsque les workflows deviennent longs et comportent :

* appels API externes ;
* retries ;
* attentes de plusieurs minutes ;
* callbacks ;
* génération vidéo ;
* reprises après erreur ;
* étapes humaines de validation.


# 11. Workflow complet

```text
CREATE_TOPIC
      ↓
SEARCH
      ↓
COLLECT_SOURCES
      ↓
RESEARCH
      ↓
GENERATE_SCRIPT
      ↓
FACT_CHECK
      │
      ├── FAILED → REWRITE_SCRIPT
      │                 ↓
      │             FACT_CHECK
      │
      ▼
GENERATE_AUDIO
      ↓
GENERATE_AVATAR
      ↓
ASSEMBLE_VIDEO
      ↓
QUALITY_CONTROL
      │
      ├── FAILED → REGENERATE
      │
      ▼
READY
      ↓
PUBLISH
```


# 12. API backend

## Authentification

```http
POST /api/auth/login
POST /api/auth/register
POST /api/auth/refresh
```

## Projects

```http
GET    /api/projects
POST   /api/projects
GET    /api/projects/{id}
DELETE /api/projects/{id}
```

## Topics

```http
GET  /api/projects/{id}/topics
POST /api/projects/{id}/topics
POST /api/topics/{id}/research
```

## Scripts

```http
GET   /api/topics/{id}/scripts
POST  /api/topics/{id}/scripts
PATCH /api/scripts/{id}
POST  /api/scripts/{id}/validate
```

## Workflows

```http
POST /api/workflows
GET  /api/workflows/{id}
POST /api/workflows/{id}/cancel
POST /api/workflows/{id}/retry
```

## Videos

```http
GET  /api/videos
GET  /api/videos/{id}
POST /api/videos/{id}/generate
GET  /api/videos/{id}/download
```


# 13. APIs externes

La plateforme doit utiliser des **adapters/providers** afin de ne pas être dépendante d'un fournisseur unique.

## LLM

Interface :

```text
LLMProvider
```

Responsabilités :

* génération de texte ;
* synthèse ;
* classification ;
* extraction structurée ;
* fact-checking assisté.

Le fournisseur exact peut être sélectionné lors de l'implémentation selon les contraintes de coût, qualité, confidentialité et disponibilité.

## Recherche web

Interface :

```text
SearchProvider
```

Responsabilités :

* recherche ;
* récupération de résultats ;
* métadonnées ;
* éventuellement extraction du contenu.

## Text-to-Speech

Interface :

```text
TTSProvider
```

## Avatar

Interface :

```text
AvatarProvider
```

## Storage

Interface :

```text
StorageProvider
```

Cela permet par exemple de changer de fournisseur vidéo sans modifier :

```text
Script Agent
Workflow
Frontend
Database
```

---

# 22. Message Queue

Pour les tâches longues, le frontend ne doit pas attendre directement la réponse.

Exemple :

```text
Frontend
   ↓
POST /workflows
   ↓
API
   ↓
Queue
   ↓
Worker
   ↓
Agent
```

Le frontend récupère ensuite l'état :

```http
GET /api/workflows/{id}
```

ou reçoit les changements via WebSocket/SSE.

États possibles :

```text
PENDING
RUNNING
WAITING
FAILED
COMPLETED
CANCELLED
```


# 14. Frontend

Le dashboard principal pourrait être organisé ainsi :

```text
┌─────────────────────────────────────────────┐
│ Dashboard                                   │
├─────────────┬───────────────────────────────┤
│             │                               │
│ Projets     │  Production en cours         │
│             │                               │
│ Actualités  │  ┌─────────────────────────┐ │
│             │  │ Sujet                   │ │
│ Vidéos      │  │ ███████████░░ 75%      │ │
│             │  │ Avatar en génération    │ │
│ Agents      │  └─────────────────────────┘ │
│             │                               │
│ Paramètres  │  Vidéos récentes             │
│             │                               │
└─────────────┴───────────────────────────────┘
```


# 15. Écran de création

L'utilisateur peut choisir :

```text
Sujet
[________________________]

Catégorie
[ Technologie ▼ ]

Langue
[ Français ▼ ]

Durée
[ 30 sec ▼ ]

Avatar
[ Avatar 01 ▼ ]

Voix
[ Voix 01 ▼ ]

Format
[ 9:16 ▼ ]

       [ Générer ]
```


# 16. Écran de production

L'utilisateur voit l'avancement en temps réel :

```text
✓ Recherche
✓ Analyse
✓ Script
✓ Vérification
✓ Audio
● Avatar
○ Montage
○ Contrôle qualité
```

Chaque étape doit pouvoir être ouverte pour afficher :

* input ;
* output ;
* durée ;
* fournisseur ;
* modèle ;
* coût ;
* erreurs éventuelles.


# 17. Observabilité

Chaque appel IA doit être enregistré.

Exemple :

```json
{
  "agent": "script_agent",
  "provider": "llm_provider",
  "model": "model",
  "duration_ms": 3200,
  "input_tokens": 1200,
  "output_tokens": 450,
  "cost": 0.01,
  "status": "success"
}
```

Cela permettra de connaître le coût réel d'une vidéo.


# 18. Gestion des erreurs

Tous les appels externes doivent prévoir :

```text
Timeout
Retry
Backoff
Fallback
Logging
```

Exemple :

```text
Avatar API
    ↓
Erreur
    ↓
Retry #1
    ↓
Erreur
    ↓
Retry #2
    ↓
Erreur
    ↓
Fallback provider
```

Une erreur sur l'avatar ne doit pas obliger à refaire :

```text
Recherche
Script
Fact-checking
Audio
```

Le système doit reprendre au dernier point valide.


# 19. Sécurité

Le backend doit prévoir :

* JWT ou sessions sécurisées ;
* hash des mots de passe ;
* gestion des rôles ;
* validation des inputs ;
* limitation du nombre de requêtes ;
* secrets stockés dans un Secret Manager ;
* URLs signées pour les fichiers privés ;
* logs d'accès ;
* isolation des fichiers utilisateurs.

Les clés API des fournisseurs IA ne doivent **jamais** être exposées au frontend.


# 20. Dockerisation

Tous les composants doivent pouvoir fonctionner via Docker.

```text
docker-compose.yml

services:

  frontend
  backend
  worker
  postgres
  redis
```

En production, cette architecture pourra évoluer vers :

```text
Frontend
    ↓
Load Balancer
    ↓
API
    ↓
Queue
    ↓
Workers
    ↓
External APIs
```


# 21. MVP

Le MVP doit volontairement rester limité.

## Fonctionnalités MVP

### Recherche

* recherche manuelle d'un sujet ;
* recherche web ;
* récupération de plusieurs sources.

### IA

* génération du résumé ;
* génération du script ;
* vérification du script.

### Vidéo

* une voix ;
* un avatar ;
* format vertical ;
* génération audio ;
* génération vidéo ;
* sous-titres.

### Interface

* login ;
* dashboard ;
* création d'un sujet ;
* affichage du workflow ;
* édition du script ;
* prévisualisation ;
* téléchargement de la vidéo.


# 22. Version 2

Après validation du MVP :

* veille automatique ;
* plusieurs avatars ;
* plusieurs voix ;
* plusieurs langues ;
* montage automatique avancé ;
* images d'illustration ;
* vidéos B-roll ;
* génération de thumbnails ;
* publication automatique ;
* analytics ;
* A/B testing des formats ;
* gestion de plusieurs chaînes/comptes.


# 23. Version 3

Architecture plus avancée :

```text
                    AI CONTENT PLATFORM
                            │
       ┌────────────────────┼────────────────────┐
       │                    │                    │
   News Factory        Video Factory       Social Factory
       │                    │                    │
    Research             Avatar             Publishing
    Scripts              Voice              Scheduling
    Fact-check            Editing            Analytics
```

La plateforme pourrait alors produire automatiquement plusieurs variantes d'un même contenu :

```text
Article
   │
   ├── TikTok
   ├── Instagram Reels
   ├── YouTube Shorts
   ├── YouTube
   └── Article / Newsletter
```


# 24. Principe architectural important

Le point central du projet est de **ne pas coupler les agents entre eux**.

Mauvaise architecture :

```text
Agent A → Agent B → Agent C
```

où chaque agent appelle directement le suivant.

Architecture recommandée :

```text
             Workflow Engine
                    │
       ┌────────────┼────────────┐
       ↓            ↓            ↓
    Agent A      Agent B      Agent C
       │            │            │
       └────────────┴────────────┘
                    │
                 Database
```

Le workflow engine décide quel agent doit être exécuté.

Ainsi, si demain tu remplaces ton fournisseur d'avatars, tu n'as pas besoin de modifier toute la chaîne.


# 25. Architecture finale recommandée

```text
                         ┌─────────────────┐
                         │    Next.js      │
                         │    Frontend     │
                         └────────┬────────┘
                                  │
                                  ▼
                         ┌─────────────────┐
                         │    FastAPI      │
                         │      API        │
                         └────────┬────────┘
                                  │
                                  ▼
                         ┌─────────────────┐
                         │ Workflow Engine │
                         │   Temporal /    │
                         │ Celery + Redis  │
                         └────────┬────────┘
                                  │
              ┌───────────────────┼──────────────────┐
              │                   │                  │
              ▼                   ▼                  ▼
       ┌────────────┐      ┌────────────┐     ┌────────────┐
       │ News Agent │      │Script Agent│     │ Quality    │
       │ Research   │      │            │     │ Agent      │
       └──────┬─────┘      └─────┬──────┘     └────────────┘
              │                  │
              └─────────┬────────┘
                        ▼
                 ┌──────────────┐
                 │ Media Agents │
                 ├──────────────┤
                 │ TTS          │
                 │ Avatar       │
                 │ Video        │
                 │ Subtitles    │
                 └──────┬───────┘
                        │
                        ▼
                ┌───────────────┐
                │ Object Storage│
                │ S3 / R2       │
                └───────────────┘

        ┌─────────────────────────────────┐
        │          PostgreSQL             │
        │                                 │
        │ Users / Projects / Sources      │
        │ Scripts / Workflows / Videos    │
        │ Agent runs / Costs / Logs       │
        └─────────────────────────────────┘
```

# 26. Critères de réussite du MVP

Une première version sera considérée comme fonctionnelle lorsqu'un utilisateur pourra :

1. saisir un sujet ;
2. lancer une recherche ;
3. obtenir plusieurs sources ;
4. générer un script ;
5. modifier le script ;
6. valider le script ;
7. générer l'audio ;
8. générer une vidéo avec avatar ;
9. ajouter les sous-titres ;
10. visualiser la vidéo ;
11. télécharger la vidéo ;
12. retrouver l'historique de production.

Le système devra également permettre de savoir **pour chaque vidéo** :

* quelles sources ont été utilisées ;
* quel script a été généré ;
* quelles versions du script existent ;
* quels agents ont été exécutés ;
* quels modèles/API ont été utilisés ;
* combien chaque étape a coûté ;
* quelles erreurs ont éventuellement été rencontrées.


# 27. Priorité de développement

## Phase 1 — Infrastructure

* PostgreSQL
* FastAPI
* Next.js
* Redis/queue
* stockage objet
* authentification
* système de logs

## Phase 2 — Intelligence

* Search Agent
* Research Agent
* Script Agent
* Quality Agent

## Phase 3 — Média

* TTS Agent
* Avatar Agent
* Video Assembly Agent
* subtitles

## Phase 4 — Interface

* dashboard
* workflow en temps réel
* éditeur de script
* bibliothèque vidéo

## Phase 5 — Industrialisation

* retries
* monitoring
* coûts
* multi-provider
* scaling
* publication automatique


# 28. Principe directeur

La plateforme doit être conçue comme une **usine de contenu pilotée par workflow**, et non comme un simple chatbot.

Chaque production doit être considérée comme un workflow possédant :

```text
un ID
un état
des entrées
des sorties
des agents
des versions
des sources
des fichiers
des logs
un coût
un historique
```

Cette conception permettra ensuite d'ajouter de nouveaux agents sans remettre en cause l'architecture existante.
