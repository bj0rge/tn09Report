%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%  %NAME%    : Classe permettant l'�criture rapide d'un rapport type
%              rapport de stage en francais
%  %AUTHOR%  : Virginie Quesnay
%  %EMAIL%   : virginie.quesnay@free.fr
%  %VERSION% : 0.4 (29/04/2004)
%
%    Copyright (C) Virginie Quesnay
%    
%    This program is free software; you can redistribute it and/or
%    modify it under the terms of the GNU General Public License
%    as published by the Free Software Foundation; either version 2
%    of the License, or (at your option) any later version.
%    
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%    
%    You should have received a copy of the GNU General Public License
%    along with this program; if not, write to the Free Software
%    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
%
%
%    The GNU General Public License can be found on the website
%    http://www.fsf.org
%    
%    Les travaux de traduction de la GPL peuvent �tre trouv�s sur le
%    site : http://www.april.org/gnu/gpl_french.html
%
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Cette classe est inspir�e de beaucoup d'autres classes et styles glan�s sur 
%   internet ainsi que de solutions apport�es dans les newsgroup (comp.text.tex 
%   et fr.comp.text.tex) et dans les FAQ en tout genre.
%
% Cependant, je tiens particuli�rement � remercier Laurent Mouillart et Nicolas
%   Roard car je me suis bas� sur leur travaux pour commencer cette classe.
%
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\ProvidesClass{rapportiup}[2004/04/29 v0.4 rapportiup class Virginie Quesnay]
\NeedsTeXFormat{LaTeX2e}

