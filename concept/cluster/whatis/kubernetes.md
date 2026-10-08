[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Cluster][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[host whatis]: /concept/machine/whatis/host.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |

<h1 align="center">What is a Kubernetes Cluster</h1>

The concept of Kubernetes Cluster

# Definition
- Aka. K8s, K8s cluster
- Orchestrates [containers](#) lifecycle
- uses both declarative and imperative mode

# Key Idea
- Containerized applications and infrastructure are modeled as a set of **Kubernetes resources**.
- K8s doesn't manage containers directly.
- It only defines interfaces and delegates container operations to external components that implement them.
- The cluster is often made of VMs, but for learnig and test purpose it can be made of containers

# Concept
**Node Role**:
- Each node has a role
- It may be a 
    - **worker**: run the actual workloads.
    - **control plane**: make decisions (API, scheduler, controllers).

**Resource**
- Described in **manifest**

**Kind**
- Static
- The type of a **resource** (e.g. `Pod`, `Deployment`, `Service`).
- The type name of a REST resource
- The `kind` **field** in a manifest.
- Determines the resource's **schema**, **fields**, and which **controller** manages it.

**Object**
- Dynamic
- Instance of a **Kind**
- Persistent entity in the Kubernetes system
- has names and UIDs 
- gets a unique name (within its namespace) and a cluster-wide unique UID to distinguish it.
- E.g: 
  - `nginx-pod`, `redis-pod`, `db-pod`, all instanciate from kind:`pod`
  - `web-deployment` instanciate from kind:`deployment`

**Manifest**
- Described the **desired state** of a resource
- A file (usually YAML/JSON)
- Describes one or more objects (aka. **instance**).

**State**
- Each resource has a state:
  - **Current/Actual state** = what's running now.
  - **Desired state** = what the manifest says.


**Controller**
- A background control loop
- Continuously compares a resource's **actual** and **desired** state.
- Reconciles them when they differ, changing the actual state until it matches the desired state.

**Workload** 
- a containerized application or task that Kubernetes must runs and manages.
Kubernetes provides several built-in workload resources for managing Pods. Examples include Deployment, StatefulSet, DaemonSet, Job, and CronJob.

# How it works

## Modeling as Kubernetes resources
1. **You** → declare what you want using resources (`Pod`, `Deployment`, `Service`, `ConfigMap`, `Ingress`, …).
1. **API server** → stores them as objects.
1. **Controllers** → reconcile the **actual state** toward the **desired state**.

## From desired state to running containers
1. **Controller** → creates **Pods** to match desired state.
1. **Scheduler** → assigns Pods to **nodes**.
1. **kubelet** → watches Pods on its node, calls the **container runtime**.
1. **Runtime** (via **CRI**, e.g. `containerd`) → **starts / stops / restarts containers**.

# Imperative vs. Declarative

## Imperative

You tell K8s **what to do**, step by step:

```bash
kubectl run nginx --image=nginx          # create a pod
kubectl scale deployment web --replicas=5 # scale it
kubectl delete pod nginx                  # delete it
kubectl expose deployment web --port=80   # create a service
```

1. **You** → issue a **command** (`kubectl run nginx --image=nginx`, `kubectl scale …`, `kubectl delete …`).
1. **kubectl** → builds a manifest from that command and sends it to the API Server.
1. **API server** → stores it as an object, exactly like the declarative path.

You say **what to do**, step by step. **Not idempotent** — good for quick tasks and debugging, not for production.

## Declarative

You tell K8s **what you want** (the desired state), and it figures out how:

```bash
kubectl apply -f deployment.yaml
```

```yaml
kind: Deployment
metadata: { name: web }
spec:
  replicas: 5
  ...
```



**From manifest to stored object**

| Stage | Thing | Form | Who handles it |
|---|---|---|---|
| 1. You write | **manifest** | YAML text (file) | you |
| 2. kubectl builds | **request object** | JSON (in memory) | kubectl |
| 3. kubectl sends | **HTTP request + request object** | JSON (over HTTP) | kubectl → API server |
| 4. API server receives | **request object** | JSON (in memory) | API server |
| 5. API server authenticates | **identity check** | credentials / token | API server |
| 6. API server authorizes | **permission check** (RBAC) | policy decision | API server |
| 7. API server decodes | **API object** | structured Go type (in memory) | API server |
| 8. API server admits | **admission review** (mutating → validating webhooks) | API object (possibly modified) | API server + webhooks |
| 9. API server validates | **schema validation** | API object (checked) | API server |
| 10. API server defaults | **defaulted API object** | structured Go type (in memory) | API server |
| 11. API server assigns identity | **identity fields** (`UID`, `resourceVersion`, `creationTimestamp`) | structured Go type (in memory) | API server |
| 12. API server persists | **stored object** | serialized key–value record | etcd |
| 13. API server responds | **response object** (with identity + status) | JSON (over HTTP) | API server → kubectl |

**step 1**:
- you describe the **desired state** (of one or more **objects**) and do a `kubectl apply -f manifest.yaml`.

**step 5 to 11**: The API server:
- **validates** the request body against the schema
- **defaults** fields the schema says are required or have defaults 
- **assigns** identity (name, UID, resourceVersion, creationTimestamp)
- **assigns** status - the observed state, which you never wrote.


**step 12**: etcd stores 
- the object as a key–value record (a serialized blob, not a live JSON document).

**step 13**: etcd stores 
- the object as a key–value record (a serialized blob, not a live JSON document).



## Summary
```
You write a manifest (YAML)
↓
kubectl builds a JSON object (request) 
↓
the API server validates, defaults, and assigns identity
↓
etcd persists the object. 
↓
The stored object is the request object plus server-added fields and status.
```


- K8s controllers reconciles actual → desired, repeatedly.
- The manifest is **versionable, reviewable, repeatable** (GitOps).

## Conclusion

**The key difference**

| | Imperative | Declarative |
|---|---|---|
| You provide | **commands** (how) | **state** (what) |
| K8s does | executes the action | reconciles toward the state |
| Idempotent? | ❌ not really | ✅ yes (`apply` is safe to re-run) |
| Source of truth | your shell history | the manifest (in Git) |
| Best for | quick tasks, debugging | production, automation |

**Which should you use?**

- **Imperative** → learning, quick tests, one-off debugging (`kubectl run`, `kubectl delete`).
- **Declarative** → anything real: production, CI/CD, GitOps (ArgoCD, Flux).
- **Best practice:** use imperative for *inspection* (`kubectl get`, `describe`, `logs`) and declarative for *changes* (`apply`).
- **Key idea:** 
  - K8s *can* be driven imperatively
  - but its power (self-healing, reconciliation, GitOps) only kicks in when you use it **declaratively**.

# Idempotence by example

```bash
kubectl scale deployment web --replicas=5
```

- Run it **once** → 5 replicas.
- Run it **again** → still 5 replicas. ✅ (this one *is* idempotent)

---

```bash
kubectl run nginx --image=nginx
```

- Run it **once** → creates a Pod called `nginx`.
- Run it **again** → **ERROR: already exists**. ❌ (not idempotent)

---

```bash
# create -> knows how to create, not update - imperative operation
kubectl create -f pod.yaml
```

- Run it **once** → creates the object.
- Run it **again** → **ERROR: already exists**. ❌

---

```bash
# apply -> diffs the file against the live object and updates it - declarative operation
kubectl apply -f pod.yaml
```

- Run it **once** → creates the object.
- Run it **again** → **no error, no change** (or updates to match). ✅ (idempotent)



---

# Actual vs. Desired State

K8s reconciles/comptraes actual vs. desired state using either **three-way merge** (client-side `kubectl apply`) or **field-ownership tracking** (Server-Side Apply), with SSA being the newer replacement.


# Does every K8s kind lead to Pods and containers?

The official docs state: 
- In Kubernetes, you run your **workload** inside a set of pods. 
- A Pod represents a set of one or more **running containers**.
- You use the Kubernetes API to create **workload objects** from **workload resources**.
- these objects represent a higher abstraction level than a **Pod**, 
- Kubernetes control plane automatically manages Pod objects on your behalf from these **workload objects**.

The process is:
- you **don't directly declare Pods** when using controllers. 
- You declare a **higher-level object** (e.g., a `Deployment`). 
- The associated **controller** then creates the Pods for you.
- kubelet + runtime start `containers`**



Many resource kinds have **nothing to do with Pods**:

- `Service`, `Ingress` — networking
- `ConfigMap`, `Secret` — configuration
- `PersistentVolume`, `PersistentVolumeClaim` — storage
- `ServiceAccount`, `Role`, `RoleBinding` — identity and access

## Conclusion

- Only **workload resources** create/lead to Pods.
- **workload resources** are
  - Deployment
  - StatefulSet
  - DaemonSet
  - Job / Cronjob

**Yes.** Kubernetes officially describes them as "workload resources" that manage a set of Pods on your behalf. Each configures a controller that ensures the right Pods are running.

| Workload Kind | What its controller creates |
|---|---|
| **Deployment** | Creates a ReplicaSet, which creates and manages Pods |
| **StatefulSet** | Creates Pods directly, each with a stable identity and its own PersistentVolume |
| **DaemonSet** | Creates one Pod per matching node (or a subset of nodes) |
| **Job / CronJob** | Creates Pods that run to completion, then stop |

```
Workload (what you want running)
↓
Deployment / Job / StatefulSet / etc. (how Kubernetes manages it)
↓
Pod(s) (Kubernetes' smallest runnable unit)
↓
Container(s) (where the application actually runs)
```

The chain for a Deployment is: **Deployment → ReplicaSet → Pods → Containers**. For the others, the controller creates Pods more directly.

# From common resources to K8s resources


| IT / Container concept                                  | Kubernetes equivalent               | Manifest `kind` / field                            | Notes                                                                                                                                 |
| ------------------------------------------------------- | ----------------------------------- | -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| **Running container**                                   | **Pod**                             | `kind: Pod`                                        | A Pod is the smallest deployable unit and can contain **one or more containers**. A Pod is not exactly the same thing as a container. |
| **Container image**                                     | **Container image reference**       | `spec.containers[].image`                          | There is **no `kind: Image`** in standard Kubernetes. Example: `image: nginx:1.27`.                                                   |
| **Container definition / run configuration**            | **Container spec** inside a Pod     | `spec.containers[]`                                | There is **no `kind: Container`**. Container configuration lives inside a Pod template/spec.                                          |
| **Multiple identical application instances (replicas)** | **Deployment → ReplicaSets → Pods** | `kind: Deployment`                                 | A Deployment manages ReplicaSets, which manage the actual Pods. Use `spec.replicas` for the desired count.                            |
| **One-off / batch task**                                | **Job**                             | `kind: Job`                                        | Runs Pods until the requested work completes.                                                                                         |
| **Scheduled batch task**                                | **CronJob → Jobs → Pods**           | `kind: CronJob`                                    | Creates Jobs according to a schedule.                                                                                                 |
| **Stateful application**                                | **StatefulSet → Pods**              | `kind: StatefulSet`                                | Provides stable Pod identity, ordering, and commonly persistent storage.                                                              |
| **One Pod on each node**                                | **DaemonSet → Pods**                | `kind: DaemonSet`                                  | Common for node agents such as logging or monitoring agents.                                                                          |
| **Network endpoint / load balancing for Pods**          | **Service**                         | `kind: Service`                                    | Provides a stable virtual IP/DNS name and routes traffic to matching Pods.                                                            |
| **External HTTP(S) routing**                            | **Ingress**                         | `kind: Ingress`                                    | Routes HTTP/HTTPS traffic to Services. Requires an Ingress controller.                                                                |
| **Application configuration**                           | **ConfigMap**                       | `kind: ConfigMap`                                  | Stores non-sensitive configuration; can be exposed as environment variables or files.                                                 |
| **Passwords, tokens, sensitive configuration**          | **Secret**                          | `kind: Secret`                                     | Kubernetes Secret object. Note that base64 encoding is **not encryption by itself**.                                                  |
| **Persistent storage request**                          | **PersistentVolumeClaim (PVC)**     | `kind: PersistentVolumeClaim`                      | A workload normally requests storage through a PVC.                                                                                   |
| **Actual cluster storage resource**                     | **PersistentVolume (PV)**           | `kind: PersistentVolume`                           | Represents storage available to the cluster; often dynamically provisioned.                                                           |
| **CPU / memory allocation**                             | **Resource requests and limits**    | `spec.containers[].resources.requests` / `.limits` | **Not a Kubernetes `kind`**. These are fields in a container specification.                                                           |
| **Container restart behavior**                          | **Pod restart policy**              | `spec.restartPolicy`                               | Controls restarting of containers in the Pod. Common values: `Always`, `OnFailure`, `Never`.                                          |
| **Container health check**                              | **Probe**                           | `livenessProbe`, `readinessProbe`, `startupProbe`  | **Not separate Kubernetes kinds**. Probes are container-spec fields.                                                                  |
| **Namespace / logical isolation**                       | **Namespace**                       | `kind: Namespace`                                  | Groups and isolates namespaced Kubernetes resources.                                                                                  |
| **Application identity / grouping**                     | **Labels and selectors**            | `metadata.labels`, `spec.selector`                 | Not a separate resource. Used heavily by Deployments, Services, etc.                                                                  |

# Modeling containers inside k8s

> ⚠️ You don't deploy containers in K8s — you deploy Pods

## 1. The Pod is the smallest deployable unit

A container is always wrapped inside a Pod.

- In Docker, the unit of deployment is **the container**. You `docker run` a container, and that's it.
- In K8s, the smallest unit you can **create, schedule, and manage** is the **Pod** — not the container. 
  - The scheduler places *Pods* on nodes. 
  - The kubelet runs *Pods*. 
  - Controllers reconcile *Pods*. 


## 2. A Pod can hold more than one container

> ⚠️ deploying a container is in fact deploying a Pod that happens to contain a container

A Pod can run:
- **One container** — the common case (one app per Pod).
- **Multiple containers** 
— e.g. 
  - a main app + a **sidecar** (logging, proxy, config reloader)
  - an **init container** that runs before the main one.

These containers in a Pod:
- Share the **same network namespace** (same IP, same ports).
- Can share **volumes**.
- Are scheduled **together** on the same node.
- Share a **lifecycle** (they start and stop as a unit).


## 3. You rarely create Pods directly

Deploying a Pod is usually **indirect**. In practice 
1. **you** → declare **resources/objetcs** : a `Deployment`, `StatefulSet`, `DaemonSet`, `Job`
1. its **controller** → creates and manages the Pods for you. 
1. kubelet + runtime → start `containers`
  
Those controllers handle:
- **Replicas** (how many Pods).
- **Rolling updates** (replace Pods gradually).
- **Self-healing** (recreate Pods when they die).
- **Scaling** (up/down).


## 4. Why this design exists
- **Colocation:** some processes must run tightly coupled on the same node and share network/storage — Pods make that a first-class concept.
- **Scheduling unit:** the scheduler reasons about Pods, not individual containers.
- **Lifecycle:** grouping containers under one lifecycle simplifies restart, eviction, and rescheduling.
- **Abstraction:** you describe *what* you want; K8s handles *how* containers actually run.


# Classifying K8s resources

- Kubernetes resources can be **grouped conceptually into categories**, 
- There isn't **one single official Kubernetes taxonomy** that says

A useful practical classification is:

| Category                                | Purpose                                          | Common Kubernetes resources                                                   |
| --------------------------------------- | ------------------------------------------------ | ----------------------------------------------------------------------------- |
| **Workload resources**                  | Run and manage Pods / applications               | `Deployment`, `StatefulSet`, `DaemonSet`, `Job`, `CronJob`                    |
| **Service / networking resources**      | Provide network access to workloads              | `Service`, `Ingress`, `NetworkPolicy`, `Gateway`, `HTTPRoute`                 |
| **Configuration resources**             | Store application configuration                  | `ConfigMap`, `Secret`                                                         |
| **Storage resources**                   | Request and provide persistent storage           | `PersistentVolumeClaim`, `PersistentVolume`, `StorageClass`, `VolumeSnapshot` |
| **Cluster / infrastructure resources**  | Describe or control cluster-level infrastructure | `Node`, `Namespace`, `ResourceQuota`, `LimitRange`                            |
| **Access control / security resources** | Define authentication/authorization permissions  | `ServiceAccount`, `Role`, `ClusterRole`, `RoleBinding`, `ClusterRoleBinding`  |
| **Metadata / organization resources**   | Organize and identify resources                  | `Namespace`, `Label`, `Annotation`*                                           |
| **Autoscaling resources**               | Automatically adjust workload capacity           | `HorizontalPodAutoscaler`, `VerticalPodAutoscaler`*                           |
| **Policy resources**                    | Control how workloads may behave or be scheduled | `PodDisruptionBudget`, `NetworkPolicy`, `ResourceQuota`, `LimitRange`         |

> ⚠️ `Labels` and `annotations` aren't actually Kubernetes `kind`s; they're metadata attached to resources. 

> ⚠️ `VerticalPodAutoscaler` is also not part of the Kubernetes core API; it's an additional component.

> ⚠️ **workload resource** is a specific Kubernetes concept while **configuration**, **cluster** are not a official classification; They are only **useful organizational groupings**

The same classification as a tree:

```text
Kubernetes API resources
│
├── Workloads
│   ├── Deployment
│   ├── StatefulSet
│   ├── DaemonSet
│   ├── Job
│   └── CronJob
│
├── Networking
│   ├── Service
│   ├── Ingress
│   ├── NetworkPolicy
│   └── Gateway / HTTPRoute
│
├── Configuration
│   ├── ConfigMap
│   └── Secret
│
├── Storage
│   ├── PersistentVolume
│   ├── PersistentVolumeClaim
│   └── StorageClass
│
├── Security / Access
│   ├── ServiceAccount
│   ├── Role
│   ├── ClusterRole
│   ├── RoleBinding
│   └── ClusterRoleBinding
│
└── Cluster / Administration
    ├── Node
    ├── Namespace
    ├── ResourceQuota
    └── LimitRange
```
