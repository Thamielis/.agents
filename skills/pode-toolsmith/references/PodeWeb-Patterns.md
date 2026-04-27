# Pode.Web Patterns

## When to choose Pode.Web

- Need a dashboard quickly without writing HTML/CSS/JS.
- Require pages, cards, tables, forms, charts, themes.

## Layout

- Use pages as top-level shells and cards as information blocks.
- Keep data shaping in services, not in UI scriptblocks.

## Tables

- Drive tables from a scriptblock data source.
- Prefer server-side pagination for large datasets.
- Use auto-refresh only for lightweight calls; otherwise push updates.

## Progress / long operations

- Avoid blocking UI during heavy work:
  - Compute in background (runspaces/jobs)
  - Stream progress (progress components)

## Themes & custom CSS

- Start with built-in themes.
- Add custom CSS only after layout is stable.

## Common performance knobs

- Cache expensive data.
- Reduce object shape early (select only needed properties).
- Avoid repeated module imports per request.

## Error handling

- Surface friendly errors in UI with a correlation ID.
- Log full error details server-side.
