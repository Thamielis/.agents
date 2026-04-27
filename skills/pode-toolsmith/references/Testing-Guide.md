# Testing Guide

## Pester focus areas

- Route coverage: happy path + error path.
- Service layer: IO boundaries, input validation, caching logic.
- Auth: unauthenticated requests should fail with expected status.

## Smoke tests

- Health endpoint returns 200 and JSON payload.
- Basic API endpoint returns expected shape.
- UI endpoint renders without errors.

## OpenAPI validation

- Ensure OpenAPI doc includes all routes.
- Confirm response schemas match payloads.

## Example smoke commands

- `Invoke-RestMethod http://localhost:8080/health`
- `Invoke-RestMethod http://localhost:8080/api/v1/info`
