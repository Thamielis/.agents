# Podex Patterns (Pode + htmx)

## When to choose Podex

- Need a modern, interactive UI with minimal JavaScript.
- Accept templates + Tailwind build step.

## Hypermedia endpoints

- Use routes that return:
  - Full pages for initial load
  - Partial fragments for htmx swaps
- Keep state server-side (sessions) or encode in URLs/forms.

## Templates

- Mustache is logic-light.
- Shape data in PowerShell before rendering.
- Keep templates declarative and small.

## htmx conventions

- Prefer server-rendered fragments.
- Use out-of-band swaps for notifications/toasts.
- Use SSE for live updates where appropriate.

## Error rendering

- Return htmx-friendly error fragments.
- Use status code + inline error message for form responses.

## Static assets

- Serve `public/` for CSS/JS/images.
- Version CSS assets to avoid cache confusion.
