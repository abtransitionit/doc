[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Project Feca : Summary for a POC</h1>


# Python vs. Go

actions to do

|                           | Python                  | Go                      |
| ------------------------- | ----------------------- | ----------------------- |
| Appels API IA             | Très bon                | Très bon                |
| Appels réseau parallèles  | Très bon                | **Excellent**           |
| CPU pur                   | Moyen                   | **Excellent**           |
| Traitement vidéo / FFmpeg | Très bon via subprocess | Très bon via subprocess |
| Développement rapide      | **Excellent**           | Très bon                |
| Écosystème IA/LLM         | **Excellent**           | Bon                     |
| Concurrence               | Bon                     | **Excellent**           |
| Simplicité du POC         | **Excellent**           | Excellent               |
| Consommation mémoire      | Plus élevée             | **Plus faible**         |

The pipeline is :

```text
Recherche API
     ↓
LLM API
     ↓
TTS API
     ↓
Avatar API
     ↓
FFmpeg
```

La majeure partie du temps est donc passée **à attendre des services externes**.

Par exemple, si :

```text
Recherche       2 s
LLM             5 s
TTS             8 s
Avatar         60 s
FFmpeg          5 s
```

le programme lui-même n'a quasiment aucune influence sur les ~80 secondes.

Que l'orchestrateur soit Python ou Go ne va donc probablement **presque rien changer au temps total de génération**.

Les modèles IA sont généralement consommés via des APIs HTTP. Go peut donc parfaitement appeler :

* API LLM ;
* API de recherche ;
* API TTS ;
* API avatar ;
* API vidéo ;
* FFmpeg.

Tu peux également utiliser des bibliothèques Go pour gérer JSON, HTTP, WebSocket, files, concurrence, etc.

## Les points forts de Go

Si tu veux rapidement faire évoluer le POC vers une architecture très concurrente :

```text
              ┌─ Recherche 1
              ├─ Recherche 2
Sujet ────────┼─ Recherche 3
              ├─ Recherche 4
              └─ Recherche 5
                     ↓
                  Synthèse
```

ou traiter :

```text
100 sujets
   ↓
100 workflows parallèles
```

Go est particulièrement à l'aise avec ce genre de charge.



## Les points forts de Python

**Python** est plus à l'aise sur:
- la manipulation de données
- le parsing, 
- le prompts, 
- le traitement de contenu et d'expérimentation avec différents fournisseurs. 

