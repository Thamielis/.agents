# Mermaid CLI Rendering Examples

Use Mermaid CLI (`mmdc`) for deterministic rendering in CI or docs pipelines.

## Single Diagram to SVG

```bash
mmdc -i diagram.mmd -o diagram.svg
```

## Single Diagram to PNG (scaled)

```bash
mmdc -i diagram.mmd -o diagram.png -s 2
```

## Use Custom Config

```bash
mmdc -i diagram.mmd -o diagram.svg -c mermaid-config.json
```

## Example Config

```json
{
  "theme": "base",
  "themeVariables": {
    "primaryColor": "#e6f4ff",
    "primaryBorderColor": "#1d4ed8",
    "fontFamily": "Inter, Arial, sans-serif"
  },
  "flowchart": {
    "defaultRenderer": "elk"
  }
}
```

## Troubleshooting Notes

- If rendering fails, strip styles and re-run with minimal syntax.
- If fonts render differently in CI, pin runtime fonts or use default-safe stacks.
- If layout is unstable, set direction explicitly and reduce label length.