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
%%
%%  * Fixed compatibility problem with hyperref using \phantomsection
%%    as suggested by Halvor Borgen
%%
%% v0.8 2008/05/20
%%
%%  * Options oneside and twoside added by Rune Hammersland
%%
%% TODO:
%%
%%  * Capitals for chapters in toc.
%%
%%  * Other fonts for tt, sf etc.?
%%
%%  * Check page numbering (where is page numer i?)
%%
%%  * Problems with nested itemize environments
%%
%%  * Font warnings (pdflatex)
%%
%%  * Warning about page numbers (pdflatex)

%% IDENTIFICATION

\xdef\gucmasterthesisdate{2008/05/20}
\xdef\gucmasterthesisversion{0.8}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gucmasterthesis}
  [\gucmasterthesisdate\space
   v\gucmasterthesisversion\space
   Copyright (C) 2005 Ivar Farup]

%% CLASS FILE COMMANDS

\LoadClass[a4paper,twoside]{report}

%% PACKAGE LOADING

\RequirePackage{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{charter}
\RequirePackage{euler}

%% MAIN PART

% Page geometry and layout

\AtBeginDocument{\baselineskip=14pt%
  \parskip=0pt%
  \parindent=14pt%
  \frenchspacing%
  \setcounter{secnumdepth}{2}%
}
\pagenumbering{roman}           % until first chapter, see below

% Header and footer

\def\thesis@title{Use thesistitle to insert your title here.}
\def\thesis@date{Use thesisdate to insert your date here.}
\def\thesis@author{Use thesisauthor to insert your name here.}
\def\thesistitle#1{\def\thesis@title{#1}}
\def\thesisdate#1{\def\thesis@date{#1}}
\def\thesisauthor#1{\def\thesis@author{#1}}
\def\ps@gucheadings{%
  \def\@oddfoot{\reset@font\hfil\thepage\hfil}
  \def\@oddhead{\underline{\hbox
      to\hsize{\fontsize{7}{9}\selectfont\hfil\thesis@title}}}
  \def\@evenhead{\underline{\hbox
      to\hsize{\fontsize{7}{9}\selectfont\thesis@title\hfil}}}
  \let\@evenfoot=\@oddfoot}
\pagestyle{gucheadings}
% Empty page does not have header or footer
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

% Title page

\def\thesistitlepage{
  \title{\thesis@title}
  \date{\thesis@date}
  \author{\thesis@author}
  \maketitle
}

% Sectioning commands

\def\section{\@startsection
  {section}%
  {1}%
  {0mm}%
  {-10pt}%
  {4pt}%
  {\normalfont\fontsize{12}{14}\selectfont\bfseries}%
}
   
\def\subsection{\@startsection
  {subsection}%
  {2}%
  {0mm}%
  {-6pt}%
  {2pt}%
  {\normalfont\fontsize{10.5}{14}\selectfont\bfseries}%
}

\def\subsubsection{\@startsection
  {subsubsection}%
  {3}%
  {0mm}%
  {-6pt}%
  {2pt}%
  {\normalfont\normalsize\selectfont\bfseries}%
}

\def\paragraph{\@startsection
  {paragraph}%
  {4}%
  {0mm}%
  {-6pt}%
  {2pt}%
  {\normalfont\normalsize\selectfont\itshape}%
}

\newcounter{firstchapter}       % hack to find out where to start
\c@firstchapter=1               % arabic page numbering, see below

\newcounter{tmpfig}             % hack to have continuous numbering of
\newcounter{tmptab}             % figures and tables, see below

\renewcommand\chapter{%\if@openright\cleardoublepage\else\clearpage\fi
  \cleardoublepage
 \thispagestyle{plain}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}
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
 Add extra space in list of figures and list of tables between
 figures & tables belonging to different chapters:
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \if@twocolumn
  \@topnewpage[\@makechapterhead{{#2}}]%
  \else
  \@makechapterhead{{#2}}%
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
Use $\backslash$useyear\{<year>\} to set year.
}

\newcommand{\useyear}[1]{%
  \renewcommand{\gmt@frontpagesyear}{#1}
}

\newcommand\gmt@firstpagetext{%
  \noindent Use this class with options\\ ``medieteknikk,''
  ``mediatechnology,'' ``informasjonssikkerhet'' or\\
  ``informationsecurity''.  
}

\newcommand\gmt@secondpagetext{%
  \noindent Use this package with options\\ ``medieteknikk,''
  ``mediatechnology,'' ``informasjonssikkerhet'' or\\
  ``informationsecurity''.
}

\newcommand\gmt@imttext{%
  \noindent
  Avdeling for\\
  informatikk og medieteknikk\\
  H\o{}gskolen i Gj\o{}vik\\
  Postboks 191\\
  2802 Gj\o{}vik

  \vskip 3em%

  \noindent
  Department of Computer Science\\
  and Media Technology\\
  Gj\o{}vik University College\\
  Box 191\\
  N-2802 Gj\o{}vik\\
  Norway
}

%% OPTIONS (declare more here if needed)

\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse%
\geometry{a4paper, left=3.75cm, right=3.75cm, top=3cm, bottom=4cm,
  head=1.2cm, foot=2cm}}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue%
\geometry{a4paper, left=4.5cm, right=3cm, top=3cm, bottom=4cm,
  head=1.2cm, foot=2cm}}

\DeclareOption{medieteknikk}{%
  \renewcommand\gmt@firstpagetext{%
    IMT3521 \\
    Introduction to security planning and incident management \\
    H\o{}gskolen i Gj\o{}vik, \gmt@frontpagesyear
  }
  \renewcommand\gmt@secondpagetext{\gmt@imttext}
}

\DeclareOption{informasjonssikkerhet}{%
  \renewcommand\gmt@firstpagetext{%
    Masteroppgave\\
    Master i informasjonssikkerhet\\
    30 ECTS\\
    Avdeling for informatikk og medieteknikk\\
    H\o{}gskolen i Gj\o{}vik, \gmt@frontpagesyear
  }
  \renewcommand\gmt@secondpagetext{\gmt@imttext}
}

\DeclareOption{mediatechnology}{%
  \renewcommand\gmt@firstpagetext{%
    Master's Thesis\\
    Master of Science in Media Technology\\
    30 ECTS\\
    Department of Computer Science and Media Technology\\
    Gj\o{}vik University College, \gmt@frontpagesyear
  }
  \renewcommand\gmt@secondpagetext{\gmt@imttext}
}

\DeclareOption{informationsecurity}{%
  \renewcommand\gmt@firstpagetext{%
    Master's Thesis\\
    Master of Science in Information Security\\
    30 ECTS\\
    Department of Computer Science and Media Technology\\
    Gj\o{}vik University College, \gmt@frontpagesyear
  }
  \renewcommand\gmt@secondpagetext{\gmt@imttext}
}


\ProcessOptions\relax

%% FRONTPAGE GENERATION

\newcommand\makefrontpages{%
  \begin{titlepage}%
    % \thispagestyle{empty}
    % \setcounter{page}\z@
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \null\vfil
    \vskip 165\p@
    \begin{center}%
      {\fontsize{20}{24}\selectfont \thesis@title}%
      \vskip 3em%
      {%\large
        \lineskip .75em%
        \begin{tabular}[t]{c}%
          %{\fontsize{14}{16}\selectfont \thesis@author \par} %\@author
          {\fontsize{14}{16}\selectfont Leonard Eschenbaum\par} \\ %\@author
          {\fontsize{14}{16}\selectfont Adri\'{a}n Alberdi Ainciburu \par} \\ %\@author
        \end{tabular}\par}%
      % \vskip 1.5em%
      % {\large Dato \par}%       % Set date in \large size.
    \end{center}\par
    \@thanks
    \vfill
    \vskip 3em
    \begin{center}%
      \includegraphics[width=70pt]{higlogo} \\
      \medskip
      \gmt@firstpagetext
    \end{center}
  \end{titlepage}

  %\newpage
  %\thispagestyle{empty}
  %\null\vfil
  %\vfill
  %\vbox{\footnotesize{\gmt@secondpagetext}}
}