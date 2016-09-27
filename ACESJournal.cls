%%
%% ACESJournal.cls
%%   LaTex template for ACES journals (http://www.aces-society.org/)
%%
%% Copyright (c) 2016 by Luca De Camillis
%%
%% Authors:
%%   Luca De Camillis <lucadecamillis@gmail.com>
%%
%% License:
%%   This Source Code Form is subject to the terms of the Mozilla Public
%%   License, v. 2.0. If a copy of the MPL was not distributed with this
%%   file, You can obtain one at http://mozilla.org/MPL/2.0/.
%%
%%   This Source Code Form is 'Incompatible With Secondary Licenses',
%%   as defined by the Mozilla Public License, v. 2.0.
%%



\ProvidesClass{ACESJournal}[2016/09/27 V0.1 by Luca De Camillis]
\NeedsTeXFormat{LaTeX2e}
%
\RequirePackage{etoolbox}
%
% Used to identify the titlepage environment
\newif\if@restonecol
\newif\if@titlepage
\@titlepagefalse
%
% Paper Size
\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\fi
%
% Margin definition
\def\@ACESmargin{1in}
\def\@ACEStitleaddmargin{.25in}
%
% Debug
\setlength\overfullrule{5pt}
%
% Font Size
\def\@ACESvspace{10pt}
\def\@ACESglueStretch{2pt} % allow glue dimension to Stretch
\def\@ACESglueShrink{5pt} % allow glue dimension to Shrink
%
% Set the base font size tp 10pt using @ptsize.clo
\newcommand\@ptsize{0}
\def\sectionsize{\@setfontsize{\medium}{11}{12pt}}
\def\medium{\@setfontsize{\medium}{12}{14pt}}
\def\titlesize{\@setfontsize{\titlesize}{14}{17pt}}
%
% Produce output only on one side or two
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue \@mparswitchtrue}
%
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
%
% One or two columns
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
%
% Set default options
\ExecuteOptions{letterpaper,oneside,twocolumn,final}
\ProcessOptions
%
%In the standard document classes, the font size selection works as follows: The last digit of the default font size (0, 1 or 2) is saved in the command \@ptsize, then the file size1\@ptsize.clo is read, which changes some parameters.
\input{size1\@ptsize.clo}
%
% To reduce the space between equations and text
% we have to redefine the normalsize which is included
% in size10.clo
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xpt\@xiipt
   \abovedisplayskip 2\p@ \@plus1\p@ \@minus1\p@
   \abovedisplayshortskip \z@ \@plus1\p@
   \belowdisplayshortskip 2\p@ \@plus1\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize

