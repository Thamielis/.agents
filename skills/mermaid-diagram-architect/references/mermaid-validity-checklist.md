# Mermaid Validity Checklist

Run this checklist before returning Mermaid output.

## A. Syntax Integrity

- Ensure the first non-comment line is a valid diagram declaration.
- Keep syntax strictly aligned with the declared type.
- Avoid mixing constructs from other diagram grammars.
- Keep one statement per line for traceable parser errors.

## B. Identifier and Label Safety

- Use stable IDs with letters, digits, and underscores.
- Quote labels containing punctuation, brackets, or reserved words.
- Avoid unescaped content that can be parsed as operators.

## C. Flowchart Hazard Checks

- Replace plain lowercase `end` node text with quoted or capitalized text.
- Prevent accidental circle/cross edge syntax (`---o`, `---x`) unless intended.
- Keep subgraph boundaries explicit and balanced.

## D. Config and Styling Safety

- Keep `%%{init: ...}%%` JSON valid.
- Use `theme: "base"` when custom `themeVariables` are set.
- Add `classDef` before large class assignment blocks for readability.
- Avoid over-styling that hides edge direction or node labels.

## E. Delivery and Rendering

- Wrap output in ```mermaid fenced blocks when target is Markdown.
- Provide raw `.mmd` block when CLI rendering is requested.
- If parser errors persist, return a minimized reproducer plus repaired final diagram.

## F. Error Recovery Loop

1. Remove styling/config and test core graph first.
2. Add nodes and edges incrementally.
3. Reintroduce labels, then classes, then init/config.
4. Stop when first failing line is identified; fix root cause before continuing.