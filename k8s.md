[//]: #(Reference)
[README]:  ./README.md

# [<-][README]Kubernetes

* aka. **cluster Kubernetes**
* une **plateforme d’orchestration de conteneurs**
* un système qui maintient en permanence **l’état désiré** des **applications** containerisées.
* écrite principalement en **Go**
* basée sur un **modèle déclaratif**

Rôle :

* **déployer**, **exécuter**, **scaler** et **auto-réparer** des applications conteneurisées

Fonctionnement (vue d’ensemble) :


1. Définir/Déclarer un **manifest Kubernetes** (fichier YAML)
2. Envoyer le YAML/Manifest à Kubernetes qui le reçoit via son **API**
3. l’**état désiré**, issu du manifest, est **stocké dans etcd**
4. l’**état réel** provient des **nœuds**, via les **kubelets** qui **remontent leur statut** à l’API
5. les **contrôleurs** comparent état désiré (etcd) / état réel (statuts - feedback des nœuds via kubelet)
6. les **nœuds** exécutent ou corrigent l’exécution des conteneurs


Composants clés :

* API Server
* etcd
* contrôleurs
* scheduler
* kubelet

👉 En résumé :


# kubectl
* La télécommande pour piloter le **cluster**.
* communique avec l’**API Server**
* La `CLI` pour **piloter un cluster Kubernetes**. 

Son rôle:
* **Gérer** le cluster lui même ou ses ressources
* exemple de gestion générique
  - **déployer**, **modifier**, **inspecter** et **supprimer** des ressources k8s (pods, services, deployments, etc.)
* exemple de gestion spécifique  
  - **orchestrer** le placement des pods selon les contraintes (CPU, mémoire, labels, affinités),  
  - **assurer** la haute disponibilité via le redémarrage automatique et le rescheduling,  
  - **adapter** dynamiquement le cluster (autoscaling, rolling updates).

Exemples typiques :

* déployer une app : `kubectl apply`
* voir l’état du cluster : `kubectl get`
* diagnostiquer : `kubectl describe`, `kubectl logs`
* intervenir : `kubectl exec`, `kubectl delete`


# L’API Kubernetes

* serveur REST central, écrit en Go, , cœur de tout Kubernetes**.
* un **serveur REST** appelé **kube-apiserver**
* **implémenté en Go**
* exposé en **HTTPS**
* utilisant des **ressources typées**
* DB: backed par **ETCD** une DB décentralisé (Pod, Service, Deployment, etc.)

Fonctionnement de base :

1. `kubectl` (ou autre client) envoie des requêtes **HTTP (GET, POST, PUT, DELETE)**
2. `kube-apiserver` :

   * authentifie et autorise la requête (RBAC)
   * valide les objets
   * les **stocke dans etcd** (base clé/val distribuée)
3. Les contrôleurs et composants Kubernetes **regardent l’API** et réagissent aux changements

Toujours très rapidement 👇

# ETCD

* Est la mémoire fiable et cohérente du cluster Kubernetes.
* une **base de données clé/val distribuée**
* **écrite en Go**
* communiquant via une **API gRPC / HTTP**
* basée sur l’algorithme de consensus **Raft**

Rôle dans Kubernetes :

* stocker **tout l’état du cluster** (objets, config, secrets, métadonnées)
* garantir **cohérence forte** et **haute disponibilité**

Fonctionnement de base :

1. Le **kube-apiserver** lit/écrit dans **etcd**
2. **etcd** réplique les données entre ses nœuds via **Raft**
3. Une écriture est validée seulement si la **majorité** des nœuds l’accepte



# Contrôleur Kubernetes

* moteur d’auto-réparation de Kubernetes.
* un **processus en boucle** (*control loop*)
* soit 
  - **prédéfini** (natif, fourni par Kubernetes), exécuté dans le control plane (Deployment, ReplicaSet, Node, Job, etc.)
  - **custom** ( **opérateur** Kubernetes) écrit en **Go** et déployé via **Helm**

Rôle :

* **surveiller l’API Kubernetes**
* comparer **état désiré** vs **état réel**
* agir pour les rendre conformes

Fonctionnement :

1. le contrôleur **observe** les ressources (watch)
2. détecte un écart
3. **crée / modifie / supprime** des ressources via l’API pour minimiser l'écart

Exemples :

* Deployment Controller
* ReplicaSet Controller
* Node Controller



# Opérateur Kubernetes

* Permet d'intégrée à Kubernetes des automatisations liés des **actions** (voire complexe) nécessitant une **expertise** 
* un **contrôleur Kubernetes** custom
* écrit le plus souvent en **Go**
* basé sur des **CRD (Custom Resource Definitions)**

Rôle :

* étendre Kubernetes avec un **nouveau type de ressource**
* automatiser des tâches complexes (install, upgrade, backup, heal)

Fonctionnement :

1. Déclarer un objet custom (ex : `PostgresCluster`)
2. l’opérateur **observe l’API Kubernetes**
3. il agit pour que l’état réel corresponde à l’état désiré



# Helm

* gestionnaire de déploiement (repos, packages, operateurs) spécifique à **Kubernetes**
* basé sur des **charts Helm** (templates YAML)
* côté client (pas un composant du cluster)

Rôle :

* **installer, mettre à jour, supprimer** des applications
* gérer les versions et la configuration

Fonctionnement :

1. Helm `rend` les templates YAML
2. envoie les manifests via l’API Kubernetes
3. Kubernetes fait le reste

Très rapidement 👇

# kubelet

* **Agent** qui tourne sur **chaque nœud**
* écrit en **Go**
* parle avec l’**API Kubernetes**

Rôle :

* **exécuter les Pods** sur le nœud
* vérifier leur **état réel**
* rapporter l’état au control plane

Fonctionnement :

1. chef d’orchestre local du **nœud**
2. kubelet reçoit des Pods assignés
2. Appelle le **runtime de conteneurs** (containerd, CRI-O)
3. Surveille les conteneurs et remonte le statut



# scheduler

* composant du **control plane**
* écrit en **Go**

Rôle :

* Décide/Choisit **sur quel nœud** placer chaque Pod

Fonctionnement :

1. Détecte les Pods **non planifiés**
2. Filtre les nœuds possibles
3. Score les meilleurs nœuds
4. Assigne le Pod via l’API

Critères :

* ressources (CPU, RAM)
* affinités / anti-affinités
* taints & tolerations


# Pod

**Pods planifiés vs non planifiés**

1. Etapes de **placement des pods**

    1. **Créer** par user ou controller → API le reçoit → le Pod est ajouté à l’API → **non planifié**.
    2. **Décider** : 
        - le scheduler consulte l’API pour détecter les Pods non planifiés.
        - le scheduler choisit le meilleur nœud disponible.
    3. **Assigner** : 
        - le **scheduler** écrit le `nodeName` dans l’objet Pod via l’API → le Pod devient **planifié**.
        - le **kubelet** prends le relais

1. **Pod non planifié**
   * C’est un Pod 
       - **en attente de décision du scheduler**
       - **créé mais pas encore assigné à un nœud**.
   * Cela arrive juste après un `kubectl apply -f pod.yaml` ou quand on **créé** un **Deployment**.
   * Le Pod existe dans l’**API Kubernetes**, mais n’a pas encore de champ `nodeName` défini.

1. **Pod planifié**

   * C’est un Pod **prêt à être exécuté** sur un nœud**.
   * C’est un Pod qui a **été assigné à un nœud par le scheduler**.
   * Son champ `nodeName` est rempli.
   * Le kubelet du nœud peut alors lancer les conteneurs.



# Terminology

|name|type|extension|comment
|-|-|-|-|
|manifest|concept|description déclarative d’une ou plusieurs ressources|
|CLI|acro|**C**ommand **L**ine **I**nteface|ex: `ls`, `print`, `aws`