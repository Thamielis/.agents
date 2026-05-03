---
description: 'Base skill profile for PSArchitecture-style blank PowerShell module scaffolds'
applyTo: '**'
---

# Base Skill Profile

Use this profile when creating or maintaining a blank scaffold based on the
PSArchitecture repository structure and build framework.

## Source Order

- Prefer `.github/skills/*` as the normative repository skill set.
- Use `.agents/skills/*` only as a broader local mirror when `.github/skills/*`
  lacks a concrete capability required by the task.
- Do not bulk-enable every mirrored skill. Enable the smallest skill set that
  matches the scaffold, task, and current repository state.

## General Base Skills

Enable or prefer these skills for ordinary software engineering tasks:

| Skill | Use For |
| --- | --- |
| `context-map` | Map relevant files before changing behavior |
| `create-implementation-plan` | Create deterministic implementation plans |
| `update-implementation-plan` | Keep plans current as requirements change |
| `documentation-writer` | Write durable developer and user documentation |
| `conventional-commit` | Generate conventional commit messages |
| `git-commit` | Stage and commit logical change sets |
| `gh-cli` | Use GitHub CLI for repository, issue, PR, and Actions work |
| `refactor` | Make behavior-preserving scoped refactors |
| `refactor-plan` | Plan multi-file refactors before editing |
| `review-and-refactor` | Review code and apply safe local improvements |
| `microsoft-docs` | Query official Microsoft documentation |
| `microsoft-code-reference` | Verify Microsoft API and SDK usage |
| `model-recommendation` | Tune model choices for agents, prompts, and workflows |
| `suggest-awesome-github-copilot-agents` | Discover relevant Copilot custom agents |
| `suggest-awesome-github-copilot-instructions` | Discover relevant Copilot custom instructions |
| `suggest-awesome-github-copilot-prompts` | Discover relevant Copilot prompts |
| `suggest-awesome-github-copilot-skills` | Discover relevant Copilot skills |

## PowerShell Module Base Skills

For a PSArchitecture-style scaffold, enable or prefer:

| Skill | Source Preference | Use For |
| --- | --- | --- |
| `powershell-master` | `.agents/skills` | General PowerShell module, script, and CI work |
| `powershell-7-expert` | `.agents/skills` | PowerShell 7+ and cross-platform behavior |
| `powershell-module-architect` | `.agents/skills` | Module structure, public/private functions, manifests |
| `powershell-windows` | `.agents/skills` | Windows-specific PowerShell pitfalls |
| `powershell-shell-detection` | `.agents/skills` | PowerShell vs Git Bash/MSYS2 command behavior |
| `tdd-test-writer` | `.agents/skills` | Red/green test-first workflows |
| `breakdown-test` | `.agents/skills` | Test strategy and validation planning |
| `code-review` | `.agents/skills` | Final code review findings |
| `code-review-testing` | `.agents/skills` | Test adequacy review |
| `code-review-context` | `.agents/skills` | Review context quality |
| `code-review-change-size` | `.agents/skills` | Change size discipline |
| `code-review-breaking-changes` | `.agents/skills` | Breaking-change review |
| `architecture-blueprint-generator` | `.github/skills` | Architecture blueprint maintenance |
| `project-workflow-analysis-blueprint-generator` | `.github/skills` | Workflow and data-flow documentation |
| `code-exemplars-blueprint-generator` | `.github/skills` | Local coding exemplar discovery |
| `create-readme` | `.github/skills` | Initial README creation |
| `readme-blueprint-generator` | `.github/skills` | README blueprint and refresh work |
| `update-markdown-file-index` | `.github/skills` | File indexes in Markdown docs |
| `create-github-action-workflow-specification` | `.github/skills` | CI workflow specification |
| `github-actions-templates` | `.agents/skills` | CI workflow templates |
| `gh-fix-ci` | `.agents/skills` | Debug failing GitHub Actions checks |
| `gh-address-comments` | `.agents/skills` | Address PR or issue review comments |
| `codex-pr-body` | `.agents/skills` | PR title and body maintenance |
| `github-issues` | `.agents/skills` | Issue creation and updates |
| `create-github-issues-feature-from-implementation-plan` | `.agents/skills` | Turn implementation phases into issues |
| `changelog-generator` | `.agents/skills` | Release-note and changelog backfill |

## Conditional Skills

Enable these only when the active task requires them:

| Task Signal | Skill Candidates |
| --- | --- |
| Prompt, agent, or instruction safety review | `ai-prompt-engineering-safety-review`, `agent-governance` |
| New custom skill creation | `skill-creator`, `microsoft-skill-creator`, `make-skill-template` |
| GitHub issue or PR production | `github-issues`, `create-github-pull-request-from-specification`, `codex-pr-body` |
| Rendered Markdown or docs site output | `markdown-to-html`, `web-design-reviewer` |
| Architecture uncertainty | `create-technical-spike`, `architecture-patterns` |
| Broader repo analysis | `context-map`, `project-workflow-analysis-blueprint-generator`, `folder-structure-blueprint-generator` |

## Do Not Enable By Default

For a blank PowerShell module scaffold, do not enable frontend, cloud,
database, mobile, Office document, data science, or language-specific non-
PowerShell skills unless the scaffold adds that surface.

Examples include `frontend-design`, `webapp-testing`, `vercel`, `supabase`,
`azure-*`, `docx`, `xlsx`, `pdf`, `java-*`, `csharp-*`, `python-*`, and
database-specific SQL skills.

## Skill Rescan

Rescan skills when:

- The user asks to search, enable, disable, install, update, or review skills.
- `.github/skills/` or `.agents/skills/` changes.
- A task introduces a new language, runtime, external service, UI surface,
  database, documentation target, release process, or security-sensitive path.
- Existing skills fail to cover a needed workflow without repeated ad hoc
  reasoning.

When policy changes are durable, update this file and `AGENTS.md`. For one-off
task use, report the temporary skill selection without changing repo policy.
