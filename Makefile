# Purpose: Makefile for creating the summary of the source code
# Creator: Stas German
# Date: 2024-08-04
diff:
	git diff --patch-with-raw --raw --minimal --compact-summary origin/master HEAD > diff.txt

summary:
	./summary.sh diff.txt > summary.txt
