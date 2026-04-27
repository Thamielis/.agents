#!/usr/bin/env python3
"""
Validate and optionally render Mermaid diagrams using Mermaid CLI (mmdc).

Examples:
  python scripts/validate_and_render_mermaid.py --input diagram.mmd --check-only
  python scripts/validate_and_render_mermaid.py --input diagram.mmd --output diagram.svg
  python scripts/validate_and_render_mermaid.py --input diagram.mmd --output diagram.png --scale 2
"""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
from pathlib import Path


def run_command(args: list[str]) -> subprocess.CompletedProcess[str]:
    return subprocess.run(args, capture_output=True, text=True)


def resolve_mmdc(binary_hint: str | None) -> list[str]:
    if binary_hint:
        return [binary_hint]

    direct = shutil.which('mmdc')
    if direct:
        return [direct]

    npx = shutil.which('npx')
    if npx:
        return [npx, '@mermaid-js/mermaid-cli']

    return []


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description='Validate and render Mermaid diagrams via mmdc.'
    )
    parser.add_argument('--input', required=True, help='Path to Mermaid input file (.mmd or .md snippet file).')
    parser.add_argument('--output', help='Optional render target (.svg/.png/.pdf). If omitted, only validation runs.')
    parser.add_argument('--config', help='Optional Mermaid config JSON passed to mmdc with -c.')
    parser.add_argument('--scale', type=int, default=1, help='Output scale for image rendering (default: 1).')
    parser.add_argument('--check-only', action='store_true', help='Run validation only, never render output.')
    parser.add_argument('--mmdc', help='Optional explicit mmdc executable path or command name.')
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    input_path = Path(args.input)
    if not input_path.exists():
        print(f'ERROR: Input file not found: {input_path}', file=sys.stderr)
        return 2

    if args.output and args.check_only:
        print('ERROR: --output cannot be combined with --check-only.', file=sys.stderr)
        return 2

    mmdc_prefix = resolve_mmdc(args.mmdc)
    if not mmdc_prefix:
        print('ERROR: Mermaid CLI not found. Install mmdc or provide --mmdc.', file=sys.stderr)
        return 3

    # Validation pass: render to temp SVG to ensure parser acceptance.
    temp_output = str(input_path.with_suffix(input_path.suffix + '.validate.svg'))
    validate_cmd = [*mmdc_prefix, '-i', str(input_path), '-o', temp_output]

    if args.config:
        validate_cmd.extend(['-c', args.config])

    validation = run_command(validate_cmd)
    if validation.returncode != 0:
        print('Validation failed.', file=sys.stderr)
        if validation.stderr.strip():
            print(validation.stderr.strip(), file=sys.stderr)
        if validation.stdout.strip():
            print(validation.stdout.strip(), file=sys.stderr)
        return validation.returncode

    # Cleanup temp file from validation run.
    try:
        Path(temp_output).unlink(missing_ok=True)
    except OSError:
        pass

    print('Validation successful.')

    if args.check_only or not args.output:
        return 0

    render_cmd = [*mmdc_prefix, '-i', str(input_path), '-o', str(args.output)]
    if args.config:
        render_cmd.extend(['-c', args.config])
    if args.scale and args.scale != 1:
        render_cmd.extend(['-s', str(args.scale)])

    render = run_command(render_cmd)
    if render.returncode != 0:
        print('Render failed.', file=sys.stderr)
        if render.stderr.strip():
            print(render.stderr.strip(), file=sys.stderr)
        if render.stdout.strip():
            print(render.stdout.strip(), file=sys.stderr)
        return render.returncode

    print(f'Render successful: {args.output}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())