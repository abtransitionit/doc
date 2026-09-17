# Directory Layout


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