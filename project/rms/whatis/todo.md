
# Todo 
## List
- **Provision** resources: create files, VMs, Clusters, Git repositories, and other resources.
- **Operate** resources: update files, configure hosts, manage repositories, install packages.
- **Abstract** implementations: use scripts, CLIs, protocols, or APIs without exposing their implementation details to the Agent.
- Compose operations: combine multiple operations into higher-level workflows spanning multiple resources and environments.
- Report outcomes: return execution status, results, and errors through a consistent interface.


## Abstract implementations


- Create a file: use local filesystem operations, SSH commands, or an S3 API.
- Create a VM: use the OVH API, AWS API, OpenStack CLI, or a local hypervisor.
- Execute a command: use SSH, WinRM, or a container runtime interface.
- Manage a Git repository: use local Git commands, `gh`, `glab`, or GitHub/GitLab APIs.
- Install a package: use `apt`, `dnf`, or `winget`, locally or remotely.
- Deploy a workload: use `kubectl`, a Kubernetes API client, or a provider-specific deployment interface.


# The YAML I provide
- a list of *imperative steps* (`UpgradeOs`, `InitCplane`, `AddCniCilium`).
- Is not a declarative manifest
- Is a **procedural workflow manifest** (aka. playbook, pipeline conf, or task graph)
- Is an imperative control flow wrapped in a YAML file with Explicit `dependency:` chains (`dependency: - CheckSshConf`).
- It describe the exact recipe and execution order with action like `Install`, `Init`, `Reset`. E.g: 
    - Step 1, `check` SSH. 
    - Step 2, `deploy` agent. 
    - Step 3, `upgrade` OS. 
    - Step 4, `reboot`.... 
- a pipeline runner that traverses the dependency tree (defined in the YAML) and executes the specified capabilities (`Check`, `Deploy`, `Upgrade`, `Install`) node by node.
- is just the config file of a  **Workflow Orchestrator CLI** (similar to a lightweight Ansible or a custom provisioning engine).

# The **hybrid approach** when provisioning Infra

In fact, for provisioning and bootstrapping infrastructure (like setting up a Kubernetes cluster from bare metal), **pure declarative state reconciliation is notoriously difficult to write.**

Bootstrapping a server is inherently a chronological, state-changing process: you *must* have SSH access before you can upgrade the OS, and you *must* upgrade the OS before you can load kernel modules, and you *must* initialize the control plane before workers can join.

Because of this, infrastructure provisioning tools often choose a **hybrid approach**:

1. **The Manifest is a Workflow/Pipeline:** (Like yours) It defines tasks, targets, capabilities, and dependencies.
2. **The Execution Engine is Procedural:** The CLI reads this dependency graph and executes the tasks in order.

---
---
---
---

# From workflow to infrastructure orchestrator
1. Bridge the gap between from **procedural workflow manifest** to **software engineering standards**


## 1. split the YAML in 2

Separate "Desired State" from "Execution Plan" (The Ansible/Terraform Model)
- The YAML mixes 
    - the *identity* of what you want 
    - the *exact execution recipe*. To make it more professional, split it into two layers:

**Part 1: The Configuration (The Input):** 
- A clean, user-friendly file declare *what* infrastructure they want 
- e.g., node IPs, OS versions, Kubernetes version, CNI choice.
- They shouldn't have to specify 30 sequential tasks.

**Part 2: The Engine (The Internal Logic):** 
- Your CLI reads that simple configuration
- internally builds the dependency graph
- The initial YAML
- Executes the YAML.


## 2. Manage idempotency through Capability

Introduce Idempotency to Every Task (`capability`)
- CLI should be able be run 10 times safely. 
- If a user runs `kbe apply` and something fails halfway through, running it again shouldn't crash or duplicate things.

**How to fix it:** 
- Make sure every capability checks the actual state of the node *before* acting.
- **Example:** 
    - Instead of blindly running `UpgradeOs`
    - the capability should check: **"Are packages already up to date?"** 
    - If yes, skip. If no, upgrade.



## 3. Add a Dry-Run / Preview Mode (`--dry-run` or `plan`)

Introduce Dry-Run / Preview Mode
- CLI should show the user what it's going to do before acting

**Implementation:** 
- Implement a flag that walks through the task graph
- evaluates the current state of each node
- Prints an execution plan:

