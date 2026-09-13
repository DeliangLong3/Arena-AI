.PHONY: validate validate-skill validate-fixture

validate-skill:
	python3 scripts/validate_skills.py

validate-fixture:
	python3 scripts/validate_fixtures.py

validate: validate-skill validate-fixture
