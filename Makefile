# OS detected
ifeq ($(OS),Windows_NT)
	ifneq ($(findstring .exe,$(SHELL)),)
    OS_TYPE := Windows
	else
    OS_TYPE := Cygwin
	endif
else
    OS_TYPE := $(shell uname -s)
endif

# Program Defintions
TEX    = lualatex -shell-escape -8bit
BIBTEX = bibtex
INDEX  = makeindex -q
RM     = $(if $(filter $(OS_TYPE),Windows),del /f /q ,rm -f )

all: hxthesis
hxthesis : hxthesis.pdf

hxthesis.pdf : hxthesis.tex hustthesis.cls hustthesis.bst ref.bib
	@$(TEX) $(<F)
	@$(BIBTEX) $(basename $(<F))
	@$(TEX) $(<F)
	@$(TEX) $(<F)

fast : hxthesis_fast
hxthesis_fast : hxthesis_fast.pdf
hxthesis_fast.pdf : hxthesis.tex hustthesis.cls hustthesis.bst ref.bib
	@$(TEX) $(<F)

clean:
	-$(RM) *.acn *.acr *.alg *.aux *.bbl \
			*.blg *.dvi *.fdb_latexmk *.glg *.glo \
			*.gls *.idx *.ilg *.hd *.ind *.ist \
			*.lof *.log *.lot *.maf *.mtc \
			*.mtc0 *.nav *.nlo *.out *.pdfsync \
			*.pyg *.snm *.synctex.gz *.thm *.toc \
			*.vrb *.xdy *.tdo *.fls\
			*.pdf \
			#*.cls *.tex *.bib *.bst

reallyclean:
	-$(RM) *.acn *.acr *.alg *.aux *.bbl \
			*.blg *.dvi *.fdb_latexmk *.glg *.glo \
			*.gls *.idx *.ilg *.hd *.ind *.ist \
			*.lof *.log *.lot *.maf *.mtc \
			*.mtc0 *.nav *.nlo *.out *.pdfsync \
			*.pyg *.snm *.synctex.gz *.thm *.toc \
			*.vrb *.xdy *.tdo \
			#*.cls *.tex *.bib *.bst hustthesis*.pdf

.PHONY:all unpack class bst doc example example-zh example-en clean reallyclean checksum ctan ctan-upload FORCE
