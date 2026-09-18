- Extracting ADR (**A**rchitecture **D**ecision **R**ecords) into standalone document is an industry best practice.

- Including brief ADR summaries in **SPEC-01-architecture.md** keeps the overall architecture readable, but dedicated ADR files give you three critical advantages:
  - **Immutable Decision History**: ADRs are historical records. Once marked Accepted, an ADR is frozen. If a decision changes, you do not edit the old ADR—you create a new one that supersedes it (e.g., ADR-04 supersedes ADR-01).
  - **Focused Discussions**: Pull Requests for architectural shifts can target a single isolated document rather than re-opening a broad architecture specification.
  - **Traceability**: Individual design choices can be linked directly back to specific requirements (REQ-01, REQ-03).