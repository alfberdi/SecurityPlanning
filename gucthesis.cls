%% 'gucmasterthesis.cls' - a LaTeX class for master's theses at GUC
%%
%% Copyright (C) 2005 Ivar Farup and Kjetil Orbekk
%%
%% CHANGE LOG:
%%
%% v0.1 2005/03/09:
%%
%%  * First pre-alpha draft
%%
%% v0.2 2005/03/10:
%%
%%  * Reduced size of heading to 7pt
%%
%%  * Reimplemented the heading without using fancyhdr, making the
%%    package (more) compatible with hyperref.
%%
%%  * Introduced \thesisdate for upper right header
%%
%% v0.3 2005/03/11:
%%
%%  * \chapter{} and \chapter*{} heading can cover several lines
%%
%% v0.4 2005/04/19:
%%
%%  * new itemize and enumerate environments
%%
%%  * twoside, adjusted headers and margins; header and footers are
%%    not shown on pages that are empty due to new chapters
%%
%%  * \thesistitlepage: dummy title page using new commands
%%    \thesisauthor, \thesisdate, and \thesistitle
%%
%%  * no centering of sections
%%
%%  * \subsubsection and \paragraph now produce an error message
%%
%% v0.5 2005/05/10:
%%
%%  * \subsubsection and \paragraph reintroduced
%%
%%  * \parskip and \parindent changed
%%
%% v0.6 2005/05/13:
%%
%%  * \chapter no longer in capitals
%%
%% v0.7 2007/05/30:
%%
%%  * Added frontpage matter implemented by Kjetil Orbekk
%% 'gucmasterthesis.cls' - a LaTeX class for master's theses at GUC
%%

%%	Magnus Øverbø	-	2014/02/06
%%		* Removed redundant code from creating front pages
%%		* Specific types of study programs are more easily created
%%		* Added a separate counter for wordcount
%%		* Added a second title page for bachelor students
%%		* Fixed norwegian/english language bug
%%		*	Fixed cleardoublepage on summaries on twoside
%%		

%% MACRO
\newcommand{\GUC}{{G}j\o{}vik {U}niversity {C}ollege} %the extra {'s protect upper case
\newcommand{\HiG}{{H}\o{}gskolen i {G}j\o{}vik}

%%	IF
\newif\if@norsk				\@norskfalse
\newif\if@english			\@englishfalse
\newif\if@masters			\@mastersfalse
\newif\if@infoPage		\@infoPagefalse
\newif\if@listing			\@listingfalse
\newif\if@todo				\@todofalse
\newif\if@dictionary	\@dictionaryfalse

%% IDENTIFICATION
\xdef\gucthesisdate{2014/02/28}
\xdef\gucthesisversion{1.01.01}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gucthesis}
  [\gucthesisdate\space
   v\gucthesisversion\space
   Copyright (C) 2011 Ivar Farup and Simon McCallum
	 Modified by Magnus Øverbø 2014]

%% CLASS FILE COMMANDS
\LoadClass[a4paper]{report}

%% PACKAGE LOADING
\RequirePackage{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8x]{inputenc}
\RequirePackage{charter}
\RequirePackage{euler}
\RequirePackage{lastpage}
\RequirePackage{babel}
\RequirePackage[pdftex]{graphicx, hyperref}
\RequirePackage{color}
\RequirePackage{pdfpages}
\RequirePackage{multicol}
\RequirePackage{longtable}
\RequirePackage[table]{xcolor}
\RequirePackage[all]{hypcap}
\RequirePackage{nomencl}
\RequirePackage[xindy]{glossaries}
\RequirePackage{listings}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{bbding}
\RequirePackage{caption}
\RequirePackage{todonotes}

%	Counters
\newcounter{firstchapter}       % hack to find out where to start
	\c@firstchapter=1               % arabic page numbering, see below
\newcounter{tmpfig}             % hack to have continuous numbering of
\newcounter{tmptab}             % figures and tables, see below
\newcounter{numapp}

\newcommand{\numberofapp}{%
	\immediate\write\@auxout%
	{\string\setcounter{numapp}{\the\c@chapter}}%
}