% Reduce space between figures and the text
\setlength\floatsep	{1\p@ \@plus .5\p@ \@minus .5\p@}
\setlength\textfloatsep	{1\p@ \@plus .5\p@ \@minus .5\p@}
% \setlength\dblfloatsep    {1\p@ \@plus .5\p@ \@minus .5\p@}
% \setlength\dbltextfloatsep{1\p@ \@plus .5\p@ \@minus .5\p@}
%
% Reduce space in the wrapping environment
\setlength\intextsep   	{1\p@ \@plus .5\p@ \@minus .5\p@}
%
% Set the paragraph indentation to .25 inches --> 18pt
\parindent 18\p@
%
% set distance between paragraphs
\parskip 0ex plus 0.2ex minus 0.1ex
%
%
% Layout definition
%
\setlength\marginparwidth{20\p@}% Margin Note Lenght
\headheight   12pt
\headsep      18pt
%
% to be checked with \twocolumn[\layout]
\setlength\topmargin{0\p@}
\advance \topmargin by -\headheight
\advance \topmargin by -\headsep
%
% Set the body lenght by the paper lenght minus 2 x margin
\setlength\textheight\paperheight
\advance \textheight by -\@ACESmargin
\advance \textheight by -\@ACESmargin
%
% These parameters control \TeX's behaviour when two lines tend to come too close together.
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
%
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
%
% Create the title
\newcommand\maketitle{\par
  \begingroup
    \if@twocolumn
	\twocolumn[\@maketitle]%
    \else
      \newpage
      \global\@topnum\z@ % Prevents figures from going at top of page.
      \@maketitle
    \fi
  \endgroup
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
%
% Affiliations
\newcounter{affl@cnt}
\newcommand\affiliation[1]{%
  \stepcounter{affl@cnt}%
  \csdef{text\theaffl@cnt}{#1}}
%
\def\@maketitle{%
  \begingroup
  \null
  % \vfill
  \begin{center}
  \centering%
    \vskip \@ACEStitleaddmargin%
    \textrm{\bfseries{\titlesize\@title}}%
    \vskip \@ACESvspace%
    \vskip \@ACESvspace%
    \vskip 0pt%
    \textrm{\bfseries{\medium\@author}}%
    %
    \newcounter{tempcount}
    \setcounter{tempcount}{0}
    %
    \loop\ifnum\value{tempcount}<\theaffl@cnt
      \stepcounter{tempcount}
      \vskip \@ACESvspace
      \textsuperscript{\thetempcount}\csuse{text\thetempcount}
    \repeat
    %}}
  \end{center}
  \cleardoublepage
  \vfill
  %\null
  \endgroup}
  
% TODO --> Refine word spacing
% \fontdimen2\font=0.4ex% inter word space
% \fontdimen3\font=0.2em% inter word stretch

\setcounter {secnumdepth}{3}
\newcounter {part}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thepart 	      {\@Roman\c@part}
\renewcommand\thesection      {\@Roman\c@section}
\renewcommand\thesubsection   {\@Alph\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\part{%
   \if@noskipsec \leavevmode \fi
   \par
   \addvspace{4ex}%
   \@afterindentfalse
   \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
       \Large\bfseries \partname\nobreakspace\thepart
       \par\nobreak
     \fi
     \huge \bfseries #2%
     \markboth{}{}\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}
\def\@spart#1{%
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \huge \bfseries #1\par}%
     \nobreak
     \vskip 3ex
     \@afterheading}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {\@ACESvspace \@plus \@ACESglueStretch \@minus \@ACESglueShrink}%
                                   {.1ex}%
                                   {\normalfont\sectionsize\bfseries\centering}}%
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {\@ACESvspace \@plus \@ACESglueStretch \@minus \@ACESglueShrink}%
                                     {.1ex}%
                                     {\normalfont\normalsize\bfseries}}%
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {\@ACESvspace \@plus \@ACESglueStretch \@minus \@ACESglueShrink}%
                                     {.1ex}%
                                     {\normalfont\normalsize\bfseries}}%
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {\@ACESvspace \@plus \@ACESglueStretch \@minus \@ACESglueShrink}%
                                    {.1ex}%
                                    {\normalfont\normalsize\bfseries}}%
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {\@ACESvspace \@plus \@ACESglueStretch \@minus \@ACESglueShrink}%
                                       {.1ex}%
                                      {\normalfont\normalsize\bfseries}}%
%
% Overwrite the section format defined in latex.ltx
% to remove the space from the section numbering and the title
% and to insert the point between name and description
\def\@seccntformat#1{\csname the#1\endcsname.\ }
%
% Redefine the \@sect command defined in latex.ltx
% to remove the \@hangfrom directive that divides
% the section counter from the section title
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
	  \noindent \hskip #3\relax\@svsec%
	  \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
%
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
% Abstract
\newenvironment{abstract}{%
    \if@twocolumn
      \noindent{\bfseries{\textit\abstractname}\ --}\relax%
    \else
      \small
      \begin{center}%
	{\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
      \end{center}%
      \quotation
    \fi}
    {\if@twocolumn\else\endquotation\fi\vskip\@ACESvspace}
%
% Index Terms
\newenvironment{ACESkeywords}{%
    \if@twocolumn
      \noindent{\bfseries{\textit\ACESkeywordsname}\ --}\relax%
    \else
      \small
      \begin{center}%
	{\bfseries \ACESkeywordsname\vspace{-.5em}\vspace{\z@}}%
      \end{center}%
      \quotation
    \fi}
    {\if@twocolumn\else\endquotation\fi\vskip\@ACESvspace}
%
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
%
\if@compatibility
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi
%
\newdimen\@tmpdimenA
\newdimen\@tmpdimenB
\newdimen\@tmpdimenC
%
\newcount\@tmpcountA
\newcount\@tmpcountB
\newcount\@tmpcountC
%
\def\@tranneedspace#1#2{\penalty-100\begingroup%shield temp variable
\@tmpdimenB\pagegoal\advance\@tmpdimenB-\pagetotal% space left
\ifdim #1>\@tmpdimenB\relax% not enough space left
\ifdim\@tmpdimenB>\z@\relax #2\fi%
\newpage%
\fi\endgroup}
%
% photo area size
\def\@BIOphotowidth{1.0in}    % width of the biography photo area
\def\@BIOphotodepth{1.25in}   % depth (height) of the biography photo area
% area cleared for photo
\def\@BIOhangwidth{1.1in}    % width cleared for the biography photo area
\def\@BIOhangdepth{1.25in}    % depth cleared for the biography photo area
                                  % actual depth will be a multiple of 
                                  % \baselineskip, rounded up
