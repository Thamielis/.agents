---
description: 'Base plugin profile for PSArchitecture-style blank PowerShell module scaffolds'
applyTo: '**'
---

# Base Plugin Profile

Use this profile when creating or maintaining a blank scaffold based on the
PSArchitecture repository structure and build framework.

## Scaffold Assumptions

- The scaffold is a PowerShell 7+ module repository.
- Source lives under `src/<ModuleName>/`.
- Tests live under `src/Tests/`.
- Build orchestration uses `Invoke-Build` with `src/<ModuleName>.build.ps1`.
- Testing uses Pester v5 through the build task, not direct `Invoke-Pester`.
- Documentation uses comment-based help and generated Markdown help.
- CI/CD uses GitHub Actions.
- `.github/*` is the normative AI asset root.
- `.agents/*` is a compatibility mirror or plugin inventory.

## Base Plugins

Enable or prefer these plugins for every PSArchitecture-style scaffold when
they are available in the active runtime:

| Plugin | Required | Use For |
| --- | --- | --- |
| `project-planning` | Yes | Implementation plans, technical spikes, feature breakdowns |
| `GitHub` | Yes | Repository, issue, PR, and CI workflow work |
| `gh-tools` | Yes | GitHub workflow hygiene, GFM validation, issue and PR helpers |
| `Superpowers` | Yes | Planning, TDD, debugging, verification workflow |
| `doc-tools` | Yes | Markdown, documentation, generated docs, diagrams |
| `link-tools` | Yes | README, docs, help, and release-note link validation |
| `quality-tools` | Recommended | Code quality, pre-ship validation, dead-code and duplication checks |
| `codex-security` | Recommended | Threat modeling, security scans, finding fixes, validation |
| `Browser Use` | Conditional | Rendered documentation or localhost/browser validation |

## Conditional Plugins

Enable conditional plugins only when the scaffold adds the matching surface:

| Surface Added | Plugin Candidates |
| --- | --- |
| Documentation website or hosted preview | `Build Web Apps`, `Browser Use`, `Vercel`, `Netlify`, `Render`, `Cloudflare` |
| UI or design artifacts | `Figma`, `Canva`, `Browser Use` |
| External project management source | `Atlassian Rovo`, `Linear`, `ClickUp`, `Notion` |
| Microsoft 365 documents or collaboration | `SharePoint`, `Teams`, `Outlook Email`, `Outlook Calendar` |
| Data storage or analytics | `database-data-management`, `neon-postgres`, `supabase`, provider-specific plugins |
| Payments, CRM, marketing, finance, calendar, or email integrations | Enable only the concrete provider named by the task or repository design |

## Disable Rules

- Do not enable web, design, database, mobile, finance, CRM, or marketing
  plugins for a plain PowerShell module scaffold.
- Disable a plugin by omitting it from the default task context; do not delete
  local plugin package files.
- If a plugin requires credentials or external writes, use it only after the
  task explicitly needs that system and runtime approval policy allows it.

## Scaffold Rescan

Rescan plugin recommendations when:

- The scaffold adds a new top-level capability such as a docs website, service
  integration, UI surface, database, deployment target, or telemetry sink.
- Build, test, documentation, CI/CD, release, or security workflow files change.
- `.agents/plugins/` changes.
- `.github/collections/`, `.github/instructions/`, `.github/agents/`,
  `.github/prompts/`, or `.github/skills/` changes.

During rescan, compare runtime-callable plugins with local plugin inventory and
report any recommended plugin that is present locally but unavailable in the
active runtime.
