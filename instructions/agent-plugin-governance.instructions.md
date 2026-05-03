---
description: 'Repository plugin governance, default enablement, rescanning, and enable-disable rules for agent workflows'
applyTo: '**'
---

# Agent Plugin Governance

Use this instruction file to decide which plugins, custom agents, custom
instructions, prompts, and skills are active for PSArchitecture work.

For blank PSArchitecture-style scaffolds, also apply
`.github/instructions/agent-base-plugins.instructions.md` as the reusable base
plugin profile.

## Source Order

- Treat `.github/*` as the normative source for repository AI guidance.
- Treat `.agents/plugins/*` as the local plugin inventory and compatibility
  mirror. Use plugin content there only when it matches the current task.
- Treat currently callable session plugins as runtime capabilities. If a
  recommended plugin is present under `.agents/plugins/*` but is not callable in
  the active agent runtime, report that limitation and continue with the closest
  repo-local skill, prompt, or instruction.
- Do not modify `.agents/plugins/*` plugin source files unless the user
  explicitly asks to maintain plugin packages themselves.

## Default General Plugins

Enable or prefer these plugins for general software engineering work when they
are available in the active agent runtime:

| Plugin | Use For |
| --- | --- |
| `GitHub` | Repository inspection, issues, pull requests, CI diagnosis, publishing changes |
| `Superpowers` | Planning, TDD, debugging, verification, and collaborative development workflow |
| `Browser Use` | Local browser validation, screenshots, UI inspection, localhost checks |
| `codex-security` | Security scan, threat modeling, finding discovery, and security validation |
| `quality-tools` | Code quality, validation, duplicate/dead-code checks, pre-ship review |
| `doc-tools` | Markdown standards, documentation validation, diagrams, generated-doc workflows |
| `gh-tools` | GitHub workflow hygiene, GFM validation, issue workflow helpers |
| `link-tools` | Link validation for README, docs, generated help, and release notes |

## PSArchitecture Default Plugins

For this repository, prefer this plugin set for normal module development,
planning, testing, documentation, and release work:

| Priority | Plugin | Repository Rationale |
| --- | --- | --- |
| Required | `project-planning` | Root guidance requires `.github/collections/project-planning.collection.yml` and `.agents/plugins/project-planning/` for implementation planning |
| Required | `GitHub` | The project uses GitHub Actions, Git Flow, issue-key conventions, pull requests, and CI gates |
| Required | `gh-tools` | Complements GitHub workflow automation, GFM checks, and issue/PR hygiene |
| Required | `Superpowers` | Matches the required plan, test, verify, and iterate workflow |
| Required | `doc-tools` | The project requires README, changelog, architecture, platyPS, and generated help maintenance |
| Required | `link-tools` | Documentation and generated help need repeatable link validation |
| Recommended | `quality-tools` | Supports validation, pre-ship review, and maintainability checks |
| Recommended | `codex-security` | Supports external input validation and privileged-data review requirements |
| Conditional | `Browser Use` | Use only for local web preview, rendered documentation, or browser-based validation |

Do not treat `Build Web Apps`, `Figma`, or `Vercel` as PSArchitecture defaults.
Enable them only when the active task adds a web UI, design-system artifact,
website deployment, or hosted preview.

## Conditional Plugins

Enable these only for matching task signals:

| Plugin Family | Enable When |
| --- | --- |
| `Figma`, `Canva` | UI design, design systems, diagrams, slides, or visual design review are requested |
| `Build Web Apps`, `Vercel`, `Netlify`, `Render`, `Cloudflare` | A web app, documentation site, hosted preview, or deployment workflow is introduced |
| `Atlassian Rovo`, `Linear`, `ClickUp`, `Notion`, `Teams`, `Slack` | The repository task references that system as a source of truth or delivery target |
| `Google Drive`, `SharePoint` | Documents, spreadsheets, slides, or shared files are part of the requested workflow |
| Domain-specific finance, CRM, marketing, sales, calendar, email, or analytics plugins | The user explicitly asks for those systems or the repo adds that integration |

Disable means "do not use by default"; it does not mean deleting local plugin
folders or removing plugin package files.

## Rescan Protocol

Rescan available plugins and related Copilot assets before planning or
implementation when any of these happen:

- The user asks to search, rescan, enable, disable, install, update, or review
  plugins, agents, prompts, instructions, skills, or collections.
- Files are added, removed, or modified under `.agents/plugins/`, `.github/skills/`,
  `.github/agents/`, `.github/prompts/`, `.github/instructions/`, or
  `.github/collections/`.
- `AGENTS.md`, `src/AGENTS.md`, `Project_Architecture_Blueprint.md`, build
  scripts, CI workflows, or module dependencies change in a way that affects
  workflow, architecture, documentation, validation, security, release, or
  deployment.
- The project adds a new integration surface, external service, UI surface,
  documentation publishing flow, issue tracker, deployment target, data store,
  telemetry sink, or security-sensitive feature.
- A task fails because a needed capability is unavailable, stale, or mismatched
  with the current repository structure.

During a rescan:

1. List currently callable runtime plugins from the active agent environment.
2. List local plugin packages under `.agents/plugins/` by folder name and
   `plugin.json` or `.codex-plugin/plugin.json` metadata when present.
3. Review `.github/collections/*.collection.yml` for normative project
   collections and `.github/instructions/*.instructions.md` for active rules.
4. Compare findings with the default and conditional plugin tables above.
5. Report any plugin that is recommended but unavailable in the active runtime.
6. Update this file and `AGENTS.md` only when the default repository policy
   changes, not for one-off task usage.

## Enable and Disable Rules

- Enable the smallest plugin set that satisfies the current task and repository
  policy.
- Prefer repository-default plugins for normal PSArchitecture work; add
  conditional plugins only when concrete task signals require them.
- Disable or stop recommending a plugin when its task signal disappears, it
  creates noise, it overlaps with a better repo-default tool, or it requires
  credentials that are not available.
- Never enable a plugin only because it exists locally; require a repository
  reason, task reason, or explicit user request.
- If a plugin requires network access, secrets, account credentials, or external
  writes, state the requirement before using it and follow the active approval
  policy.
- When plugin policy changes, update the relevant `.github/instructions/*` file
  and mention the reason in the final response.

## Task Routing Defaults

- For feature or refactor work, use `project-planning`, `Superpowers`, `GitHub`,
  `gh-tools`, `quality-tools`, and PowerShell/Pester instructions.
- For documentation/help work, use `doc-tools`, `link-tools`, `GitHub`,
  `gh-tools`, and the repository documentation instructions.
- For CI or release work, use `GitHub`, `gh-tools`, `quality-tools`, and
  GitHub Actions instructions.
- For security-sensitive work, use `codex-security`, `quality-tools`, and
  security instructions.
- For architecture changes, use `project-planning`, `Superpowers`,
  `doc-tools`, and `Project_Architecture_Blueprint.md` guidance.
