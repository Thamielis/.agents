# Diagram Selection Matrix

Map user intent to the most expressive Mermaid diagram type.

## Selection Rules

- Choose `flowchart` for control flow, branching logic, request lifecycles, and operational playbooks.
- Choose `sequenceDiagram` for temporal interactions between actors/services.
- Choose `stateDiagram-v2` for lifecycle/state transitions with guards.
- Choose `classDiagram` for structural relationships in object or package models.
- Choose `erDiagram` for database/domain entities and cardinality.
- Choose `gantt` for delivery plans and scheduling.
- Choose `timeline` for chronological milestones and event stories.
- Choose `journey` for UX/customer experience phases and sentiment.
- Choose `pie` for static proportional summaries.
- Choose `mindmap` for hierarchical ideation and decomposition.
- Choose `gitGraph` for branching/merge narratives.

## Fast Mapping

- "How a process works" -> `flowchart`
- "Who calls what and when" -> `sequenceDiagram`
- "How state changes" -> `stateDiagram-v2`
- "How data is related" -> `erDiagram`
- "How classes connect" -> `classDiagram`
- "How work is scheduled" -> `gantt`

## Decision Heuristics

- Prefer one diagram per core question.
- Split into multiple diagrams when one block needs more than ~30 nodes.
- Separate static structure (`classDiagram`, `erDiagram`) from dynamic behavior (`sequenceDiagram`, `flowchart`).
- Reserve `flowchart` for process semantics, not for dense data modeling.