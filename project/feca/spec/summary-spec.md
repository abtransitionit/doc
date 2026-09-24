[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Project Feca : Summary</h1>

# 1. Vision

- Développer une plateforme capable d'automatiser la création de vidéos courtes à partir de sujets d'actualité.
- La plateforme repose sur plusieurs **agents IA spécialisés**, chacun responsable d'une étape du processus :

```
Recherche → Analyse → Rédaction → Vérification → Voix → Avatar → Vidéo
```

L'objectif est de pouvoir passer d'un sujet d'actualité à une vidéo prête à publier avec un minimum d'intervention humaine.


# 2. Fonctionnement général

```text
Sujet
 ↓
Recherche web
 ↓
LLM → script
 ↓
TTS → voix
 ↓
Avatar → vidéo
```


```text
        Sujet d'actualité
               ↓
        Agent de recherche
               ↓
       Agent de synthèse
               ↓
        Agent rédacteur
               ↓
       Agent de vérification
               ↓
          Texte validé
               ↓
        Agent Text-to-Speech
               ↓
        Agent Avatar/Vidéo
               ↓
         Vidéo finale
```

Une validation humaine peut être ajoutée avant la génération ou la publication de la vidéo.


# 3. Les principaux agents

| Agent              | Fonction                                                | Sortie                 |
| ------------------ | ------------------------------------------------------- | ---------------------- |
| **News Agent**     | Recherche les sujets et informations sur le web         | Sources + informations |
| **Research Agent** | Analyse et croise les sources                           | Synthèse structurée    |
| **Script Agent**   | Transforme les informations en script court             | Script                 |
| **Quality Agent**  | Vérifie le script et les sources                        | Script validé/corrigé  |
| **Voice Agent**    | Transforme le texte en voix                             | Audio                  |
| **Avatar Agent**   | Fait parler un avatar                                   | Vidéo                  |
| **Video Agent**    | Assemble avatar, audio, sous-titres et éléments visuels | Vidéo finale           |

Les agents doivent être indépendants afin de pouvoir remplacer ou ajouter facilement des modèles et fournisseurs.


# 4. Architecture technique

## Frontend

* **Next.js**
* **React**
* **TypeScript**
* Interface de gestion des projets et des générations
* Éditeur de scripts
* Suivi des workflows
* Prévisualisation des vidéos

## Backend

* **Python**
* **FastAPI**
* API REST
* Gestion des utilisateurs
* Gestion des projets
* Orchestration des agents
* Gestion des workflows

## Infrastructure

* **PostgreSQL** : utilisateurs, projets, sources, scripts, workflows, vidéos et logs
* **Redis + Celery** ou **Temporal** : exécution des tâches asynchrones
* **S3 / Cloudflare R2** : stockage des vidéos, audios et assets
* **FFmpeg** : assemblage et traitement vidéo


# 5. APIs externes

La plateforme doit utiliser des interfaces permettant de remplacer facilement les fournisseurs.

```text
LLMProvider
SearchProvider
TTSProvider
AvatarProvider
StorageProvider
```

Les fournisseurs pourront être choisis selon :

* qualité ;
* coût ;
* disponibilité ;
* rapidité ;
* fonctionnalités.


# 6. Workflow

Chaque génération est représentée par un **workflow**.

```text
Création du sujet
       ↓
Recherche web
       ↓
Analyse des sources
       ↓
Génération du script
       ↓
Vérification
       ↓
Validation humaine (optionnelle)
       ↓
Génération de la voix
       ↓
Génération de l'avatar
       ↓
Montage vidéo
       ↓
Contrôle qualité
       ↓
Vidéo prête
```

Le workflow doit pouvoir reprendre à la dernière étape réussie en cas d'erreur.


# 7. Interface utilisateur

Le dashboard permet de :

* créer un projet ;
* créer ou sélectionner un sujet ;
* lancer une génération ;
* suivre l'avancement des agents ;
* consulter les sources ;
* modifier le script ;
* choisir un avatar et une voix ;
* prévisualiser la vidéo ;
* télécharger la vidéo ;
* consulter l'historique des générations.


# 8. Données principales

Les principales entités sont :

```text
User
Project
Topic
Source
Script
Workflow
AgentRun
Audio
Avatar
Video
```

Chaque vidéo doit conserver son historique de production :

* sources utilisées ;
* script ;
* version du script ;
* agents exécutés ;
* modèles utilisés ;
* fichiers générés ;
* coûts ;
* erreurs éventuelles.


# 9. Exigences non fonctionnelles

La plateforme doit être :

* **sécurisée** : authentification, gestion des droits et protection des clés API ;
* **scalable** : possibilité d'ajouter des workers selon la charge ;
* **fiable** : retries et reprise des workflows ;
* **observable** : logs, métriques et suivi des coûts ;
* **maintenable** : agents et fournisseurs indépendants ;
* **extensible** : ajout de nouveaux agents, modèles, avatars et voix sans refonte globale ;
* **traçable** : historique complet de chaque génération.


# 10. MVP

Le MVP se limite à :

1. Saisie d'un sujet.
2. Recherche de sources sur le web.
3. Génération d'un script de 30–60 secondes.
4. Vérification du script.
5. Modification/validation humaine.
6. Génération de la voix.
7. Génération d'une vidéo avec un avatar.
8. Ajout des sous-titres.
9. Prévisualisation et téléchargement.

## Architecture MVP

```text
Next.js
   ↓
FastAPI
   ↓
Celery + Redis
   ↓
┌──────────┬───────────┬───────────┐
│ Recherche│   Script  │   Média   │
│   Agent  │   Agent   │   Agents  │
└──────────┴───────────┴───────────┘
       ↓
 PostgreSQL + S3/R2
```


# 11. Évolution future

Après le MVP :

* veille automatique de l'actualité ;
* génération de plusieurs vidéos simultanément ;
* plusieurs avatars et voix ;
* multilingue ;
* montage automatique avancé ;
* publication automatique sur les réseaux sociaux ;
* analytics ;
* génération de plusieurs formats à partir d'un même sujet ;
* ajout de nouveaux agents spécialisés.


# 12. Principe architectural

Le système doit être conçu comme une **chaîne de production de contenu pilotée par un orchestrateur**, et non comme un ensemble d'agents directement connectés entre eux.

L'orchestrateur contrôle :

* l'ordre d'exécution ;
* les dépendances ;
* les erreurs ;
* les retries ;
* les validations ;
* l'état du workflow.

Cette architecture permettra de faire évoluer progressivement la plateforme sans devoir reconstruire l'ensemble du système.

