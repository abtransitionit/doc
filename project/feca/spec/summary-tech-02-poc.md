[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

<h1 align="center">Project Feca : Summary for a POC</h1>

Pour le POC, no
- sécurité
- calabilité
- authentification
- dashboard
- CI/CD
- ...

On cherche juste à faire fonctionner la chaîne de bout en bout le plus vite possible.


# 1. Objectif

Construire un prototype technique permettant de valider la chaîne complète :

```text
Sujet
 ↓
Recherche web
 ↓
Analyse / synthèse
 ↓
Génération du script
 ↓
Text-to-Speech
 ↓
Avatar parlant
 ↓
Vidéo finale
```

Le POC doit privilégier **la vitesse de développement** et la validation technique.


# 2. Périmètre

Le POC fonctionne en **mode développeur**, sans interface graphique.

Lancement possible simplement avec :

```bash
python main.py "Sujet à traiter"
```

Le résultat attendu est une vidéo finale générée automatiquement.


# 3. Architecture

Architecture volontairement minimale :

```text
main.py
   ↓
Orchestrateur
   ↓
┌─────────────┐
│ News Agent  │
└─────────────┘
       ↓
┌───────────────┐
│ Research Agent│
└───────────────┘
       ↓
┌─────────────┐
│ Script Agent│
└─────────────┘
       ↓
┌────────────┐
│ TTS Agent  │
└────────────┘
       ↓
┌──────────────┐
│ Avatar Agent │
└──────────────┘
       ↓
┌──────────────┐
│ Video Output │
└──────────────┘
```

Pas de microservices pour le POC : **une seule application Python**.


# 4. Stack technique

## Backend / orchestration

* Python
* appels API classiques
* éventuellement `asyncio` pour les appels asynchrones

## IA

* LLM pour analyse et génération du script
* API de recherche web
* API TTS
* API Avatar

## Vidéo

* **FFmpeg** si nécessaire pour l'assemblage ou la conversion.

## Stockage

Simple système de fichiers local.

```text
output/
├── sources/
├── scripts/
├── audio/
├── videos/
└── final/
```

Aucune base de données nécessaire pour le POC.


# 5. Agents

## 5.1 News Agent

Entrée :

```text
sujet
```

Sortie :

```json
{
  "topic": "...",
  "sources": [
    {
      "title": "...",
      "url": "...",
      "content": "..."
    }
  ]
}
```


## 5.2 Research Agent

Analyse les sources et produit une synthèse exploitable.

Entrée :

```text
sources
```

Sortie :

```text
synthèse structurée
```


## 5.3 Script Agent

Transforme la synthèse en script court.

Contraintes initiales :

* 30 à 60 secondes ;
* texte destiné à être parlé ;
* style clair et naturel ;
* aucune information non présente dans les sources.

Sortie :

```text
script.txt
```


## 5.4 TTS Agent

Transforme le script en fichier audio.

Entrée :

```text
script.txt
```

Sortie :

```text
audio.mp3
```


## 5.5 Avatar Agent

Envoie le texte ou l'audio au fournisseur d'avatar.

Sortie :

```text
avatar.mp4
```

Le fournisseur est libre pour le POC.


## 5.6 Video Agent

Si nécessaire, assemble :

* vidéo avatar ;
* audio ;
* sous-titres ;
* éléments visuels simples.

Sortie :

```text
final.mp4
```


# 6. Orchestrateur

Le POC utilise un orchestrateur Python très simple.

```python
sources = news_agent.run(topic)

research = research_agent.run(sources)

script = script_agent.run(research)

audio = tts_agent.run(script)

avatar = avatar_agent.run(audio)

video = video_agent.run(avatar)
```

Chaque étape retourne son résultat à l'étape suivante.

Pas de Celery, Redis ou Temporal à ce stade.


# 7. Gestion des fichiers

Chaque exécution possède un dossier :

```text
runs/
└── 2026-09-23_001/
    ├── sources.json
    ├── research.txt
    ├── script.txt
    ├── audio.mp3
    ├── avatar.mp4
    └── final.mp4
```

Cela permet de conserver les résultats et de déboguer facilement le pipeline.


# 8. Configuration

Les clés API sont stockées dans un fichier `.env` :

```text
LLM_API_KEY=
SEARCH_API_KEY=
TTS_API_KEY=
AVATAR_API_KEY=
```

Le POC n'a pas besoin de système de gestion des secrets avancé.


# 9. Logs

Logs simples dans le terminal :

```text
[NEWS] Recherche...
[NEWS] OK

[RESEARCH] Analyse...
[RESEARCH] OK

[SCRIPT] Génération...
[SCRIPT] OK

[TTS] Génération...
[TTS] OK

[AVATAR] Génération...
[AVATAR] OK

[VIDEO] Finalisation...
[VIDEO] OK

VIDEO: runs/.../final.mp4
```

En cas d'erreur, l'exécution s'arrête avec le détail de l'étape concernée.


# 10. Structure du projet

```text
poc/
├── main.py
├── config.py
├── orchestrator.py
│
├── agents/
│   ├── news.py
│   ├── research.py
│   ├── script.py
│   ├── tts.py
│   ├── avatar.py
│   └── video.py
│
├── providers/
│   ├── llm.py
│   ├── search.py
│   ├── tts.py
│   └── avatar.py
│
├── prompts/
│   ├── research.txt
│   └── script.txt
│
├── runs/
├── .env
├── requirements.txt
└── README.md
```


# 11. Interfaces fournisseurs

Même dans le POC, les appels externes doivent être légèrement isolés.

Exemple :

```python
class LLMProvider:
    def generate(self, prompt):
        ...
```

Cela permet de changer de fournisseur sans réécrire les agents.

Mais aucune architecture complexe n'est nécessaire.


# 12. Critère de réussite

Le POC est considéré comme réussi lorsqu'une commande :

```bash
python main.py "un sujet d'actualité"
```

produit automatiquement :

```text
sources
   ↓
synthèse
   ↓
script
   ↓
audio
   ↓
avatar
   ↓
vidéo finale
```

avec **une intervention humaine minimale ou nulle pendant le pipeline**.


# 13. Hors périmètre

Pour rester rapide, le POC ne comprend pas :

* interface graphique ;
* authentification ;
* utilisateurs multiples ;
* base de données ;
* système de paiement ;
* déploiement cloud complexe ;
* monitoring avancé ;
* système de permissions ;
* orchestration distribuée ;
* scalabilité ;
* publication automatique ;
* analytics ;
* gestion avancée des erreurs ;
* haute disponibilité.


# 14. Évolution vers le MVP

Le POC sert à identifier les briques qui fonctionnent réellement.

Après validation :

```text
POC
 ↓
Choix des fournisseurs
 ↓
Stabilisation des agents
 ↓
Architecture MVP
 ↓
Backend + DB + stockage
 ↓
Workflow robuste
 ↓
IHM
 ↓
MVP
```

Le POC doit donc rester **jetable et rapide**, sans chercher à anticiper toute l'architecture du produit final.

# Principe

> **Faire fonctionner la chaîne complète avant de chercher à la rendre belle, robuste ou scalable.**

C'est volontairement beaucoup plus léger. **Le seul objectif du POC : obtenir une vidéo à partir d'un sujet, automatiquement.** Ensuite seulement, on industrialise ce qui a prouvé son intérêt.


