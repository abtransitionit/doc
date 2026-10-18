[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[resource whatis]: /concept/resource/whatis/ep.md
[capability howto]: /concept/resource/howto/operation.md


<h1 align="center">What is a Lifecycle</h1>


# Definition

- A sequence of states/phases and transitions attached to a resource. 
- Not be a sibling of `File`/`Package`/`Host/Process`/`Session`. 
- Rather **facet** attached to any of them.

## Other
- A **state** (e.g. `Running`) is a property of a resource.
- A **transition** (e.g. `start`, `stop`, `drain`) is an **action**


## 1. Kind — what is a lifecycle?


**(a) What lifecycle are we talking about?** (the *subject*)
**(b) What is the shape of the lifecycle?** (the *model*)

```
Lifecycle
├── BySubject
│   ├── ResourceLifecycle        (a file, package, host, VM…)
│   ├── ProcessLifecycle         (a daemon, a job, a container process)
│   ├── SessionLifecycle         (login session, SSH session, agent session)
│   └── DeploymentLifecycle      (release, rollout, environment)
│
└── ByModel
    ├── StateMachine             (explicit states + allowed transitions)
    ├── PhaseModel               (ordered phases, e.g. init → ready → drain → stop)
    ├── EventDriven              (transitions triggered by events, not a fixed graph)
    └── Declarative              (desired state; controller reconciles)
```



## 2. Mechanism — how do we observe or drive the lifecycle?

```
Mechanism
├── ObservationMechanism         (how do we learn the current state?)
│   ├── Poll                     (query status on demand)
│   ├── Watch                    (event stream: inotify, k8s watch, systemd journal)
│   ├── Probe                    (health check, readiness check)
│   └── Hook                     (callback registered by the resource)
│
└── TransitionMechanism          (how do we cause a state change?)
    ├── DirectCommand            (systemctl start, docker stop)
    ├── API                      (cloud provider start/stop, k8s patch)
    ├── Signal                   (SIGTERM, SIGKILL)
    ├── Agent                    (CLI or API on the target)
    └── Controller               (declarative reconcile loop)
```

**Key point:** 
- a resource may support observation without supporting transition, and vice versa. 
- A read‑only monitoring endpoint can `Watch` but cannot `Stop`. 
- A cloud API can `Start`/`Stop` a VM but cannot observe the guest OS's internal lifecycle. 

Mechanism is also **layered**, exactly as with File and Host:

```
Mechanism: SSH → systemd → unit
Mechanism: CloudAPI → VM → guest agent → service
Mechanism: k8s API → controller → pod → container runtime
```

The lifecycle mechanism is the **outermost** layer that actually reaches the thing whose lifecycle you care about. Which layer "owns" the lifecycle is a modeling choice — but it should be stated.


## 3. Capabilities — what can we do with a lifecycle?

```
LifecycleCapabilities
├── Observe
│   ├── GetState
│   ├── ListStates           (enumerate the state machine)
│   ├── ListTransitions      (what is allowed from here?)
│   └── Watch                (subscribe to changes)
│
├── Drive
│   ├── Start
│   ├── Stop
│   ├── Restart
│   ├── Pause / Resume
│   ├── Drain                (graceful removal from traffic)
│   ├── Rollback
│   └── Reconcile            (declarative: push desired state)
│
└── Constrain
    ├── SetPolicy            (e.g. restart policy, max retries)
    ├── SetTimeout           (per-transition)
    └── SetHook              (pre/post transition)
```

**Capabilities depend on state and on mechanism** 
- You cannot `Stop` a resource that is already `Stopped` — the capability exists but is **not applicable in this state**.
- You cannot `Rollback` if no previous state was recorded.
- A `Drain` capability may exist on the transition mechanism but not on a read‑only observation mechanism.

So the tuple needs a fourth piece here that File/Package/Host didn't force: **the current state** (or a state predicate). I would not add a new dimension to the model — I would say *capabilities are a function of (mechanism, permissions, current state)*, and record that as a known refinement.


| Claim | Meaning | Example |
|---|---|---|
| **Not applicable in this state** | The transition edge does not exist from this state. Calling it is a *model error*. | `Stop` from `Stopped` — there is no `stopped → stopping` edge. |
| **Idempotent** | The operation *is* callable, and re‑calling it leaves the system in the same state. Calling it is *safe*, just redundant. | `Stop` from `Stopped` — the postcondition `state == stopped` already holds. |

---

## 4. Concrete examples

| Resource | Subject | Model | Observation mechanism | Transition mechanism | Capabilities |
|---|---|---|---|---|---|
| `systemd` service on local host | Process | StateMachine | `systemctl status` | `systemctl start/stop` | GetState, ListTransitions, Start, Stop, Restart |
| Docker container | Process | StateMachine | Docker API `inspect` | Docker API `start/stop/kill` | GetState, Start, Stop, Restart, Pause |
| Cloud VM | Resource | StateMachine | Cloud API `describe` | Cloud API `start/stop` | GetState, Start, Stop, Restart |
| k8s Deployment | Deployment | Declarative | k8s `watch` | k8s `patch` (desired replicas) | Watch, Reconcile, Rollback |
| File on disk | Resource | EventDriven | `inotify` | (none — files don't transition) | Watch, GetState |
| SSH session | Session | PhaseModel | channel state | client `close` / server timeout | GetState, Stop, SetTimeout |

The **SSH session** row is the useful stress test: it has an observation mechanism and a transition mechanism, but the transitions are limited (you can close, you cannot "restart" a session — you open a new one). That is the lifecycle analogue of the Package doc's "publishing is not a standard `apt` capability."

The **file** row is the other useful stress test: a file has *state* (exists, size, mtime) and is *observable*, but it has no meaningful `Start`/`Stop`. So `Lifecycle` as a facet can be **partial** — a resource may expose only the `Observe` half.

---

## 5. Candidate representation

```
kind: Lifecycle
subject:
  kind: Host
  type: VM
  identity: { id: vm-123 }
model: StateMachine
states: [stopped, starting, running, stopping, failed]
transitions:
  - { from: stopped,  to: starting, action: start }
  - { from: starting, to: running,  action: (implicit) }
  - { from: running,  to: stopping, action: stop }
  - { from: stopping, to: stopped,  action: (implicit) }
  - { from: "*",      to: failed,   action: (error) }
observation:
  mechanism: { type: CloudAPI, interface: describe }
  capabilities: [GetState, Watch]
transition:
  mechanism: { type: CloudAPI, interface: start-stop }
  capabilities: [Start, Stop, Restart]
current_state: running
```

Two things this reveals:

1. **Observation and transition mechanisms are separate fields.** This is the Host doc's open question ("should `Mechanism` represent OS access or host management?") answered by *splitting the field* rather than choosing. I would carry that back to `Host`.
2. **The lifecycle is a graph, not a flat capability list.** The File/Package/Host tuple assumed capabilities are a set. For lifecycle, capabilities are *edges*, and their applicability depends on the source state. That is a genuine extension of the model — but a small one (capabilities become `(state, action)` pairs), not a new abstraction.

---

## 6. Questions this raises (in the spirit of the Package doc's §7)

2. **Does the lifecycle belong to the subject or to the mechanism?** 
  - A VM's lifecycle is owned by the cloud API; 
  - a service's lifecycle is owned by `systemd`; 
  - a k8s Deployment's lifecycle is owned by the controller. 
  - The *states* are intrinsic to the subject; 
  - the *transitions* are provided by a mechanism on a target. 
3. **Can a lifecycle span multiple targets?** Yes — `Drain → Stop` on a load‑balanced service touches the LB target and the host target. This is the Package doc's multi‑target action plan, and it means lifecycle **transitions are themselves action plans** that may recurse (your "allow recursive decomposition" recommendation from the Package doc).
4. **What is the success criterion of a transition?** The Package doc deferred this ("action dependencies, success criteria, failure handling, resume/compensate"). Lifecycle makes it unavoidable: 
- `Stop` is only successful when the resource reaches `stopped`, not when the command returns. 
- So a transition needs a **completion predicate** 
- and that predicate is observed via the **observation** mechanism, not the **transition** mechanism. 
- That is a clean, useful asymmetry.
5. **Compensation / rollback:** 
- the Package doc asked whether a failed plan can resume or compensate. 
- Lifecycle gives the natural vocabulary: a `Rollback` transition is just a transition back along a recorded edge. 
- No new abstraction needed — but the model must **record the state history** to know which edge is valid.

---

## Summary of what I'd do

- Split `Mechanism` into **Observation** and **Transition** — and back‑port that split to `Host` (it resolves your open question there).
- Express capabilities as **(source state, action) edges**, not a flat set. Keep the flat list as the *union* over states.
- Add **`current_state`** and **`state_history`** as fields; they are what make capabilities and rollback well‑defined.
- Model each transition as an **action plan** (recursive, possibly multi‑target), with a **completion predicate observed via the observation mechanism**.
- Don't add a new abstraction for "process" or "session" yet — see whether they fall out as `subject.kind` values. If they do, the model holds; if they don't, that is the next pressure point.

The one genuinely new thing Lifecycle forces — compared to File, Package, and Host — is that **the resource has a graph, not just a type**. I'd record that as the finding, validate it against `KernelModule` (which has `load`/`unload`/`loaded`/`builtin` states) next, and only then decide whether "state graph" deserves to be a first‑class concept or stays a field on the facet.