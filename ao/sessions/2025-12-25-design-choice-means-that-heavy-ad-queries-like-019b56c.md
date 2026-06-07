---
session_id: 019b56cf-e1f2-75e1-8194-661fe4f53a56
date: 2025-12-25
summary: "design choice means that heavy AD queries (like pulling thousands of users) are not repeated on e..."
tags:
  - agentops
  - session
  - 2025-12
---

# design choice means that heavy AD queries (like pulling thousands of users) are not repeated on e...

**Session:** 019b56cf-e1f2-75e1-8194-661fe4f53a56
**Date:** 2025-12-25

## Decisions
- design choice means that heavy AD queries (like pulling thousands of users) are not repeated on every page load. When developing, be mindful of the cache:

  - If you need fresh data for testing,...

## Knowledge
- tilities module [(GitHub)](https://github.com/In-Pro-Org/ADBrowser/blob/50fe6a380b05cf49e23edae5542192693ce2ce28/src/Utilities.psm1#L2-L5). The web **routes** (for API endpoints) are defined...
- https://chatgpt.com/c/694c82f3-8dd0-8326-85a3-d545a9d61e4a
author:
---

# AGENTS.md

---

## 🚀 Project Overview

**ADBrowser** is a PowerShell-based web application for browsing Active...

## Issues
- `pre-built`
- `of-the-box`
- `dot-sourced`
- `in-memory`
- `hot-reload`
- `web-related`
- `non-obvious`
- `on-failure`

## Tokens

- **Input:** 0
- **Output:** 0
- **Total:** ~16863 (estimated)
