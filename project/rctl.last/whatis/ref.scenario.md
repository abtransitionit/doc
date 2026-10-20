[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[project software howto]: /project/blueprj/howto/boostrap.md
[res whatis]:             /concept/machine/whatis/res.md
[adr list]:   ../adr/ep.md

Related topics

| Topic | Location| Kind |
|-|-|-|


**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Project: RCtl / Rpro : Use case</h1>

a System to provision and control Resources


# Example 1 — SSH key setup

**Goal:** A new developer should be able to `git clone` the team's repository from GitHub onto their laptop.

## How it works

1. Copy **dotfiles** onto the laptop (just files).
1. Those dotfiles contain an **SSH key** (a file with strict permissions).
    - Generate/obtain the key locally
    - Put the priprivate key in `~/.ssh/id_rsa`
1. You register the **public half** of that key on GitHub as a **deploy key** for the repository.
    - Register the public key remotely
    - GitHub doesn't know who you are yet. 
    - Upload the public half (~/.ssh/id_rsa.pub) to GitHub as a deploy key or SSH key.
1. You **clone** the repository onto the laptop using the local Git client.
    - Run `git clone git@github.com:...`
    - Your local Git client uses the local private key to sign a challenge from GitHub
    - GitHub verifies that signature against the public key registered on its server. If it matches, the clone succeeds.

## Dependencies

```
Local Key file     → Registered on GitHub → clone works
(Private + Public)   (Deploy key added)       (Uses key to auth)
```

## System boundary

* **What it creates:** 
    - Key file
    - deploy key registration
    - local cloned repository.
* **What it does NOT create:** 
    - The GitHub repository
    - The developer's laptop.
* **Lifecycle unit:** The laptop environment.


## The model

* **Three different** places are involved
    - laptop disk
    - GitHub API
    - Local Git client. 
* **Ordering matters**: The clone silently fails if step 3 hasn't completed.
* **Idempotency:**  Re-running the provisioning 
    - must update or verify existing files/keys 
    - must not create SSH keys or deploy key entries.




# Example 2 — Local VM & cluster

**Goal:** A developer should have a small Kubernetes cluster running on their laptop to test application changes against.

## How it works


1. Create a local **VM** on the laptop (using a local hypervisor like QEMU).
2. Install a lightweight **Kubernetes distribution** inside the VM.
3. Load/Apply **configuration files** (manifests) into that cluster.

## Dependencies

* `VM → Kubernetes cluster → manifest configurations`

 ## System boundary

* **What it creates:** 
    - VM instance
    - Kubernetes cluster instance
    - Deployed manifests.
* **What it does NOT create:** 
    - The laptop hypervisor/OS.
* **Lifecycle unit:** The laptop dev environment.

## The model

* **Nested layering:** Each layer acts as a container for the next: 
    - `Hypervisor → Virtual Machine → Kubernetes Cluster → Application Configs``
    - application configurations reside within the Kubernetes cluster, the cluster runs inside the virtual machine, and the virtual machine is hosted on the local hypervisor."
* **Lifecycle coupling:** Deleting the VM implicitly destroys all nested resources (cluster and configs) above it.
* **Readiness Probes & Latency Cascades**: You cannot provision a child until its parent's control plane is fully ready:





# Example 3 — PR preview environment

**Goal:** Every pull request gets a live, isolated, disposable copy of the application running at its own URL so reviewers can test changes interactively.

## The context

- A team owns a web application
- It runs on a Kubernetes cluster in production. 
- Reviewers want to *click around* a change before approving it (i.e need a **live** env for every pull request)
- That live copy is a disposable, real, running instance of the app (inside a k8s cluster), reachable at some URL.

## How it works

1. A developer opens PR #42.
1. The system notices, and says: "PR #42 needs a preview environment."
1. The system provisions an environment to test the changes
    - it spins up **two VMs** in the cloud (one control plane, one worker node) 
    - It turns them into a smal **K8s cluster**.
1. It builds the code from PR #42's branch 
1. It deploys the artifact into the cluster alongside required secrets, certificates, and storage buckets.
1. It gives the PR a URL like `pr-42.preview.example.com` to the deployment.
1. The reviewer opens that URL and sees the change, live.
1. The developer pushes another commit to PR #42. The system **redeploys** to the same environment. Same URL, new code.
1. When PR #42 receives new commits, The system updates the existing environment
1. When PR #42 is merged or closed, The system tears down the environment of PR #42. (i.ee the 2 VMs)



## Dependencies

* `Pull request opened → 2 VMs provisioned in parallel → cluster formed → build + secrets + certs → application deployed → URL routed`

## System boundary

* **What it creates:** 
    - 2 cloud VMs
    - a cluster instanvce
    - build artifacts, secrets, certificates, storage buckets
    - Preview URL routing.
* **What it does NOT create:** 
    - The production cluster
    - The base cloud account
    - The core domain zone.
* **Lifecycle unit:** - The environment *belongs to* the PR.     
    - The environment exists because the PR exists. 
    - The environment dies when the PR dies.
    

## The model

* **Many resources per goal.** 
    - One PR = two VMs + a cluster + a build + a bucket + secrets + certs + a URL. 
    - The system has to hold all of that together under one identity (PR #42).
* **Fan-out / Fan-in graph:** 
    - The two VMs are created in parallel. 
    - The cluster waits for *both*. 
    - Then the deploy waits for the cluster *and* the build *and* the secrets.
    - Build artifacts, and secrets simultaneously.
* **Group lifecycle & scoped teardown:** 
    - A single action ("close PR") must clean up a complex graph of resources
    - Production or sibling PR environments remain untouched
    - You don't delete a VM: you delete *the environment of PR #42*, and everything it owns goes with it.
* **In-place updates:** Subsequent commits must 
    - must trigger an idempotent update/redeploy flow
    - must not provision a brand-new set of VMs from scratch.
* **Idempotency under re-runs.** 
    - A new commit triggers a redeploy, not a rebuild-from-scratch. 
    - The system must know "this environment already exists, just update it."
* **Scoped teardown.** Closing the PR 
    - must not touch production or other PRs' environments
    - must not leave orphan VMs behind. 
    - The graph has a clean boundary.





# Example 4 — Multi-tenant onboarding

**Goal:** Provide a new development team ("tenant A") with an isolated workspace inside an existing, shared Kubernetes cluster owned by the platform team.

## The context

- The platform team sets up, owns, patches and  pays for a Kubernetes cluster. 
- It's been running for two years. 
- You do **not** create it, **nor** can destroy it. It's just there
- A Dev team  — let's call them "tenant A" needs a place to run their app on that cluster. 


## How it works

1. You create a **namespace** (`tenant-a`) inside the existing cluster to isolate their workload.
    - This is this Dev Team private slice of the cluster. 
    - Nothing they do can spill into another slice of the cluster.
1. You deploy a **config file** into that namespace. 
    - It comes from a Git repo 
    — it's the settings tenant A's app needs.
1. You inject a **secret** into that namespace. 
    - It comes from a vault 
    — it's the password their app uses to talk to the database.
1. You provision a dedicated **Git repository** on GitHub for the team to manage their manifests.
1. When another teamm - let says "tenant B" arrives, you repeat the exact same steps with distinct names and configurations.


## Dependencies


- `Existing cluster (pre-condition) → namespace created → config file + secret applied`
    - The namespace needs a cluster.
    - The config file needs the namespace.
    - The secret needs the namespace.
- The Git repo is created independently — it lives on GitHub, not in the cluster.

So the graph has an unusual shape: **the root already exists, and you're attaching branches to it.**

## System boundary

* **What it creates:** 
    - Namespace
    - config maps
    - secrets
    - external Git repository.
* **What it does NOT create nor own:** 
    - The shared Kubernetes cluster
    - underlying nodes
    - cloud networking
    - storage classes.
* **Lifecycle unit:** The tenant workspace (`tenant-a`).

## The model

* **Adoption model:** 
    - The root resource (the cluster) already exists and is managed externally; 
    - the model must reference the existing cluster without claiming creation or destruction rights over it.
    - The model needs a concept of **adoption**: A resource you take responsibility for without having provisioned.
    - Adoption has to change the **destroy** semantics: when you tear down tenant A, you must **not** tear down the cluster. 
* **Ownership boundaries:** 
    - The system mange the content not the container
    - Destroying a tenant must ONLY clean up its namespace, configs, secrets, and repository (cluster remain intact).
    - You only remove tenant A's namespace, config, secret, and repo.

* **The graph has a boundary**: 
- Everything inside the boundary is yours to create and destroy. 
- Everything outside is someone else's, and you only *reference* it.
* **External drift:** 
    - Is the price of adoption
    - If you own the thing, you control it. 
    - If you adopt the thing, you're sharing it with someone else, and you have to detect/tolerate changes you didn't make.
    - Is the price of adoption
    - Because an external team owns the underlying cluster it can upgrade, change a default or remove a node
    - the system must handle changes made to the parent infrastructure outside of its control.

## Conclusion

- A tenant is a slice *inside* an existing cluster you don't own
— you create and manage the slice, and when the tenant leaves, you remove the slice
- the cluster remain untouched.


# Comparison Matrix

| Example | Description | Key Architectural Pattern | Places Involved | Creation Scope | Unmanaged Root | Primary Model Stress |
|---|---|---|---|---|---|---|
| **1 — SSH Key** | Laptop repository clone access | Sequential cross-system ordering | <li>Laptop disk</li><li>GitHub API</li> | <li>Local files</li><li>deploy key</li> | Laptop hardware / OS | Execution order validation |
| **2 — Local VM + Cluster** | Local cluster for dev testing | Nested resource layering | <li>Hypervisor</li><li>VM interior</li><li>cluster interior</li> | <li>VM</li><li>cluster</li><li>local manifests</li> | Laptop hypervisor | Implicit nested deletion |
| **3 — PR Preview** | Live disposable app copy per PR | Group lifecycle with fan-out/fan-in | <li>Cloud provider</li><li>GitHub</li><li>Vault</li><li>DNS</li> | <li>VMs</li><li>cluster</li><li>build</li><li>certs</li><li>DNS</li> | Cloud account / main DNS zone | Teardown of complex multi-resource groups |
| **4 — Multi-tenant** | Isolated workspace on shared cluster | Adoption and bounded ownership | <li>GitHub</li><li>Vault</li><li>external cluster</li> | <li>Namespace</li><li>configs</li><li>secrets</li><li>Git repo</li> | Shared Kubernetes cluster | Managing state inside adopted resources |


- **1A** tests *ordering* — some steps must happen before others.
- **1B** tests *nesting* — resources inside resources inside resources.
- **2** tests *grouping* — many resources sharing one lifecycle, created and destroyed as a unit.
- **3** tests *adoption* — managing something you didn't create, and knowing where authority stops.

If your model handles all four, it will handle most real provisioning work.

