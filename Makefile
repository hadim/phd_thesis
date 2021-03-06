.PHONY: pdf log docx odt latex

# Custom path
PANDOC_BIN_FOLDER=~/.local/bin/
PANDOC_BIN=~/.local/bin/pandoc
MAIN_BIB=library.bib
BIB_STYLE=templates/cell.csl
LATEX_TEMPLATE=templates/preamble.tex

SRC_FILES := $(shell find text/ -name '*.md' | sort)
TEST_SRC_FILES := $(shell find text/1_start -name '*.md' | sort)

define PANDOC_OPTIONS
--chapters \
--bibliography=$(MAIN_BIB) \
--csl=$(BIB_STYLE) \
--filter $(PANDOC_BIN_FOLDER)/pandoc-crossref \
--filter $(PANDOC_BIN_FOLDER)/pandoc-citeproc
endef

define TEX_OPTIONS
--latex-engine=xelatex \
-H $(LATEX_TEMPLATE) \
-V fontsize=12pt \
-V documentclass:book \
-V papersize:a4paper \
-V classoption:openright \
-V classoption:twoside \
--template=templates/template.tex \
 --highlight-style=tango \
 --number-sections
endef

define TEX_OPTIONS_ABSTRACT
--latex-engine=xelatex \
-H $(LATEX_TEMPLATE) \
-V fontsize=12pt \
-V documentclass:book \
-V papersize:a4paper \
-V classoption:oneside
endef

define DOCX_OPTIONS
--reference-docx=templates/references.docx \
--toc
endef


pdf: build-bib
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.pdf" --verbose | grep makePDF

log: build-bib
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.pdf" --verbose

test: build-bib
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(TEST_SRC_FILES) \
	              -o "test.pdf" --verbose

latex: build-bib
	$(PANDOC_BIN) $(TEX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -t latex -o "thesis.tex" --verbose

docx: build-bib
	$(PANDOC_BIN) $(DOCX_OPTIONS) $(PANDOC_OPTIONS) $(SRC_FILES) \
	              -o "thesis.docx" --verbose

build-bib:
	python scripts/md2bib.py library.bib -g text/ -o /tmp/pandoc.bib

abstract:
	$(PANDOC_BIN) $(TEX_OPTIONS_ABSTRACT) $(PANDOC_OPTIONS) text/1_start/3_summary.md \
	              -o "abstract.pdf" --verbose