\def\@BIOskipN{4\baselineskip}% nominal value of the vskip above the biography

% Biography
\newenvironment{ACESbiography}[2]{%
\unitlength 1in\parskip=0pt\par\parindent 1em\interlinepenalty500%
% we need enough space to support the hanging indent
% the nominal value of the spacer
% and one extra line for good measure
\@tmpdimenA=\@BIOhangdepth%
\advance\@tmpdimenA by \@BIOskipN%
\advance\@tmpdimenA by 1\baselineskip%
% if this page does not have enough space, break it and lets start
% with a new one
\@tranneedspace{\@tmpdimenA}{\relax}%
% nominal spacer can strech, not shrink use 1fil so user can out stretch with \vfill
% \vskip \@BIOskipN plus 1fil minus 0\baselineskip%
%
\def\@biographybox{\begin{minipage}[b][\@BIOphotodepth][c]{\@BIOphotowidth}\includegraphics[width=1in,height=1.2in,clip]{#2}\end{minipage}}%
%
\let\@BIOORGparCMD=\par% save the original \par command
\edef\par{\hfil\break\indent}% the new \par will not be a "real" \par
%
\settoheight{\@tmpdimenA}{\@biographybox}% get height of biography box
\@tmpdimenB=\@BIOhangdepth%
\@tmpcountA=\@tmpdimenB% countA has the hang depth
\divide\@tmpcountA by \baselineskip%  calculates lines needed to produce the hang depth
\advance\@tmpcountA by 1% ensure we overestimate
% set the hanging indent
\hangindent\@BIOhangwidth%
\hangafter-\@tmpcountA%
% reference the top of the photo area to the top of a capital T
\settoheight{\@tmpdimenB}{\mbox{T}}%
% set the photo box, give it zero width and height so as not to disturb anything
\noindent\makebox[0pt][l]{\hspace{-\@BIOhangwidth}\raisebox{\@tmpdimenB}[0pt][0pt]{%
\raisebox{-\@BIOphotodepth}[0pt][0pt]{\@biographybox}}}%
%
% now place the author name and begin the bio text
\noindent\textbf{#1\ }}%
{\relax\let\par=\@BIOORGparCMD\par%
\vskip \@ACESvspace \@plus \@ACESglueStretch \@minus \@ACESglueShrink}
%
% Figures and Tables
%
% Define a variable that define if we are in a table environment
% this variable is set when opening the table and table* environments
% and closed afterwards
%
\newif\if@istableenv
%
\setlength\arraycolsep{.1\p@}
\setlength\tabcolsep{2\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{1\p@}
\setlength\fboxrule{.4\p@}
\renewcommand \theequation {\@arabic\c@equation}
\newcounter{figure}
\renewcommand \thefigure {\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}
\renewcommand\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\@float{table} \@istableenvtrue}
               {\end@float \@istableenvfalse}
\newenvironment{table*}
               {\@dblfloat{table} \@istableenvtrue}
               {\end@dblfloat \@istableenvfalse}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{\@ACESvspace}
\setlength\belowcaptionskip{0\p@}
%
% Define the caption sequence in order to change the behaviour
% of the caption (Fig. 1: blablabla vs Fig. 1. blablabla)
% depending of the environment (table vs figure)
% This is based on the variable \if@istableenv
%
\long\def\@makecaptionseq#1#2{%
  \if@istableenv
    #1: #2%
  \else
    #1. #2%
  \fi}
%
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \savebox\@tempboxa[\textwidth][l]{\@makecaptionseq{#1}{#2}}%
  \ifdim \wd\@tempboxa >\hsize
    \@makecaptionseq{#1}{#2}\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{3}
\newcommand\tableofcontents{%
    \section*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty\@secpenalty
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
       \if@compatibility
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
      \fi
    \endgroup
  \fi}
\newcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{1.0em \@plus\p@}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}
\newcommand*\l@subsection{\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{7.0em}{4.1em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{10em}{5em}}
\newcommand\listoffigures{%
    \section*{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \section*{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\section*{\sectionsize\MakeUppercase\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \setlength{\parskip}{0pt}
      \setlength{\itemsep}{0pt plus 1pt}
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist%
      \vskip\@ACESvspace\vskip\@ACESvspace\vskip\@ACESvspace}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \twocolumn[\section*{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
%
% Define some section names
%
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\refname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Fig.}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
% Extra names
\def\ACESkeywordsname{Index Terms}

\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
% Remove page numbering
\pagenumbering{gobble}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\endinput