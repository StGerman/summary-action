# Purpose: Makefile for creating the summary of the source code
# Creator: Stas German
# Date: 2024-08-04
install:
	pip3 install poetry > /dev/null
	poetry install --no-root

diff:
	git diff --patch-with-raw --raw --minimal --compact-summary origin/master HEAD > diff.txt

summary:
	poetry run python3 summary/generate.py diff.txt

lint:
	poetry run pylint **/*.py

test:
	poetry run pytest
