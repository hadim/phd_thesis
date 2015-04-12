.PHONY: phd

MD_FILES := $(shell find text/ -name '*.md' | sort)
PANDOC_BIN=~/.cabal/bin/pandoc

phd:
	$(PANDOC_BIN) --latex-engine=xelatex \
	              -H latex/preamble.tex \
	              -V fontsize=12pt \
	              -V documentclass:book \
	              -V papersize:a4paper \
	              -V classoption:openright \
	              --chapters \
	              --bibliography=bib/library.bib \
	              --csl="bib/cell.csl" \
	              $(MD_FILES) \
	              -o "thesis.pdf" --verbose \
	              | grep "makePDF"

phdlog:
	$(PANDOC_BIN) --latex-engine=xelatex \
	              -H latex/preamble.tex \
	              -V fontsize=12pt \
	              -V documentclass:book \
	              -V papersize:a4paper \
	              -V classoption:openright \
	              --chapters \
	              --bibliography=bib/library.bib \
	              --csl="bib/cell.csl" \
	              $(MD_FILES) \
	              -o "thesis.pdf" --verbose

docx:
	$(PANDOC_BIN) --chapters \
	              --bibliography=bib/library.bib \
	              --csl="bib/cell.csl" \
	              $(MD_FILES) \
	              -o "thesis.docx" --verbose -t docx
