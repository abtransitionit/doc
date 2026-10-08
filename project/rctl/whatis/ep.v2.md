### 2.3 Secondary Outcomes
- **Portability**: the same provisioning intent runs across environments.
- **Composability**: resources can depend on and reference each other (a cluster depends on VMs, which depend on files, which come from Git repos).
- **Extensibility**: new resources, environments, or mechanisms can be added without forking the core.
- **Idempotency & safety**: operations are repeatable, dry-runnable, and reversible where possible.
- **Auditability**: every provisioning action is observable and traceable.


## 3. Problem Statement



### 3.4 Current Resource Properties
- Resources may be **local or remote**.
- Resources may be **accessed via different mechanisms** (CLI, API, SDK, protocol).
- Resources may be **managed by different systems** with incompatible state models.

### 3.5 Consequences of Fragmentation
- **N×M explosion**: every resource × every environment needs bespoke glue.
- **Duplication**: the same "create repo if missing" logic in dozens of scripts.
- **Brittleness**: CLI output changes break parsers.
- **Non-portability**: an AWS script cannot target OVH without rewrite.
- **Credential sprawl**: secrets scattered across `.env`, CI variables, keychains.
- **Inconsistent safety**: some paths idempotent, others destructive.
- **No unified audit**: provisioning actions are not centrally traceable.




## 9. Phase 01 Deliverables

- This vision document.
- A glossary of core concepts (Section 4) refined and frozen.
- A capability matrix: **resources × environments × mechanisms**.
- A candidate provider interface sketch (even if rough).
- A list of concrete end-to-end scenarios to validate against in Phase 02.


## 10. Next Phase (Preview)

**Phase 02 — Requirements & Capability Model** will:
- Enumerate every resource type, environment, and mechanism in scope.
- Define the **capability matrix** (what must work where).
- Derive the **minimal provider interface** from that matrix.
- Establish the **state, idempotency, and error models**.
- Produce testable acceptance criteria for the first vertical slice.







# 6. Lifecycle Phases (When)

1. **Plan / dry-run**: preview changes without applying.
2. **Create / provision**: instantiate the resource.
3. **Configure / bootstrap**: cloud-init, user-data, playbooks, manifests.
4. **Connect / wire**: networking, DNS, secrets, service discovery.
5. **Operate**: start, stop, scale, upgrade, rotate credentials.
6. **Observe**: logs, metrics, traces, health checks.
7. **Reset / rehydrate**: reset Git history, rebuild VMs, wipe clusters.
8. **Destroy / deprovision**: release resources, revoke credentials.
9. **Import / adopt**: bring existing resources under management.
10. **Migrate**: move between environments (lift-and-shift, rehydrate).

Each phase has different **idempotency**, **atomicity**, and **rollback** requirements.

# 7. Conclusuin

## 7.1 Problems arising from this diversity
- **N×M interface explosion**: every resource × every environment needs glue.
- **Inconsistent error semantics**: exit codes vs. HTTP codes vs. exceptions.
- **Inconsistent idempotency**: some tools are declarative, some imperative.
- **Credential sprawl**: different auth for each tool and target.
- **Output parsing fragility**: scraping CLI stdout vs. structured APIs.
- **Version skew**: CLI versions, API versions, deprecations.

## 7.2 Cross-Cutting Concerns

- **Authentication & authorization**: SSH keys, PATs, OAuth, OIDC, IAM roles, service accounts, mTLS, Vault, SOPS, age, sealed secrets.
- **State management**: local state files, remote backends (S3, GCS, Consul), locking, drift detection.
- **Idempotency**: "create if not exists," upsert semantics, reconciliation loops.
- **Atomicity & rollback**: all-or-nothing vs. best-effort; compensating transactions.
- **Concurrency**: parallel provisioning, race conditions, dependency graphs.
- **Secrets handling**: never log, never persist in plaintext, rotation.
- **Observability**: structured logs, traces, audit trails.
- **Error taxonomy**: transient vs. permanent, retryable vs. fatal, quota vs. auth.
- **Rate limiting & quotas**: backoff, batching, pagination.
- **Portability**: abstraction without leaking environment specifics.
- **Extensibility**: adding a new provider without forking the core.
- **Security**: least privilege, network isolation, supply-chain integrity (SBOM, signing).
- **Cost awareness**: dry-run estimates, tagging, teardown guarantees.
- **Compliance**: auditability, data residency, retention.


## 7.3 Current State: Disparate Mechanisms

Today's provisioning is a patchwork:

- **Custom scripts** in Go, Python, Shell, Make—each reimplementing auth, retries, idempotency.
- **Dedicated CLIs** (`gh`, `aws`, `gcloud`, `az`, `ovh`, `kubectl`, `helm`, `terraform`) with incompatible flags, outputs, and exit codes.
- **Direct API calls** (GitHub REST/GraphQL, AWS SDK, Kubernetes client) requiring per-provider knowledge.
- **Config files** in YAML, JSON, HCL, TOML, INI, env vars—no shared schema.
- **Ad-hoc state** in shell variables, temp files, or nothing at all.

