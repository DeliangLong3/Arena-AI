# Agent Skills

Each skill is a portable directory containing a standard `SKILL.md` with YAML frontmatter and optional reference files. The frontmatter intentionally uses only the portable required fields:

```yaml
---
name: lowercase-hyphenated-name
description: What the skill does and when to use it.
---
```

Authoring rules used here:

- `name` matches the directory name;
- lowercase letters, digits and hyphens only;
- `description` says what the skill does and when it should trigger;
- description is written in third person and is below 1,024 characters;
- body is procedural, explicit and below 500 lines;
- destructive, clinical or approval actions are represented as stop conditions;
- references are loaded only when needed;
- skills do not contain enterprise credentials or live clinical data.

Validate locally:

```bash
python3 scripts/validate_skills.py
```

The format follows the portable Agent Skills convention. See <https://agentskills.io/specification> and the authoring guidance at <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>.
