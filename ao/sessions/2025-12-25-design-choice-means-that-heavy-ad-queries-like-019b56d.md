---
session_id: 019b56d2-73dd-78c3-8090-9c118cd9ef70
date: 2025-12-25
summary: "design choice means that heavy AD queries (like pulling thousands of users) are not repeated on e..."
tags:
  - agentops
  - session
  - 2025-12
---

# design choice means that heavy AD queries (like pulling thousands of users) are not repeated on e...

**Session:** 019b56d2-73dd-78c3-8090-9c118cd9ef70
**Date:** 2025-12-25

## Decisions
- design choice means that heavy AD queries (like pulling thousands of users) are not repeated on every page load. When developing, be mindful of the cache:

  - If you need fresh data for testing,...

## Knowledge
- til all tests pass.
- **Reflection & Validation:** Review the solution, test edge cases, and add tests for uncovered logic.
- **Documentation & Changelog:**
  - Update all relevant documentation...
- https://aka.ms/psstyle) strictly.
- Always use approved Verbs for functions ('<Verb-Noun>')
- One function per file starting with full comment-based help preceding the function.
- Prefer strong...
- https://github.com/openai/skills/tree/main/skills/.curated, but users can also provide other locations.

Use the helper scripts based on the task:
- List curated skills when the user asks what is...

## Issues
- `pre-built`
- `of-the-box`
- `dot-sourced`
- `in-memory`
- `hot-reload`
- `web-related`
- `non-obvious`
- `one-hop`
- `on-failure`
- `gh-address-comments`
- `gh-fix-ci`

## Tool Usage

| Tool | Count |
|------|-------|
| apply_patch | 5 |
| shell_command | 16 |

## Tokens

- **Input:** 0
- **Output:** 0
- **Total:** ~70927 (estimated)
