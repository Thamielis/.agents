# Podex Feature Architecture Checklist

## 1. User journey
1. Entry point page
2. Primary actions
3. Empty/loading/error states

## 2. Routes
1. Full page routes (GET)
2. htmx fragment routes (GET/POST)
3. API routes (if needed)

## 3. Templates
1. Full page in `views/`
2. Partials for list rows/forms/error summaries
3. Consistent layout slots (header, nav, content)

## 4. Data
1. Schema changes (tables + indexes)
2. Parameterized queries
3. Validation before write
4. Pagination and sorting strategy

## 5. Security
1. Auth + session cookie flags
2. CSRF for writes
3. Output encoding rules
4. Rate limiting where needed

## 6. Tests
1. Pester: repository functions + validation
2. Smoke path checklist (manual): “create → list → edit → delete”
