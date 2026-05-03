---
description: 'Create a time-boxed technical spike document for researching and de-risking an implementation decision'
mode: 'ask'
tools: ['changes', 'codebase', 'fetch', 'githubRepo', 'search', 'usages', 'vscodeAPI']
---

# Create Technical Spike

Create a focused technical spike document in Markdown that reduces uncertainty before implementation.

## Objectives

- Identify the exact problem or unknown that needs investigation.
- Capture current repository context and affected files.
- Evaluate plausible implementation approaches.
- Document risks, tradeoffs, and validation steps.
- Produce a clear recommendation and explicit next actions.

## Required Output Structure

1. Problem statement
2. Current repository context
3. Unknowns and assumptions
4. Options considered
5. Evidence gathered
6. Recommendation
7. Time box and exit criteria
8. Follow-up tasks

## Constraints

- Prefer repository evidence over assumptions.
- Use concrete file paths when referencing existing code.
- Keep the spike decision-oriented, not implementation-heavy.
- Call out missing information explicitly.
