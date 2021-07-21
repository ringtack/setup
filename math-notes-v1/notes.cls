%MIT License

%Copyright (c) 2020 Dev

%Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

%The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%SOFTWARE.

% The project can be found at 
% https://github.com/dev-aditya/LaTeX-template


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{math-notes-v1/notes}[2020/11/01 notes class]
\LoadClass[a4paper,oneside]{book}

%%%%%%%%%% Default Package %%%%%%%%%%%%%
\RequirePackage{math-notes-v1/color-env}
%%%%%%%%%% %%%%%%%%%%%%%%% %%%%%%%%%%%%%

%%%%%%%%%% Required Packages %%%%%%%%%%%%%
\RequirePackage{background}
\RequirePackage[object=vectorian]{pgfornament} %% used in title.tex

\RequirePackage{lipsum}  %% for dummy text 

\RequirePackage{subfiles}

\RequirePackage{amssymb,amsmath,amsfonts, dsfont}  %%% for maths

\RequirePackage{caption}
\captionsetup{labelformat=empty}%% for better captioning

\RequirePackage{booktabs} %% for top/bottomrule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[
backend=biber,
style=numeric,
citestyle=numeric-comp ,
sorting=none 
]{biblatex}
\RequirePackage{csquotes}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{lmodern}
\RequirePackage[english]{babel}
\RequirePackage{geometry}
\geometry{margin=1.5in}
\hypersetup{
	colorlinks=true,
	linkcolor=blue,
	filecolor=magenta,      
	urlcolor=cyan,
}

%\RequirePackage[]{fncychap}
\RequirePackage{xpatch}
\RequirePackage{blindtext}
\RequirePackage{graphics}
\RequirePackage{xcolor}

\makeatletter
\def\thickhrulefill{\leavevmode\leaders \hrule height 1pt \hfill \kern \z@}
\def\@makechapterhead#1{%
  %\vspace*{60\p@}%
  {\parindent \z@ \centering
          {\color{black}
            \scshape \Large \textbf{\@chapapp{} \thechapter} 
		  }
		  \par\nobreak
		  \thickhrulefill
        \par\nobreak
        \interlinepenalty\@M
	{\Huge \bf #1 \par}
    \thickhrulefill
    %\par\nobreak
    \vskip 40\p@
  }}
\makeatother

\makeatletter
\xpatchcmd{\@makeschapterhead}{%
  \Huge \bfseries  #1\par\nobreak%
}{%
  \Huge \bfseries\centering #1\par\nobreak%
}{\typeout{Patched makeschapterhead}}{\typeout{patching of @makeschapterhead failed}}

\xpatchcmd{\@makechapterhead}{%
  \huge\bfseries \@chapapp\space \thechapter
}{%
  \huge\bfseries\centering \@chapapp\space \thechapter
}{\typeout{Patched @makechapterhead}}{\typeout{Patching of @makechapterhead failed}}

