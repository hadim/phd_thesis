.PHONY: pdf log docx odt latex

SRC_FILES := $(shell find text/ -name '*.md' | sort)

PANDOC_BIN=~/.cabal/bin/pandoc

define PANDOC_OPTIONS
--chapters \
--bibliography=bib/library.bib \
--csl="bib/cell.csl"
endef

define TEX_OPTIONS
--latex-engine=xelatex \
-H latex/preamble.tex \
-V fontsize=12pt \
-V documentclass:book \
-V papersize:a4paper \
-V classoption:openright \
-V classoption:twoside
endef

define DOCX_OPTIONS
--reference-docx=templates/references.docx \
--toc
endef


pdf:
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.pdf" --verbose | grep "makePDF"

log:
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.pdf" --verbose

latex:
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -t latex -o "thesis.tex" --verbose

docx:
	$(PANDOC_BIN) $(DOCX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.docx" --verbose
