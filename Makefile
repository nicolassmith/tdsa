SHELL=/bin/sh

PROJECT=tdsa
TEXFILES=tdsa.tex
BIBTEXFILES=
PUBLISHFILES=
EXTRA_DIST=

TEXFLAGS=-interaction=batchmode
LATEX=latex $(TEXFLAGS)
DVIPS=dvips
DVIPDF=dvipdf
PDFLATEX=pdflatex
BIBTEX=bibtex
TAR=tar
DISTFILES= tdsa.tex tdsa.bib ./Images/*eps ./Images/*pdf ./Images/*.png ./Images/*.jpg Makefile

all: tdsa.pdf

tdsa.pdf: $(TEXFILES) $(BIBTEXFILES)
	for file in $(TEXFILES) ; do \
	  base=`basename $$file .tex`; \
          $(PDFLATEX) $$base && \
	  $(BIBTEX)   $$base && \
	  $(PDFLATEX) $$base && \
	  $(PDFLATEX) $$base ;  \
	done

dist:
	if test -d dist ; then rm -fr dist; fi ; \
	mkdir dist ; \
	for file in $(DISTFILES) ; do cp $$file dist ; done ; \
	$(TAR) chozf dist.tar.gz dist ; \
	rm -fr dist

clean:
	for file in $(TEXFILES) ; do \
	  base=`basename $$file .tex` ; \
          rm -f $$base.log $$base.aux $$base.end $$base.bbl $$base.blg $$base.pdf; \
	done

