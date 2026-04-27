# Pode Patterns (Production-Leaning)

## Baseline server skeleton

- Use `Start-PodeServer` and declare endpoints explicitly.
- Separate concerns:
  - `src/Server/Server.ps1` (bootstrap)
  - `src/Server/Endpoints.ps1`
  - `src/Routes/*.ps1`
  - `src/Services/*.ps1`
  - `src/Middleware/*.ps1`

## Configuration

- Load config from `appsettings.json` + environment overrides.
- Keep secrets out of repo; use environment variables or secret stores.
- Surface config via a typed config object used by routes/services.

## Security middleware order (typical)

1. Headers / CORS
2. Rate limiting / allowlisting
3. Sessions (if used)
4. CSRF (if forms)
5. Authentication
6. Authorization checks (roles/groups/scopes)
7. Routes

## Authentication choices

- Basic over HTTPS for quick internal tools.
- Windows AD / LDAP for enterprise environments.
- Session auth for web apps with login forms.

## Input validation

- Validate inputs before service calls.
- Normalize query/path payloads early.
- Return structured errors with a correlation ID.

## OpenAPI

- For APIs: generate OpenAPI definitions and serve docs using viewers.
- Treat OpenAPI as a first-class artifact (versioned).

## Logging

- Emit structured logs with a request/correlation ID.
- Log at boundaries: request start/end, external calls, failures.
- Avoid logging secrets or PII.

## Error model

- Use consistent error shape: `code`, `message`, `correlationId`.
- Map common failures to HTTP status codes.

## Real-time updates

- Use SSE for one-way server -> client events.
- Use WebSockets for bi-directional interactions.

## Caching

- Cache expensive data (AD/SQL) with TTL + explicit invalidation.
- Ensure cache keys include query parameters.
- Provide a cache bypass for troubleshooting.