%
%	CUSTOM CONFIG AND COMMANDS
%
\renewcommand*{\glspostdescription}{}
\renewcommand{\lstlistingname}{Code}
\renewcommand\lstlistlistingname{Code snippets and scripts}
\newcommand{\comment}[1]{\textcolor{blue}{\emph{#1}}}	%	Comment
\newcommand{\com}[1]{{\color{red}#1}}									% Supervisory comment
\renewcommand{\todo}[1]{{\color{green}#1}}						% Items to do
\newcommand{\n}[1]{{\color{blue}#1}} 									% Other comment
\newcommand{\dn}[1]{} 																% Finished comment
\renewcommand{\nomname}{List of Abbreviations}				%	Abbrevations

\renewcommand*{\nompreamble}{\begin{multicols}{2}}		%
\renewcommand*{\nompostamble}{\end{multicols}}				%
\setlength{\columnsep}{3em}														% 
\setlength{\nomitemsep}{0.01cm}												% 

%
\AtBeginDocument{
	\baselineskip=14pt%
  \parskip=0pt%
  \parindent=14pt%
  \frenchspacing%
  \setcounter{secnumdepth}{2}%
  \setcounter{tocdepth}{1}%
	\if@dictionary
		\makeglossaries
		\makenomenclature
	\fi
}
\pagenumbering{roman}           % until first chapter, see below
\captionsetup{justification=centering}

% Header and footer
\def\wordcount{ Use wordcount to insert the wordcount }
	\def\wordcount#1{\def\wordcount{#1}}
\def\thesis@title{Use thesistitle to insert your title here.}
	\def\thesistitle#1{\def\thesis@title{#1}}
\def\thesis@date{ Use thesisdate to insert your title here.}
	\def\thesisdate#1{\def\thesis@date{#1}}
\def\thesis@author{Use thesisauthor to insert your name here.}
	\def\thesisauthor#1{\def\thesis@author{#1}}
\def\thesis@authorA{}
	\def\thesisauthorA#1{\def\thesis@authorA{#1}}
\def\thesis@authorB{}
	\def\thesisauthorB#1{\def\thesis@authorB{#1}}
\def\thesis@authorC{}
	\def\thesisauthorC#1{\def\thesis@authorC{#1}}
\def\thesis@supervisor{}
	\def\thesissupervisor#1{\def\thesis@supervisor{#1}}
\def\thesis@supervisorA{}
	\def\thesissupervisorA#1{\def\thesis@supervisorA{#1}}
\def\thesis@oppdragsgiver{}
	\def\gmtoppdragsgiver#1{\def\thesis@oppdragsgiver{#1}}

\def\gmt@keywords{}
	\def\gmtkeywords#1{\def\gmt@keywords{#1}}
\def\gmt@desc{}
	\def\gmtdesc#1{\def\gmt@desc{#1}}

\def\thesis@titleNOR{Use thesistitle to insert your title here.}
	\def\thesistitleNOR#1{\def\thesis@titleNOR{#1}}
\def\gmt@keywordsNOR{}
	\def\gmtkeywordsNOR#1{\def\gmt@keywordsNOR{#1}}
\def\gmt@descNOR{}
	\def\gmtdescNOR#1{\def\gmt@descNOR{#1}}

\def\gmt@number{}
	\def\gmtnumber#1{\def\gmt@number{#1}}
	\def\gmtbachelornumber#1{\def\gmt@number{#1}}
\def\gmt@contact{}
	\def\gmtcontact#1{\def\gmt@contact{#1}}
\def\gmt@appnumber{}
	\def\gmtappnumber#1{\def\gmt@appnumber{#1}}
\def\gmt@pagecount{}
	\def\gmtpagecount#1{\def\gmt@pagecount{#1}}


%% Headings
\def\ps@gucheadings{%
  \def\@oddfoot{\reset@font \hfill \thepage \hfill }
  \let\@evenfoot=\@oddfoot
  \def\@oddhead{
		\underline{
			\hbox
      to\hsize{
				\fontsize{7}{9}	\selectfont \markright \hfill \thesis@title 
			}%hsize
		}%underline
	}%oddhead
  \def\@evenhead{
		\underline{
			\hbox
			to\hsize{
				\fontsize{7}{9} \selectfont \thesis@title \hfill
			}%hsize
		}%underline
	}%evenhead
}
\pagestyle{gucheadings}

% Empty page does not have header or footer
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

% Title page
\def\thesistitlepage{
	\title{	\thesis@title	}
  \date{	\thesis@date	}
  \author{\thesis@author \\\thesis@authorA \\\thesis@authorB \\\thesis@authorC}
  \maketitle
}

% Sectioning commands
\def\section{\@startsection
	{section}	{1}	{0mm}	{-10pt}	{4pt}
  {\normalfont \fontsize {12} {14} \selectfont \bfseries}
}
\def\subsection{\@startsection
  {subsection}	{2}	{0mm}	{-6pt}	{2pt}%
  {\normalfont\fontsize{10.5}{14}\selectfont\bfseries}%
}
\def\subsubsection{\@startsection
  {subsubsection}	{3}	{0mm}	{-6pt}	{2pt}%
  {\normalfont\normalsize\selectfont\bfseries}%
}
\def\paragraph{\@startsection
  {paragraph}	{4}	{0mm}	{-6pt}	{2pt}%
  {\normalfont\normalsize\selectfont\itshape}%
}

\renewcommand\chapter{
	\if@openright		\cleardoublepage
	\else						\clearpage
	\fi
  \thispagestyle{plain}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}
	\def\@chapter[#1]#2{
	\ifnum \c@secnumdepth >\m@ne
  	\c@tmpfig=\c@figure           % hack for figure and table numbering
  	\c@tmptab=\c@table
  	\refstepcounter{chapter}%
  	\c@figure=\c@tmpfig
  	\c@table=\c@tmptab
 		\ifnum\c@firstchapter = 1     % hack for page numbering
  		\pagenumbering{arabic}
  		\c@page=1 \c@firstchapter=0
  		\fi
  	\typeout{\@chapapp\space\thechapter.}%
  	\phantomsection
  	\addcontentsline{toc}{chapter}%
  	{\protect\numberline{\thechapter}#1}%
  \else
  	\phantomsection
  	\addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \if@twocolumn
  	\@topnewpage[\@makechapterhead{{#2}}]%
  \else \@makechapterhead{{#2}}%
  	\@afterheading
  \fi}
\def\@makechapterhead#1{%
  \vspace*{24\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
    \begin{center}
    \normalfont\fontsize{14}{14}\selectfont\bfseries\thechapter
    \fi
    \normalfont\fontsize{14}{14}\selectfont\bfseries\quad #1
    \end{center}\par\nobreak
    \vskip 12\p@
  }}
\def\@schapter#1{\if@twocolumn
  \@topnewpage[\@makeschapterhead{{#1}}]%
  \else
  \@makeschapterhead{{#1}}%
  \@afterheading
  \fi
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}% Contentsline also for \chapter*
}
\def\@makeschapterhead#1{%
  \vspace*{24\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \begin{center}\fontsize{14}{14} \bfseries  #1\end{center}\par\nobreak
    \vskip 12\p@
  }}

% Table of contents
\def\l@chapter#1#2{\@dottedtocline{1}{0em}{1.5em}{\bf #1}{\bf #2}}

% Table and figure captions
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\fontsize{9}{13}\selectfont #1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    \fontsize{9}{13}\selectfont #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

% Table and figure numbering without chapter number
\def\thefigure{\@arabic\c@figure}
\def\thetable{\@arabic\c@table}

% Quotes
\renewenvironment{quote}
{\list{}{\rightmargin\leftmargin\fontsize{9}{12}\selectfont}%
\item\relax}
{\endlist}

% Lists (itemize and enumerate)
\renewenvironment{itemize}{\begin{list}{\ensuremath\bullet}%
    {\labelwidth=.5em%
      \labelsep=1em%
      \leftmargin=\labelwidth%
      \advance\leftmargin\labelsep%
      \rightmargin=0pt%
      \topsep=5pt%
      \parsep=0pt%
      \partopsep=\baselineskip%
      \itemsep=\topsep%
      }}{\end{list}}

\newcounter{nenum}
\renewenvironment{enumerate}{\begin{list}{\llap{\arabic{nenum}.}}%
     {\usecounter{nenum}%
      \labelwidth=.7em%
      \labelsep=.8em%
      \leftmargin=\labelwidth%
      \advance\leftmargin\labelsep%
      \rightmargin=0pt%
      \topsep=5pt%
      \parsep=0pt%
      \partopsep=0pt%
      \itemsep=\topsep%
      }%
   }{\end{list}}

%%
%% GMT Frontpage by Kjetil:
%%
\newcommand{\gmt@frontpagesyear}{%
	\textbf{\color{red}N/A - \textbackslash useyear}
}

\newcommand{\useyear}[1]{%
  \renewcommand{\gmt@frontpagesyear}{#1}
}

\newcommand\gmt@firstpagetext{%
	\textbf{\color{red}
  \noindent Use this class with options\\ 
  ``MMT'' Masters i Medieteknikk,\\
  ``MIS'' Masters i Informasjonssikkerhet,\\
  ``CIMET'' Erasmus mundus Masters in Colour Science,\\
  ``BSP'' Bachelor i Spillprogrammering,\\
  ``BRD'' Bachelor i drift av nettverk og datasystemer,\\
  ``BIS'' Bachelor i Informasjonssikkerhet,\\
  ``BPU'' Bachelor i Programvareutvikling, \\
  ``BIND'' Bachelor i Ingeniørfad - data. 
	}
}

\newcommand\gmt@secondpagetext{%
	\gmt@firstpagetext
}

\newcommand\gmt@imttext{%
  \noindent	Avdeling for\\	informatikk og medieteknologi\\
	H\o{}gskolen i Gj\o{}vik\\  Postboks 191\\  2802 Gj\o{}vik  \vskip 3em%
  \noindent	Department of Computer Science\\	and Media Technology\\
  Gj\o{}vik University College\\	  Box 191\\  N-2802 Gj\o{}vik\\
  Norway
}

%% OPTIONS (declare more here if needed)
\DeclareOption{norsk}{
	\@norsktrue \@englishfalse
}

\DeclareOption{english}{
	\@englishtrue	\@norskfalse
}

\DeclareOption{oneside}{
	\@twosidefalse \@mparswitchfalse%
	\geometry{a4paper, left=3.75cm, right=3.75cm, top=3cm, 
						bottom=4cm, head=1.2cm, foot=2cm}
}
\DeclareOption{twoside}{
	\@twosidetrue  \@mparswitchtrue%
	\geometry{a4paper, left=4.5cm, right=3cm, top=3cm, 
						bottom=4cm, head=1.2cm, foot=2cm}
}

\DeclareOption{openright}{
	\@openrighttrue
}
\DeclareOption{infoPage}{
	\@infoPagetrue
}
\DeclareOption{listing}{
	\@listingtrue
}
\DeclareOption{todo}{
	\@todotrue
}
\DeclareOption{dictionary}{
	\@listingtrue
	\@dictionarytrue
}

\newcommand\showLists{
	\if@listing
		\if@openright	\cleardoublepage
		\else					\clearpage
		\fi
		\begingroup
			\let\cleardoublepage\relax
			\let\clearpage\relax
			\listoffigures
			\lstlistoflistings
			\listoftables
			\if@dictionary
				\printnomenclature
				\printglossaries
			\fi
			\if@todo	\listoftodos	\fi
		\endgroup
		\if@openright	\cleardoublepage
		\else					\clearpage
		\fi
	\fi
}

% Get education level
\newcommand\gmt@bachName{
	\if@masters
		\if@norsk	Masteroppgave		\else	Master's Thesis		\fi
	\else
		\if@norsk	Bacheloroppgave	\else	Bachelor's Thesis	\fi
	\fi
}
	
%	Get ECTS score for the education
\newcommand\gmt@ECTS{
	\if@masters	-	30 ECTS \\
	\else				-	20 ECTS \\
	\fi
}

%	Get/Set education program name
\newcommand\gmt@ProgName{
	\textnf{\color{red}NOT DEFINED}
}

\newcommand\gmt@CollegeNameText{%
	\if@norsk
  	Avdeling for informatikk og medieteteknologi\\
 	  H\o{}gskolen i Gj\o{}vik
	\else
		Department of Computer Science and Media Technology\\
		Gj\o{}vik University College
	\fi
}

\newcommand\gmt@ThesisData{
 	\renewcommand\gmt@firstpagetext{%
		\gmt@bachName	\gmt@ECTS
		\if@masters
			\if@norsk	Master i	\else	Master of Science in	\fi
		\else
			\if@norsk Bacher i 	\else	Bachelor of Science in\fi
		\fi
		\gmt@ProgName
  	\gmt@CollegeNameText
 	}
	\renewcommand\gmt@secondpagetext{\gmt@imttext}
}
	
\DeclareOption{BSP}{%
	\renewcommand\gmt@ProgName{
		\if@norsk Spillprogrammering  \\
		\else	 		Game Programming \\
		\fi
	}
	\gmt@ThesisData
}

\DeclareOption{BRD}{%
	\renewcommand\gmt@ProgName{
		\if@norsk Drift av Nettverk og Datasystemer \\
		\else 		Network and Computer Administration \\
		\fi
	}
	\gmt@ThesisData
}

\DeclareOption{BIND}{%
	\renewcommand\gmt@ProgName{
		\if@norsk	ingeniorfag - data \\
		\else			Computer Engineering \\
		\fi
	}
	\gmt@ThesisData
}

\DeclareOption{BIS}{%
	\renewcommand\gmt@ProgName{
		\if@norsk	Informasjonssikkerhet \\
		\else			Information Security \\
		\fi
	}
	\gmt@ThesisData
}

\DeclareOption{BPU}{%
	\renewcommand\gmt@ProgName{
		\if@norsk	Programvareutvikling  \\
		\else			Software Development  \\
		\fi
	}
	\gmt@ThesisData
}


\DeclareOption{MMT}{%
  \@masterstrue
	\renewcommand\gmt@ProgName{
		\if@norsk	Teknologi - Medieteknikk  \\
		\else			Media Technology  \\
		\fi
	}
	\gmt@ThesisData
}

\DeclareOption{MIS}{%
  \@masterstrue
	\renewcommand\gmt@ProgName{
		\if@norsk	Informasjonssikkerhet  \\
		\else			Information Security  \\
		\fi
	}
	\gmt@ThesisData
}

\DeclareOption{CIMET}{% not implemented yet
  \@masterstrue
	\renewcommand\gmt@ProgName{
		\if@norsk	\textbf{\color{red}Only english for CIMET thesis}\\
		\else			Colour Science  \\
		\fi
	}
	\gmt@ThesisData
}

\ProcessOptions\relax

%% FRONTPAGE GENERATION
\newcommand\makefrontpages{%
	\if@masters	\makemastersfrontpages
	\else				\makebachelorfrontpages
	\fi
}


\newcommand\makemastersfrontpages{%
  \begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \null\vfil
    \vskip 165\p@
    \begin{center}%
      {\fontsize{20}{24}\selectfont \thesis@title }%
      \vskip 3em%
      {%\large
        \lineskip .75em%
        \begin{tabular}[t]{c}%
          {\fontsize{14}{16}\selectfont \thesis@author \par} \\ %\@author
          {\fontsize{14}{16}\selectfont \thesis@authorA \par} \\ %\@author
          {\fontsize{14}{16}\selectfont \thesis@authorB \par} \\ %\@author
          {\fontsize{14}{16}\selectfont \thesis@authorC \par} \\ %\@author
        \end{tabular}\par}%
    \end{center}\par
    \@thanks
    \vfill
    \vskip 3em
    \begin{center}%
      \includegraphics[width=70pt]{pictures/higlogo} \\
      \medskip
      \gmt@firstpagetext
    \end{center}
  \end{titlepage}

  \newpage
  \thispagestyle{empty}
  \null\vfill
  \vfill
  \vbox{\footnotesize{\gmt@secondpagetext}}
}

\newcommand\makebachelorfrontpages{%
  \begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \vspace*{6.9mm}	{%
	    \fontsize{14}{16}\selectfont 
    	\if@norsk		BACHELOROPPGAVE: \\
			\else				BACHELOR THESIS: \\
			\fi
			\par
		}
    \hspace*{-5mm}{
    	\hspace{-5mm}
										%should be 127 and 67 but front cover wrong
			\includegraphics[width=130mm,height=70mm]{pictures/greybackground} \\
      \vskip -6cm % 7 gets to the top of the box
      \begin{tabular}[10cm]{p{0.5cm}p{10.2cm}l}%
      	& { \fontsize{14}{16}\selectfont \textbf{\thesis@title} \par } 
				& \rule[-7cm]{0cm}{7cm}
      \end{tabular}
			\par
		}
   
	\fontsize{14}{16}\selectfont 
  \if@norsk		FORFATTERE: \\
	\else				AUTHORS: \\
	\fi
	\begin{tabular}{p{1.5cm} p{10cm} }%
		\rule[-4cm]{0cm}{4cm} & {
			\fontsize{14}{16}\selectfont 
    	\parbox{5cm}{\vspace{5mm}
				\thesis@author \\ \\
    		\thesis@authorA \\ \\
    		\thesis@authorB \\ \\
				\thesis@authorC \\ 
    	} 
    	\par
		}
	\end{tabular}\par\vspace{-5mm}
  \if@norsk		DATO: \\
	\else				DATE: \\
	\fi
  \hspace*{21.5mm}{\fontsize{14}{16}\selectfont {\gmt@frontpagesyear} \par}

  \end{titlepage}

	\if@infoPage
		\if@twoside		\cleardoublepage
		\else					\clearpage
		\fi
  	\newpage
		\thispagestyle{empty}
		\null\vspace{4cm}
		\vbox{
			\begin{center}
				\includegraphics[width=40mm]{pictures/higlogo}\\[5mm]
				\vbox{
				%	\gmt@CollegeNameText\\[5mm]
					\gmt@firstpagetext
				}
			\end{center}
		}
		\vfill
		\vbox{\footnotesize{\gmt@secondpagetext}}\vspace{0mm}
	\fi

	\if@twoside		\cleardoublepage
	\else					\clearpage
	\fi
 	\newpage
  {%
    \fontsize{14}{16}\selectfont 
    Sammendrag av Bacheloroppgaven\\
	\par}
\begin{tabular}{|l@{  }p{0.2\textwidth}|l|l|l|}\hline
  Tittel: & \multicolumn{3}{@{}p{0.5\textwidth}|}{\thesis@titleNOR} & Nr: \gmt@number \\
	\cline{2-5}
	& \multicolumn{3}{@{  }l|}{} & Dato: \gmt@frontpagesyear\\\cline{2-5}
	& \multicolumn{4}{@{  }l|}{}\\\cline{2-5}
	& \multicolumn{4}{@{  }l|}{}\\\hline
	Deltakere: & \multicolumn{4}{@{  }l|}{\thesis@author}\\\cline{2-5}
	& \multicolumn{4}{@{  }l|}{\thesis@authorA}\\	\cline{2-5}
	& \multicolumn{4}{@{  }l|}{\thesis@authorB}\\\cline{2-5}
	& \multicolumn{4}{@{  }l|}{\thesis@authorC}\\\hline
	Veiledere: & \multicolumn{4}{@{\thesis@supervisor}l|}{}\\\cline{2-5}
	& \multicolumn{4}{@{  }l|}{\thesis@supervisorA}\\\hline
	Oppdragsgiver: & \multicolumn{4}{@{  }l|}{\thesis@oppdragsgiver}\\\cline{2-5}
	& \multicolumn{4}{@{  }l|}{}\\\hline
	Kontaktperson: & \multicolumn{4}{@{  }p{0.5\textwidth}|}{\gmt@contact}\\\cline{2-5}
	& \multicolumn{4}{@{  }l|}{}\\\hline
	Stikkord & \multicolumn{4}{@{  }l|}{\gmt@keywordsNOR}\\\cline{2-5}
	& \multicolumn{4}{@{}l|}{}\\\hline
	\multicolumn{2}{|p{0.18\textwidth}|}{Antall sider: \pageref{LastPage}} & Antall vedlegg: \gmt@appnumber & \multicolumn{2}
  {|l|}{Tilgjengelighet: \AA{}pen}\\\hline
	\multicolumn{5}{|l|}{Kort beskrivelse av bacheloroppgaven:}\\
	\multicolumn{5}{|p{0.9\textwidth}|}{\gmt@descNOR}\\\hline
\end{tabular}

% this should be a function call so that the layout is done in a single place.
% This is currently bad coding but I do not have time to fix it at the moment.
% I will fix this later.
\if@twoside		\cleardoublepage
\else					\clearpage
\fi
\newpage
{\fontsize{14}{16}\selectfont Summary of Graduate Project\\ \par}

\begin{tabular}{|l@{  }p{0.2\textwidth}|l|l|l|} \hline
	  Title: & \multicolumn{3}{@{}p{0.5\textwidth}|}{\thesis@title} & Nr: \gmt@number \\
		\cline{2-5}
		& \multicolumn{3}{@{  }l|}{} & Date: \gmt@frontpagesyear\\\cline{2-5}
		& \multicolumn{4}{@{  }l|}{}\\\cline{2-5}
		& \multicolumn{4}{@{  }l|}{}\\\hline
		Participants: & \multicolumn{4}{@{  }l|}{\thesis@author}\\\cline{2-5}
		& \multicolumn{4}{@{  }l|}{\thesis@authorA}\\\cline{2-5}
		& \multicolumn{4}{@{  }l|}{\thesis@authorB}\\\cline{2-5}
		& \multicolumn{4}{@{  }l|}{\thesis@authorC}\\\hline
		Supervisor: & \multicolumn{4}{@{\thesis@supervisor}l|}{}\\\cline{2-5}
		 & \multicolumn{4}{@{  }l|}{\thesis@supervisorA}\\\hline
		Employer: & \multicolumn{4}{@{  }l|}{\thesis@oppdragsgiver}\\\cline{2-5}
		& \multicolumn{4}{@{  }l|}{}\\\hline
		Contact person: & \multicolumn{4}{@{  }p{0.5\textwidth}|}{\gmt@contact}\\
		\cline{2-5}
		& \multicolumn{4}{@{  }l|}{}\\\hline
		Keywords & \multicolumn{4}{@{  }l|}{\gmt@keywords}\\\cline{2-5}
		& \multicolumn{4}{@{}l|}{}\\\hline
		\multicolumn{2}{|p{0.18\textwidth}|}{Pages: \pageref{LastPage}} & Appendixes: \gmt@appnumber & \multicolumn{2}
       {|l|}{Availability: Open}\\\hline
		\multicolumn{5}{|l|}{Short description of the main project:}\\
		\multicolumn{5}{|p{0.9\textwidth}|}{\gmt@desc}\\\hline
  \end{tabular}
}

%	Package setup
\definecolor{commentfg}{rgb}{0.6,0,0}
\definecolor{stringfg}{rgb}{0.25,0.35,0.75}
\definecolor{codebg}{rgb}{1,1,0.9}

\hypersetup{
	colorlinks=false,
	pdfborder={0 0 0}
}

\lstset{
	language					= python, %%Default language
	numbers		  			= left,
	breaklines				= true,
	breakindent				= 10pt,
	breakautoindent 	= true,
	stepnumber				= 1,
	numbersep	  			= 5pt,
	numberstyle				= \footnotesize \color{black},
	basicstyle				= \footnotesize \ttfamily,
	keywordstyle			= \footnotesize \color{black},
	commentstyle			= \footnotesize \color{commentfg},
	stringstyle				= \footnotesize\color{stringfg},
	showstringspaces	= false,
	frame		    			= none,
	tabsize		  			= 2,
	backgroundcolor		=	\color{codebg}
}  
%%Languages
%	Lang    	Name			Dialects
%------- 	--------	------------------->
% Python		Python		
%	SQL				SQL
%	PHP				PHP
% C					C					ANSI, Objective, Sharp
% C++				C++				ANSI, GNU, ISO, VISUAL
%	Basic			Basic			Visual
%	HTML			HTML
% Lua				Lua				5.0,	5.1,	5.2
%	Matlab		Matlab
%	Bash			bash
%	sh				sh
%	XML				XML
%	TeX				TeX				common,	LaTeX, plain, primitive
%	VBScript	VBScript
%	Java			Java			empty, AspectJ
% Assmebler	Assembler	x86masm