```text
[PLAN] kbe cluster will execute 24 tasks:
  ~ [node.cp] UpgradeOs (Changes detected: 3 packages to update)
  + [node.worker] AddWorker (Will join cluster to 192.168.1.50)

```



### 4. Manage Error

Manage 
- Robust Error Handling
- Rollback
- State Tracking

When provisioning a cluster, things *will* fail (SSH timeouts, package download errors).


**State File:** Save a local state record (e.g., `.kbe-state.json`) tracking which phases have successfully completed for each node.

**Resume Capability:** If a run fails at `AddKParam`, a user shouldn't have to start from `CheckSshConf`. The CLI should support resuming: `kbe apply --resume-from AddKParam`.

**Clean Error Reporting:** 
- Do not dump raw stack trace
- Catch execution errors and print clear diagnostics:
    ```text

    `[ERROR] Task 'AddKModule' failed on 'node.cp': Module 'br_netfilter' could not be loaded. (Check logs with 'kbe logs node.cp')`
    ```

## 5. Manage the Manifest

Validate the Manifest Schema
- typo in a YAML key (e.g., writing `dependncy` instead of `dependency`), your parser might silently ignore it or crash cryptographically.

- **Solution:** 
- Write a JSON Schema or use a validation library (**Pydantic**/Python or **Zod**/Go struct tags)
- Validate the manifest structure the moment the CLI boots up
- Throw a validation error before any actions begin.

## 6. manage concurency

Concurrent Execution (Parallelism)

Your workflow defines dependencies, but all nodes (`node.all`, `node.worker`) seem processed sequentially in mental models.

**Pro Feature:** 
- Use worker pools or async routines to execute independent tasks across multiple nodes concurrently. 
- For instance, updating OS packages on 5 worker nodes at the same time instead of one by one.




----
----
----
----
----
----

# The architecture

separate 
- the **Desired State** from 
- the **Execution Plan** 

to turn the system from a "task runner" into a true "orchestrator."


## Step 1: The manifest

- From "Tasks" to "Intent"
- should contain **zero tasks**. 
- should only describe **what they want the cluster to look like**.

```yaml
# V1
apiVersion: kbe.io/v1alpha1
kind: Cluster
metadata:
  name: my-production-cluster
spec:
  ssh:
    user: ubuntu
    bastion: 192.168.1.10
  nodes:
    controlPlane:
      - ip: 192.168.1.20
    workers:
      - ip: 192.168.1.21
      - ip: 192.168.1.22
  os:
    packages:
      native: ["curl", "git", "jq"]
    kernelModules:
      - br_netfilter
    kernelParams:
      - net.bridge.bridge-nf-call-iptables=1
  kubernetes:
    version: "1.30.0"
    cni:
      provider: cilium
      version: "1.18.5"
    helm:
      repositories:
        - name: cilium
          url: https://helm.cilium.io/

```


```yaml
# V2
apiVersion: kbe.io/v1alpha1
kind: ClusterK8s
cluster:
  name: Kbe-easy
  parameter:
    podCidr: 192.168.0.0/16
    serviceCidr: 172.16.0.0/16
    k8sVersion: 1.32.0
    cplaneName: cpl
  containerRuntime:
    socketName: unix:///var/run/crio/crio.sock

ssh:
  delay: 120

agent:
  src: /tmp/luca
  dst: /usr/local/bin/
  chmod: 755

node:
  bastion: local
  all: [o2a, o1u, o3r, o4f, o5d]
  cp: [o1u]
  worker: [o2a, o3r, o4f, o5d]
  helm: [o1u]
  kubectl: [o1u]

kernel:
  module:
    - name: overlay
    - name: br_netfilter
  param:
    - name: net.ipv4.ip_forward
      value: 1
    - name: net.bridge.bridge-nf-call-iptables
      value: 1

onpm:
  repo:
    crio: { name: crio, fileName: kbe-crio, version: "1.32" }
    k8s:  { name: k8s, fileName: kbe-k8s, version: "1.32" }
  pkg:
    crio: crio
    kubeadm: kubeadm
    kubelet: kubelet
    kubectl: kubectl
    yq: yq

helm:
  repo:
    - name: cilium
  release:
    - name: kbe-cilium
      namespace: kube-system
      chart:
        qname: cilium/cilium
        version: 1.18.5
      param:
        podCidr: 192.168.0.0/16


```


