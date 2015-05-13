.PHONY: pdf log docx odt latex

# Custom path
PANDOC_BIN=~/.cabal/bin/pandoc
MAIN_BIB=$$HOME/Documents/phd/library.bib
BIB_STYLE=templates/cell.csl
LATEX_TEMPLATE=templates/preamble.tex

SRC_FILES := $(shell find text/ -name '*.md' | sort)

define PANDOC_OPTIONS
--chapters \
--bibliography=$(MAIN_BIB) \
--csl=$(BIB_STYLE)
endef

define TEX_OPTIONS
--latex-engine=xelatex \
-H $(LATEX_TEMPLATE) \
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


pdf: build-bib
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.pdf" --verbose | grep "makePDF"

log: build-bib
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.pdf" --verbose

latex: build-bib
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -t latex -o "thesis.tex" --verbose

docx: build-bib
	$(PANDOC_BIN) $(DOCX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.docx" --verbose

build-bib:
	python scripts/md2bib.py library.bib -g text/ -o /tmp/pandoc.bib
