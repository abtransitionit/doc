[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Project Feca : Summary for a POC</h1>


# Les Fournisseurs

cette section s'interesse au choix concret des fournisseurs/API pour les 4 briques externes.

Oui. Pour le **POC**, je choisirais les fournisseurs avec un critère très simple : **qualité + simplicité d'intégration + possibilité de tester rapidement**, pas optimisation du coût à grande échelle.

Je recommande cette stack :

| # | Brique           | Choix POC      | Pourquoi                                                        |
| - | ---------------- | -------------- | --------------------------------------------------------------- |
| 1 | 🌐 Recherche web | **Tavily**     | API pensée pour les agents/LLM, résultats + contenu exploitable |
| 2 | 🧠 LLM           | **OpenAI API** | Très bon pour recherche/synthèse/rédaction, API simple          |
| 3 | 🔊 TTS           | **ElevenLabs** | Très bonne qualité vocale, API REST simple                      |
| 4 | 🧑 Avatar        | **HeyGen**     | API dédiée aux vidéos avec avatar parlant                       |
| 5 | 🎬 Montage       | **FFmpeg**     | Local, gratuit, robuste                                         |

## 1. Recherche : Tavily

Je prendrais **Tavily** pour le POC.

Son API est spécifiquement conçue pour les applications IA : elle recherche le web, classe les résultats et peut retourner du contenu directement exploitable par un LLM. ([Tavily Help Center][1])

Pour notre POC :

```text
Sujet
 ↓
Tavily Search
 ↓
5-10 sources
 ↓
contenu des sources
 ↓
Research Agent
```

C'est également intéressant pour commencer sans gros engagement : Tavily propose actuellement un niveau **gratuit** avec 1 000 crédits/mois. ([Tavily][2])

**→ Choix : Tavily**


## 2. LLM : OpenAI

Pour le cerveau du POC, je prendrais **OpenAI**.

On peut utiliser le même fournisseur pour :

* analyser les sources ;
* extraire les faits ;
* produire la synthèse ;
* rédiger le script ;
* éventuellement effectuer une première vérification.

Je séparerais quand même les rôles dans notre code :

```text
ResearchAgent
      ↓
LLM
      ↓
ScriptAgent
      ↓
LLM
```

Ainsi, changer de modèle plus tard ne demande pas de réécrire les agents.

**→ Choix : OpenAI API**


## 3. TTS : ElevenLabs

Ici, je choisirais clairement **ElevenLabs** pour le POC.

L'API accepte directement du texte et retourne l'audio ; elle supporte notamment le français et plusieurs modèles/voix. ([ElevenLabs][3])

Pour notre première version, quelque chose comme :

```text
script.txt
   ↓
ElevenLabs
   ↓
audio.mp3
```

Pas besoin de streaming, de clonage vocal ou de fonctionnalités avancées au départ.

**→ Choix : ElevenLabs**


## 4. Avatar : HeyGen

Pour l'avatar, **HeyGen** est le candidat que je testerais en premier.

L'objectif est très simple :

```text
audio.mp3
   ↓
Avatar API
   ↓
avatar.mp4
```

Le point important ici est que **l'API Avatar doit accepter notre audio généré par ElevenLabs** ou permettre de fournir le texte avec une voix compatible.

C'est cette intégration que je validerais très tôt dans le POC, car c'est probablement la partie la plus susceptible de nous imposer des contraintes techniques.

**→ Choix initial : HeyGen**


# Traduction  du POC 

```text
                    SUJET
                      │
                      ▼
                 ┌─────────┐
                 │ Tavily  │
                 └────┬────┘
                      │
                   sources
                      │
                      ▼
                ┌──────────┐
                │ OpenAI   │
                │ Research │
                └────┬─────┘
                     │
                  synthèse
                     │
                     ▼
                ┌──────────┐
                │ OpenAI   │
                │  Script  │
                └────┬─────┘
                     │
                   texte
                     │
                     ▼
              ┌─────────────┐
              │ ElevenLabs  │
              └──────┬──────┘
                     │
                  audio.mp3
                     │
                     ▼
                ┌─────────┐
                │ HeyGen  │
                └────┬────┘
                     │
                  avatar.mp4
                     │
                     ▼
                 ┌───────┐
                 │FFmpeg │
                 └───┬───┘
                     │
                     ▼
                  final.mp4
```

### Et surtout : je ne mettrais pas encore de "provider abstraction" sophistiquée

Pour le POC, on fait simplement :

```text
Tavily
OpenAI
ElevenLabs
HeyGen
FFmpeg
```

On encapsule juste chaque API dans son package Go.

**Prochaine étape que je te propose : on définit précisément le contrat de données entre chaque étape** — ce que `NewsAgent` reçoit, ce qu'il retourne, le JSON exact, puis `ResearchAgent`, etc. C'est là qu'on pourra commencer à coder le POC proprement.

[1]: https://help.tavily.com/articles/4840311948-tavily-search-api?utm_source=chatgpt.com "What is the Tavily Search API?"
[2]: https://www.tavily.com/pricing?utm_source=chatgpt.com "Tavily"
[3]: https://elevenlabs.io/docs/api-reference/text-to-speech/convert?utm_source=chatgpt.com "Create speech | ElevenLabs Documentation"
