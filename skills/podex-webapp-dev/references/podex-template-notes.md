# Podex Template Notes (Repo-Aware)

## 1. What Podex is
Podex is a framework/template for building full-stack web apps using:
- Backend: PowerShell Core, Pode, SQLite
- Frontend: htmx, Mustache, Tailwind CSS

## 2. Repo layout (top-level)
Expected directories:
- `api/` route handlers / endpoint code
- `views/` full page templates
- `htmx/` partial templates / fragments
- `errors/` error definitions/handling helpers
- `public/` static assets
- `tests/` Pester tests

## 3. Default development flow
1. `npm install`
2. `powershell -Command ". ./.build.ps1"`
3. `npm start`
4. Open `http://localhost:8433`

## 4. htmx patterns we prefer
- Full page returns: layout + targets
- htmx returns: fragments only (no duplicated layout)
- Use predictable IDs for swap targets:
  - `#Main`
  - `#Table`
  - `#Modal`
  - `#Toast`

## 5. “Done means”
- Page loads without htmx
- htmx enhances it (search/sort/paging/modals)
- No inline JS required (unless unavoidable)
- Tests cover non-trivial logic