\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\def\@seccntformat#1{\@ifundefined{#1@cntformat}%
	{\csname the#1\endcsname\quad}%      default
	{\csname #1@cntformat\endcsname}}%   individual control
\newcommand{\section@cntformat}{\S\thesection\quad}
\newcommand{\subsection@cntformat}{\S\thesubsection\quad}
\newcommand{\subsubsection@cntformat}{\S\thesubsubsection\quad}
\makeatletter


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength\parindent{0pt}
\let\mathbb\mathds
\let\mc\mathcal
\newcommand{\Z}{\mathds{Z}}
\newcommand{\N}{\mathds{N}}
\newcommand{\R}{\mathds{R}}
\newcommand{\C}{\mathds{C}}
\newcommand{\Q}{\mathds{Q}}
\newcommand{\I}{\mathds{I}}
\newcommand{\F}{\mathds{F}}
\newcommand{\HH}{\mathds{H}}
\newcommand{\D}{\mathcal{D}}

\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\Span}{span}
\DeclareMathOperator{\Null}{null}
\DeclareMathOperator{\range}{range}
\DeclareMathOperator{\Char}{char}
\DeclareMathOperator{\GL}{GL}
\DeclareMathOperator{\SL}{SL}

%%%%%%%%%% Ease of Background generation %%%%%%%%%%

%%%%%%%%%% Ease of title generation %%%%%%%%%%

%%%%% Helper commands for background/title %%%%%
\newcommand{\makebackground}{\backgroundsetup{
    scale=1,
    opacity=1,
    angle=0,
    color=black,
    contents={\begin{tikzpicture}[color=black, every node/.style={inner sep= 15pt}]
      \node (NW) [anchor=north west] at (current page.north west){\pgfornament[width=2.5cm] {131}};
      \node (NE) [anchor=north east] at (current page.north east){\pgfornament[width=2.5cm, symmetry=v]{131}};
      \node (SW) [anchor=south west] at (current page.south west){\pgfornament[width=2.5cm, symmetry=h]{131}};
      \node (SE) [anchor=south east] at (current page.south east){\pgfornament[width=2.5cm, symmetry=c]{131}};
      \foreach \i in {-4,0,4}
      \node[anchor=north,xshift=\i cm] at (current page.north){\pgfornament[scale=0.25,symmetry=v]{71}};
      \foreach \i in {-4,0,4}
      \node[xshift=\i cm, yshift=32.25 pt] at (current page.south){\pgfornament[scale=0.25,symmetry=v]{71}};
      \foreach \i in {-8,-4,0,4,8}
      \node[yshift=\i cm, xshift=32.25pt, rotate=90] at (current page.west){\pgfornament[scale=0.25,symmetry=v]{71}};
      \foreach \i in {-8,-4,0,4,8}
      \node[yshift=\i cm, xshift=-32.25pt, rotate=90] at (current page.east){\pgfornament[scale=0.25,symmetry=v]{71}};
      \foreach \i in {-11,-9,...,7,9}
      \node[anchor=west, yshift=\i cm, xshift=52.25pt, rotate=90] at (current page.west){\pgfornament[scale=0.1]{80}};
      \foreach \i in {-11,-9,...,7,9}
      \node[anchor=east, yshift=\i cm, xshift=-52.25pt, rotate=-90] at (current page.east){\pgfornament[scale=0.1]{80}};
    \end{tikzpicture}
    }
  }
}


\newcommand{\maketitleinfo}[3]{%------------------------------------------------
  %	Title
  %------------------------------------------------

  % \rule{\textwidth}{1.6pt}\vspace*{-\baselineskip}\vspace*{2pt} % Thick horizontal rule
  \rule{\textwidth}{0.4pt} % Thin horizontal rule

  \vspace{0.75\baselineskip} % Whitespace above the title
  {\huge {#1}\\} % Title

  \vspace{0.75\baselineskip} % Whitespace below the title

  \rule{\textwidth}{0.4pt}\vspace*{-\baselineskip}\vspace{3.2pt} % Thin horizontal rule
  %\rule{\textwidth}{1.6pt} % Thick horizontal rule

  \vspace{2\baselineskip} % Whitespace after the title block

  %------------------------------------------------
  %	Subtitle
  %------------------------------------------------

  \LARGE{#2} 

  \vspace*{3\baselineskip} % Whitespace under the subtitle



  \vspace{0.5\baselineskip} 

  {\scshape   \LARGE #3\ }

  \vspace{0.2\baselineskip} 

  \textit{\Large Brown University} 

  \vfill 
  %------------------------------------------------
  % Author
  %------------------------------------------------

  \begin{figure}[!h]
      \centering
      \includegraphics[width = 3cm]{\string~/Desktop/Brown/BrownLogo.png}
  \end{figure}
  \vspace{0.3\baselineskip} 
  {\large Edited by \\  Richard Tang}
}

%%%%% Title page generator %%%%%
\newcommand{\maketitlepage}[3]{\begin{titlepage}
    %%%%% make background %%%%%
    \makebackground

    %%%%% Format title page %%%%%
    \centering % Centre everything on the title page
    \scshape % Use small caps for all text on the title page
    \vspace*{\baselineskip} % White space at the top of the page

    %%%%% Add relevant info %%%%%
    \maketitleinfo{#1}{#2}{Professor #3}
  \end{titlepage}
  
  %%%%% Get ready for next section
  \newpage 
  \backgroundsetup{contents={}} %% to remove background and watermark from other pages
  \tableofcontents %% Generate ToC
  \newpage
}


%%%%%%%%%% Ease of bibliography generation %%%%%%%%%%
\newcommand{\makebibliography}{\pagebreak

  \medskip

  \printbibliography[heading=bibintoc,title={\centering Bibliography}]
}
