[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Feca Specifications non fonctionelles</h1>

cette section dédiée intervient 
- après la sécurité
- avant la dockerisation



Les exigences non fonctionnelles définissent les contraintes 
- de qualité
- de sécurité
- de performance
- de disponibilité
- de maintenabilité 
- d'évolutivité 

auxquelles la plateforme doit répondre.


# 1 Performance

### API

Les endpoints classiques de l'API doivent répondre rapidement lorsque l'opération ne nécessite pas de traitement IA long.

Objectifs indicatifs :

* **p95 < 500 ms** pour les requêtes API simples ;
* **p99 < 1,5 s** pour les requêtes API simples ;
* les traitements longs ne doivent jamais bloquer une requête HTTP ;
* les générations vidéo doivent être exécutées de manière asynchrone.

### Traitements IA

Les traitements suivants doivent être exécutés en arrière-plan :

* recherche web ;
* recherche approfondie ;
* génération de script ;
* fact-checking ;
* génération audio ;
* génération avatar ;
* montage vidéo.

Le frontend doit afficher l'état du traitement en temps réel.


# 2 Scalabilité

L'architecture doit permettre d'augmenter indépendamment la capacité de chaque composant.

Exemple :

```text
                    API
                     │
              ┌──────┴──────┐
              │             │
          Worker 1      Worker 2
              │             │
         Script Agent    Video Agent
```

Un grand nombre de générations vidéo ne doit pas nécessairement entraîner une augmentation équivalente du nombre d'instances API.

Les workers doivent pouvoir être multipliés horizontalement.

Exemple :

```text
10 vidéos simultanées
        ↓
10 jobs dans la queue
        ↓
Workers disponibles
        ↓
Traitement parallèle
```

Le système doit également prévoir des limites de concurrence afin d'éviter :

* le dépassement des quotas des fournisseurs ;
* une explosion des coûts ;
* la saturation des ressources.


# 3 Disponibilité

Objectif MVP :

**99 % de disponibilité mensuelle** pour les composants critiques de la plateforme, hors dépendances externes.

À terme :

**99,9 %** pour l'API et le frontend.

Les fournisseurs externes (LLM, TTS, avatar, recherche, etc.) ne sont pas inclus dans cette garantie.

En cas d'indisponibilité d'un fournisseur externe :

* le workflow doit passer en état `WAITING` ou `FAILED` ;
* l'erreur doit être enregistrée ;
* un retry doit être effectué selon une politique définie ;
* un fournisseur alternatif peut être utilisé lorsque cela est possible.


# 4 Fiabilité

Chaque étape d'un workflow doit être **idempotente** lorsque cela est possible.

Exemple :

```text
GENERATE_AUDIO
       ↓
Erreur réseau
       ↓
Retry
       ↓
Ne doit pas créer
2 fichiers audio inutiles
```

Chaque tâche doit posséder un identifiant unique.

Le système doit éviter les doubles traitements causés par :

* un double clic utilisateur ;
* un retry ;
* une reconnexion ;
* un redémarrage d'un worker ;
* une erreur réseau.


# 5 Résilience

Les appels aux services externes doivent intégrer :

* timeout ;
* retry automatique ;
* exponential backoff ;
* limitation du nombre de retries ;
* circuit breaker lorsque nécessaire ;
* fallback provider lorsque disponible.

Exemple :

```text
Provider A
    │
    ├── succès → continuer
    │
    └── erreur
          ↓
       retry #1
          ↓
       retry #2
          ↓
       Provider B
          ↓
       continuer
```

Une erreur sur une étape ne doit pas entraîner la perte de l'ensemble du workflow.


# 6 Reprise après incident

Après un redémarrage du backend ou d'un worker, les workflows en cours doivent pouvoir être repris.

Exemple :

```text
Recherche       ✓
Research        ✓
Script          ✓
Fact-checking   ✓
Audio           ✓
Avatar          ●
Montage         ○
```

Si le worker tombe pendant la génération de l'avatar, le workflow doit reprendre à l'étape avatar plutôt que recommencer depuis la recherche.


# 7 Maintenabilité

Le code doit être organisé par domaine fonctionnel.

Les agents doivent être indépendants les uns des autres.

Architecture souhaitée :

```text
Agent
   │
   ├── Input schema
   ├── Business logic
   ├── Provider
   ├── Output schema
   └── Tests
```

Les dépendances entre composants doivent être limitées.

Les interfaces internes doivent être définies avec des contrats explicites.

Exemple :

```python
class TTSProvider:
    def generate_audio(
        self,
        text: str,
        voice_id: str,
        language: str
    ):
        ...
```

Le remplacement d'un fournisseur externe ne doit pas nécessiter de modifier les agents consommateurs.


# 8 Testabilité

Le système doit comporter plusieurs niveaux de tests.

### Tests unitaires

Ils doivent couvrir :

* logique métier ;
* agents ;
* validateurs ;
* parsers ;
* transformations de données.

### Tests d'intégration

Ils doivent vérifier :

* API ↔ PostgreSQL ;
* API ↔ Redis ;
* API ↔ stockage ;
* workflow ↔ workers ;
* agents ↔ providers.

### Tests end-to-end

Un scénario complet doit pouvoir être exécuté :

```text
Création sujet
      ↓
Recherche
      ↓
Script
      ↓
Validation
      ↓
Audio
      ↓
Avatar
      ↓
Montage
      ↓
Vidéo finale
```


# 9 Sécurité

La plateforme doit respecter les principes suivants :

### Authentification

* mots de passe hashés avec un algorithme robuste ;
* sessions sécurisées ;
* expiration des tokens ;
* possibilité de révoquer les sessions.

### Autorisation

Les permissions doivent être contrôlées côté backend.

Exemple :

```text
USER
 ├── READ own projects
 ├── WRITE own projects
 └── DELETE own projects

ADMIN
 ├── READ all projects
 ├── MANAGE agents
 ├── MANAGE providers
 └── VIEW system logs
```

### Secrets

Les clés API ne doivent jamais être :

* stockées dans le code ;
* envoyées au frontend ;
* écrites dans les logs ;
* stockées en clair dans Git.

Elles doivent être stockées dans des variables d'environnement sécurisées ou un Secret Manager.


# 10 Protection des données

Les données utilisateurs doivent être isolées logiquement.

Un utilisateur ne doit jamais pouvoir accéder aux :

* projets d'un autre utilisateur ;
* scripts d'un autre utilisateur ;
* vidéos privées ;
* fichiers privés ;
* logs contenant des données d'un autre utilisateur.

Les URLs des fichiers privés doivent être temporaires et signées.


# 11 Confidentialité

Le système doit limiter les données envoyées aux fournisseurs externes au strict nécessaire.

Avant l'envoi d'un contenu à un fournisseur IA, il faut déterminer :

```text
Donnée nécessaire ?
       │
       ├── Oui → envoyer
       │
       └── Non → ne pas envoyer
```

La plateforme doit également documenter :

* quels fournisseurs reçoivent les données ;
* quelles données sont envoyées ;
* combien de temps elles sont conservées ;
* si elles sont utilisées pour l'entraînement des modèles lorsque l'information est disponible.


# 12 Traçabilité

Toutes les étapes importantes doivent être traçables.

Pour chaque génération, le système doit pouvoir répondre à :

```text
Qui ?
Quoi ?
Quand ?
Avec quel agent ?
Avec quel modèle ?
Avec quel fournisseur ?
Avec quelles sources ?
Quel résultat ?
Quel coût ?
Quelle erreur éventuelle ?
```

Chaque `agent_run` doit donc disposer d'un identifiant unique.


# 13 Versioning

Les éléments génératifs doivent être versionnés.

Cela concerne notamment :

* prompts ;
* scripts ;
* configurations ;
* modèles ;
* workflows ;
* assets ;
* vidéos.

Exemple :

```text
Script v1
   ↓
Script v2
   ↓
Script v3
```

L'utilisateur doit pouvoir identifier quelle version du script a servi à produire une vidéo.


# 14 Reproductibilité

Une génération doit conserver suffisamment de métadonnées pour permettre de comprendre comment elle a été produite.

Exemple :

```json
{
  "agent": "script_agent",
  "prompt_version": "3.2",
  "model": "model-x",
  "provider": "provider-a",
  "temperature": 0.4,
  "input_hash": "...",
  "created_at": "..."
}
```

La reproductibilité exacte d'une génération IA ne peut toutefois pas être garantie dans tous les cas.

L'objectif est donc principalement de garantir la **traçabilité de la configuration utilisée**.


# 15 Observabilité

La plateforme doit disposer de trois niveaux d'observabilité.

### Logs

Exemples :

```text
INFO
WARNING
ERROR
```

### Métriques

Les métriques importantes comprennent :

* nombre de workflows ;
* workflows réussis ;
* workflows échoués ;
* durée moyenne ;
* durée p95 ;
* nombre de retries ;
* erreurs par fournisseur ;
* coût moyen par vidéo ;
* coût par agent ;
* nombre de tokens consommés ;
* taille des fichiers générés.

### Traces

Une génération doit pouvoir être suivie grâce à un identifiant de corrélation :

```text
workflow_id
      │
      ├── search_run
      ├── research_run
      ├── script_run
      ├── factcheck_run
      ├── tts_run
      ├── avatar_run
      └── video_run
```


# 16 Gestion des coûts

Les coûts IA doivent être suivis individuellement.

Exemple :

```text
Production #123

Recherche       0,01 €
LLM             0,03 €
Fact-checking   0,02 €
TTS             0,05 €
Avatar          0,40 €
Montage         0,01 €
-----------------------
Total           0,52 €
```

Le système doit permettre :

* de connaître le coût par vidéo ;
* de connaître le coût par agent ;
* de connaître le coût par fournisseur ;
* de définir des limites de dépenses ;
* de détecter les consommations anormales.


# 17 Gestion des quotas

Chaque fournisseur externe peut imposer des limites.

Le système doit donc gérer :

```text
rate limit
quota journalier
quota mensuel
concurrence maximale
```

Une file d'attente doit permettre de lisser les appels lorsque les limites sont atteintes.


# 18 Qualité des contenus

La qualité doit être contrôlée indépendamment de la génération.

Le système doit vérifier notamment :

* cohérence du script ;
* cohérence avec les sources ;
* absence de citations inventées ;
* dates ;
* chiffres ;
* noms propres ;
* durée ;
* qualité audio ;
* synchronisation audio/vidéo ;
* sous-titres ;
* format final.

Pour les contenus d'actualité, les sources et leur date de publication doivent être conservées avec le contenu produit.


# 19 Validation humaine

Le système doit permettre d'introduire une validation humaine entre certaines étapes.

Exemple :

```text
Recherche
    ↓
Script IA
    ↓
┌───────────────────┐
│ VALIDATION HUMAINE │
└─────────┬─────────┘
          ↓
       Audio
          ↓
       Avatar
          ↓
       Vidéo
```

Cette étape doit pouvoir être activée ou désactivée selon le workflow.

Elle est particulièrement utile avant la publication automatique.


# 20 Accessibilité

L'interface frontend devra respecter les bonnes pratiques d'accessibilité.

Objectif recommandé :

**WCAG 2.2 niveau AA**, dans la mesure applicable.

Prévoir notamment :

* navigation clavier ;
* labels explicites ;
* contrastes suffisants ;
* états de chargement accessibles ;
* messages d'erreur compréhensibles ;
* sous-titres pour les vidéos ;
* alternatives textuelles pour les éléments visuels importants.


# 21 Compatibilité

Le frontend doit être compatible avec les versions récentes des principaux navigateurs :

* Chrome ;
* Edge ;
* Firefox ;
* Safari.

L'interface doit être responsive et utilisable sur :

* desktop ;
* tablette ;
* mobile.

La génération vidéo peut cependant être optimisée principalement pour un usage desktop dans le MVP.


# 22 Formats vidéo

Le système doit supporter au minimum :

```text
MP4
H.264
AAC
```

Formats :

```text
9:16  → Shorts / Reels / TikTok
16:9  → YouTube
1:1   → réseaux sociaux compatibles
```

Résolutions cibles :

```text
1080 × 1920
1920 × 1080
1080 × 1080
```


# 23 Gestion du stockage

Les fichiers temporaires doivent être supprimés automatiquement après une durée configurable.

Exemple :

```text
Fichier temporaire
      ↓
Production terminée
      ↓
Rétention temporaire
      ↓
Suppression automatique
```

Les vidéos finales doivent disposer d'une politique de rétention configurable.


# 24 Sauvegardes

La base PostgreSQL doit être sauvegardée automatiquement.

Objectif initial :

* sauvegarde quotidienne ;
* conservation de plusieurs versions ;
* restauration testée régulièrement.

Le stockage objet doit également disposer d'une stratégie de sauvegarde ou de réplication adaptée à la criticité des fichiers.


# 25 RPO / RTO

Pour le MVP, les objectifs peuvent être :

### RPO

**≤ 24 heures**

Perte maximale acceptable de données en cas d'incident majeur.

### RTO

**≤ 4 heures**

Temps cible pour restaurer le service après un incident majeur.

Ces valeurs devront être réduites pour une version production critique.


# 26 Déploiement

Les environnements doivent être séparés :

```text
development
      ↓
staging
      ↓
production
```

Une modification ne doit pas être déployée directement en production sans validation préalable.

Les migrations de base de données doivent être versionnées.


# 27 CI/CD

Le pipeline CI/CD devra effectuer automatiquement :

```text
Git Push
   ↓
Lint
   ↓
Tests
   ↓
Build
   ↓
Security checks
   ↓
Deploy staging
   ↓
Validation
   ↓
Deploy production
```

Un déploiement doit pouvoir être rollbacké en cas de problème.


# 28 Configuration

Les paramètres suivants doivent être configurables sans modifier le code :

* fournisseurs IA ;
* modèles ;
* prompts ;
* timeout ;
* retries ;
* limites de concurrence ;
* quotas ;
* durée maximale des vidéos ;
* formats vidéo ;
* voix ;
* avatars ;
* règles de validation.

Les prompts doivent idéalement être stockés comme des ressources versionnées plutôt que directement dans le code.


# 29 Extensibilité

L'ajout d'un nouvel agent doit être possible sans modifier profondément le reste de la plateforme.

Exemple :

```text
agents/
├── news/
├── research/
├── script/
├── factcheck/
├── voice/
├── avatar/
├── video/
├── quality/
└── translation/       ← nouvel agent
```

Un nouvel agent doit pouvoir être enregistré dans le workflow via une interface standardisée.


# 30 Interopérabilité

Les communications internes doivent utiliser des formats structurés et documentés.

Format recommandé :

**JSON**

Les contrats d'API doivent être documentés via :

**OpenAPI / Swagger**

Chaque agent doit définir :

```text
Input schema
Output schema
Error schema
```


# 31 Gouvernance des modèles IA

Les modèles utilisés par les agents doivent être identifiables.

Pour chaque exécution :

```text
provider
model
version
prompt_version
parameters
timestamp
```

Une modification de modèle doit pouvoir être détectée dans l'historique.


# 32 Exigences de sécurité spécifiques aux agents IA

Les agents doivent être protégés contre :

* prompt injection provenant de pages web ;
* instructions malveillantes présentes dans les contenus récupérés ;
* fuite de données ;
* exécution d'actions non autorisées ;
* manipulation des sorties ;
* utilisation abusive des outils.

Les données récupérées sur le web doivent être considérées comme **non fiables**.

Une page web ne doit jamais pouvoir modifier directement les instructions système d'un agent.

Architecture :

```text
Contenu Web
     ↓
Données non fiables
     ↓
Extraction / nettoyage
     ↓
Agent
     ↓
Validation
```

Les agents disposant d'outils d'action doivent fonctionner avec le principe du **moindre privilège**.


# 33 Critères d'acceptation non fonctionnels

Le MVP devra respecter au minimum les critères suivants :

| Domaine       | Critère                                                  |
| ------------- | -------------------------------------------------------- |
| API           | p95 < 500 ms pour les endpoints simples                  |
| Asynchrone    | Aucun traitement IA long ne bloque une requête HTTP      |
| Résilience    | Retry automatique sur les erreurs temporaires            |
| Reprise       | Reprise possible d'un workflow interrompu                |
| Traçabilité   | Chaque étape possède un `agent_run_id`                   |
| Sécurité      | Les clés API ne sont jamais exposées au frontend         |
| Isolation     | Un utilisateur ne peut accéder aux données d'un autre    |
| Stockage      | Les fichiers lourds sont stockés hors PostgreSQL         |
| Versioning    | Scripts et prompts sont versionnés                       |
| Monitoring    | Logs et métriques disponibles                            |
| Coûts         | Coût par génération calculable                           |
| Tests         | Tests unitaires + intégration + E2E                      |
| Déploiement   | Environnements dev/staging/prod séparés                  |
| Rollback      | Retour à une version précédente possible                 |
| Accessibilité | Objectif WCAG 2.2 AA                                     |
| Formats       | MP4/H.264/AAC minimum                                    |
| Sécurité IA   | Protection contre les prompt injections provenant du web |
| Disponibilité | Objectif MVP : 99 %                                      |


# 34 Priorisation des exigences non fonctionnelles

Pour éviter de surdimensionner le MVP, les exigences peuvent être classées en trois niveaux.

### Critiques — MVP

* sécurité ;
* isolation des utilisateurs ;
* gestion des erreurs ;
* reprise des workflows ;
* traçabilité ;
* gestion des coûts ;
* stockage sécurisé ;
* tests ;
* monitoring minimal ;
* protection des secrets.

### Importantes — V1

* haute disponibilité ;
* autoscaling ;
* fallback providers ;
* CI/CD complet ;
* métriques avancées ;
* optimisation des coûts ;
* disaster recovery.

### Évolutives — V2/V3

* multi-région ;
* haute disponibilité avancée ;
* scaling automatique avancé ;
* réplication multi-région ;
* orchestration avancée des modèles ;
* optimisation dynamique du choix des fournisseurs.


# 35 Principe directeur mis à jour

La plateforme doit donc répondre à deux contraintes simultanées :

**1. Être capable de produire automatiquement du contenu.**

**2. Être suffisamment robuste pour que chaque production soit traçable, contrôlable, reproductible autant que possible et récupérable en cas d'erreur.**

L'architecture cible doit privilégier :

```text
Modularité
     +
Observabilité
     +
Sécurité
     +
Résilience
     +
Scalabilité
     +
Traçabilité
```

plutôt qu'une simple chaîne d'agents connectés entre eux.

Cette section complète bien le cahier des charges existant : elle transforme notamment des notions comme « robuste », « scalable » ou « sécurisé » en **exigences vérifiables et mesurables**.