## Step 2: Build the "Compiler" (The Plan Generator)

Inside your CLI, 
- you add a **compilation layer**. 
- When the user runs `rms kbe create -conf kbe.yaml`,
- the CLI doesn't execute anything yet. 
- Instead, it runs a **Workflow/Plan Generator** function.
    - This compiler reads the Desired State (manifest)
    - **dynamically constructs your task graph** (the exact dependency tree you currently write manually in YAML).

### How it works conceptually (in code/pseudo-logic):

```python
def compile_execution_plan(desired_state):
    graph = TaskGraph()
    
    # 1. Always add base checks
    graph.add_task("CheckSshConf", target=desired_state.spec.ssh.bastion)
    
    # 2. Dynamically add OS tasks for every node
    all_nodes = [desired_state.spec.ssh.bastion] + \
                [n.ip for n in desired_state.spec.nodes.controlPlane] + \
                [n.ip for n in desired_state.spec.nodes.workers]
                
    for node in all_nodes:
        graph.add_task("UpgradeOs", target=node, depends_on=["CheckSshConf"])
        graph.add_task("RebootIfNeeded", target=node, depends_on=["UpgradeOs"])

    # 3. Conditionally add CNI tasks based on user intent
    if desired_state.spec.kubernetes.cni.provider == "cilium":
        graph.add_task("AddCniCilium", version=desired_state.spec.kubernetes.cni.version)

    return graph

```


## Step 3: Templated workflow

Turn Your Hardcoded Tasks into Reusable Templates

- Defines a **Task Templates**.
- Every time the compiler sees a *Kubernetes cluster* request
- it instanciate a template with the desired state (inject the variables from manifest)


## Step 4: 

The Execution Pipeline. With this separation, your CLI runtime workflow becomes:

1. **Input:** User passes `kbe.yaml` (Desired State/Manidest).
2. **Validate:** CLI checks `kbe.yaml` against a strict JSON Schema.
3. **Compile:** CLI runs the compiler to generate the **Execution Plan** (the dependency graph of tasks).
4. **Inspect (Dry-Run):** CLI compares the Execution Plan against the local state file and prints what it's about to do.
5. **Execute:** Your existing **graph runner** executes the tasks concurrently and safely.

## 1. The manifest

- The user should **never** touch or see the `phases` block. 

## 2. The templated workflow

- Hardcode or embed the task graph inside your CLI's source code as a default pipeline template.
- The CLI's internal code compiles the plan dynamically by injecting the user's variables (manifest) into the built-in graph:

```go
// Inside your CLI source code (Go, Python, Rust, etc.)
func BuildExecutionPlan(config UserConfig) TaskGraph {
    graph := NewTaskGraph()

    // 1. Add base checks
    graph.AddTask("CheckSshConf", Target(config.Node.Bastion))
    graph.AddTask("CheckSshAccess", Target(config.Node.Bastion), DependsOn("CheckSshConf"))

    // 2. Dynamically map 'node.all' tasks using variables from config
    for _, node := range config.Node.All {
        graph.AddTask("UpgradeOs", Target(node), DependsOn("CheckSshAccess"))
        graph.AddTask("RebootIfNeeded", Target(node), DependsOn("UpgradeOs"))
        // ... inject kernel params, modules, crio/kubelet packages from config data ...
    }

    // 3. Dynamically map Control Plane tasks
    for _, cpNode := range config.Node.Cp {
        graph.AddTask("InitCplane", Target(cpNode), Params(config.Cluster.Parameter))
    }

    return graph
}

```


## Why this changes everything for your CLI

1. **Massive UX Improvement:** 
    - Agent no longer maintains a massive 300-line YAML full of low-level dependencies. 
    - Agent writes a clean, 30-line configuration file focused purely on **intent** (nodes, versions, IPs).
1. **True Separation:** 
    - If you want to change how `InitCplane` works tomorrow
    - Just update your **CLI binary code**, not every single user's YAML file.
3. **Flexibility:** 
    - The CLI can now dynamically add or skip phases based on the user's config
    - E.g., if user didn't specify Cilium, automatically skip `AddCniCilium*`