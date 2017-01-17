%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%  %NAME%    : Classe permettant l'écriture rapide d'un rapport type
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
%    Les travaux de traduction de la GPL peuvent être trouvés sur le
%    site : http://www.april.org/gnu/gpl_french.html
%
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Cette classe est inspirée de beaucoup d'autres classes et styles glanés sur 
%   internet ainsi que de solutions apportées dans les newsgroup (comp.text.tex 
%   et fr.comp.text.tex) et dans les FAQ en tout genre.
%
% Cependant, je tiens particulièrement à remercier Laurent Mouillart et Nicolas
%   Roard car je me suis basé sur leur travaux pour commencer cette classe.
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
%     chapter de la table des matières
% Changement des numéro des parties pour pouvoir utilise des "part" dans le 
%     mainmatter.
% Ajout de l'option listing qui utilise le package si l'option est activée
% Ajustements pour une meilleure utilisation des frontmatter, backmatter ... 
%     avec minitoc et hyperref.
% Création de frontchapter et backchapter qui permettent de mettre à jour 
%     correctement les numéro pour apparaitre dans les minitoc, bookmarks et toc
% Changement du style de page uitilisé pour les parttoc (utilisé ici pour la
%     liste des annexes
% Ajout de la commande \fin pour donner un nom autre que Conclusions à la partie
%     backmatter dans les bookmarks (Ce nom est utilisé uniquement là).
% Correction de bugs divers
% 
%===============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% On veut pouvoir avoir des options :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Choix entre différentes polices :
\newif\ifCompMod\CompModfalse
%%%%% Pour pouvoir choisir si on veut des points dans la toc pour les chapter
\newif\ifDotted\Dottedfalse
%%%%% Pour choisir si on veut faire des listings
\newif\ifListing\Listingfalse

% computer modern : un peu plus cursive que les classiques attention
% pb avec les accents (é est en fait 'e)
\DeclareOption{cm}{\CompModtrue\def\DocFontName{computer modern}}
% Palatino : police assez classique (un peu comme times)
\DeclareOption{palatino}{\def\DocFontName{palatino}}
% Bookman : lettres assez grosses et un peu décoratives
\DeclareOption{bookman}{\def\DocFontName{bookman}}
% Times : simple fichier très petit
\DeclareOption{times}{\def\DocFontName{times}}
% type1ec : presque pareil que police cm sans pb d'accents
\DeclareOption{ec}{\def\DocFontName{type1ec}}
% utopia : plus ``arrondie'' que palatino ou times
\DeclareOption{utopia}{\def\DocFontName{utopia}}

%%%%% Autres options :
% option pour supprimer l'indentation en début de paragraphe
\DeclareOption{noindent}{\AtEndOfClass{\setlength{\parindent}{0cm}}}
% option pour que les "chapter" aient des lignes de suite dans la table des matières
\DeclareOption{dottedchapter}{\Dottedtrue}
% option pour inclure les commandes pour les listing
\DeclareOption{listings}{\Listingtrue}

% si l'option n'est pas une crée par moi, la passer à book
\DeclareOption*{%
      \PassOptionsToClass{\CurrentOption}{book}}

% par défaut on executre en 1er l'option palatino 
\ExecuteOptions{palatino}
% on execute ensuite les options passées par l'utilisateur
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
% \og et \fg sont utilisés pour les guillemets françaises

% pour gérer l'insertion de figures
\RequirePackage{graphicx}
\DeclareGraphicsExtensions{.pdf,.jpg,.png}
% pour gérer le placement des figures (et tableau ...)
\RequirePackage{float}
% pour modifier les marges facilement
\RequirePackage[pdftex,a4paper,centering]{geometry}
\RequirePackage{chngpage}
% pour pouvoir chager la profondeur de toc
\RequirePackage{tocvsec2}
% pour personnaliser les entêtes et pieds de page
\RequirePackage{fancyhdr}
% Pour avoir des ``boites'' personalisées
\RequirePackage{fancybox}
% pour pouvoir inserer des url
\RequirePackage{url}
% pour avoir des couleurs
\RequirePackage{color}
% Pour créer des tables des matières intermédiaires
\RequirePackage[french]{minitoc}
%Type d'encryptage du document (pour l'entrée du texte)
\RequirePackage[latin1]{inputenc}
%Selection de la langue du document
\RequirePackage[frenchb]{babel} \selectlanguage{french}
%\RequirePackage{xspace}


% configuration de la transformation en PDF
\pdfoutput=1
\RequirePackage[pdftex,a4paper,bookmarks=true,bookmarksnumbered=true,plainpages=false,breaklinks=true,colorlinks=true,urlcolor=black,citecolor={black},linkcolor={black}]{hyperref}
\pdfcompresslevel=9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Définitions des variables et des macros pour les modifier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macro qui permet de créer rapidement de nouvelles commandes
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
% année
\creecommande {annee}
% nom de l'auteur
\creecommande {auteur}
% type de rapport (rapport de stage, rapport préliminaire, ...)
\creecommande {typerapport}
% titre 
\creecommande {titre}
% nom du logo de l'entreprise
\creecommande {dessintitre}
% date à utiliser
\creecommande {jour}
% maitre de stage
\creecommande {maitrestage}
% tuteur de stage
\creecommande {tuteurstage}

%%%%%%%%%%%%%%%%%%%%
% Pour le document %
%%%%%%%%%%%%%%%%%%%%
% mots clefs (mots clefs pour décrire le rapport)
\creecommande {motscles}
% résumé (contient le résumé du contenu du rapport)
\creecommande {resum}
% fin contient le nom qui sera utilisé dans les bookmarks pour la partie backmatter
\def\@fin{Conclusions}
\def\fin#1{\def\@fin{#1}}

%%%%%%%%%%%%%%
% Entreprise %
%%%%%%%%%%%%%%
% logo de l'entreprise dans l'entête de page
\creecommande {hlogo}
% nom de l'image logo de entreprise
\creecommande {logoentrep}
% nom entreprise
\creecommande {nomentrep}
% adresse entreprise
\creecommande {addrentrep}

%%%%%%%%%%%%%%
% Université %
%%%%%%%%%%%%%%
% logo de l'université
\creecommande {logouniv}
% sigle de l'université
\creecommande {sigleuniv}
% nom complet univ
\creecommande {nomuniv}
% option étude
\creecommande {optionetude}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% On configure deux trois trucs ...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Définition des marges
\geometry{headheight=0cm,headsep=0cm,footskip=0.7cm,textwidth=18cm,textheight=28cm}
\setlength{\headwidth}{14.5cm}

% Espacement entre les figures et leur légende
%\setlength{\abovecaptionskip}{-2mm}
%\setlength{\belowcaptionskip}{-2mm}

% style sans serif pour les url
\urlstyle{sf}

% Seulement les chapters sont dans les part minitocs
\setcounter{parttocdepth}{0}

% Utilisation des entêtes et pieds de pages personnalisés
\pagestyle{fancy}
% Effaçage des champs
\fancyhf{}
% Entête droit
\fancyhead[R]{\utilisecommande{hlogo}{fancyhead}{\includegraphics [height=.7cm]{img/\@hlogo}}}
% Entête gauche
\fancyhead[L]{\leftmark}
% Pied de page droit
\fancyfoot[R]{\thepage}
% Pied de page gauche
\fancyfoot[L]{\utilisecommande{auteur}{fancyfoot}{\@auteur}
  \utilisecommande{sigleuniv}{fancyfoot}{~- \@sigleuniv} 
  \utilisecommande{jour}{fancyfoot}{~- \@jour}}
% Définit une ligne en dessous de l'entete
\renewcommand{\headrulewidth}{0.5pt}
% Définit une ligne au dessus du pied de page
\renewcommand{\footrulewidth}{0.5pt}

% Modification des entêtes et pieds de page pour les pages de type plain
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

% une profondeur de 3 pour la table des matières
\setcounter{tocdepth}{3}

% Modification du nom de la liste des figures.
% le AtBeginDocument permet de passer après les modifications de babel
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
    \utilisecommande{maitrestage}{logotuteur}{Maître de stage~: \@maitrestage}
  \end{minipage}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% réglage des paramètres pour la création des pdf
% à mettre dans l'entête du document
\def\docpdf{
\hypersetup{
  pdftitle={\@typerapport},
  pdfauthor={\@auteur},
  pdfsubject={\@titre},
  pdfkeywords={\@motscles}}
}

% \refer produit une référence à un document numéroté par son numéro
% et la page.
% \refer {type de document}{label du document}
\newcommand{\refer}[2]{voir #1 \ref{#2}, page \pageref{#2}}

%Permet de faire plusieurs références à une même note de bas de page
% utiliser : \footnote{ma note de bas de page\label{monLabel}}
% puis     : \refmark{antman}
\newcommand{\refmark}[1]{\footnotemark{\ref{#1}}}


% Trace une ligne de 3 cm centrée
\newcommand{\ligne}{%
\begin{center}
\begin{minipage}{3cm}
\vspace*{.2mm}
{\hrule height 0.1pt width 3cm}
\vspace*{.2mm}
\end{minipage}
\end{center}}
 
% Insère une figure simplement 
% \fig {nom_fichier}{largeur}{titre}{label}
\newcommand{\fig}[4]{
\begin{figure}[H]
\begin{center}
\includegraphics [width=#2]{img/#1}
\end{center}
\caption{#3}\label{#4}
\end{figure}}

% Insère une figure avec une rotation de 90° 
% \figrotate {nom_fichier}{largeur}{titre}{label}
\newcommand{\figrotate}[4]{
\begin{figure}[H]
\begin{center}
\includegraphics [width=#2, angle=90]{img/#1}
\end{center}
\caption{#3}\label{#4}
\end{figure}}

% Insère une figure de la largeur du texte 
% \figautowidth {nom_fichier}{titre}{label}
\newcommand{\figautowidth}[3]{
\begin{figure}[H]
\begin{center}
\includegraphics [width=\textwidth]{img/#1}
\end{center}
\caption{#2}\label{#3}
\end{figure}}

% Insère un fichier venant d'un autre répertoire
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


% insère la date de compilation et la mention qu'il a été produit avec LaTex
\newcommand{\faitparlatex}{%
  Ce rapport, produit avec \LaTeXe{}, a été compilé le~\today.}

% permet de sauter une ligne sans message d'erreur
\newcommand{\NL}{\hfill\newline}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Crée la page de titre
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
        % Double ligne inversée %
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
        \utilisecommande{maitrestage}{page de titre}{Maître de stage~: \@maitrestage}
        \hfill 
        \utilisecommande{tuteurstage}{page de titre}{Enseignant tuteur~: \@tuteurstage}%
      \end{minipage}
    \end{flushbottom}
  \end{center}
}

% Crée la page de titre d'un autre type
% avec le dessintitre centré
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


% Crée la page de garde du style classique Latex
\newcommand{\pagedegarde}{
\thispagestyle{empty} \setcounter{page}{-2} 
\maketitle
}

% Crée la page avec les cadres pour le résumé
% et les mots clés
                                %\newlength{\logowidth} 
                                %\setlength{\logowidth}{\linewidth}
\newcommand{\pagederesume}{%
  \cleardoublepage
  \phantomsection
  \pdfbookmark[0]{Résumé}{pagederesume}%
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
        {\huge\scshape\bfseries \quad Résumé :\par}
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

% Crée la page de table des matières
\newcommand{\pagedesmatieres}{
  \cleardoublepage
  \phantomsection
  \pdfbookmark[0]{\contentsname}{pagedesmatieres}
  \dominitoc
  \tableofcontents
}

% Crée la page de liste des figures
\newcommand{\pagedesfigures}{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\listfigurename}
  \listoffigures%
}

% Crée la page de bibliographie
\newcommand{\bibliographie}{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{part}{Bibliographie}
}

% Crée la page de liste des tableaux
\newcommand{\pagedestableaux}{
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{\listtablename}
  \listoftables%
}

%Crée la page de liste des sources de code (listings)
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
%    Définition de l'aspect des têtes de chapitre      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Début de la zone avec les pages de titre. Ex : 1ere page, page de garde
% page de résumé (non numérotées)
\newcommand\titlematter{%
  \setcounter{part}{-3}%
  \cleardoublepage
  \maxtocdepth{subsection}%
  \settocdepth{subsection}%
  \dominitoc
  \doparttoc
  \@mainmatterfalse}

% Début de la zone avec les pages avant le début du rapport. Ex :
% remerciments, tables des matières, listes des figures, liste des
% tableaux (pages numérotées en chiffres romains minuscules)
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

% Début de la zone avec les pages de début de rapport. Ex : introduction
% (pages se comportant comme la suite du rapport mais les chapitres ne
% sont pas numérotés)
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

% Début de la zone avec les pages du corp du rapport (pages numérotées
% normalement avec numérotation des chapitres à partir de 1)
\renewcommand\mainmatter{\settocdepth{subsection}%
  \setcounter{part}{0}%
  \setcounter{chapter}{0}
  \gdef\thesection{\thechapter.\@arabic\c@section}
  \cleardoublepage%
  \@mainmattertrue}

% Début de la zone avec la fin du corp du rapport (pages numérotées
% normalement sans numérotation des chapitres)
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

% Début de la zone avec les pages d'annexe
% Crée la page de début des annexes (avec la liste des annexes)
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
  % ici liste des annexes puisque utilisé que pour ça  
  \renewcommand{\ptctitle}{Liste des annexes}
  % Pour faire croire qu'il y a une partie annexes à minitoc
  % et par la même occasion, insérer un lien dans la TOC
  % et dans les bookmarks
  \addtocounter{part}{1}% \setcounter{part}{4}%
  %\mtcaddpart[Annexes]
  \phantomsection
  \addcontentsline{toc}{part}{Annexes}%
  \parttoc
}


% Début de la zone avec les pages se trouvant après les annexes. Ex :
% bibliographie, remerciements (numérotés à la suite des chapitres
% d'avant les annexes)
\newcommand\postappendix{\settocdepth{subsection}%
%  \setcounter{part}{6}%
  \addtocounter{part}{1}%
  \gdef\@chapapp{\chaptername}%
  \gdef\thechapter{\@arabic\c@chapter}
  \gdef\thesection{\@arabic\c@section}
  \@mainmatterfalse}

% Change l'aspect des entètes de chapitre 
% j'ai juste changé le vspace qui était trop grand
% pour mes goûts
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

% Change l'aspect de la réference à un chapitre
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}

% Pour que la reference à un chapitre dans le fichier .toc se fasse
% également avec le numero de partie (il est alors possible remettre à
% zéro les numéro de section pour les annexes
\renewcommand\theHchapter{\thepart.\arabic{chapter}}

