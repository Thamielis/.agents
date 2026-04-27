# Advanced Flowchart Patterns

Apply these patterns for expressive but reliable flowcharts.

## 1. Direction and Layout

- Declare direction explicitly at the top: `flowchart LR`, `flowchart TB`, `flowchart RL`, or `flowchart BT`.
- Use `LR` for service architecture and pipeline narratives.
- Use `TB` for procedures and runbooks.

## 2. Subgraphs for Bounded Contexts

Use subgraphs to cluster ownership or runtime boundaries.

```mermaid
flowchart LR
    subgraph Client
        UI[Web UI]
    end

    subgraph Platform
        API[Gateway API]
        Auth[Auth Service]
    end

    UI --> API --> Auth
```

## 3. Semantic Edge Labels

Keep edge labels short and action-oriented.

```mermaid
flowchart LR
    A[Job Runner] -->|enqueue| B[Queue]
    B -->|dispatch| C[Worker]
    C -->|write result| D[(Store)]
```

## 4. Styling with Class Definitions

Define classes once, then assign by node ID.

```mermaid
flowchart TB
    A[Public Entry]
    B[Business Logic]
    C[(Data Store)]

    classDef edge fill:#e6f4ff,stroke:#1d4ed8,stroke-width:1px,color:#0f172a;
    classDef data fill:#ecfdf5,stroke:#047857,stroke-width:1px,color:#052e16;

    class A,B edge;
    class C data;

    A --> B --> C
```

## 5. Safe Labeling Rules

- Quote labels with commas, colons, parentheses, or uncommon punctuation.
- Avoid lowercase `end` as literal node text.
- Keep label text concise to reduce layout instability.

## 6. Complexity Control

- Split giant flows into multiple linked diagrams.
- Keep each diagram focused on one operational question.
- Prefer repeated simple patterns over one dense supergraph.