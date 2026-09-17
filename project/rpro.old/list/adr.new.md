[//]: #(home)
[home]:  ../README.md

[//]: #(functional)
[forge whatis]: whatis/forge.md
[res list]:     list/res.md
[host list]:     list/host.md
[roadmap readme]: roadmap.md

[←][home]

<h1 align="center">List of Forge ADR</h1>

# List

- [ADR-0001 — Resource Model](#adr-0001--resource-model)
- [ADR-0002 — Host Model](#adr-0001--host-model)
- [ADR-0002 — Provider Model](0002-provider-model.md)
- [ADR-0003 — State Management](0003-state-management.md)




# ADR-001: Provider Responsibility

## Status

Proposed

## Context
- RPro must provision resources in different environments.
- The provisioning mechanism can differ significantly between environments. 
- For example, 
  - provisioning a `directory` on a `local host` differs from provisioning one on a `remote host`.
- RPro therefore needs a way to separate the 
  - common provisioning model from 
  - environment-specific operations.

## Decision

RPro delegates environment-specific provisioning to a `Provider`.

||||
|-|-|-|
| `RPro` | manages | the provisioning model 
| `RPro` | orchestrate  | provisioning
| Provisioning | is delegated to | Provider
| `RPro` | interacts with an environment through a `provider` |
| A `Provider` | performs the environment-specific provisioning |
| A `Provider` | provisions | Environment
| An `Environment` | remains external to `RPro` |

## Consequences

* `RPro` does not need to implement environment-specific provisioning directly.
* `Providers` can support different `resources` and `environments`.
* Adding support for a `new environment` can be done through a `provider`.
* The provider mechanism becomes an important part of the architecture.


# ADR-002: Provider Integration

## Status

Proposed

## Context
- this ADR is a consequence of ADR-001
  - `RPro` delegates environment-specific provisioning to providers.
  - `RPro` therefore needs to call/invoke communicate talk to a `provider` when a provisioning operation is invoked.
- **Yet** we do not decide the mechanism ("plugins", "dynamic libraries", "executables", etc). It must allow `RPro` 
  - to use different providers 
  - to decouple the provisioning orchestration and the implementation of each provider.
  - to define an integration contract for providers.

there is 3 possible mechanisms as candidates:
  
||||
|-|-|-|
| Language/API interface | <li>in-process provider implementation. <li>Providers implement an interface defined by RPro and run in the same process. | ```Rpro ─── interface ───> provider```
| Plugin interface | <li>dynamically loaded provider. <li>providers implement a plugin contract and are loaded by RPro. | ```Rpro ─── Plugin contract ───> provider plugin``` |
| External protocol | <li>provider runs as a separate process/service. <li>Providers run separately and communicate with RPro through a defined protocol. | ```Rpro ─── protocol ───> provider process```

## Consequences

- `RPro`'s provisioning orchestration is independent of individual provider implementations.
- Providers must conform to a defined integration contract.
- Different provider implementations can be introduced without changing the core provisioning model.
- The concrete provider integration mechanism remains open until it is justified by the project requirements.




# ADR-002: Provider Integration
## Status

Proposed

## Context
- this ADR is a consequence of ADR-2
- The question is: What must `RPro` be able to ask a Provider to do?
- The minimal contract is
```
RPro
 │
 │ provision(resource, environment, configuration)
 ↓
Provider
 │
 ↓
result
```
So the next ADR can establish the contract semantics, rather than whether it is an interface, plugin, API, etc.


# ADR-003: Provider Contract

## Status

Proposed

## Context

- `RPro` delegates environment-specific provisioning to providers.
- `RPro` therefore needs a defined contract for invoking a provider.
- The contract 
  - must give providers enough information to perform provisioning.
  - must not expose provider implementation details to `RPro`.

## Decision

A provider must receive a provisioning operation containing:

* the `Resource` to provision
* the target `Environment`
* the operation `configuration`

The provider returns the result of the provisioning operation.

```text
Provisioning
├── resource
├── environment
└── configuration
        │
        │
        ↓
     Provider
        │
        ↓
      Result
```

The concrete representation of this contract is not decided yet.

## Consequences

* `RPro` can invoke providers using a common contract.
* Providers remain responsible for environment-specific provisioning.
* The contract does not depend on a specific provider implementation mechanism.
* Details such as error handling, lifecycle operations, and provider capabilities remain to be defined when required.