### Consequences
- **Duplication**: the same "create a repo if missing" logic appears in dozens of scripts.
- **Brittleness**: CLI output changes break parsers.
- **Non-portability**: a script targeting AWS cannot target OVH without rewrite.
- **Onboarding cost**: each contributor must learn N tools.
- **Inconsistent safety**: some paths are idempotent, others are destructive.
- **Credential sprawl**: secrets scattered across `.env`, CI variables, and keychains.
- **No unified audit**: provisioning actions are not centrally traceable.


## 7.4 Requirements for a Unified Solution

### Functional
- Express provisioning of **files, VMs, clusters, and Git repos** with a single model.
- Target **local, remote, cloud, container, and edge** environments.
- Support **all lifecycle phases**, including reset and rehydrate.
- Support **multiple access mechanisms** per resource (CLI, API, SDK) with a preferred default.
- Provide **idempotent, declarative** operations with dry-run and apply.
- Enable **composition**: a cluster may depend on VMs, which depend on files, which depend on Git repos.
- Allow **escape hatches** to native tools when abstraction leaks.

### Non-functional
- **Portable** across OSes and environments.
- **Extensible** via plugins/providers without core changes.
- **Secure** by default: least privilege, no secret leakage, signed artifacts.
- **Observable**: structured logs, traces, audit records.
- **Deterministic**: reproducible given the same inputs and state.
- **Testable**: providers can be unit- and integration-tested.
- **Performant**: parallel where safe, batched where required.


## 7.5  Out of Scope (Explicitly)

- Application-level deployment (this is about *provisioning*, not app release).
- Runtime orchestration of workloads (scheduling, scaling apps).
- Day-2 application operations (though cluster day-2 ops are in scope).
- Replacing IaC tools wholesale; rather, unifying the *interface* to them.
- Inventing new cloud providers or hypervisors.


## 7.6  Open Questions

1. **Abstraction level**: lowest-common-denominator (portable but weak) vs. provider-specific (powerful but fragmented)? Likely a layered model with a portable core and provider extensions.
2. **State model**: external state file vs. reconciliation from live systems?
3. **Execution model**: agent-based vs. agentless? Central controller vs. distributed?
4. **Language/DSL**: embedded DSL (Go/Python library) vs. declarative config (YAML/HCL/CUE) vs. hybrid?
5. **Provider contract**: what is the minimal interface every provider must implement?
6. **Idempotency guarantees**: per-resource, per-operation, or per-plan?
7. **Error model**: unified taxonomy across HTTP, CLI, and SDK failures?
8. **Secrets**: integrate with existing managers (Vault, SOPS) or own the store?
9. **Git operations**: model as a resource provider or as a first-class primitive?
10. **Multi-tenancy**: single-user CLI vs. shared service with RBAC?


## 7.7  Success Criteria

- A single provisioning definition can target **≥2 environments** and **≥3 resource types** without core changes.
- Adding a new provider requires **only** implementing a documented interface—no core forks.
- Operations are **idempotent** and **dry-runnable**.
- Secrets never appear in logs or state in plaintext.
- Provisioning actions are **auditable** end-to-end.
- The same tool can **reset Git history**, **provision a VM**, **bootstrap a cluster**, and **place files in S3** within one coherent workflow.

