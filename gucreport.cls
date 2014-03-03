%% 'gucreport.cls' - a LaTeX class for reports at GUC, based upon gucthesis.cls
%%
%% Copyright (C) 2014 Magnus Øverbø
%% 'gucthesis.cls' - Copyright (C) 2005 Ivar Farup and Kjetil Orbekk
%%
%% CHANGE LOG:
%%
%% v0.1 2005/03/09:
%%  * First pre-alpha draft
%%
%% v0.2 2005/03/10:
%%  * Reduced size of heading to 7pt
%%  * Reimplemented the heading without using fancyhdr, making the
%%    package (more) compatible with hyperref.
%%  * Introduced \thesisdate for upper right header
%%
%% v0.3 2005/03/11:
%%  * \chapter{} and \chapter*{} heading can cover several lines
%%
%% v0.4 2005/04/19:
%%  * new itemize and enumerate environments
%%  * twoside, adjusted headers and margins; header and footers are
%%    not shown on pages that are empty due to new chapters
%%  * \thesistitlepage: dummy title page using new commands
%%    \thesisauthor, \thesisdate, and \thesistitle
%%  * no centering of sections
%%  * \subsubsection and \paragraph now produce an error message
%%
%% v0.5 2005/05/10:
%%  * \subsubsection and \paragraph reintroduced
%%  * \parskip and \parindent changed
%%
%% v0.6 2005/05/13:
%%  * \chapter no longer in capitals
%%
%% v0.7 2007/05/30:
%%  * Added frontpage matter implemented by Kjetil Orbekk
%% 'gucmasterthesis.cls' - a LaTeX class for master's theses at GUC
%%
%%
%% 2014/02/06
%%	* Removed redundant code from creating front pages
%%	* Specific types of study programs are more easily created
%%	* Added a separate counter for wordcount
%%	* Added a second title page for bachelor students
%%	* Fixed norwegian/english language bug
%%	*	Fixed cleardoublepage on summaries on twoside
%%
%% 2014/02/23
%%	* Created report template with frontpage 
%%	* 
%%	* 
%%

%%	Fix norsk option, since it returns errors on UTF8x
%%	
%%	
%%	


%%	IF
\newif\if@norsk
	\@norskfalse
\newif\if@english
	\@englishtrue
\newif\if@showIndex
	\@showIndexfalse
\newif\if@showDict
	\@showDictfalse
\newif\if@showTodo
	\@showTodofalse

%% IDENTIFICATION
\xdef\gucrepd{2014/02/28}
\xdef\gucrepv{1.00.00}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gucreport}
  [\gucrepd\space
   v\gucrepv\space
   Copyright (C) 2014 Magnus Øverbø.
	 Based on the gucthesis class by Ivar Farup and Simon McCallum]

%% CLASS FILE COMMANDS
\LoadClass[a4paper]{report}

%% PACKAGE LOADING
\RequirePackage{geometry}
\RequirePackage[T1]{fontenc}\RequirePackage[utf8x]{inputenc}
\RequirePackage[utf8x]{inputenc}
\RequirePackage{euler}
\RequirePackage{lastpage}
\RequirePackage{babel}
\RequirePackage[pdftex]{graphicx, hyperref}
\RequirePackage{color}
\RequirePackage{nomencl}
\RequirePackage{pdfpages}
\RequirePackage{multicol}
\RequirePackage{longtable}
\RequirePackage[table]{xcolor}
\RequirePackage[all]{hypcap}
\RequirePackage[xindy]{glossaries}
\RequirePackage{listings}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{bbding}
\RequirePackage{caption}
\RequirePackage{todonotes}

%	Counters
\newcounter{firstchapter}       % hack to find out where to start
	\c@firstchapter=1             % arabic page numbering, see below
\newcounter{tmpfig}             % hack to have continuous numbering of
\newcounter{tmptab}             % figures and tables, see below
\newcounter{numapp}

\newcommand{\numberofapp}{%
	\immediate\write\@auxout%
	{\string\setcounter{numapp}{\the\c@chapter}}%
}

