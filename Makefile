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
	       --bibliography=bib/library.bib \
	       --csl="bib/cell.csl" \
	       $(MD_FILES) \
	       -o "thesis.pdf"
