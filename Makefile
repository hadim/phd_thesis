.PHONY: phd

MD_FILES := $(shell find text/ -name '*.md' | sort)

phd:
	pandoc --latex-engine=xelatex \
	       -H latex/preamble.tex \
	       -V fontsize=12pt \
	       -V documentclass:book \
	       -V papersize:a4paper \
	       -V classoption:openright \
	       --chapters \
	       --bibliography=bib/papers.bib \
	       --csl="bib/csl/nature.csl" \
	       $(MD_FILES) \
	       -o "thesis.pdf"
