# Pode Toolsmith Skill

## Overview

Provide guidance, templates, and checklists for building production-grade PowerShell tools
using Pode, Pode.Web, and Podex. The skill focuses on secure defaults, clear
architectural choices, and testable structure.

## Contents

- `SKILL.md`: Primary instructions for the agent.
- `scripts/`: Tooling helpers for environment validation, scaffolding, and self-tests.
- `references/`: Patterns and checklists for Pode, Pode.Web, Podex, security, testing, and operations.
- `assets/templates/`: Mustache templates and sample config for scaffolding.

## How to use

1. Read `SKILL.md` for the full operating procedure.
2. Run `scripts/Test-PodeToolingEnvironment.ps1 -Stack <Pode|PodeWeb|Podex>`.
3. Scaffold with `scripts/New-PodeToolScaffold.ps1`.
4. Implement slices and validate with `scripts/Invoke-PodeToolSelfTest.ps1`.

## References

Consult `references/` for patterns and checklists before implementation and final review.
