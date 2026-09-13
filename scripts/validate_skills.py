#!/usr/bin/env python3
"""Validate the portable SKILL.md contract without external dependencies."""
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1] / "skills"
NAME_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")


def frontmatter(path: Path):
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines()
    if not lines or lines[0] != "---":
        raise ValueError("missing opening frontmatter delimiter")
    try:
        end = lines.index("---", 1)
    except ValueError as exc:
        raise ValueError("missing closing frontmatter delimiter") from exc
    values = {}
    for line in lines[1:end]:
        if not line.strip():
            continue
        if ":" not in line:
            raise ValueError(f"frontmatter line is not key/value: {line}")
        key, value = line.split(":", 1)
        values[key.strip()] = value.strip().strip('"')
    return values, "\n".join(lines[end + 1:])


def main():
    failures = []
    skills = sorted(p.parent for p in ROOT.glob("*/SKILL.md"))
    if not skills:
        failures.append("no skills found")
    for directory in skills:
        path = directory / "SKILL.md"
        try:
            meta, body = frontmatter(path)
            name = meta.get("name", "")
            description = meta.get("description", "")
            if name != directory.name:
                raise ValueError(f"name {name!r} does not match directory")
            if not NAME_RE.fullmatch(name) or len(name) > 64:
                raise ValueError("name must be lowercase, hyphenated and <= 64 characters")
            if not description or len(description) > 1024 or "<" in description or ">" in description:
                raise ValueError("description must be non-empty, <= 1024 chars and contain no XML tags")
            if len(body.splitlines()) > 500:
                raise ValueError("body exceeds 500 lines")
            if "## Stop conditions" not in body:
                raise ValueError("missing Stop conditions section")
            if "## Output contract" not in body:
                raise ValueError("missing Output contract section")
            print(f"PASS {path}")
        except ValueError as exc:
            failures.append(f"{path}: {exc}")
    if failures:
        for failure in failures:
            print(f"FAIL {failure}")
        return 1
    print(f"Validated {len(skills)} skills")
    return 0


if __name__ == "__main__":
    sys.exit(main())