From here, the next step is to derive a 
- **capability model** (verbs × resources × environments) 
- a **provider interface** that satisfies Section 9's requirements without collapsing into the N×M explosion described in Section 5.6.
```




----
----
----
----
----
----



### 5.6 Problems arising from this diversity
- **N×M interface explosion**: every resource × every environment needs glue.
- **Inconsistent error semantics**: exit codes vs. HTTP codes vs. exceptions.
- **Inconsistent idempotency**: some tools are declarative, some imperative.
- **Credential sprawl**: different auth for each tool and target.
- **Output parsing fragility**: scraping CLI stdout vs. structured APIs.
- **Version skew**: CLI versions, API versions, deprecations.

---

## 6. Lifecycle Phases (When)

1. **Plan / dry-run**: preview changes without applying.
2. **Create / provision**: instantiate the resource.
3. **Configure / bootstrap**: cloud-init, user-data, playbooks, manifests.
4. **Connect / wire**: networking, DNS, secrets, service discovery.
5. **Operate**: start, stop, scale, upgrade, rotate credentials.
6. **Observe**: logs, metrics, traces, health checks.
7. **Reset / rehydrate**: reset Git history, rebuild VMs, wipe clusters.
8. **Destroy / deprovision**: release resources, revoke credentials.
9. **Import / adopt**: bring existing resources under management.
10. **Migrate**: move between environments (lift-and-shift, rehydrate).

Each phase has different **idempotency**, **atomicity**, and **rollback** requirements.

---

## 7. Cross-Cutting Concerns

- **Authentication & authorization**: SSH keys, PATs, OAuth, OIDC, IAM roles, service accounts, mTLS, Vault, SOPS, age, sealed secrets.
- **State management**: local state files, remote backends (S3, GCS, Consul), locking, drift detection.
- **Idempotency**: "create if not exists," upsert semantics, reconciliation loops.
- **Atomicity & rollback**: all-or-nothing vs. best-effort; compensating transactions.
- **Concurrency**: parallel provisioning, race conditions, dependency graphs.
- **Secrets handling**: never log, never persist in plaintext, rotation.
- **Observability**: structured logs, traces, audit trails.
- **Error taxonomy**: transient vs. permanent, retryable vs. fatal, quota vs. auth.
- **Rate limiting & quotas**: backoff, batching, pagination.
- **Portability**: abstraction without leaking environment specifics.
- **Extensibility**: adding a new provider without forking the core.
- **Security**: least privilege, network isolation, supply-chain integrity (SBOM, signing).
- **Cost awareness**: dry-run estimates, tagging, teardown guarantees.
- **Compliance**: auditability, data residency, retention.

---

## 8. Current State: Disparate Mechanisms

Today's provisioning is a patchwork:

- **Custom scripts** in Go, Python, Shell, Make—each reimplementing auth, retries, idempotency.
- **Dedicated CLIs** (`gh`, `aws`, `gcloud`, `az`, `ovh`, `kubectl`, `helm`, `terraform`) with incompatible flags, outputs, and exit codes.
- **Direct API calls** (GitHub REST/GraphQL, AWS SDK, Kubernetes client) requiring per-provider knowledge.
- **Config files** in YAML, JSON, HCL, TOML, INI, env vars—no shared schema.
- **Ad-hoc state** in shell variables, temp files, or nothing at all.

### Consequences
- **Duplication**: the same "create a repo if missing" logic appears in dozens of scripts.
- **Brittleness**: CLI output changes break parsers.
- **Non-portability**: a script targeting AWS cannot target OVH without rewrite.
- **Onboarding cost**: each contributor must learn N tools.
- **Inconsistent safety**: some paths are idempotent, others are destructive.
- **Credential sprawl**: secrets scattered across `.env`, CI variables, and keychains.
- **No unified audit**: provisioning actions are not centrally traceable.

---

## 9. Requirements for a Unified Solution

### Functional
- Express provisioning of **files, VMs, clusters, and Git repos** with a single model.
- Target **local, remote, cloud, container, and edge** environments.
- Support **all lifecycle phases**, including reset and rehydrate.
- Support **multiple access mechanisms** per resource (CLI, API, SDK) with a preferred default.
- Provide **idempotent, declarative** operations with dry-run and apply.
- Enable **composition**: a cluster may depend on VMs, which depend on files, which depend on Git repos.
- Allow **escape hatches** to native tools when abstraction leaks.

### Non-functional
- **Portable** across OSes and environments.
- **Extensible** via plugins/providers without core changes.
- **Secure** by default: least privilege, no secret leakage, signed artifacts.
- **Observable**: structured logs, traces, audit records.
- **Deterministic**: reproducible given the same inputs and state.
- **Testable**: providers can be unit- and integration-tested.
- **Performant**: parallel where safe, batched where required.

---

## 10. Out of Scope (Explicitly)

- Application-level deployment (this is about *provisioning*, not app release).
- Runtime orchestration of workloads (scheduling, scaling apps).
- Day-2 application operations (though cluster day-2 ops are in scope).
- Replacing IaC tools wholesale; rather, unifying the *interface* to them.
- Inventing new cloud providers or hypervisors.

---

## 11. Open Questions

1. **Abstraction level**: lowest-common-denominator (portable but weak) vs. provider-specific (powerful but fragmented)? Likely a layered model with a portable core and provider extensions.
2. **State model**: external state file vs. reconciliation from live systems?
3. **Execution model**: agent-based vs. agentless? Central controller vs. distributed?
4. **Language/DSL**: embedded DSL (Go/Python library) vs. declarative config (YAML/HCL/CUE) vs. hybrid?
5. **Provider contract**: what is the minimal interface every provider must implement?
6. **Idempotency guarantees**: per-resource, per-operation, or per-plan?
7. **Error model**: unified taxonomy across HTTP, CLI, and SDK failures?
8. **Secrets**: integrate with existing managers (Vault, SOPS) or own the store?
9. **Git operations**: model as a resource provider or as a first-class primitive?
10. **Multi-tenancy**: single-user CLI vs. shared service with RBAC?

---

## 12. Success Criteria

- A single provisioning definition can target **≥2 environments** and **≥3 resource types** without core changes.
- Adding a new provider requires **only** implementing a documented interface—no core forks.
- Operations are **idempotent** and **dry-runnable**.
- Secrets never appear in logs or state in plaintext.
- Provisioning actions are **auditable** end-to-end.
- The same tool can **reset Git history**, **provision a VM**, **bootstrap a cluster**, and **place files in S3** within one coherent workflow.

---

This statement is intended as the exhaustive, accurate framing of the problem. From here, the next step is to derive a **capability model** (verbs × resources × environments) and a **provider interface** that satisfies Section 9's requirements without collapsing into the N×M explosion described in Section 5.6.