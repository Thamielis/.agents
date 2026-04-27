# Security Checklist

## Transport & network

- Enforce HTTPS for any auth or sensitive data.
- Bind to localhost for dev; require allowlisting for LAN tools.
- Document firewall/port requirements.

## Authentication & authorization

- Choose one auth model (Basic over HTTPS, AD/LDAP, sessions).
- Enforce authorization at route or service boundary.
- Use least-privilege accounts for external systems.

## Sessions & CSRF

- Enable CSRF for form-based flows.
- Rotate session identifiers after login.
- Set secure, HttpOnly cookies where supported.

## Input handling

- Validate and normalize input before processing.
- Reject unexpected fields in request bodies.
- Sanitize file paths; avoid path traversal.

## Secrets

- Avoid hard-coded secrets in scripts or templates.
- Use environment variables or secret stores.
- Mask secrets in logs and outputs.

## Auditing

- Log auth events (login attempts, access denied).
- Include correlation IDs in errors.
