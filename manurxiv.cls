\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{manurxiv}[2021/11/20 Manuscript draft class suitable for arXivs]

% some shortcuts for quick setup of fonts
\def\f@ntload{\usepackage{lmodern}}
\DeclareOption{palladio}{\def\f@ntload{%
  \RequirePackage{tgpagella}%
  \RequirePackage[T1]{fontenc}%
  \linespread{1.05}}}
\DeclareOption{schoolbook}{\def\f@ntload{%
  \RequirePackage{tgschola}%
  \RequirePackage[T1]{fontenc}}}
\DeclareOption{libertinus}{\def\f@ntload{\RequirePackage{libertinus}}}
% there's no titlepage support
\DeclareOption{titlepage}{\PackageWarning{manurxiv}{Option `titlepage' ignored}}
% the class options are otherwise the same as with article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[notitlepage]{article}

% oh yes.
\RequirePackage{microtype}
\f@ntload

% opinion: this should be mandatory
\usepackage{booktabs}

% use authblk by default
\RequirePackage{authblk}
\renewcommand{\Affilfont}{\it\small}
\setlength{\affilsep}{1ex}

% distinguish captions of stuff visually
\usepackage[font={footnotesize,sf},labelfont=bf]{caption}

% setup line numbering
\if@twocolumn
 \RequirePackage[switch]{lineno}
\else
 \RequirePackage{lineno}
\fi
\RequirePackage{xcolor}
\renewcommand{\linenumberfont}{\tiny\color{black!33}}

% provide a bit more space between columns
\setlength\columnsep{2em}

% setup how title and abstract is printed out
\providecommand{\titlefont}{\LARGE\bfseries}
\providecommand{\abstractsep}{:\quad}
\providecommand{\abstractlabelformat}{\itshape}
\providecommand{\abstractlabel}{\begingroup\abstractlabelformat\abstractname\abstractsep\endgroup}
\def\abstract#1{\global\def\@abstract{#1}}

% normal \and from article would fail here, so we use a normal one
\def\and{\quad}

% setup the nice title format
\def\@maketitle{%
  \newpage\bgroup
    \def\thanks{\PackageWarning{manurxiv}{use authblk author structure instead of `thanks'}}
    \setlength{\parindent}{0pt}%
    {\sloppy\flushright\hyphenpenalty=10000\scriptsize\@date\par}%
    \rule{\linewidth}{.75pt}%
    {\sloppy\flushleft\titlefont\@title\par}%
    \vskip 1ex%
    {\sloppy\@author\par}%
    \vskip 1ex%
    {\footnotesize\abstractlabel\@abstract\par}%
    \rule{\linewidth}{.5pt}%
  \egroup\vskip 4ex}

% date contains "version", provide a nice command to set it up right
\providecommand{\version}[1]{\date{#1, \today}}
