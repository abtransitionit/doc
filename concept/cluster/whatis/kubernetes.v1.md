---
---

[//]: #(Reference)

[ApiClient_Whatis]:   .
[Operator_whatis]:    ./operator.md
[Kubelet_whatis]:     ./cpl-kubelet.md
[Scheduler_whatis]:   ./cpl-scheduler.md
[Controller_whatis]:  ./ctl-controller.md
[Deployment_whatis]:  ./res-dep.md
[ApiServer_Whatis]:   ./cpl-apiserver.md
[Etcd_Whatis]:        ./cpl-etcd.md
[Cni_Whatis]:         ./plug-cni.md
[Csi_Whatis]:         ./plug-csi.md
[Resource_Whatis]:    ./res-resource.md
[Kubectl_Whatis]:     ./cli-kubectl.md
[Helm_Whatis]:        ./cli-helm.md
[Controller_Whatis]:  ./ctl-controller.md
[Manifest_Whatis]:    ./res-manifest.md
[Node_Whatis]:        ./node.md
[Webhook_Whatis]:     ./plug-webhook.md
[Cri_Whatis]:         ./plug-cri.md




# Todo
**server that expose data in kubernetes**: is there other server that does this in kubernetes
| Component      | Exposes              | API type     | Meaning              |
| -------------- | -------------------- | ------------ | -------------------- |
| **etcd**       | Key–value data       | gRPC / HTTP  | Raw state storage    |
| **API Server** | Kubernetes resources | REST / HTTPS | Kubernetes semantics |







## Declarative Model and self-healing

### declarative  vs imperative

Kubernetes can works in both imperative and declarative mode, but works best in **declarative mode**

**Imperative** mode: 

You tell Kubernetes **what to do**.

Example:

* “Create this Pod”
* “Scale this Deployment to 5 replicas”

**Declarative** mode: 

You tell Kubernetes **what to want** (not what to do) by describing the **desired state** of one or more **resources** in a [manifest][Manifest_Whatis], and Kubernetes try to make it true.

Example:

* “I want 5 replicas of this Deployment running”

### the declarative model

Kubernetes uses the concept of **resource state**.
It continuously compares:

* the **actual state** of a resource (what is **running** in the cluster - ie. the resource **status** of the instance stored in [etcd][Etcd_Whatis])
* the **desired state** of a resource (what is **declared** in a manifest - ie. the **spec** field that is also stored in [etcd][Etcd_Whatis])

**how it works**

Controllers continuously **watch** resources state (both actual and desired) and **try** to **reconcile** them (ie. make the **actual** state of a resource **match** the **desired** state of that resource).
In other words, if a resource fails or disappears, Kubernetes automatically tries to correct the situation.
This behavior (automatic correction) is called **self-healing**.


This applies to all resources:

* **kubernetes resources** (eg. pods, services, volumes, replicas)


For example, if a container disappears, Kubernetes attempts to restart it.


## Self-Healing and the Declarative Model

Kubernetes is based on the concept of **resource state**.
It continuously compares:

* the **desired state** of a resource (what is **declared**)
* the **actual state** of a resource (what is **running**)

Controllers continuously **watch** resources and **try** to **reconcile** them (ie. make the **actual** state of a resource **match** the **desired** state of that resource).
In other words, if a resource fails or disappears, Kubernetes automatically tries to correct the situation.
This behavior is called **self-healing**.


This applies to a lot of resources:

* **kubernetes resources** (eg. pods, services, volumes, replicas)
* **containerized applications** that are set of several **kubernetes resources**


For example, if a container disappears, Kubernetes attempts to restart it.






# Interaction with the cluster

- Users and tools interact with the cluster through the **API server**, using **manifests** or **direct commands**.
- The API server is the only entry point to the cluster.
- All queries, and operations go through it.

the way to interact with the cluster are:

| Method| What it is / How it works|
| -----------------------| -------------------------------------------------------------------------------------------------------------------------------|
| `kubectl`| CLI that sends requests using kubeconfig credentials.|
| `curl` (REST API)| Direct HTTP requests to the Kubernetes API server. Requires authentication (token/cert).|
| `Go` client (client-go)| the official Go client library to build controllers, operators, or automation tools.|
| Other client libraries| SDKs for Python, Java, JavaScript, etc. (e.g., `python-kubernetes`, `java-client`).|
| `Controllers` / Operators| Control loops running inside the cluster that interact with the API to maintain state.|
| GitOps tools| Tools like `ArgoCD` or `Flux` that continuously reconcile Git repositories with cluster state.|





# How it works


1. Create a [manifest][Manifest_Whatis] that declares the desired state of one or more resources.
1. Send (aka `apply`) the manifest to the API server with [kubectl][Kubectl_Whatis] or another [API client][ApiClient_Whatis].
1. The API server **stores** the **desired state** (defined in the manifest) in [etcd][Etcd_Whatis].
1. Controllers **observe the desired state** and determine what must change compared to the actual state.
1. The **Scheduler** assigns/places pods to/on nodes (if needed), based on the desired state.
1. Kubelets **create or update containers** according to the desired state in the manifest.
1. The **actual state**,that is the set of running containers and resources on the nodes is formed.
1. Kubelets **report the actual state** back to the API server.
1. Controllers **reconcile**: they continuously compare actual vs desired state and act to make them match.


# reference
|Name|link|
|-|-|
|kubectl|[definition][Kubectl_Whatis]
|helm|[definition][Helm_Whatis]
|API Server|[definition][ApiServer_whatis]
|ETCD|[definition][Etcd_whatis]
|Controller|[definition][Controller_whatis]
|Operator|[definition][Operator_whatis]
|kubelet|[definition][Kubelet_whatis]
|scheduler|[definition][Scheduler_whatis]
|Pod|[definition][Controller_whatis]
|Deployment|[definition][Deployment_whatis]


# namespace
## Rules and BP
- never put them in chart
- `kube-system` is reserved for:
  - kube-apiserver
  - kube-controller-manager
  - kube-scheduler
  - CoreDNS
  - kube-proxy
  - CNI plugins
  - cluster-autoscaler
  - metrics-server
  - etc.
- A resource does NOT **mandatory** belongs in `kube-system` because it is:
  - cluster-wide
  - running on all nodes
  - privileged
  - using hostPath
  - etc.

does NOT mean it belongs in kube-system.
# Installation
