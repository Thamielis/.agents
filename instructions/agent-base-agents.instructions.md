---
description: 'Base custom agent profile for CliToolRegistry-style blank PowerShell module scaffolds'
applyTo: '**'
---

# Base Agent Profile

Use this profile when creating or maintaining a blank scaffold based on the
CliToolRegistry repository structure and build framework.

## Source Order

- Prefer `.github/agents/*` as the normative custom agent set.
- Use `.agents/agents/*` only as a compatibility mirror when intentionally
  maintained.
- Select agents by task role. Do not activate every available agent for normal
  work.

## Base Agents

Enable or prefer these custom agents for every CliToolRegistry-style scaffold:

| Agent | Use For |
| --- | --- |
| `implementation-plan.agent.md` | Required implementation plans for features, refactors, upgrades, architecture, and infrastructure |
| `planner.agent.md` | General planning when the user asks for strategy or options |
| `plan.agent.md` | Deep planning and requirement clarification before implementation |
| `task-planner.agent.md` | Task-level work breakdowns |
| `task-researcher.agent.md` | Repository and technical research before planning |
| `research-technical-spike.agent.md` | Time-boxed technical spikes and unknowns |
| `repo-architect.agent.md` | Agentic scaffold structure and architecture validation |
| `software-engineer-agent-v1.agent.md` | General implementation work |
| `tdd-green.agent.md` | Implement code to satisfy existing failing tests |
| `github-actions-expert.agent.md` | GitHub Actions CI/CD creation, review, and repair |
| `se-gitops-ci-specialist.agent.md` | GitOps and CI troubleshooting |
| `se-technical-writer.agent.md` | README, docs, help, architecture, and release documentation |
| `se-system-architecture-reviewer.agent.md` | Architecture review and blueprint consistency |
| `se-security-reviewer.agent.md` | Security review and hardening |

## CliToolRegistry Agent Routing

Use this routing table for normal scaffold work:

| Task Type | Primary Agent | Supporting Agents |
| --- | --- | --- |
| New feature or refactor | `implementation-plan.agent.md` | `task-researcher.agent.md`, `software-engineer-agent-v1.agent.md`, `tdd-green.agent.md` |
| Module structure or architecture | `repo-architect.agent.md` | `se-system-architecture-reviewer.agent.md`, `implementation-plan.agent.md` |
| Tests and behavior changes | `tdd-green.agent.md` | `implementation-plan.agent.md`, `task-planner.agent.md` |
| CI/CD work | `github-actions-expert.agent.md` | `se-gitops-ci-specialist.agent.md` |
| Documentation/help/changelog | `se-technical-writer.agent.md` | `implementation-plan.agent.md` |
| Security-sensitive changes | `se-security-reviewer.agent.md` | `se-system-architecture-reviewer.agent.md` |
| Unclear requirements | `planner.agent.md` | `task-researcher.agent.md`, `research-technical-spike.agent.md` |

## Conditional Agents

Enable these only when the scaffold adds the matching concern:

| Agent | Enable When |
| --- | --- |
| `prd.agent.md` | Product requirements or user-story work is requested |
| `refine-issue.agent.md` | Existing issue text needs refinement |
| `devops-expert.agent.md` | Deployment, infrastructure, or release operations go beyond GitHub Actions |
| `modernization.agent.md` | Framework, runtime, or architecture modernization is requested |
| `meta-agentic-project-scaffold.agent.md` | The repository itself is becoming an agentic scaffold/template |
| `se-ux-ui-designer.agent.md` | A UI, docs site, visual flow, or UX artifact is introduced |
| `search-ai-optimization-expert.agent.md` | Search indexing, SEO, or AI search visibility becomes relevant |
| `expert-dotnet-software-engineer.agent.md` | The scaffold adds .NET application code |
| `microsoft-agent-framework-dotnet.agent.md` | The scaffold adds Microsoft Agent Framework/.NET agent code |

## Disable Rules

- Do not use UI, .NET app, SEO, or product agents for a plain PowerShell module
  scaffold unless the task adds that concern.
- Do not use implementation agents before planning when root guidance requires
  an implementation plan.
- Do not use external-system agents unless the corresponding integration is a
  source of truth or delivery target for the task.

## Agent Rescan

Rescan custom agents when:

- `.github/agents/` or `.agents/agents/` changes.
- A new project surface appears: UI, docs site, service integration, database,
  deployment target, security domain, release flow, or issue-tracker workflow.
- A task needs an expert role that is not covered by the base routing table.
- The user asks to enable, disable, update, or review agents.

When durable agent policy changes, update this file and `AGENTS.md`. For
one-off agent use, report the task-specific selection without changing policy.
