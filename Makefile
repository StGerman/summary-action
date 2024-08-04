# Purpose: Makefile for creating the summary of the source code
# Creator: Stas German
# Date: 2024-08-04
diff:
	git diff --patch-with-raw --raw --minimal --compact-summary origin/master HEAD > diff.txt

summary: diff
	python3 summary.py diff.txt

test:
	python3 -m unittest discover -v