%==============================================================================
% Changelog
%
% v0.4
%
% Ajout de la fonction \NL
% Ajout de l'option dottedchapter pour avoir des lignes de suite pour le niveau 
%     chapter de la table des mati�res
% Changement des num�ro des parties pour pouvoir utilise des "part" dans le 
%     mainmatter.
% Ajout de l'option listing qui utilise le package si l'option est activ�e
% Ajustements pour une meilleure utilisation des frontmatter, backmatter ... 
%     avec minitoc et hyperref.
% Cr�ation de frontchapter et backchapter qui permettent de mettre � jour 
%     correctement les num�ro pour apparaitre dans les minitoc, bookmarks et toc
% Changement du style de page uitilis� pour les parttoc (utilis� ici pour la
%     liste des annexes
% Ajout de la commande \fin pour donner un nom autre que Conclusions � la partie
%     backmatter dans les bookmarks (Ce nom est utilis� uniquement l�).
% Correction de bugs divers
% 
%===============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% On veut pouvoir avoir des options :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Choix entre diff�rentes polices :
\newif\ifCompMod\CompModfalse
%%%%% Pour pouvoir choisir si on veut des points dans la toc pour les chapter
\newif\ifDotted\Dottedfalse
%%%%% Pour choisir si on veut faire des listings
\newif\ifListing\Listingfalse

% computer modern : un peu plus cursive que les classiques attention
% pb avec les accents (� est en fait 'e)
\DeclareOption{cm}{\CompModtrue\def\DocFontName{computer modern}}
% Palatino : police assez classique (un peu comme times)
\DeclareOption{palatino}{\def\DocFontName{palatino}}
% Bookman : lettres assez grosses et un peu d�coratives
\DeclareOption{bookman}{\def\DocFontName{bookman}}
% Times : simple fichier tr�s petit
\DeclareOption{times}{\def\DocFontName{times}}
% type1ec : presque pareil que police cm sans pb d'accents
\DeclareOption{ec}{\def\DocFontName{type1ec}}
% utopia : plus ``arrondie'' que palatino ou times
\DeclareOption{utopia}{\def\DocFontName{utopia}}

%%%%% Autres options :
% option pour supprimer l'indentation en d�but de paragraphe
\DeclareOption{noindent}{\AtEndOfClass{\setlength{\parindent}{0cm}}}
% option pour que les "chapter" aient des lignes de suite dans la table des mati�res
\DeclareOption{dottedchapter}{\Dottedtrue}
% option pour inclure les commandes pour les listing
\DeclareOption{listings}{\Listingtrue}

% si l'option n'est pas une cr�e par moi, la passer � book
\DeclareOption*{%
      \PassOptionsToClass{\CurrentOption}{book}}

% par d�faut on executre en 1er l'option palatino 
\ExecuteOptions{palatino}
% on execute ensuite les options pass�es par l'utilisateur
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Charger la classe book :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[11pt,a4paper,oneside,openany]{book}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% On a besoin des packages suivants :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Pour les polices %%%%%
\RequirePackage[T1]{fontenc}
\ifCompMod
   \RequirePackage[cyr]{aeguill}
   \RequirePackage{type1cm}
\else
   \RequirePackage{\DocFontName}
\fi

%%%%% Pour les "dotted lines" pour chapter %%%%%
\ifDotted
	\RequirePackage{tocloft}
	\renewcommand{\cftchapdotsep}{\cftdotsep}
\fi

%%%%% Pour les listings %%%%%
\ifListing
	\RequirePackage{listings}
	\lstset{numbers=left, stepnumber=1, breaklines=true, frame=single, firstnumber=1, numberstyle=\tiny}
\fi
% Rappel :
% \og et \fg sont utilis�s pour les guillemets fran�aises

% pour g�rer l'insertion de figures
\RequirePackage{graphicx}
\DeclareGraphicsExtensions{.pdf,.jpg,.png}
% pour g�rer le placement des figures (et tableau ...)
\RequirePackage{float}
% pour modifier les marges facilement
\RequirePackage[pdftex,a4paper,centering]{geometry}
\RequirePackage{chngpage}
% pour pouvoir chager la profondeur de toc
\RequirePackage{tocvsec2}
% pour personnaliser les ent�tes et pieds de page
\RequirePackage{fancyhdr}
% Pour avoir des ``boites'' personalis�es
\RequirePackage{fancybox}
% pour pouvoir inserer des url
\RequirePackage{url}
% pour avoir des couleurs
\RequirePackage{color}
% Pour cr�er des tables des mati�res interm�diaires
\RequirePackage[french]{minitoc}
%Type d'encryptage du document (pour l'entr�e du texte)
\RequirePackage[latin1]{inputenc}
%Selection de la langue du document
\RequirePackage[frenchb]{babel} \selectlanguage{french}
%\RequirePackage{xspace}


% configuration de la transformation en PDF
\pdfoutput=1
\RequirePackage[pdftex,a4paper,bookmarks=true,bookmarksnumbered=true,plainpages=false,breaklinks=true,colorlinks=true,urlcolor=black,citecolor={black},linkcolor={black}]{hyperref}
\pdfcompresslevel=9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D�finitions des variables et des macros pour les modifier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macro qui permet de cr�er rapidement de nouvelles commandes
\newcommand{\creecommande}[1]{%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \@ifundefined{@#1}{}{%
      \ClassWarning{rapportiup}{\expandafter\protect\csname
        @#1\endcsname\space est defini plus d'une fois.}}%
    \expandafter\gdef\csname @#1\endcsname{##1}}}

% Macro qui permet d'utiliser une des nouvelle commande
\newcommand{\utilisecommande}[3]{%
  \@ifundefined{@#1}{%
    \ClassWarning{rapportiup}{\expandafter\protect\csname
        @#1\endcsname\space n'est pas defini pour l'utilisation de #2}%
  }{%
    #3}%
}
%%%%%%%%%%%%%%%%%
% Pour le stage %
%%%%%%%%%%%%%%%%%
% ann�e
\creecommande {annee}
% nom de l'auteur
\creecommande {auteur}
% type de rapport (rapport de stage, rapport pr�liminaire, ...)
\creecommande {typerapport}
% titre 
\creecommande {titre}
% nom du logo de l'entreprise
\creecommande {dessintitre}
% date � utiliser
\creecommande {jour}
% maitre de stage
\creecommande {maitrestage}
% tuteur de stage
\creecommande {tuteurstage}

%%%%%%%%%%%%%%%%%%%%
% Pour le document %
%%%%%%%%%%%%%%%%%%%%
% mots clefs (mots clefs pour d�crire le rapport)
\creecommande {motscles}
% r�sum� (contient le r�sum� du contenu du rapport)
\creecommande {resum}
% fin contient le nom qui sera utilis� dans les bookmarks pour la partie backmatter
\def\@fin{Conclusions}
\def\fin#1{\def\@fin{#1}}

%%%%%%%%%%%%%%
% Entreprise %
%%%%%%%%%%%%%%
% logo de l'entreprise dans l'ent�te de page
\creecommande {hlogo}
% nom de l'image logo de entreprise
\creecommande {logoentrep}
% nom entreprise
\creecommande {nomentrep}
% adresse entreprise
\creecommande {addrentrep}

%%%%%%%%%%%%%%
% Universit� %
%%%%%%%%%%%%%%
% logo de l'universit�
\creecommande {logouniv}
% sigle de l'universit�
\creecommande {sigleuniv}
% nom complet univ
\creecommande {nomuniv}
% option �tude
\creecommande {optionetude}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% On configure deux trois trucs ...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D�finition des marges
\geometry{headheight=0cm,headsep=0cm,footskip=0.7cm,textwidth=18cm,textheight=28cm}
\setlength{\headwidth}{14.5cm}

% Espacement entre les figures et leur l�gende
%\setlength{\abovecaptionskip}{-2mm}
%\setlength{\belowcaptionskip}{-2mm}

% style sans serif pour les url
\urlstyle{sf}

% Seulement les chapters sont dans les part minitocs
\setcounter{parttocdepth}{0}

% Utilisation des ent�tes et pieds de pages personnalis�s
\pagestyle{fancy}
% Effa�age des champs
\fancyhf{}
% Ent�te droit
\fancyhead[R]{\utilisecommande{hlogo}{fancyhead}{\includegraphics [height=.7cm]{img/\@hlogo}}}
% Ent�te gauche
\fancyhead[L]{\leftmark}
% Pied de page droit
\fancyfoot[R]{\thepage}
% Pied de page gauche
\fancyfoot[L]{\utilisecommande{auteur}{fancyfoot}{\@auteur}
  \utilisecommande{sigleuniv}{fancyfoot}{~- \@sigleuniv} 
  \utilisecommande{jour}{fancyfoot}{~- \@jour}}
% D�finit une ligne en dessous de l'entete
\renewcommand{\headrulewidth}{0.5pt}
% D�finit une ligne au dessus du pied de page
\renewcommand{\footrulewidth}{0.5pt}

% Modification des ent�tes et pieds de page pour les pages de type plain
\fancypagestyle{plain}{%
\fancyhf{}%
\fancyfoot[L]{\utilisecommande{auteur}{fancyfoot plain}{\@auteur}%
    \utilisecommande{sigleuniv}{fancyfoot plain}{~- \@sigleuniv}%
    \utilisecommande{jour}{fancyfoot plain}{~- \@jour}}%
\fancyfoot[R]{\thepage}%
\renewcommand{\headrulewidth}{0pt}%
\renewcommand{\footrulewidth}{0.5pt}}

% utilisation des commandes classiques de page de garde
\title{\@titre}
\author{\@auteur}
\date{\@jour}

% une profondeur de 3 pour la table des mati�res
\setcounter{tocdepth}{3}

% Modification du nom de la liste des figures.
% le AtBeginDocument permet de passer apr�s les modifications de babel
\AtBeginDocument{\renewcommand{\listfigurename}{Liste des illustrations}}

% Modification du style de page pour les parttoc
\renewcommand{\thispageparttocstyle}{\thispagestyle{plain}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\logoentreprise} {
\begin{minipage}{6cm}
\begin{center}
  \utilisecommande{logoentrep}{logoentreprise}{\includegraphics [width=3cm]{img/\@logoentrep}\\}
  \LARGE{\utilisecommande{nomentrep}{logoentreprise}{\textsc{\@nomentrep}\\}}
  \large{\utilisecommande{addrentrep}{logoentreprise}{\textit{\@addrentrep}\\}}
\end{center}\end{minipage}
\vspace*{5mm}
}

\newcommand{\logoauteur} {
\begin{minipage}{6cm}
\begin{center}
  \LARGE{
    \utilisecommande{auteur}{logoauteur}{\textsc{\@auteur}\\}
    \utilisecommande{sigleuniv}{logoauteur}{\textit{\@sigleuniv}\\}
    \utilisecommande{annee}{logoauteur}{\textit{\@annee}\\}
  }
\end{center}\end{minipage}
\vspace*{5mm}
}

\newcommand{\logouniversite}{
\begin{minipage}{6cm}\begin{center}%
    \utilisecommande{logouniv}{logouniversite}{\includegraphics [width=3cm]{img/\@logouniv}\\}
    \vspace{2mm}
    \utilisecommande{nomuniv}{logouniversite}{\textsc{\tiny{\@nomuniv}}}
    \vspace{1mm}\\
    \utilisecommande{optionetude}{logouniversite}{\textit{\@optionetude}}
    \vspace{1mm}\\
  \end{center}\end{minipage}}

\newcommand{\logotuteurs}{
  \begin{minipage}{7cm}
    \utilisecommande{tuteurstage}{logotuteur}{Enseignant tuteur~: \@tuteurstage \\}     
    \utilisecommande{maitrestage}{logotuteur}{Ma�tre de stage~: \@maitrestage}
  \end{minipage}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% r�glage des param�tres pour la cr�ation des pdf
% � mettre dans l'ent�te du document
\def\docpdf{
\hypersetup{
  pdftitle={\@typerapport},
  pdfauthor={\@auteur},
  pdfsubject={\@titre},
  pdfkeywords={\@motscles}}
}

% \refer produit une r�f�rence � un document num�rot� par son num�ro
% et la page.
% \refer {type de document}{label du document}
\newcommand{\refer}[2]{voir #1 \ref{#2}, page \pageref{#2}}

%Permet de faire plusieurs r�f�rences � une m�me note de bas de page
% utiliser : \footnote{ma note de bas de page\label{monLabel}}
% puis     : \refmark{antman}
\newcommand{\refmark}[1]{\footnotemark{\ref{#1}}}


% Trace une ligne de 3 cm centr�e
\newcommand{\ligne}{%
\begin{center}
\begin{minipage}{3cm}
\vspace*{.2mm}
{\hrule height 0.1pt width 3cm}
\vspace*{.2mm}
\end{minipage}
\end{center}}
 
% Ins�re une figure simplement 
% \fig {nom_fichier}{largeur}{titre}{label}
\newcommand{\fig}[4]{
\begin{figure}[H]
\begin{center}
\includegraphics [width=#2]{img/#1}
\end{center}
\caption{#3}\label{#4}
\end{figure}}

% Ins�re une figure avec une rotation de 90� 
% \figrotate {nom_fichier}{largeur}{titre}{label}
\newcommand{\figrotate}[4]{
\begin{figure}[H]
\begin{center}
\includegraphics [width=#2, angle=90]{img/#1}
\end{center}
\caption{#3}\label{#4}
\end{figure}}

% Ins�re une figure de la largeur du texte 
% \figautowidth {nom_fichier}{titre}{label}
\newcommand{\figautowidth}[3]{
\begin{figure}[H]
\begin{center}
\includegraphics [width=\textwidth]{img/#1}
\end{center}
\caption{#2}\label{#3}
\end{figure}}

% Ins�re un fichier venant d'un autre r�pertoire
% \import{repertoire}{nom_fichier}

\def\import{\begingroup
  \protected@edef\@tempa{\endgroup
    \noexpand\@import{\@ifundefined{input@path}{}{\input@path}}%
    {\@ifundefined{Ginput@path}{}{\Ginput@path}}}%
  \@tempa}
\def\@import#1#2#3#4{%
  \def\input@path{{#3}#1}\def\Ginput@path{{#3}#2}%
  \input{#4}%
  \def\input@path{#1}\ifx\input@path\@empty \let\input@path\@undefined \fi
  \def\Ginput@path{#2}\ifx\Ginput@path\@empty \let\Ginput@path\@undefined \fi
}


% ins�re la date de compilation et la mention qu'il a �t� produit avec LaTex
\newcommand{\faitparlatex}{%
  Ce rapport, produit avec \LaTeXe{}, a �t� compil� le~\today.}

% permet de sauter une ligne sans message d'erreur
\newcommand{\NL}{\hfill\newline}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cr�e la page de titre
\newcommand{\pagedetitre}{
  \cleardoublepage
    \thispagestyle{empty} \setcounter{page}{-4}
    \begin{center} 
      \begin{minipage}{17.5cm}
      \logoentreprise \hfill \logoauteur
        \begin{center}
          \vfill
        % Double ligne %
        \vspace*{6cm}
        {\hrule height 1.5pt}
        \vspace*{1mm}
        {\hrule height 0.1pt}
        \vspace*{2mm}
        %%%%%%%%%%%%%%%
        \vspace{1cm}
        \utilisecommande{typerapport}{page de titre}{\huge{\textsc{\@typerapport}}\\}
        \utilisecommande{titre}{page de titre}{\Large{\@titre}}
        \vspace{1cm}
        % Double ligne invers�e %
        \vspace*{2mm}
        {\hrule height 0.1pt}
        \vspace*{1mm}
        {\hrule height 1.5pt}
        \vspace*{4cm}
        %%%%%%%%%%%%%%%%
        \vfill
      \end{center}
    \end{minipage}\\
    \begin{flushbottom}
      \vfill
      \begin{minipage}{17.5cm}
        \utilisecommande{maitrestage}{page de titre}{Ma�tre de stage~: \@maitrestage}
        \hfill 
        \utilisecommande{tuteurstage}{page de titre}{Enseignant tuteur~: \@tuteurstage}%
      \end{minipage}
    \end{flushbottom}
  \end{center}
}

% Cr�e la page de titre d'un autre type
% avec le dessintitre centr�
\newcommand{\pagedetitrefun}{
  \cleardoublepage%
  \thispagestyle{empty}%
  \setcounter{page}{-3}%
  \begin{center}%
    \begin{minipage}{17.5cm}
      \logoentreprise \hfill \logoauteur
        \vspace*{2cm}
        \begin{center}
          \utilisecommande{typerapport}{pagedetitrefun}{\huge{\textsc{\@typerapport}}\\}
          \Large{\@titre}
         \vspace*{5mm}
         \begin{figure}[H]
            \begin{center}
              \utilisecommande{dessintitre}{pagedetitrefun}{\includegraphics [height=12cm]{img/\@dessintitre}}
            \end{center}
          \end{figure}
          \vspace*{1cm}
        %%%%%%%%%%%%%%%%
        \end{center}
      \end{minipage}\\
      \begin{flushbottom}
        \vfill
        \begin{minipage}{17.5cm}
          \logotuteurs \hfill \logouniversite
      \end{minipage}
    \end{flushbottom}
  \end{center}
}


% Cr�e la page de garde du style classique Latex
\newcommand{\pagedegarde}{
\thispagestyle{empty} \setcounter{page}{-2} 
\maketitle
}

% Cr�e la page avec les cadres pour le r�sum�
% et les mots cl�s
                                %\newlength{\logowidth} 
                                %\setlength{\logowidth}{\linewidth}
\newcommand{\pagederesume}{%
  \cleardoublepage
  \phantomsection
  \pdfbookmark[0]{R�sum�}{pagederesume}%
  \thispagestyle{empty}%
  \setcounter{page}{-1}%
                                %  \makebox[\logowidth]{\logoentreprise  \hfill  \logoauteur}%
  \makebox[\linewidth]{\logoentreprise  \hfill  \logoauteur}%
  \vspace{\stretch{1}}%
  \begin{center}
    \fboxsep=10pt
    \Ovalbox{%
      \parbox[h][10cm][t]{14.5cm}{%
        \parindent=0pt
        \parskip  =5pt
        {\huge\scshape\bfseries \quad R�sum� :\par}
        {\Large\strut \utilisecommande{resum}{pagederesume}{\@resum} \strut\par}}}%
    \par\vspace{1cm}%
    \Ovalbox{%
      \parbox[h][4cm][t]{14.5cm}{%
        \parindent=0pt
        \parskip  =5pt
        {\huge\scshape\bfseries \quad Mots-clefs :\par}
        {\Large\strut \utilisecommande{motscles}{pagederesume}{\@motscles} \strut\par}}}%
  \end{center}%
  \vspace*{\stretch{1}}}

% Cr�e la page de table des mati�res
\newcommand{\pagedesmatieres}{
  \cleardoublepage
  \phantomsection
  \pdfbookmark[0]{\contentsname}{pagedesmatieres}
  \dominitoc
  \tableofcontents
}

% Cr�e la page de liste des figures
\newcommand{\pagedesfigures}{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\listfigurename}
  \listoffigures%
}

% Cr�e la page de bibliographie
\newcommand{\bibliographie}{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{part}{Bibliographie}
}

% Cr�e la page de liste des tableaux
\newcommand{\pagedestableaux}{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\listtablename}
  \listoftables%
}

%Cr�e la page de liste des sources de code (listings)
\ifListing
	\renewcommand{\lstlistlistingname}{Liste des codes sources}
	\renewcommand{\lstlistingname}{Source}
	
	\newcommand{\pagedessources}{
	  \cleardoublepage
	  \phantomsection
	  \addcontentsline{toc}{chapter}{\lstlistlistingname}
	  \lstlistoflistings%
	}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    D�finition de l'aspect des t�tes de chapitre      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D�but de la zone avec les pages de titre. Ex : 1ere page, page de garde
% page de r�sum� (non num�rot�es)
\newcommand\titlematter{%
  \setcounter{part}{-3}%
  \cleardoublepage
  \maxtocdepth{subsection}%
  \settocdepth{subsection}%
  \dominitoc
  \doparttoc
  \@mainmatterfalse}

% D�but de la zone avec les pages avant le d�but du rapport. Ex :
% remerciments, tables des mati�res, listes des figures, liste des
% tableaux (pages num�rot�es en chiffres romains minuscules)
\newcommand\beforefrontmatter{%
  \setcounter{part}{-2}%
  \cleardoublepage
  \pagenumbering{roman}
  \setcounter{page}{1}
  %options de changetext : \changetext{textheight}{textwidth}{evensidemargin}{oddsidemargin}{columnsep}
  \changetext{-5cm}{-3.5cm}{1.5cm}{1.5cm}{0.5cm}
%  \setlength{\bottom}{2cm}
  \setlength{\headheight}{1.5cm}
  \setlength{\headsep}{1cm}
  \setlength{\footskip}{1.5cm}
  %\geometry{left=3cm,top=1.5cm,right=1.5cm,bottom=2cm,headheight=1.5cm,headsep=1cm,footskip=1.5cm}
}

% D�but de la zone avec les pages de d�but de rapport. Ex : introduction
% (pages se comportant comme la suite du rapport mais les chapitres ne
% sont pas num�rot�s)
\renewcommand\frontmatter{%
  \newcounter{frontchap}
  \setcounter{frontchap}{1}
  \setcounter{part}{-1}%
  \gdef\thesection{\@arabic\c@section}
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{arabic}
  \setcounter{page}{1}}

%% Commande de chapitre pour ceux qui se trouvent dans le frontmatter
\newcommand{\frontchapter}[2]{
	\setcounter{section}{0}%
	\chapter{#1}\label{#2}
	\setcounter{chapter}{\c@frontchap}
	\addtocounter{frontchap}{1}
}

% D�but de la zone avec les pages du corp du rapport (pages num�rot�es
% normalement avec num�rotation des chapitres � partir de 1)
\renewcommand\mainmatter{\settocdepth{subsection}%
  \setcounter{part}{0}%
  \setcounter{chapter}{0}
  \gdef\thesection{\thechapter.\@arabic\c@section}
  \cleardoublepage%
  \@mainmattertrue}

% D�but de la zone avec la fin du corp du rapport (pages num�rot�es
% normalement sans num�rotation des chapitres)
\renewcommand\backmatter{%
  \cleardoublepage
  \newcounter{backchap}
  \setcounter{backchap}{1}
  \setcounter{chapter}{0}%
  \gdef\thesection{\@arabic\c@section}
  \@mainmatterfalse
\addtocounter{part}{1}
\phantomsection
\pdfbookmark[-1]{\@fin}{\@fin}
\adjustptc
}

\newcommand{\backchapter}[2]{
	\setcounter{section}{0}%
	\chapter{#1}\label{#2}
	\setcounter{chapter}{\c@backchap}
	\addtocounter{backchap}{1}
}

% D�but de la zone avec les pages d'annexe
% Cr�e la page de d�but des annexes (avec la liste des annexes)
\newcommand{\annexes}{%
%  \adjustptc
  \cleardoublepage
  \settocdepth{chapter}%
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}
  \gdef\thesection{\thechapter.\@arabic\c@section}
  \@mainmattertrue  
  % change le nom des part minitocs 
  % ici liste des annexes puisque utilis� que pour �a  
  \renewcommand{\ptctitle}{Liste des annexes}
  % Pour faire croire qu'il y a une partie annexes � minitoc
  % et par la m�me occasion, ins�rer un lien dans la TOC
  % et dans les bookmarks
  \addtocounter{part}{1}% \setcounter{part}{4}%
  %\mtcaddpart[Annexes]
  \phantomsection
  \addcontentsline{toc}{part}{Annexes}%
  \parttoc
}


% D�but de la zone avec les pages se trouvant apr�s les annexes. Ex :
% bibliographie, remerciements (num�rot�s � la suite des chapitres
% d'avant les annexes)
\newcommand\postappendix{\settocdepth{subsection}%
%  \setcounter{part}{6}%
  \addtocounter{part}{1}%
  \gdef\@chapapp{\chaptername}%
  \gdef\thechapter{\@arabic\c@chapter}
  \gdef\thesection{\@arabic\c@section}
  \@mainmatterfalse}

% Change l'aspect des ent�tes de chapitre 
% j'ai juste chang� le vspace qui �tait trop grand
% pour mes go�ts
\def\@makechapterhead#1{%
  \vspace*{15\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \huge\bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
  }}
\def\@makeschapterhead#1{%
  \vspace*{15\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}

% Change l'aspect de la r�ference � un chapitre
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}

% Pour que la reference � un chapitre dans le fichier .toc se fasse
% �galement avec le numero de partie (il est alors possible remettre �
% z�ro les num�ro de section pour les annexes
\renewcommand\theHchapter{\thepart.\arabic{chapter}}

