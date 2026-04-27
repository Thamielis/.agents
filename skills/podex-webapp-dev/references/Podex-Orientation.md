# Podex Orientation (what to assume)

## What Podex is
Podex is a template/framework for full-stack web apps using:
1. Backend: PowerShell Core + Pode + SQLite
2. Frontend: htmx + Mustache + Tailwind CSS :contentReference[oaicite:7]{index=7}

## What the repo layout implies
Assume these folders exist and are the “feature placement” targets:
1. `api/`     - API endpoints (often JSON and/or server handlers)
2. `htmx/`    - endpoints or helpers for fragment/partial responses
3. `views/`   - Mustache templates (full pages + partials)
4. `public/`  - static assets (css, js, images)
5. `errors/`  - error templates/pages
6. `tests/`   - Pester + any other tests :contentReference[oaicite:8]{index=8}

## Bootstrapping/running (what the user likely does)
The README indicates:
1. Clone repo
2. `npm install`
3. Run a PowerShell bootstrap/build script
4. `npm start` to run the server
5. Navigate to the local URL/port shown by the template :contentReference[oaicite:9]{index=9}
