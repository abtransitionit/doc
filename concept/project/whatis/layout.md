## Software project directory Layout



```
project/
└── <project name>/
    ├── whatis/
    │   └── ep.md            <-- Evergreen project hub (framework, roadmap, dependencies)
    └── log/
    │   ├── lifecycle.log.md <-- Ephemeral execution log (active phase, phase history)
    │   ├── backlog.md       <-- Task tracking & active task backlog
    │   └── task/            <-- Task Execution detail
    │         ├── TASK-01-cli-taxonomy.md      <-- Task 01
    │         └── TASK-02-config-schema.md     <-- Task 02
    ├── spec/
    │   ├── RFC-01-vision.md
    │   ├── REQ-01-requirements.md
    │   ├── DOM-01-domain-model.md
    │   └── SPEC-01-architecture.md
    └── adr/
        ├── README.md                              <-- ADR Index & Governance Guide
        ├── ADR-02-decoupled-output-formatting.md
        └── ADR-03-statutory-non-root-local-scope.md
```

```
doc/project/
└── rctl/
    ├── adr/
    │   ├── README.md                              <-- Architectural Decision Index & Governance
    │   ├── ADR-01-pure-go-ssh-transport.md        <-- SSH Transport Decision
    │   ├── ADR-02-decoupled-output-formatting.md  <-- Presentation Layer Decision
    │   └── ADR-03-statutory-non-root-local-scope.md <-- Local Scope Boundary Decision
    ├── log/
    │   ├── backlog.md                             <-- Master Task Index (Phase 5–7)
    │   ├── lifecycle.log.md                       <-- Ephemeral Execution Log & Phase Status
    │   ├── board.md                               <-- Active Project Execution Board
    │   └── tasks/
    │       ├── TASK-01-cli-taxonomy.md            <-- CLI Taxonomy Execution File
    │       ├── TASK-02-config-schema.md           <-- Inventory Schema Execution File
    │       └── TASK-03-init-go-module.md          <-- Go Module Execution File
    ├── spec/
    │   ├── DOM-01-domain-model.md                 <-- Domain Entities & Bounded Contexts
    │   ├── REQ-01-requirements.md                 <-- System Requirements (R01–R08, C01–C02)
    │   ├── RFC-01-vision.md                       <-- Project Vision & Scope
    │   └── SPEC-01-architecture.md                <-- Architecture Specification & ADR Bridge
    └── whatis/
        └── ep.md                                  <-- Evergreen Project Hub (This File)

```

## Software project: Tool Directory Layout

```
doc/project/
└── <project name>/
    ├── whatis/
    │   └── ep.md        # What rctl is, features, high-level user orientation
    ├── list/
    │   └── capabilities.md    # Supported command matrix, inventory options, transports
    ├── howto/
    │   ├── quickstart.md      # 5-minute operator onboarding guide
    │   └── inventory-setup.md # How to structure inventory YAML files
    ├── admin/
    │   └── security.md        # Non-root local scope, SSH key governance, permissions
    └── ref/
        └── cli-reference.md   # Exact flag matrix, exit codes, output options
```


```
doc/tool/rctl/
├── README.md                 <-- Tool Hub Index & Operator Onboarding
├── whatis/
│   └── overview.md           # Product positioning, key features, and core architecture
├── list/
│   └── capabilities.md       # Supported transports, target filters, and output formats
├── howto/
│   ├── quickstart.md         # 5-minute operator quickstart guide
│   └── inventory-setup.md    # How to define hosts, groups, and global defaults
├── admin/
│   ├── security.md           # Non-root local execution boundaries and SSH key governance
│   └── configuration.md     # System-wide configuration and environment variables
└── ref/
    └── cli-reference.md      # Command syntax, flags matrix, and exit codes

```