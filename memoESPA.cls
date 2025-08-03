%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Modèle LaTeX pour le mémoire de l'ESPA
%% Basé sur la classe de base book.cls, dans un système linux à
%% /usr/share/texmf/tex/latex/base/book.cls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\filedate{2025/07/25}
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{memoSPA}[\filedate\space Standard ESPA class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\newcommand{\TypeDoc}{empty}
\newcommand{\DocLang}{francais}
\newcommand{\WithAlgoTe}{false}
\newcommand{\TypeLic}{reserved}
\newcommand{\WithHyperref}{false}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Type de documents
\DeclareOption{memoireMaitrise}{\renewcommand{\TypeDoc}{memoireMaitrise}}
\DeclareOption{projetTutore}{\renewcommand{\TypeDoc}{projetTutore}}
\DeclareOption{projetSemestre}{\renewcommand{\TypeDoc}{projetSemestre}}
\DeclareOption{memoireLicence}{\renewcommand{\TypeDoc}{memoireLicence}}
\DeclareOption{projet}{\renewcommand{\TypeDoc}{projet}}
\DeclareOption{miniProjet}{\renewcommand{\TypeDoc}{miniProjet}}

\newcommand{\memOrPrj}{memoire}

%% Declaration de type de licence
\DeclareOption{creativecommons}{\renewcommand{\TypeLic}{creativecommons}}
%% Lien hypertexte - Algorithme - Langue
\DeclareOption{hyperref}{\renewcommand{\WithHyperref}{true}}
\DeclareOption{withAlgo2e}{\renewcommand{\WithAlgoTe}{true}}
\ProcessOptions
%% Classe d'origine book
\LoadClass{book}
\RequirePackage{mathptmx,bm}
\RequirePackage{helvet, courier}
\RequirePackage{etoolbox}
\RequirePackage{ifthen}

\RequirePackage[frenchb]{babel}

%% Packages nécessaires
\RequirePackage[utf8]{inputenc} %% Caractères accentués
\RequirePackage[T1]{fontenc} %% Fontes LaTeX pour le français
\RequirePackage{calc} %% Additions et soustractions des variables
\RequirePackage{setspace}
\RequirePackage[pdftex]{graphicx}
\RequirePackage{amsfonts,amsmath,amssymb,amsbsy,amsxtra}
\RequirePackage{longtable}
\RequirePackage{float}
\RequirePackage{listings} %% extraits de code
\RequirePackage[paper=a4paper,top=1.5in,left=1.5in,right=0.75in,bottom=0.75in, headsep=0.75in]{geometry}
\RequirePackage[labelfont={bf},margin=10pt,justification=centering]{caption}
\RequirePackage[caption=false]{subfig}
\RequirePackage{tabto}
\RequirePackage{hyphenat}
\RequirePackage{enumitem}
\RequirePackage{lipsum}
\RequirePackage{fontawesome}
%\RequirePackage{tgbonum}
\RequirePackage{pifont}
\RequirePackage[french]{nomencl}
\RequirePackage{placeins}
\RequirePackage{textcomp}
\RequirePackage{tabularx}
\RequirePackage{multirow}


%% Choix de titre du document
\newcommand{\typeRapport}{MÉMOIRE DE FIN D'ÉTUDES EN VUE DE L'OBTENTION DU DIPLÔME D'INGÉNIEUR}
\ifthenelse{\equal{\TypeDoc}{memoireMaitrise}}{\renewcommand{\typeRapport}{MÉMOIRE DE FIN D'ÉTUDES EN VUE DE L'OBTENTION DU DIPLÔME D'INGÉNIEUR}}{}
\ifthenelse{\equal{\TypeDoc}{memoireLicence}}{\renewcommand{\typeRapport}{MÉMOIRE DE FIN D'ÉTUDES EN VUE DE L'OBTENTION DU GRADE DE LICENCE}}{}
\ifthenelse{\equal{\TypeDoc}{projetSemestre}}{\renewcommand{\typeRapport}{RAPPORT DE PROJET FIN DE SEMESTRE}}{}
\ifthenelse{\equal{\TypeDoc}{projetTutore}}{\renewcommand{\typeRapport}{RAPPORT DE PROJET TUTORÉ}}{}

%% Hyperref
\ifthenelse{\equal{\WithHyperref}{true}}{
    \RequirePackage[pdftex, breaklinks=true, pdfborder={0 0 0}, bookmarks=true, bookmarksnumbered=false, bookmarksopen=true, bookmarksopenlevel=2, pdfhighlight=/O, hypertexnames=false ]{hyperref}
    \hypersetup{bookmarksdepth=subsubsection}
}{
    \RequirePackage[hyphens]{url}
    \newcommand{\href}[2]{\url{#1}}
    \newcommand{\texorpdfstring}[2]{#1}
}
\urlstyle{rm}
\RequirePackage{amsthm} % a mettre apres hyperref
\ifthenelse{\equal{\WithAlgoTe}{true}}{
    \RequirePackage[french, algochapter, linesnumbered]{algorithm2e} %boxed, 
    \SetAlCapSkip{0.5\baselineskip}
    \SetAlCapFnt{\normalfont}
    \SetAlTitleFnt{normalfont}
    \SetAlgoCaptionSeparator{\quad}
    \renewcommand{\@algocf@capt@boxed}{above}% Placement de la caption sur le dessus
}{}

\RequirePackage[square]{lib/natbibESPA} % Style de citation de l'ESPA
\RequirePackage{multibib} % Permettre plusieurs listes de références

\newcommand{\bibed}{éd}
\newcommand{\bibEd}{Éd}
\newcommand{\biburlrep}{Repéré à}
\newcommand{\bibin}{Dans}
\newcommand{\bibpres}{présentée à}
\newcommand{\bibmaster}{Mémoire }
\newcommand{\bibrap}{Rapport}

\def\@ecole{}
\newcommand{\ecole}[1]{\def\@ecole{#1}}
\def\@parcours{}
\newcommand{\parcours}[1]{\def\@parcours{#1}}
\def\@mention{}
\newcommand{\mention}[1]{\def\@mention{Mention #1}}
\def\@anneeUniversitaire{}
\newcommand{\anneeU}[1]{\def\@anneeU{Année Universitaire #1}}
\def\@promo{}
\newcommand{\promo}[1]{\def\@promo{#1}}


\pagestyle{myheadings}
\hfuzz=20pt % Se débarasser des warnings de box overfull

\ifthenelse{\equal{\TypeDoc}{memoireMaitrise}}{\renewcommand{\memOrPrj}{memoire}}{}
\ifthenelse{\equal{\TypeDoc}{memoireLicence}}{\renewcommand{\memOrPrj}{memoire}}{}
\ifthenelse{\equal{\TypeDoc}{projetTutore}}{\renewcommand{\memOrPrj}{projet}}{}
\ifthenelse{\equal{\TypeDoc}{projetSemestre}}{\renewcommand{\memOrPrj}{projet}}{}
\ifthenelse{\equal{\TypeDoc}{projet}}{\renewcommand{\memOrPrj}{projet}}{}
\ifthenelse{\equal{\TypeDoc}{miniProjet}}{\renewcommand{\memOrPrj}{projet}}{}

% Méta-données du PDF
\hypersetup{
    pdfauthor={\@author},
    pdfsubject={Mémoire de fin d'études},
    pdftitle={\@title},
    pdfkeywords={ }
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Définition de commandes pour la présentation du jury
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\genTxtEnc}{Encadreur}
\newcommand{\genTxtPres}{Président du Jury}
\newcommand{\genTxtPresF}{Présidente du Jury}
\newcommand{\genTxtExamH}{Examinateur}
\newcommand{\genTxtExamF}{Examinatrice}
\newcommand{\genTxtJury}{membre du jury}

%%% Premier encadreur
\newcommand{\encadreurA}[4]{\newcommand{\titreEncA}{#1}\newcommand{\nomEncA}{#2}\newcommand{\foncEncA}{#3}\newcommand{\isJuryA}{#4}}
%%% Deuxième Encadreur
\newcommand{\encadreurB}[4]{\newcommand{\titreEncB}{#1}\newcommand{\nomEncB}{#2}\newcommand{\foncEncB}{#3}\newcommand{\isJuryB}{#4}}
%%% Troisème Encadreur
\newcommand{\encadreurC}[4]{\newcommand{\titreEncC}{#1}\newcommand{\nomEncC}{#2}\newcommand{\foncEncC}{#3}\newcommand{\isJuryC}{#4}}
%%% Quatrième Encadreur
\newcommand{\encadreurD}[4]{\newcommand{\titreEncD}{#1}\newcommand{\nomEncD}{#2}\newcommand{\foncEncD}{#3}\newcommand{\isJuryD}{#4}}
%%% Quatrième Encadreur
\newcommand{\encadreurE}[4]{\newcommand{\titreEncE}{#1}\newcommand{\nomEncE}{#2}\newcommand{\foncEncE}{#3}\newcommand{\isJuryE}{#4}}
%%% Quatrième Encadreur
\newcommand{\encadreurF}[4]{\newcommand{\titreEncF}{#1}\newcommand{\nomEncF}{#2}\newcommand{\foncEncF}{#3}\newcommand{\isJuryF}{#4}}

%%% Président du jury
\newcommand{\president}[3]{\newcommand{\titrePres}{#1}\newcommand{\nomPres}{#2}\newcommand{\foncPres}{#3}}

%%% Premier Examinateur
\newcommand{\examinateurA}[3]{\newcommand{\titreExA}{#1}\newcommand{\nomExA}{#2}\newcommand{\foncExA}{#3}}
%%% Deuxième Examinateur
\newcommand{\examinateurB}[3]{\newcommand{\titreExB}{#1}\newcommand{\nomExB}{#2}\newcommand{\foncExB}{#3}}
%%% Troisème Examinateur
\newcommand{\examinateurC}[3]{\newcommand{\titreExC}{#1}\newcommand{\nomExC}{#2}\newcommand{\foncExC}{#3}}
%%% Quatrième Examinateur
\newcommand{\examinateurD}[3]{\newcommand{\titreExD}{#1}\newcommand{\nomExD}{#2}\newcommand{\foncExD}{#3}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Copyright: Prénom Nom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\authorcopyright#1{\gdef\@authorcopyright{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variable associée aux dates de
%% soutenance et de dépôt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\datesoutenance#1{\gdef\@datesoutenance{#1}}
\def\datedepot#1{\gdef\@datedepot{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variable pour la mise en page des chapitres dans
%% la table des matières
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength{\largChap}
\newlength{\largNum}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Marges autour des objets flottants : figures et tableaux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength\abovecaptionskip{0.5\baselineskip}
\setlength\belowcaptionskip{0.5\baselineskip}
\setlength\floatsep{1.5\baselineskip}
\setlength\textfloatsep{1.5\baselineskip}
\setlength\intextsep{1.5\baselineskip}

%%%%%%%%%%%%%%%%%%%
%% Marge la table des matières et les différentes listes
%%%%%%%%%%%%%%%%%%%
\newlength{\tocRightMargin} % Marge droite
\setlength{\tocRightMargin}{2cm}
\newlength{\tocLeftMarginSecondLine}
\setlength{\tocLeftMarginSecondLine}{6.1em} % Marge gauche pour les sections et sous sections
\newlength{\tocLeftMarginSecondLineChapter}
\setlength{\tocLeftMarginSecondLineChapter}{6.1em} % Marge gauche pour les chapitres et annexes
\newlength{\tocLeftMarginSecondLineFigure}
\setlength{\tocLeftMarginSecondLineFigure}{6.5em} % Marge gauchepour les figures
\newlength{\tocLeftMarginSecondLineAlgo}
\newlength{\tocLeftMarginSecondLineTable}
\setlength{\tocLeftMarginSecondLineTable}{7em} % Marge gauche pour les tableaux.
\setlength{\tocLeftMarginSecondLineAlgo}{8.6em} % Marge gauche pour les algos
\renewcommand{\@pnumwidth}{3em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fraction maxi des objets flottants en haut et bas de page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\floatpagefraction}{.99}
\renewcommand{\textfraction}{.01}
\renewcommand{\topfraction}{.99}
\renewcommand{\bottomfraction}{.99}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Interligne du document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\mystretch{1.5}
\def\baselinestretch{\mystretch}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Espace entre 2 paragraphes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\parskip}{12pt} % 12pt


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Pas d'indentation des paragraphes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\parindent}{0pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Pour éviter les veuves et orphelins
%% (lignes seules en début ou fin de pages)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\widowpenalty=10000
\clubpenalty=10000
\raggedbottom

%% Footnotes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength{\largFoot}
\makeatletter
\renewcommand{\@makefntext}[1]{%
	\vspace{0.5em}
 	\settowidth{\largFoot}{\up{\@thefnmark}\hspace{0.5em} }
	\parindent -\largFoot
	\setlength{\leftskip}{2.5em}
	\setlength{\rightskip}{2.5em}
	\up{\@thefnmark}\hspace{0.5em} #1
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Page titre
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\lediplome}{
    \ifthenelse{\equal{\TypeDoc}{memoireMaitrise}}{INGÉNIEUR}{}
    \ifthenelse{\equal{\TypeDoc}{memoireLicence}}{LICENCE}{}
}
\newcommand{\diplome}[1]{ \renewcommand{\lediplome}{#1}}

\renewcommand{\maketitle}{
    \newgeometry{top=2cm, bottom=2cm, left=1.5cm, right=1.5cm}
    \begin{titlepage}
        \renewcommand{\baselinestretch}{1.2}
        \begin{center}
            \includegraphics[width=3cm]{figures/logoESPA}
            \hfill\includegraphics[width=3cm]{figures/logoUNA}\\
            \parbox{10cm}{{\fontfamily{lmr}\selectfont 
            \begin{center}
                \vspace*{-4 cm}\large\textbf{REPOBLIKAN'I MADAGASIKARA}\\
                \footnotesize\textbf{FITIAVANA - TANINDRAZANA - FANDROSOANA}\\
                \vspace*{0.2 cm}
                \small\textbf{MINISTÈRE DE L'ENSEIGNEMENT SUPÉRIEUR ET DE LA RECHERCHE SCIENTIFIQUE}
            \end{center}
            }}
            \vspace{1cm}
    	\parbox{\textwidth}{\begin{center}\normalsize\large\textbf{\@ecole}\end{center} }
            \parbox{\textwidth}{\begin{center}\large\textbf{\@mention}\end{center}}
            \parbox{\textwidth}{\begin{center}\rule{\textwidth}{2pt}\\ \vspace*{-0.65 cm}\rule{\textwidth}{0.5pt}\\ \end{center}}\\
    	\vspace*{-0.7 cm}
    	\parbox{\textwidth}{\begin{center}\textbf{\typeRapport}\end{center}}\\
            \vspace*{-0.7 cm}
            \parbox{\textwidth}{\begin{center}\rule{\textwidth}{0.5pt}\\ \vspace*{-0.62 cm}\rule{\textwidth}{2pt}\\ \end{center}}
            %\vfill
		\parbox{\textwidth}{\begin{center}\large\textbf{\@parcours} \\ \end{center} }\\
            \vfill
		\parbox{\textwidth}{\begin{center}{\fontfamily{qbk}\selectfont {\Huge {\@title}} }\\ \end{center}}\\
            \vfill
            \parbox{\textwidth}{
                \begin{center}
                    Par :  \\
                    \vspace{0.3 cm}
                    \normalsize{\@author} \\
                    \vspace*{1 cm}
                    Encadreurs :\\
                    \vspace{0.3 cm}
                    \rightline{{\normalsize
                    \parbox{0.7\textwidth}{
                        \begin{itemize}[noitemsep,leftmargin=*,label=\ding{70}]
                            \item \titreEncA~\nomEncA
                            \ifdef{\nomEncB}{\item \titreEncB~\nomEncB }{}
                            \ifdef{\nomEncC}{\item \titreEncC~\nomEncC }{}
                            \ifdef{\nomEncD}{\item \titreEncD~\nomEncD }{}
                            \ifdef{\nomEncF}{\item \titreEncD~\nomEncF }{}
                            \ifdef{\nomEncG}{\item \titreEncD~\nomEncG }{}
                        \end{itemize}
                    }}}
                \end{center}
            }
            \parbox{\textwidth}{
        	\begin{center}
            	\textit{\@anneeU} \\
            	\ifthenelse{\equal{\TypeDoc}{memoireMaitrise}}{\textit{Promotion : \textbf{\@promo}}}{}
            	\ifthenelse{\equal{\TypeDoc}{memoireLicence}}{\textit{Promotion : \textbf{\@promo}}}{}
        	\end{center}
            }
        \end{center}
    \end{titlepage}
    
    \restoregeometry
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Page de présentation du jury
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\presentjury{%
    \newgeometry{top=2cm, bottom=2cm, left=1.5cm, right=1.5cm}
    \begin{jurypage}%
        \let\footnotesize\small%
        \let\footnoterule\relax%
        \begin{center}%
            
            \includegraphics[width=3cm]{figures/logoESPA}
            \hfill\includegraphics[width=3cm]{figures/logoUNA}\\
            \parbox{10cm}{{\fontfamily{lmr}\selectfont 
            \begin{center}
                \vspace*{-4 cm}\large\textbf{REPOBLIKAN'I MADAGASIKARA}\\
                \footnotesize\textbf{FITIAVANA - TANINDRAZANA - FANDROSOANA}\\
                \vspace*{0.2 cm}
                \small\textbf{MINISTÈRE DE L'ENSEIGNEMENT SUPÉRIEUR ET DE LA RECHERCHE SCIENTIFIQUE}
            \end{center}
            }}
            \vfill
            %\vspace{1cm}
    	\parbox{\textwidth}{\begin{center}\normalsize\large\textbf{\@ecole}\end{center} }
            \parbox{\textwidth}{\begin{center}\large\textbf{\@mention}\end{center}}
            \parbox{\textwidth}{\begin{center}\rule{\textwidth}{2pt}\\ \vspace*{-0.65 cm}\rule{\textwidth}{0.5pt}\\ \end{center}}\\
    	\vspace*{-0.7 cm}
    	\parbox{\textwidth}{\begin{center}\textbf{\typeRapport}\end{center}}\\
            \vspace*{-0.7 cm}
            \parbox{\textwidth}{\begin{center}\rule{\textwidth}{0.5pt}\\ \vspace*{-0.62 cm}\rule{\textwidth}{2pt}\\ \end{center}}
            %\vfill
		\parbox{\textwidth}{\begin{center}\large\textbf{\@parcours} \\ \end{center} }\\
            \vfill
		\parbox{\textwidth}{\begin{center}{\fontfamily{qbk}\selectfont {\Huge {\@title}} }\\ \end{center}}\\
            \vfill
            Par :  \\
            \normalsize{\@author} \\
            \vfill
            %\vspace{1cm}
            \renewcommand{\baselinestretch}{2}\small\normalsize
            %\textbf{PRÉSENTATION DU JURY}\\
            \ifthenelse{\equal{\typeRapport}{projet}}{
                CE PROJET A ÉTÉ ÉVALUÉ
            }{
                CE MÉMOIRE A ÉTÉ ÉVALUÉ
            }
            PAR UN JURY COMPOSÉ DE: \\
            %\vspace{6em}%
        \end{center}
        \rightline{{\normalsize
            \parbox{0.8\textwidth}{
                \begin{itemize}[noitemsep,leftmargin=*,label=\ding{71}]
                    % Président du jury
                    \ifdef{\nomPres}{\item \titrePres~\nomPres~(\foncPres)}{}
                    % Premier encadreur
                    \ifthenelse{\equal{\isJuryA}{jury}}{\item \titreEncA~\nomEncA~(\foncEncA)}{}
                    % deuxieme Encadreur optionnel
                    \ifdef{\nomEncB}{\ifthenelse{\equal{\isJuryB}{jury}}{\item  \titreEncB~\nomEncB~(\foncEncB)}{}}{}
                    % troisieme Encadreur optionnel
                    \ifdef{\nomEncC}{\ifthenelse{\equal{\isJuryC}{jury}}{\item  \titreEncC~\nomEncC~(\foncEncC)}{}}{}
                    % quatrieme Encadreur optionnel
                    \ifdef{\nomEncD}{\ifthenelse{\equal{\isJuryD}{jury}}{\item \titreEncD~\nomEncD~(\foncEncD)}{}}{}
                    % quatrieme Encadreur optionnel
                    \ifdef{\nomEncE}{\ifthenelse{\equal{\isJuryE}{jury}}{\item \titreEncE~\nomEncE~(\foncEncE)}{}}{}
                    % quatrieme Encadreur optionnel
                    \ifdef{\nomEncF}{\ifthenelse{\equal{\isJuryE}{jury}}{\item \titreEncF~\nomEncF~(\foncEncF)}{}}{}
                    % Examinateur 1
                    \ifdef{\nomExA}{\item \titreExA~\nomExA~(\foncExA)}{}
                    % Examinateur 2
                    \ifdef{\nomExB}{\item \titreExB~\nomExB~(\foncExB)}{}
                    % Examinateur 3
                    \ifdef{\nomExC}{\item \titreExC~\nomExC~(\foncExC)}{}
                    % Examinateur 4
                    \ifdef{\nomExD}{\item \titreExD~\nomExD~(\foncExD)}{}
                \end{itemize}
            }
        }}
        \begin{center}%
            %\vspace{3em}%
            \vfill
            \renewcommand{\baselinestretch}{2}\small\normalsize%
            \ifthenelse{\equal{\memOrPrj}{memoire}}{IL A FAIT L'OBJET D'UNE SOUTENANCE DEVANT JURY ET PUBLIC\\
            LE ~\MakeUppercase{\@datesoutenance}, À L'ÉCOLE SUPÉRIEURE POLYTECHNIQUE}{}
        \end{center}\par%
        \vfil%\null%

    \ifthenelse{\equal{\TypeLic}{reserved}}{%
        \fbox{\parbox{0.9\textwidth}{ %% Anciennement 6.4
            %% Interligne de 1 et taille de 10pt pour le texte
            \renewcommand{\baselinestretch}{1}\footnotesize\footnotesize
       	\copyright~Tous droits réservés
            \newline
            Cette licence signifie qu'il est interdit de reproduire, d'enregistrer ou de diffuser en tout ou en partie, le présent document.  Le lecteur qui désire imprimer ou conserver sur un autre media une partie importante de ce document, doit obligatoirement en demander l'autorisation à l'auteur.
        }}
    }{%
    }
    \ifthenelse{\equal{\TypeLic}{creativecommons}}{
        \begin{center}
        \fbox{\parbox{0.9\textwidth}{
            %% Interligne de 1 et taille de 10pt pour le texte
            \renewcommand{\baselinestretch}{1}\footnotesize\footnotesize
            \includegraphics[width=50bp]{figures/logocc}
            \newline
            Cette licence Creative Commons signifie qu'il est permis de diffuser, d'imprimer ou de sauvegarder sur un autre support une partie ou la totalité de cette oeuvre à condition de mentionner l'auteur, que ces utilisations soient faites à des fins non commerciales et que le contenu de l'oeuvre n'ait pas été modifié.
        }}
        \end{center}
    }{}
    \end{jurypage}
    \restoregeometry
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Profondeur de la numérotation des divisions des chapitres
%% Valeur de 1(\section) à 5(\subparagraph)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{secnumdepth}{5}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Changement dans la table des matières
%% des entrées associées aux chapitres
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\def\@chapter[#1]#2{
     \ifnum \c@secnumdepth >\m@ne%
       \if@mainmatter%
         \refstepcounter{chapter}%
         \typeout{\@chapapp\space\thechapter}%
            \addcontentsline{toc}{chapter}
            {%
            	\protect
            	{%
            		\texorpdfstring
            		{%
            			\numberline
            			{%
            			\protect\uppercase
            				{%
            				\@chapapp\ \thechapter%
            				}%
            			}%
            			\protect\uppercase\expandafter
            			{%
            				#1
            			}%
            		}%
            		{%
            			\@chapapp\ \thechapter\ #1%
            		}%
            	}%
            }%
       \else%
         \addcontentsline{toc}{chapter}{#1}%
       \fi%
     \else%
       \addcontentsline{toc}{chapter}{#1}%
     \fi%
  \chaptermark{#1}%
  \@makechapterhead{#2}%
  \@afterheading%
  }%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Modification des chapitres numérotés
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\@makechapterhead}[1]{{
    \thispagestyle{empty}
    \begin{center}
        \singlespacing\normalfont\normalsize\bfseries
        \etchapterheadstyle{\@chapapp{ \thechapter}} % CHAPTER 1
        ~\\~\\
        \etchapterheadstyle{#1} % TITLE OF CHAPTER
        ~\\~\\
    \end{center}
    \vspace{-\parskip}
    \vspace*{-\topskip}
    \vspace{-\parskip}
}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Modification des chapitres sans numéro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\@makeschapterhead}[1]{{
	\thispagestyle{empty}
        \begin{center}
         \singlespacing\normalfont\normalsize\bfseries
        \etchapterheadstyle{#1} % TITLE OF CHAPTER
        ~\\~\\
        \end{center}
        \vspace{-\parskip}
        \vspace*{-\topskip}
		\vspace{-\parskip}
}}

\newcommand{\etchapterheadstyle}[1]{\MakeUppercase{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Définition des espacements avant et après les différentes divisions de chapitre
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\section{\@startsection{section}{1}{\z@}{-0.25ex \@plus -1ex \@minus -.2ex}{0.5ex \@plus.2ex}{\singlespacing\normalfont\normalsize\bfseries}}

\renewcommand\subsection{\@startsection{subsection}{2}{\z@}{-0.25ex\@plus -1ex \@minus -.2ex}{0.5ex \@plus .2ex}{\singlespacing\normalfont\normalsize\bfseries}}

\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}{-0.25ex\@plus -1ex \@minus -.2ex}{0.5ex \@plus .2ex}{\singlespacing\normalfont\normalsize\bfseries}}

\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}{-0.25ex \@plus -1ex \@minus -.2ex}{0.5ex \@plus .2ex}{\singlespacing\normalfont\normalsize\bfseries}}

\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}{0.25ex \@plus1ex \@minus .2ex}{-1em}{\singlespacing\normalfont\normalsize\bfseries}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Rédéfinition de l'environnement de la page de titre
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewenvironment{titlepage}{%
    \if@twocolumn
        \@restonecoltrue\onecolumn%
    \else
        \@restonecolfalse\newpage
    \fi
    \thispagestyle{empty}%
    \setcounter{page}{1}
}
{
    \if@restonecol\twocolumn \else \newpage \fi%
    \if@twoside\else \setcounter{page}\@ne \fi%
    \thispagestyle{empty}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Définition de l'environnement de la présentation du jury
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{jurypage}{%
    \if@twocolumn
        \@restonecoltrue\onecolumn%
    \else
        \@restonecolfalse\newpage
    \fi
    \thispagestyle{empty}%
}%
{
    \if@restonecol\twocolumn \else \newpage \fi%
    \if@twoside\else%
        \setcounter{page}\@ne%
    \fi
    \thispagestyle{empty}%
    \cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{abstractTemplate}[4]{%
    \newcommand\KeyWordsName{#4}
    \newcommand\KeyWords{#3}
    \if@twocolumn
        \@restonecoltrue\onecolumn%
    \else
        \@restonecolfalse\newpage
    \fi
    \cleardoublepage
    \thispagestyle{empty}% Pas de numérotation sur cette page
    \renewcommand{\baselinestretch}{1}\small\normalsize % Interligne simple
    \begin{center}
        \normalfont%
        \MakeUppercase{\bfseries#1}%
        \\ \vspace{1\baselineskip}
        %\vskip 5.5\p@%
        \@author%
        \\ \vspace{1\baselineskip}
        %\vskip 5.5\p@%
        \MakeUppercase{\bfseries#2}%
    \end{center}
    \vspace{-\baselineskip}
}{
    \vspace{\baselineskip} %Ajout de 3 retours à la ligne avant les Mot clés
    {\KeyWordsName} % \KeyWords
    %% tabulation Nicolas Lussier-Clément 2012
    \newdimen\stringwidth
    \setbox0=\hbox{\KeyWordsName}
    {\KeyWords}
    \if@restonecol\twocolumn \else \newpage \fi%
    \cleardoublepage
}
\newenvironment{sommaire}[1]{\abstractTemplate{\@title}{RÉSUMÉ}{#1}{\bf Mots clés:}}{\endabstractTemplate}
\newenvironment{abstract}[2]{\abstractTemplate{#1}{ABSTRACT}{#2}{\bf Keywords:}}{\endabstractTemplate}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Avant-propos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{avantpropos}{%
    \chapter*{Avant-propos}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Introduction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{introduction}{%
    \cleardoublepage
    \doublespacing
    \chapter*{Introduction}
    \addcontentsline{toc}{chapter}{INTRODUCTION} % Ajout dans la table des matières
    \setcounter{page}{1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Revue de littérature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{revuedelitterature}{%
    \cleardoublepage
    \chapter*{Revue de littérature}
    \addcontentsline{toc}{chapter}{REVUE DE LITTÉRATURE} % Ajout dans la table des matières
    \stepcounter{chapter}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Conclusion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{conclusion}{%
    \doublespacing
    \chapter*{Conclusion et recommandations}
    \addcontentsline{toc}{chapter}{CONCLUSION ET RECOMMANDATIONS}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Remerciement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{remerciements}{%
    \chapter*{Remerciements}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Commande pour écrire ``Page'' dans les différentes tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\tdmpage}[0]{\hspace{\fill}\mbox{Page}\vskip 0em\par}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table des matières
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\equal{\DocLang}{english}}{
    \addto\captionsenglish{
      \renewcommand{\contentsname}%
        {Table of Contents}%
    }
}{}

\renewcommand{\@dotsep}{1} % (\@dotsep est une valeur)

\renewcommand\tableofcontents{%
    \chapter*{\contentsname}
    \tdmpage
    {
        % Espace avant les différentes lignes de la table des matières
        \setlength{\parskip}{0pt}%
        % Interligne simple pour la table des matières
        \renewcommand{\baselinestretch}{1}\small\normalsize%
        \@starttoc{toc}
    }
}
\renewcommand*\l@chapter[2]{%
    \ifnum \c@tocdepth >\m@ne%
        \settowidth{\largNum}{\hss #2}
        \addpenalty{-\@highpenalty}%
        \tolerance=9999
        \vskip 1em \@plus\p@%
        \setlength\@tempdima{6.8em}%
        \begingroup
              \parindent \z@ \rightskip \tocRightMargin%
               \parfillskip -\tocRightMargin%
              \leavevmode %
              \advance\leftskip\@tempdima%
              \hskip -\leftskip%
              \nohyphens{#1} %\nobreak
              \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
              \hfil \nobreak\hb@xt@\largNum{\hss #2}\par%
              \penalty\@highpenalty%
        \endgroup
    \fi
  }

 \renewcommand*\l@section[2]{%
    \ifnum \c@tocdepth >\m@ne%
        \settowidth{\largNum}{\hss #2}
        \addpenalty{-\@highpenalty}%
        \tolerance=9999
        \setlength\@tempdima{3.1em}%
        \begingroup
            \parindent \z@ \rightskip \tocRightMargin%
            \parfillskip -\tocRightMargin%
            \leavevmode %
            \advance\leftskip\@tempdima%
            \hskip -\leftskip%
            \nohyphens{#1} %\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
            \hfil \nobreak\hb@xt@\largNum{\hss #2}\par%
            \penalty\@highpenalty%
        \endgroup
    \fi
  }

\renewcommand*\l@subsection[2]{%
    \ifnum \c@tocdepth >\m@ne%
        \settowidth{\largNum}{\hss #2}
        \addpenalty{-\@highpenalty}%
        \tolerance=9999
        \setlength\@tempdima{3.7em}%
        \begingroup
            \parindent 3.1em \rightskip \tocRightMargin%
            \parfillskip -\tocRightMargin%
            \leavevmode %
            \advance\leftskip 6.8em%\@tempdima%
            \hskip -\leftskip%
            \nohyphens{#1} %\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
            \hfil \nobreak\hb@xt@\largNum{\hss #2}\par%
            \penalty\@highpenalty%
        \endgroup
    \fi
}

 \renewcommand*\l@subsubsection[2]{%
    \ifnum \c@tocdepth >\m@ne%
    \settowidth{\largNum}{\hss #2}
    \addpenalty{-\@highpenalty}%
        \tolerance=9999
        \setlength\@tempdima{4.3em}%
        \begingroup
            \parindent 6.8em \rightskip \tocRightMargin%
            \parfillskip -\tocRightMargin%
            \leavevmode %
            \advance\leftskip 11.1em%\@tempdima%
            \hskip -\leftskip%
            \nohyphens{#1} %\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}
            \hfil \nobreak\hb@xt@\largNum{\hss #2}\par%
            \penalty\@highpenalty%
        \endgroup
    \fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Profondeur des entrées dans la table
%% des matières: 3=\subsubsection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{tocdepth}{3}


\ifthenelse{\equal{\WithAlgoTe}{true}}{

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Liste des algorithmes
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \renewcommand\listofalgorithms{%
       \chapter*{\listalgorithmename}
       %\vskip 1\baselineskip
       \tdmpage
       {
            \setlength{\parskip}{0pt}%
            % Interligne simple pour la table des matières
            \renewcommand{\baselinestretch}{1}\small\normalsize%
            \@starttoc{loa}%
        }
    }
    
    \renewcommand \thealgocf
    {\arabic{chapter}.\@arabic\c@algocf}
    \renewcommand*\l@algocf[2]{%
        \settowidth{\largNum}{\hss #2}
        \ifnum \c@tocdepth >\m@ne%
            \addpenalty{-\@highpenalty}%
            \vskip 1.0em \@plus\p@%
            \setlength\@tempdima{3.4em}%
            \noindent%
            \begingroup
                \pretolerance=10000
                \parindent \z@ \rightskip \tocRightMargin%
                \parfillskip -\tocRightMargin%
                \leavevmode \normalsize%
                \advance\leftskip \tocLeftMarginSecondLineAlgo%
                \hskip -\leftskip%
                {\algorithmname\mbox{\hspace{4pt}}#1}%\nobreak%
                \leaders\hbox{$\m@th%
                \mkern \@dotsep mu\hbox{.}\mkern \@dotsep%
                mu$} \hfil\nobreak\hb@xt@%
                \largNum{\hss #2}\par%
                \penalty\@highpenalty%
            \endgroup
        \fi
    }
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Liste des figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\listoffigures{%
    \chapter*{\listfigurename}
    \tdmpage
    {
        \setlength{\parskip}{0pt}%
        % Interligne simple pour la table des matières
        \renewcommand{\baselinestretch}{1}\small\normalsize%
        \@starttoc{lof}%
    }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Numérotation des figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand \thefigure
     {\arabic{chapter}.\@arabic\c@figure}
\renewcommand*\l@figure[2]{%
    \settowidth{\largNum}{\hss #2}
    \ifnum \c@tocdepth >\m@ne%
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@%
    \setlength\@tempdima{3.4em}%
        \noindent%
    \begingroup
        \pretolerance=10000
        \parindent \z@ \rightskip \tocRightMargin%
        \parfillskip -\tocRightMargin%
        \leavevmode \normalsize%
        \advance\leftskip \tocLeftMarginSecondLineFigure%
        \hskip -\leftskip%
        {\figurename\mbox{\hspace{4pt}}#1}%\nobreak%
        \leaders\hbox{$\m@th%
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep%
        mu$} \hfil\nobreak\hb@xt@%
            \largNum{\hss #2}\par%
        \penalty\@highpenalty%
    \endgroup
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Liste des tableaux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\listoftables{%
    \chapter*{\listtablename}
    \tdmpage
    {
    \setlength{\parskip}{0pt}%
        % Interligne simple pour la table des matières
        \renewcommand{\baselinestretch}{1}\small\normalsize%
        \@starttoc{lot}%
    }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Numérotation des tableaux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand \thetable
     {\arabic{chapter}.\@arabic\c@table}
\renewcommand*\l@table[2]{%
    \settowidth{\largNum}{\hss #2}
    \ifnum \c@tocdepth >\m@ne%
        \addpenalty{-\@highpenalty}%
        \vskip 1.0em \@plus\p@%
        \setlength\@tempdima{3.4em}%ici pour changer l'espace entre le numero et le titre du tableau !! (défaut 2.2em)
        \noindent%
        \begingroup
            \pretolerance=10000
            \parindent \z@ \rightskip \tocRightMargin%
            \parfillskip -\tocRightMargin%
            \leavevmode \normalsize%
            \advance\leftskip \tocLeftMarginSecondLineTable %5.2em%8.4em%
            \hskip -\leftskip%
            {\tablename\mbox{\hspace{4pt}}#1}%\nobreak%
            \leaders\hbox{$\m@th%
                \mkern \@dotsep mu\hbox{.}\mkern \@dotsep%
            mu$} \hfil\nobreak\hb@xt@%
            \largNum{\hss #2}\par%
            \penalty\@highpenalty%
        \endgroup
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Liste des extraits de code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\lstlistoflistings{%
    \chapter*{\lstlistlistingname}%
    \tdmpage
    {
        \setlength{\parskip}{0pt}%
        \renewcommand{\baselinestretch}{1}\small\normalsize%
        \@starttoc{lol}%
    }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Numérotation des extraits de code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand*\l@lstlisting[2]{%
    \settowidth{\largNum}{\hss #2}
    \ifnum \c@tocdepth >\m@ne%
        \addpenalty{-\@highpenalty}%
        \vskip 1.0em \@plus\p@%
        \setlength\@tempdima{3.4em}%
        \noindent%
        \begingroup
            \pretolerance=10000
            \parindent \z@ \rightskip \tocRightMargin%
            \parfillskip -\tocRightMargin%
            \leavevmode \normalsize%
            \advance\leftskip \tocLeftMarginSecondLineFigure%
            \hskip -\leftskip%
            {\lstlistingname\mbox{\hspace{4pt}}#1}%\nobreak%
            \leaders\hbox{$\m@th%
            \mkern \@dotsep mu\hbox{.}\mkern \@dotsep%
            mu$} \hfil\nobreak\hb@xt@%
                \largNum{\hss #2}\par%
            \penalty\@highpenalty%
        \endgroup
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Liste des symboles et abbréviations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength{\descril}
\setlength{\descril}{3cm} % Taille du label par défaut
\newcommand*\losymblabel[1]{\mbox{#1}\hfill}
\newenvironment{listofabbr}[1][\descril]{%
    \cleardoublepage
    \chapter*{Liste des abréviations, sigles et acronymes}
        \begin{list}{\mbox{}}{%
            \renewcommand\makelabel\losymblabel%
            \leftmargin #1%
            \labelwidth \leftmargin%
            \labelsep    1mm
        }
}%
{\end{list}}

\newenvironment{listofsymbols}[1][\descril]{%
    \cleardoublepage
    \chapter*{Liste des symboles et unités de mesure}
    \begin{list}{\mbox{}}{%
        \renewcommand\makelabel\losymblabel%
        \leftmargin #1%
        \labelwidth \leftmargin%
        \labelsep    1mm
    }}%
  {\end{list}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Mise en forme des légendes pour les figures et tableaux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength{\largetiqfig}
\setlength{\largetiqfig}{2.2cm}
\newlength{\larglegendfig}
\setlength{\larglegendfig}{\textwidth-\largetiqfig}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\tempabovecaptionskip}   %% Pour enlever l'éspace après le caption du tableau

%%%%
% On utilise le package caption pour définir le format des légendes
%
\captionsetup[figure]{labelfont=normalfont,font=singlespacing,justification=centering,labelsep=quad,position=below}
\captionsetup[table]{labelfont=normalfont,font=singlespacing,justification=centering,labelsep=quad,position=above}

%% Les subfigures sont de la forme a), mais a en citées.
\DeclareCaptionLabelFormat{singleparens}{#2)}
\captionsetup[subfigure]{labelformat=singleparens}



\DeclareCaptionType{figureap}[Figure-A]
\captionsetup[figureap]{labelfont=normalfont,font=singlespacing,justification=centering,labelsep=quad,position=below}
\renewenvironment{figureap}[1][]{%
    % espace ajouter directement  dans le texte (a l endroit ou se trouve la figure) pour decaler vers le bas
    \vspace{0.5\baselineskip}%   % ajout decalage vers bas
    \@float{figureap}%
    \centering
}{%
    \end@float
    \vspace{-0.5\baselineskip} % supprime decalage vers bas ajout au dessus
}
\renewcommand{\thefigureap}{{\thechapter-\arabic{figureap}}}

\newsubfloat{figureap} %% Definition des subfigures en annexe

\ifthenelse{\equal{\DocLang}{francais}}
{
    \DeclareCaptionType{tableap}[Tableau-A]
}
{
    \DeclareCaptionType{tableap}[Table-A]
}
\captionsetup[tableap]{labelfont=normalfont,font=singlespacing,justification=centering,labelsep=quad,position=above}
\renewenvironment{tableap}[1][]{%
    \@float{tableap}%
    \centering
}{%
    \end@float
}
\renewcommand{\thetableap}{{\thechapter-\arabic{tableap}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Mise en forme des listes enumerate et itemize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\equal{\DocLang}{francais}}
{
    \ifdef{\ifFBStandardItemizeEnv}{\frenchbsetup{StandardItemizeEnv=true,StandardEnumerateEnv=true}}{}
}{}
% Pour enumerate, pas de décallage des puces, numérotation en lettres minuscules
\setlist[enumerate]{leftmargin=*,label=\alph*. , labelsep=1em}

% Pour itemize, pas de décallage des puces, utilisation de point
\setlist[itemize]{leftmargin=*,label=$\bullet$ , labelsep=1em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Numérotation des annexes en chiffres arabes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\appendix}{
    \par

    \setcounter{chapter}{1}%

    \gdef\@chapapp{\appendixname}%
    \renewcommand\thechapter{\Roman{chapter}}

    \newcommand{\numero}{\thesection}

    \newcommand{\changenumero}[1]{\renewcommand{\numero}{##1}}

    \renewcommand \thesection{\@arabic\c@section} % Enleve le numero du chapitre courant

    \def\sectionannexe{\@ifstar\unnumberedsection\numberedsection}

    \def\numberedsection{\@ifnextchar[%]
    \numberedsectionwithtwoarguments\numberedsectionwithoneargument}

    \def\unnumberedsection{\@ifnextchar[%]
    \unnumberedsectionwithtwoarguments\unnumberedsectionwithoneargument}

    \def\numberedsectionwithoneargument##1{\numberedsectionwithtwoarguments[##1]{##1}}

    \def\unnumberedsectionwithoneargument##1{\unnumberedsectionwithtwoarguments[##1]{##1}}

    \def\numberedsectionwithtwoarguments[##1]##2{%
        \ifhmode\par\fi
        \removelastskip
        \vskip .7ex \goodbreak
        \noindent
        \begingroup
            \leavevmode\Large\bfseries\raggedright
            \normalsize\bfseries
            \numero\quad
            ##2
            \par
        \endgroup
        \vskip .7ex \nobreak
    }

    \def\unnumberedsectionwithtwoarguments[##1]##2{%
        \ifhmode\par\fi
        \removelastskip
        \vskip .7ex\goodbreak
        \noindent
        \begingroup
            \leavevmode\normalfont\Large\bfseries\raggedright
            \leavevmode\normalfont\Large\bfseries\raggedright
            \normalsize\bfseries
            ##2
            \par
        \endgroup
        \vskip .7ex\nobreak
    }

    \def\section{\refstepcounter{section}\changenumero{\thesection.} \sectionannexe}
    
    \def\subsection{\refstepcounter{subsection}\changenumero{\thesubsection} \sectionannexe}
    
    \def\subsubsection{\refstepcounter{subsubsection}\changenumero{\thesubsubsection} \sectionannexe}
    
    \def\paragraph{\refstepcounter{paragraph}\changenumero{\theparagraph} \sectionannexe}
    
    \def\subparagraph{\refstepcounter{subparagraph}\changenumero{\thesubparagraph} \sectionannexe}
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Pour une bonne mise en page des annexes
    %% ANNEXE doit apparaitre dans la table des matieres lors de sa premiere apparition
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    \newcommand{\multiannexe}{} %%Pour le moment
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Modification des annexes numérotées        % NOUVELLE DEMANDE : PAS REPETER LE TITRE SUR LA PAGE SUIVANTE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \renewcommand{\@makechapterhead}[1]{{
        \singlespacing\normalfont\bfseries%
        \begin{center}
            \MakeUppercase{\appendixname~\thechapter} % ANNEXE 1
            \vskip 3\p@%
            \MakeUppercase{##1} % Title of annexe
        \end{center}
        \thispagestyle{empty}%
        \setcounter{section}{0}%
    
    }}
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Modification des annexes sans numéro (ne devrait pas être utilisé)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \renewcommand{\@makeschapterhead}[1]{{
        \thispagestyle{empty}
        \singlespacing \normalfont\bfseries%
        \begin{center}
            \MakeUppercase{##1} % TITLE OF ANNEXE
        \end{center}
        \vskip 5\p@%
        \thispagestyle{empty}
        \setcounter{section}{0}%
    }}
    
    \renewenvironment{figure}{\begin{figureap}}{\end{figureap}}
    \renewenvironment{table}{\begin{tableap}}{\end{tableap}}
    
    \renewcommand{\theequation}{A \thechapter-\arabic{equation}}
}

%
% Intitulés francais des figures, tableaux, etc.
%
\addto\captionsfrench{\def\figurename{{Figure}}}
\addto\captionsfrench{\def\tablename{{Tableau}}}
\addto\captionsfrench{\def\lstlistingname{{Extrait}}}
\addto\captionsfrench{\def\lstlistlistingname{{Liste des extraits de code}}}
\addto\captionsfrench{\def\algorithmname{{Algorithme}}}
\addto\captionsfrench{\def\listfigurename{{Liste des figures}}}
\addto\captionsfrench{\def\listalgorithmename{{Liste des algorithmes}}}
\addto\captionsfrench{\def\CaptionSeparator{{\space\space}}}

% Pour avoir des citations à interligne simple

\renewenvironment{quote}{
    \linespread{1}\small\normalsize\list{}{\rightmargin\leftmargin}%
    \item\relax
}{\endlist}

%
% Bonne présentation des figures et tables
%

\renewenvironment{figure}[1][]{%
    % espace ajouté directement  dans le texte (a l endroit ou se trouve la figure) pour decaler vers le bas
    \vspace{0.5\baselineskip}%   % ajout decalage vers bas
    \@float{figure}%
    \centering
}{%
    \end@float
    \vspace{-0.5\baselineskip} % supprime decalage vers bas ajout au dessus
}

\renewenvironment{table}[1][]{%
    \@float{table}%
    \centering
}{%
    \end@float
}

%
% Positionnement des flottants
% on privilégie htbp (here, top, bottom, next page)
%
\def\fps@figure{htbp}
\def\fps@table{htbp}

\def\fps@figureap{htbp}
\def\fps@tableap{htbp}

\theoremstyle{plain}
\newtheorem{definition}{Definition}[chapter]

% Présentation des auteurs et affiliations pour une thèse par articles

\newif\ifartAuthSep
\newif\ifartAffSep
\newcommand*{\articleAuthors}[2]{%
    \vspace{-4mm}
    \parbox{\textwidth}{\center
        \renewcommand{\baselinestretch}{1}\small\normalsize % Interligne simple
        \artAuthSepfalse
        \artAuthScan#1\relax
        \\~\\
        \artAffSepfalse
        \artAffScan#2\relax
    }
}

\newcommand{\artAuthScan}[1]{%
    \ifx\relax#1\empty
    \else
        \ifartAuthSep
            , \relax
        \else
            \artAuthSeptrue
        \fi
        #1\relax\expandafter\artAuthScan
    \fi
}

\newcommand{\artAffScan}[1]{%
    \ifx\relax#1\empty
    \else
        \ifartAffSep
            \\ \relax
        \else
            \artAffSeptrue
        \fi
   	#1 \relax
        \expandafter\artAffScan
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rédéfinition de \cleardoublepage pour l'impression recto-verso
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}
    \thispagestyle{empty}
    \newpage
    \if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother \clearpage{\pagestyle{empty}\cleardoublepage}
