CC1			= rm -f
CC2			= pdflatex
CF1			= -file-line-error 
LOG			= >> build.log
FILE		=	main
REM1		=	*.aux *.bbl *.blg *.bst *.glg *.glo *.gls *.ilg *.ist 
REM2		= *.lof *.lol *.lot *.nlo *.nls *.out *.tdo *.toc *.xdy 
REM3		= *.log ${FILE}.pdf

##		COMPILING FUNCTIONS
build: 
	${CC2} ${CF1} ${FILE}.tex #${LOG}
double:
	${CC2} ${CF1} ${FILE}.tex #${LOG}
	${CC2} ${CF1} ${FILE}.tex #${LOG}

##		Full and new compilation
small:	double
normal:	clean	build bib double
full:		clean build index double

##		Index/listing builds
index:	bib glossary abbreviation
bib:
	bibtex main
glossary: 
	makeglossaries main 
abbreviation:
	makeindex main.nlo -s nomencl.ist -o main.nls

##		CLEANING FUNCTIONS
clean:	preclean	postclean
preclean:	
	${CC1} ${REM3} ${LOG}
postclean:
	${CC1} ${REM1} ${REM2} ${LOG}

