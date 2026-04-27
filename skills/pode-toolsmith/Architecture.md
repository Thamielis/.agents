# Pode Toolsmith Skill Architecture

## Components

- **Instruction layer**: `SKILL.md` defines the workflow and outputs.
- **Automation layer**: `scripts/` provides environment checks, scaffolding, and smoke tests.
- **Reference layer**: `references/` supplies domain patterns and checklists.
- **Template layer**: `assets/templates/` contains scaffoldable server templates.

## Execution flow

1. **Discovery**: Read `SKILL.md` and gather inputs from the prompt.
2. **Validation**: Run environment checks in `scripts/`.
3. **Scaffolding**: Generate baseline project structure and templates.
4. **Implementation**: Add routes, services, and UI components.
5. **Verification**: Run Pester/smoke tests and validate OpenAPI outputs.
6. **Delivery**: Provide file tree, run instructions, security notes, and next steps.

## Key design goals

- Minimize ambiguity with defaults and explicit decisions.
- Ensure security and observability are part of the baseline.
- Promote predictable tooling and repeatable outputs.
