[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Cluster][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[host whatis]: /concept/machine/whatis/host.md
[cncf whatis]: https://www.cncf.io/
Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |

<h1 align="center">What is a Kubernetes Cluster</h1>

The concept of Kubernetes Cluster


# Definition
- Aka. K8s, K8s cluster
- Distrinuted plaform
- Orchestrates [containers](#) lifecycle
- **self-healing**
- Optimized for **declarative** mode, but also usable in **imperative** mode
- Resource-oriented system based on YAML manifests.
- written in **Go**
- **Modular** and **pluggable** by design

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

**reconcile** 
- means trying to make the actual state of a resource **match** the desired state of that resource.


**Controller**
- A background control loop
- Continuously compares a resource's **actual** and **desired** state.
- **Reconciles** them when they differ, changing the actual state until it matches the desired state.
- Is resource specific. Each kind of resource has its controller

**Workload** 
- a containerized application or task that Kubernetes must runs and manages.
- Kubernetes provides several built-in **workload** resources for managing Pods. 
- cf. **workload** [resources](#kubernetes-is-resource-oriented)



# Kubernetes: a Container Lifecycle Orchestrator

Kubernetes manages lifecycle of containerized applications. It can **automatically**:

* **Deploy**, **start**, **run**, **stop**, and **scale** containers through `Pods` and `controllers`.
* Ensure the **self-healing** of containerized applications in response to various types of failures.

# Kubernetes ensures self-healing

Kubernetes implements self-healing through the reconciliation jobs done by the controllers.

Examples:
- If a container terminates unexpectedly, the kubelet attempts to restart it according to the Pod's restart policy.
- If a node fails, Kubernetes detects the node failure and may replace or reschedule affected Pods, depending on the workload controller and cluster conditions.


| # | Failure                                  | Kubernetes response                                               |
| - | ---------------------------------------- | ----------------------------------------------------------------- |
| 1 | Service inside container is unresponsive | Restarts container if liveness probe fails.                       |
| 2 | a repeated `404` not found inside container   | Restarts container according to restart policy.                   |
| 3 | Main process inside container exits      | Restarts container according to restart policy.                   |
| 4 | Container runs out of memory             | May terminate container; restarts it according to restart policy. |
| 5 | Container fails its startup probe        | Restarts container after repeated failures.                       |
| 6 | Container repeatedly crashes             | Applies restart backoff; does not fix the root cause.             |


## 1. Service inside the container is unresponsive

* Use case: A container runs an NGINX web server.
* Root process (PID 1): `nginx` (or its master process, depending on how the container is launched).
* **Liveness** probe: Kubernetes sends an HTTP request to the server's health endpoint (`/healthz`).
* Failure: NGINX stops responding, and the probe times out or receives an unsuccessful status code.
* Kubernetes response: Restarts the container after the configured failure threshold is reached.


## 2. Example: NGINX returns `404`

* Use case: A container runs an NGINX web server.
* Root process (PID 1): `nginx` (depending on how the container is launched).
* **Liveness** probe: Kubernetes sends an HTTP request to `/healthz`.
* Failure: NGINX returns `404 Not Found` because that endpoint does not exist.
* Kubernetes response: The probe fails. If the probe reaches its **failure threshold**, Kubernetes restarts the container.

> ⚠️ A `404` doesn't necessarily mean NGINX is unhealthy. It might simply mean the requested URL doesn't exist. That's why you should configure the probe to check an endpoint that accurately reflects the condition you're trying to detect.

## 3. Main process inside the container exits

* Use case: A container runs a Node.js application.
* Root process (PID 1): `node server.js`.
* Detection: The container runtime detects that the main process has exited.
* Failure: The Node.js process crashes because of an unhandled exception.
* Kubernetes response: Restarts the container according to its restart policy.

## 4. Container runs out of memory

* Use case: A container runs a Java application with a memory limit.
* Root process (PID 1): `java -jar app.jar`.
* Detection: The Linux kernel on the Kubernetes node uses cgroups to limit the container's memory usage and may terminate a process with an OOM kill when the memory limit is exceeded.
* Failure: The Java process is terminated by an out-of-memory (OOM) kill.
* Kubernetes response: Restarts the container according to its restart policy, if applicable. The termination reason is typically reported as `OOMKilled`.

## 5. Container fails its startup probe

* Use case: A container runs a Java application that takes time to initialize.
* Root process (PID 1): `java -jar app.jar`.
* **Startup** probe: Kubernetes checks whether the application has completed startup.
* Failure: The application does not start within the configured probe's **failure threshold**.
* Kubernetes response: Restarts the container.

## 6. Container repeatedly crashes

* Use case: A container runs an application that requires a configuration file.
* Root process (PID 1): `python app.py`.
* Detection: The container runtime detects that the main process has exited.
* Failure: The application repeatedly crashes because a required configuration file is missing.
* Kubernetes response: Repeatedly attempts to restart the container, applying increasing delays (`CrashLoopBackOff`). The underlying configuration problem remains unresolved.

> Note: The root process is the process running as PID 1 inside the container. The exact command depends on the container image's `ENTRYPOINT` and `CMD`.


# Kubernetes: a Platform

Kubernetes is composed of elements of different types.

|Element type|Example|
|-|-|
|command-line tools|`kubectl`, `kubeadm`|
|services|`API server`, `controllers`, `scheduler`, `datastore`, daemons|
|configuration files|
|environment variables|

# Kubernetes: a cluster
kubernetes is by design distributed. It must be installed on a set of [hosts][host whatis] (aka. **nodes**).


| Environment | Node type | Notes |
|-|-|-|
|Production-like| VM |
|Dev, Test| Container | cf. [kind](#)

# Kubernetes is Resource-Oriented

- Kubernetes model a **containerized application** as a set of kubernetes **resources**
- Kubernetes resources can be **grouped conceptually into categories**
- There isn't a **official Kubernetes taxonomy**

A useful classification is:

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


# Kubernetes is Modular by design

- Kubernetes is, by design, built from independent **components** that communicate.
- Each component has a clear **responsibility** and defined **capabilities**.
- Most components are written in **Go**.

Core components include:

| Component| Role|
|-|-|
| [API Server](#)| exposes the Kubernetes API|
| Built-in [Controllers](#)| watch specific resources and reconcile them (eg. node controller, replication controller)|
| Controller Manager| runs the **built-in** controllers|
| [Scheduler](#)| assigns workloads's pods to nodes|
| [Kubelet](#)| manages containers on each node|
| Kube-proxy| manages network rules for services|
| [etcd](#)| stores the cluster state (key-value datastore)|

# Kubernetes is Plugable by design

Kubernetes itself does not implement **any** low-level container operations. It does **not** directly:
* how to **manage** (eg. start, stop, or pause) containers
* how containers *communicate* on the **network**
* how **storage** is attached to containers

Instead, it defines standard interfaces and delegates these responsibilities to **external components** that implement them.

| Interface| Meaning| Delegated task managed| Component type| Examples|
|-|-|-|-|-|
| [CRI](#)| **C**ontainer **R**untime **I**nterface| **container lifecycle operations** (start/stop/pause)| container runtimes| containerd, CRI-O|
| [CNI](#)| **C**ontainer **N**etwork **I**nterface| <li>**networking** (pod IPs, routing, policies) <li> pod-to-pod communication| network plugins| Cilium, Calico, Flannel|
| [CSI](#)| **C**ontainer **S**torage **I**nterface| <li>**storage management** (attach/detach, mount) <li> persistent volumes| storage systems| OpenEBS, NFS, Ceph, cloud volumes|
| [Webhook](#)| Admission controller| extend API validation and mutation| webhooks| validating webhook, mutating webhook|

**TODO: Other optional components include**:

| Component| Role|
|-|-|
| Cloud Controller Manager|manages cloud provider-specific controllers|
| Ingress Controller| manages **external** access to **internal** services (HTTP/HTTPS)|
| DNS (CoreDNS)| provides DNS for services inside the cluster|

# Kubernetes is Declarative
# Kubernetes can be Imperative

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




# Kubernetes Tenant

There are **three** ways to implement isolation:

| Model | Isolation level | What is shared | Use case | Notes |
|-|-|-|-|-|
| **Namespace** | Soft / Logical | Control plane + nodes | Trusted internal teams |logical isolation within a shared cluster
| **Node pool** | Medium / Physical compute | Control plane only | Stronger separation needed |dedicated worker nodes per tenant
| **Cluster per tenant** | Hard / Full physical | Nothing | Untrusted or regulated tenants | full physical isolation


**Tools that implement Tenants**
|||
|-|-|
| **Capsule** | <li>defines a `Tenant` CRD that groups namespaces under shared policies (RBAC, quotas, network rules) <li> Cluster admin creates Tenants <li>tenant owners self-serve namespaces within them.
| **vCluster** | <li> Virtual control plane per tenant. <li>Stronger isolation than namespaces <li>lighter than dedicated clusters.
| **Kubernetes native** |no Tenant primitive; Namespaces + RBAC + NetworkPolicy + ResourceQuota is the manual pattern.


# Kubernetes probe

A probe is a check Kubernetes performs to determine the state of a container's application.

## Kind of probes (What to check)

| Probe type | Purpose                                                     | Failure response                                                |
| ---------- | ----------------------------------------------------------- | --------------------------------------------------------------- |
| Liveness   | Checks whether the application is still alive.              | Restarts the container after repeated failures.                 |
| Readiness  | Checks whether the application is ready to receive traffic. | Marks the Pod as not ready, so it stops receiving regular Service traffic until ready again. |
| Startup    | Checks whether the application has finished starting.       | Restarts the container after repeated failures.                 |

**Probe-specific behavior**: 
- A **liveness** or **startup** probe can trigger a restart
- A **readiness** probe instead controls whether the Pod receives regular Service traffic.

## Probe mechanisms (How to check)

Each probe type can use one of these mechanisms:

| Mechanism  | How it works                                                  |
| ---------- | ------------------------------------------------------------- |
| HTTP GET   | Sends an HTTP request and evaluates the response status code. |
| TCP Socket | Checks whether a TCP connection can be established.           |
| Exec       | Runs a command inside the container and checks its exit code. |
| gRPC       | Calls the gRPC health-check protocol.                         |

For example, you can configure 
- an HTTP liveness probe
- a TCP   readiness probe
- an exec startup probe.


## Use case

For an HTTP probe (Liveness, Ready or Startup), Kubernetes evaluates the HTTP response status code:

| HTTP status code            | Probe result |
| --------------------------- | ------------ |
| `200 OK`                    | Success      |
| `301 Moved Permanently`     | Success      |
| `399`                       | Success      |
| `404 Not Found`             | Failure      |
| `500 Internal Server Error` | Failure      |

Kubernetes considers HTTP status codes from 200 to 399 successful for HTTP probes.


## Configuration

**Use case**
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 5
  timeoutSeconds: 2
  failureThreshold: 3
  successThreshold: 1
```
Meaning:
- Kubernetes waits 10 seconds before starting the first probe.
- Kubernetes sends an HTTP GET request to /healthz:8080
- Kubernetes waits 2 seconds for the probe to complete
- Kubernetes retries the probe every 5-second: 
- Failure occurs after 3 consecutives retries (ie. probe failure).


**The parameter `successThreshold`**
- Must be `1`  for `Liveness` probe:
- Must be `1`  for `Startup` probe:
- Can be `> 1` for `Readiness` probe:



# Tools around Kubernetes
## 1. Reconciliation (GitOps & CD Engines)

**Main feature:** Continuously reconcile Kubernetes cluster resources from declarative manifests stored in a Git repository.

### Pure-Play Open Source Reconciliation

* **[Argo CD](https://argo-cd.readthedocs.io/en/stable/):** Graduated CNCF project. Best known for its intuitive Web UI, multi-tenant cluster management, and deep Helm/Kustomize support.
* **[Flux](https://fluxcd.io/):** Graduated CNCF project. Modular, lightweight, CLI/Kubernetes-native set of controllers powered by the *GitOps Toolkit*.

### Progressive Delivery & Advanced Rollouts

*These tools extend the reconciliation loop to handle traffic routing and strategy-based releases (Canary, Blue/Green).*

* **[Argo Rollouts](https://argoproj.github.io/argo-rollouts/):** A Kubernetes CRD/controller that replaces standard Deployments to provide automated canary analysis and blue-green releases.
* **[Flagger](https://flagger.app/):** A CNCF progressive delivery tool (part of Flux) that reconciles traffic routing (`Istio`, `Linkerd`, `NGINX`) based on Prometheus metrics to automate **canary deployments**.

### Infrastructure & External Resource Reconciliation

*These tools extend Kubernetes reconciliation beyond cluster-internal YAMLs to cloud infrastructure.*

* **[Crossplane](https://www.crossplane.io/):** A CNCF Graduated project that lets you manage external cloud infrastructure (AWS S3, GCP CloudSQL, Azure VMs) directly through Kubernetes custom resources using the standard reconciliation loop.
* **[Flux Helm Operator](https://fluxcd.io/flux/components/helm/):** Controller dedicated strictly to declarative Helm release management and chart automated syncs.

### Enterprise & Managed GitOps Platforms

*Commercial and wrapper solutions built on top of the core open-source engines.*

* **[Codefresh](https://codefresh.io/):** Enterprise-grade GitOps platform built directly around Argo CD to provide enterprise RBAC, multi-cluster dashboards, and compliance management.
* **[Harness GitOps](https://www.harness.io/):** An enterprise continuous delivery platform featuring a managed GitOps service powered by Argo CD/Flux engines.


## 2. Ingress & Traffic Management
Main feature: Route incoming external network traffic safely to internal services within the cluster.
- [Ingress NGINX](https://kubernetes.github.io/ingress-nginx/): The standard Kubernetes-maintained Ingress controller built around NGINX.
- [Traefik](https://traefik.io/traefik/): Cloud-native edge router and reverse proxy with automatic SSL and dynamic config support.
- [HAProxy Ingress](https://haproxy-ingress.github.io/): High-performance Ingress controller tailored for low-latency and high-traffic loads.

## 3. Service Mesh & Advanced Networking (CNI)
Main feature: Handle service-to-service communication, encryption (mTLS), observability, and networking policies.
- [Cilium](https://cilium.io/): CNCF Graduated project. High-performance CNI and service mesh leveraging Linux eBPF for security, routing, and deep packet visibility.
- [Istio](https://istio.io/): CNCF Graduated project. Feature-rich service mesh providing advanced traffic routing, security, and telemetry proxies.
- [Calico](https://www.tigera.io/project-calico/): Widely adopted CNI plugin focusing on network performance and strict security policies.

## 4. Observability & Monitoring
Main feature: Collect metrics, logs, and traces to monitor application and cluster health.
- [Prometheus](https://prometheus.io/): The industry standard for metric collection, alerting, and time-series data storage.
- [Grafana](https://grafana.com/): Dashboard and visualization platform that pairs seamlessly with `Prometheus`, `Loki`, and `Tempo`.
- [OpenTelemetry](https://opentelemetry.io/): CNCF framework for collecting unified metrics, logs, and traces across distributed services.

## 5. Storage & Persistence
Main feature: Provide persistent, distributed storage volumes to stateful Kubernetes Pods.
- [Rook](https://rook.io/): Cloud-native storage orchestrator that turns Ceph into a self-managing Kubernetes storage service.
- [Longhorn](https://longhorn.io/): Lightweight, highly available persistent block storage system designed specifically for Kubernetes.

## 6. Security, Policy & Runtime Protection
Main feature: Enforce policy governance, scan for vulnerabilities, and detect runtime security threats.
- [Kyverno](https://kyverno.io/): Kubernetes-native policy engine that uses plain YAML to validate, mutate, and generate configurations.
- [OPA / Gatekeeper](https://www.openpolicyagent.org/): Flexible policy engine used to audit and enforce compliance at the Kubernetes admission control layer.
- [Falco](https://falco.org/): CNCF Graduated runtime security threat detector that intercepts Linux system calls in real-time.



# Todo
```
kubectl apply -f network-tool.yaml
kubectl exec -it network-tool -- sh
```