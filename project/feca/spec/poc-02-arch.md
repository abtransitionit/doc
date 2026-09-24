[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Project Feca : Summary for a POC</h1>



- un seul programme Go
- quelques packages bien séparés
- des appels API synchrones au départ
- zéro infrastructure inutile

# Architecture POC en Go

```text
                    main.go
                       │
                       ▼
                 orchestrator
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
      News          Research        Script
      Agent           Agent          Agent
        │              │              │
        └──────────────┼──────────────┘
                       ▼
                    TTS Agent
                       │
                       ▼
                  Avatar Agent
                       │
                       ▼
                  Video Agent
                       │
                       ▼
                   final.mp4
```

# Structure du code

```text
poc/
├── cmd/
│   └── poc/
│       └── main.go
│
├── internal/
│   ├── orchestrator/
│   ├── agents/
│   │   ├── news/
│   │   ├── research/
│   │   ├── script/
│   │   ├── tts/
│   │   ├── avatar/
│   │   └── video/
│   │
│   ├── providers/
│   │   ├── llm/
│   │   ├── search/
│   │   ├── tts/
│   │   └── avatar/
│   │
│   └── config/
│
├── prompts/
├── runs/
├── .env
├── go.mod
└── README.md
```

# Première version du workflow

On commence volontairement par quelque chose de très direct :

```text
go run ./cmd/poc "Sujet d'actualité"
```

Puis :

```text
1. Search
      ↓
2. Research
      ↓
3. Script
      ↓
4. TTS
      ↓
5. Avatar
      ↓
6. Video
```

Chaque étape écrit son résultat dans :

```text
runs/<timestamp>/
```

Par exemple :

```text
runs/20260923-120500/
├── sources.json
├── research.json
├── script.txt
├── audio.mp3
├── avatar.mp4
└── final.mp4
```

# Une décision importante

Pour le POC, je **n'abstrairais pas excessivement**.

On pourrait faire une architecture ultra-générique avec :

```go
type Agent interface {
    Execute(ctx context.Context, input any) (any, error)
}
```

Mais je préfère commencer avec des structures explicites :

```go
type NewsAgent struct {}
type ResearchAgent struct {}
type ScriptAgent struct {}
type TTSAagent struct {}
type AvatarAgent struct {}
type VideoAgent struct {}
```

On verra ensuite ce qui mérite réellement d'être généralisé.

**Prochaine étape** : 
- définir concrètement chaque brique du POC
- quelles APIs on choisit, 
- quels inputs/outputs elles échangent et quel est le chemin exact d'une première génération.


# Le POC

je te propose qu'on fasse maintenant **le POC réel, brique par brique**, en commençant par choisir les APIs et définir les contrats entre agents.

Je partirais sur cette séquence :

|#|||
|-|-|-|
| 1 | News/Search | → récupérer les sources
| 2 |  LLM | → analyser + rédiger
| 3 | TTS | → générer la voix
| 4 | Avatar | → générer la vidéo parlée
| 5 | FFmpeg | → finaliser la vidéo
| 6 | Orchestrateur Go| → tout enchaîner
| 7 | CLI | → `go run ... "mon sujet"`

Méthode:
- On ne code pas tout d'un coup
- on valide chaque étape avant de passer à la suivante

On peut commencer par **le choix concret des fournisseurs/API pour les 4 briques externes**.