\newcommand{\pagespace}{
	\if@openright		\cleardoublepage
	\else						\clearpage
	\fi
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
\DeclareOption{listings}{
	\@showIndextrue
}
\DeclareOption{glossary}{
	\@showIndextrue
	\@showDicttrue
}
\DeclareOption{todo}{
	\@showIndextrue
	\@showTodotrue
}

%
%	CUSTOM CONFIG AND COMMANDS
\renewcommand*{\glspostdescription}{}
\renewcommand{\lstlistingname}{Code}
\renewcommand\lstlistlistingname{
	\if@norsk	Kodesnutter og skript	
	\else			Code snippets and scripts
	\fi
}
\newcommand{\comment}[1]{\textcolor{blue}{\emph{#1}}}	%	Comment
\newcommand{\com}[1]{{\color{red}#1}}									% Supervisory comment
\renewcommand{\todo}[1]{{\color{green}#1}}						% Items to do
\newcommand{\n}[1]{{\color{blue}#1}} 									% Other comment
\newcommand{\dn}[1]{} 																% Finished comment
\renewcommand{\nomname}{
	\if@norsk	Forkortelser	
	\else			List of Abbreviations
	\fi
}				%	Abbrevations

\renewcommand*{\nompreamble}{\begin{multicols}{2}}		%
\renewcommand*{\nompostamble}{\end{multicols}}				%
\setlength{\columnsep}{3em}														% 
\setlength{\nomitemsep}{0.01cm}												% 

\AtBeginDocument{
	\baselineskip=14pt%
  \parskip=0pt%
  \parindent=14pt%
  \frenchspacing%
  \setcounter{secnumdepth}{2}%
  \setcounter{tocdepth}{1}%
	\if@showIndex\if@showDict
		\makeglossaries		% Glossary
		\makenomenclature	% Abbreviations
	\fi\fi
}
\pagenumbering{roman}           % until first chapter, see below
\captionsetup{justification=centering}

% Header and footer
\def\wordcount{ wordcount }
	\def\wordcount#1{\def\wordcount{#1}}

\def\projtitle{ projtitle }
	\def\projtitle#1{\def\projtitle{#1}}

\def\projsubtitle{ projsubtitle }
	\def\projsubtitle#1{\def\projsubtitle{#1}}

\def\projdate{ projdate }
	\def\projdate#1{\def\projdate{#1}}

\def\keywords{ keywords }
	\def\keywords#1{\def\keywords{#1}}

\def\appnumber{ appnumber }
	\def\appnumber#1{\def\appnumber{#1}}

\def\pagecount{ LastPage  }
	\def\pagecount#1{\def\pagecount{#1}}

\def\projvers{projvers}
	\def\projvers#1{\def\projvers{#1}}

\def\projauthor{ projauthor }
	\def\projauthor#1{\def\projauthor{#1}}

\def\projauthorid{ projauthorid}
	\def\projauthorid#1{\def\projauthorid{#1}}

\def\projauthorAid{ projauthorid}
	\def\projauthorAid#1{\def\projauthorAid{#1}}
\def\projauthorA{ projauthor }
	\def\projauthorA#1{\def\projauthorA{#1}}

\def\projauthorBid{ projauthorid}
	\def\projauthorBid#1{\def\projauthorBid{#1}}
\def\projauthorB{ projauthor }
	\def\projauthorB#1{\def\projauthorB{#1}}

\def\projauthorCid{ projauthorid}
	\def\projauthorCid#1{\def\projauthorCid{#1}}
\def\projauthorC{ projauthor }
	\def\projauthorC#1{\def\projauthorC{#1}}

\def\projauthorDid{ projauthorid}
	\def\projauthorDid#1{\def\projauthorDid{#1}}
\def\projauthorD{ projauthor }
	\def\projauthorD#1{\def\projauthorD{#1}}

	\def\courseid{ courseid }
	\def\courseid#1{\def\courseid{#1}}
\def\coursename{ coursename }
	\def\coursename#1{\def\coursename{#1}}

\def\projteacher{ projteacher }
	\def\projteacher#1{\def\projteacher{#1}}

\def\keywords{ keywords }
	\def\keywords#1{\def\keywords{#1}}

%% Headings
\def\ps@gucheadings{%
	\def\@oddfoot{\reset@font \hfill \thepage/\pageref{LastPage} \hfill }
  \let\@evenfoot=\@oddfoot
  \def\@oddhead{
		\underline{
			\hbox to\hsize{
				\fontsize{8}{10}	\selectfont \hfill \projtitle \hfill
			}%hsize
		}%underline
	}%oddhead
  \let\@evenhead=\@oddhead
}
\pagestyle{gucheadings}

% Empty page does not have header or footer
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

% Title page
\def\projtitlepage{
	\title{	\projtitle	}
  \date{	\projdate	}
  \author{\projauthor}
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

\def\ps@gucchapterheading{%
	\def\@oddfoot{\reset@font \hfill \thepage/\pageref{LastPage} \hfill }
  \let\@evenfoot=\@oddfoot
  \def\@oddhead{}%oddhead
  \let\@evenhead=\@oddhead
}
\renewcommand\chapter{
	\pagespace
  \thispagestyle{gucchapterheading}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter
}
	\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
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
  }
}
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


	 %% MACRO
\newcommand{\GUC}{{G}j\o{}vik {U}niversity {C}ollege} %the extra {'s protect upper case
\newcommand{\HiG}{{H}\o{}gskolen i {G}j\o{}vik}
\newcommand{\gmt@frontpagesyear}{%
	\textbf{\color{red}N/A - \textbackslash useyear}
}
\newcommand{\useyear}[1]{%
  \renewcommand{\gmt@frontpagesyear}{#1}
}
\newcommand\gmt@imttext{%
  \noindent	Avdeling for\\	informatikk og medieteknologi\\
	\HiG\\  Postboks 191\\  2802 Gj\o{}vik  \vskip 3em%
  \noindent	Department of Computer Science\\	and Media Technology\\
  \GUC\\	  Box 191\\  N-2802 Gj\o{}vik\\  Norway
}

\newcommand\gmt@CollegeNameText{%
	\if@norsk
  	Avdeling for informatikk og medieteteknologi\\\HiG
	\else
		Department of Computer Science and Media Technology\\\GUC
	\fi
}

\newcommand\showindex{
	\if@showIndex
		\pagespace
		\begingroup
			\let\clearpage\relax
			\let\cleardoublepage\relax
			\listoffigures
			\lstlistoflistings
			\listoftables
			\if@showDict
				\printnomenclature
				\printglossaries
			\fi
			\if@showTodo	\listoftodos		\fi
		\endgroup
	\fi
}

\ProcessOptions\relax

%% FRONTPAGE GENERATION
\newcommand\makefrontpages{
	\begin{titlepage}
		\null
		\vskip 4mm
    \begin{center}
			\underline{\fontsize{22}{24}\selectfont \projtitle }\\[4mm]
			{\fontsize{18}{10}\selectfont {\color[gray]{0.2}\projsubtitle }}\\[15mm]

			\hskip 20mm
			\begin{tabular}[2]{ p{ 0.2\textwidth} p{0.6\textwidth} }
				{\fontsize{15}{16}\selectfont\projauthorid} &
					{\fontsize{16}{20}\selectfont \projauthor} \\[3mm]
				{\fontsize{15}{16}\selectfont\projauthorAid} &
					{\fontsize{16}{20}\selectfont \projauthorA} \\[3mm]
				{\fontsize{15}{16}\selectfont\projauthorBid} &
					{\fontsize{16}{20}\selectfont \projauthorB} \\[3mm]
				{\fontsize{15}{16}\selectfont\projauthorCid} &
					{\fontsize{16}{20}\selectfont \projauthorC} \\[3mm]
				{\fontsize{15}{16}\selectfont\projauthorDid} &
					{\fontsize{16}{20}\selectfont \projauthorD} \\[3mm]
			\end{tabular}\\[3mm]
				
			\hskip 20mm
			\begin{tabular}[2]{ p{0.2\textwidth}  p{0.6\textwidth} }
				\if@norsk
					{\fontsize{15}{20}\selectfont	Dato:}	&
				\else
					{\fontsize{15}{20}\selectfont	Date:}	&
				\fi
					{\fontsize{15}{20}\selectfont \projdate }\\[1mm]
				
				\if@norsk
					{\fontsize{15}{20}\selectfont	Versjon:}	&
				\else
					{\fontsize{15}{20}\selectfont	Version:}	&
				\fi
					{\fontsize{15}{20}\selectfont \projvers }\\[1mm]
				
				\if@norsk
					{\fontsize{15}{20}\selectfont	Fagansvarlig:}	&
				\else
					{\fontsize{15}{20}\selectfont	Teacher:}	&
				\fi
					{\fontsize{15}{20}\selectfont \projteacher }\\[1mm]
				
				\if@norsk
					{\fontsize{15}{20}\selectfont	Sideantall:} &
				\else
					{\fontsize{15}{20}\selectfont	Page count:} &
				\fi
					{\fontsize{15}{20}\selectfont \pagecount }\\[1mm]
				
				\if@norsk
					{\fontsize{15}{20}\selectfont	Antall ord:} &
				\else
					{\fontsize{15}{20}\selectfont	Word count:} &
				\fi
					{\fontsize{15}{20}\selectfont \wordcount }\\[1mm]
				
				\if@norsk
					{\fontsize{15}{20}\selectfont	Vedlegg:} &
				\else
					{\fontsize{15}{20}\selectfont	Appendices:} &
				\fi
					{\fontsize{15}{20}\selectfont \appnumber }\\[1mm]
				
				\if@norsk
					{\fontsize{15}{20}\selectfont	N\o{}kkelord:} &
				\else
					{\fontsize{15}{20}\selectfont	Keywords:} &
				\fi
					{\fontsize{15}{20}\selectfont \keywords }
			\end{tabular}\\[5mm]
    \end{center}
		
		\vfill
		\begin{center}
			\includegraphics[width=0.22\textwidth]{pictures/higlogo} \\[5mm]
			{	\fontsize{14}{20}\selectfont \courseid  \hskip 4mm--- }
			{	\fontsize{14}{20}\selectfont \coursename }\\
			{	\fontsize{14}{20}\selectfont \gmt@CollegeNameText }\\
    \end{center}
	\end{titlepage}
	\pagespace
}


%	Package setup
\definecolor{commentfg}	{rgb}{0.60,	0.00,	0.00}
\definecolor{stringfg}	{rgb}{0.25,	0.35,	0.75}
\definecolor{codebg}		{rgb}{1.00,	1.00,	0.90}

\hypersetup{
	colorlinks=false,
	pdfborder={0 0 0}
}

\lstset{
	language					= Python, %%Default language
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

