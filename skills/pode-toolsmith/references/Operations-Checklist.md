# Operations Checklist

## Observability

- Add a correlation ID per request.
- Log start/end of each request.
- Capture duration and status code.

## Caching

- Document TTLs and invalidation rules.
- Provide cache bypass for troubleshooting.

## Deployment

- Document run command and environment variables.
- Provide sample config (`appsettings.example.json`).
- List required module versions.

## Performance

- Use background jobs/runspaces for long operations.
- Avoid repeated imports per request.
- Shape data early to reduce payload size.

## Maintenance

- Add a `scripts/` entry for common ops tasks.
- Provide health endpoint and readiness checks.
