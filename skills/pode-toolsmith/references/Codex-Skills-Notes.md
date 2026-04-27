# Codex CLI Agent Skills: Practical Notes

## Mental model: progressive disclosure

- Codex indexes each skill by reading only the **YAML front matter** in `SKILL.md`.
- Full instructions are read **only when the skill is invoked** (explicitly or implicitly).

Implication:
- Keep `description` sharp (it controls auto-triggering).
- Put bulky docs in `references/` so they stay off-context until needed.

## Discovery and precedence

Codex can load skills from repo, user, and admin locations.
When two skills have the same name, higher-precedence scope wins.

Recommended layout:
- Repo-wide skill: `<repo>/.codex/skills/<skill-name>/SKILL.md`
- Personal skill: `~/.codex/skills/<skill-name>/SKILL.md`

## Authoring principles for effective skills

1. Make the **description** extremely clear about “when to use this”.
2. Prefer **instruction-only** skills unless you need determinism.
3. Scripts should:
   - be idempotent
   - validate inputs
   - produce machine-parseable output when possible (JSON)
4. Include quality gates:
   - explicit “done means …” conditions
   - verification commands (tests, lint, build)

## Common pitfalls

- Too broad: skills compete with each other; narrow beats clever.
- Vague description: Codex won’t auto-trigger reliably.
- Hidden assumptions: write as if Codex knows nothing beyond user input + repo.
