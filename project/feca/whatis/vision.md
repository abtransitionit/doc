[//]: #(home)
[home]: ../../README.md


[//]: #(functional)

[↖][home]


Related topics

| Topic | Location | Kind |
|---|---|---|
|[What is a Tool Chain](../whatis/chain.md)|internal|
|[How-to for OmtOvh](../howto/ep.md)|internal|


**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Vision</h1>

- une plateforme multi-**agents IA** de production automatisée de contenus d’actualité
- Chaque agent possède une responsabilité précise et où les sorties d’un agent servent d’entrées aux suivants.

# Formulation du projet

**Objectif :**
- Développer une plateforme composée de plusieurs agents IA
- Chaque agents IA est spécialisés 
  - Rechercher des sujets d’actualité
  - Rédiger automatiquement des scripts courts
  - Produire des vidéos avec des avatars virtuels présentant ces contenus.

### Architecture fonctionnelle

```text
                    ┌─────────────────────┐
                    │   Agent Recherche   │
                    │                     │
                    │ Recherche le web    │
                    │ Sélectionne un sujet│
                    │ Vérifie les sources │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Agent Rédacteur   │
                    │                     │
                    │ Analyse les infos   │
                    │ Génère un script    │
                    │ court et structuré  │
                    └──────────┬──────────┘
                               │
                         Texte / Script
                               │
                               ▼
                    ┌─────────────────────┐
                    │ Agent Avatar / Voix │
                    │                     │
                    │ Transforme le texte │
                    │ en narration        │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Agent Vidéo       │
                    │                     │
                    │ Avatar + voix +     │
                    │ éléments visuels   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   Vidéo finale      │
                    └─────────────────────┘
```

### Les différents agents

| Agent                      | Rôle                                                    | Entrée           | Sortie                                 |
| -------------------------- | ------------------------------------------------------- | ---------------- | -------------------------------------- |
| **Agent de veille**        | Chercher les sujets récents sur le web                  | Sources web      | Sujet + sources                        |
| **Agent de recherche**     | Collecter et synthétiser les informations               | Sujet            | Informations structurées               |
| **Agent rédacteur**        | Transformer les informations en texte court             | Informations     | Script                                 |
| **Agent de vérification**  | Vérifier cohérence et sources                           | Script + sources | Script validé / corrections            |
| **Agent voix**             | Transformer le script en narration                      | Script           | Audio                                  |
| **Agent avatar**           | Faire parler un avatar                                  | Script/audio     | Vidéo avatar                           |
| **Agent montage**          | Ajouter sous-titres, images, musique, transitions, etc. | Vidéo + assets   | Vidéo finale                           |
| **Agent contrôle qualité** | Vérifier le résultat final                              | Vidéo            | Vidéo validée ou demande de correction |

### Pipeline de production

L'intérêt de ton projet est surtout de **chaîner les agents**.

Par exemple :

```text
1. Détection d'un sujet
        ↓
2. Recherche d'informations
        ↓
3. Vérification des sources
        ↓
4. Génération du script
        ↓
5. Validation du script
        ↓
6. Génération de la voix
        ↓
7. Génération de l'avatar
        ↓
8. Montage de la vidéo
        ↓
9. Contrôle qualité
        ↓
10. Publication / export
```

Chaque étape doit idéalement produire un **objet structuré** plutôt qu'un simple texte.

Par exemple :

```json
{
  "topic": "Sujet d'actualité",
  "title": "Titre de la vidéo",
  "summary": "Résumé court",
  "script": "Texte qui sera lu par l'avatar",
  "sources": [
    {
      "title": "Source 1",
      "url": "...",
      "published_at": "..."
    }
  ],
  "status": "validated"
}
```

Cela permet ensuite aux agents suivants de travailler automatiquement dessus.

### Une formulation plus professionnelle du projet

**Développement d'une plateforme d'agents IA autonomes pour la production automatisée de contenus vidéo d'actualité.**

- La plateforme repose sur une architecture multi-agents dans laquelle chaque agent est spécialisé dans une étape du processus de production. 
- Un premier ensemble d'agents assure la veille et la recherche d'informations sur le web. 
- Un agent de rédaction transforme ensuite ces informations en scripts courts et structurés. 
- Des agents spécialisés prennent ensuite en charge la synthèse vocale, la génération d'avatars et la production vidéo. 
- Enfin, un agent de contrôle qualité vérifie le contenu généré avant sa publication.

> L'objectif est d'automatiser l'ensemble de la chaîne de production, depuis la détection d'un sujet d'actualité jusqu'à la génération d'une vidéo prête à être publiée.

### MVP conseillé

Pour une première version, je ne construirais pas 10 agents. Tu peux commencer avec **4 agents** :

**1. News Agent**

* recherche sur le web ;
* sélectionne un sujet ;
* récupère les sources ;
* produit un résumé structuré.

**2. Script Agent**

* reçoit les informations ;
* génère un script de 30–60 secondes ;
* conserve les sources associées.

**3. Avatar Agent**

* reçoit le script ;
* génère la voix ;
* produit la vidéo avec l'avatar.

**4. Quality Agent**

* vérifie le script ;
* vérifie que les sources sont présentes ;
* vérifie la durée et le format ;
* valide ou renvoie le contenu à l'étape précédente.

Cela te donne déjà une chaîne complète :

**Web → Actualité → Script → Avatar → Vidéo**

Puis tu peux ajouter progressivement 
  - le montage automatique
  - les sous-titres
  - plusieurs langues
  - plusieurs avatars
  - la publication automatique sur les réseaux sociaux, etc.

Si tu veux, je peux aussi te transformer ça en **vrai cahier des charges technique** avec l'architecture backend/frontend, les agents, les APIs à utiliser, la base de données et le workflow d'exécution.
