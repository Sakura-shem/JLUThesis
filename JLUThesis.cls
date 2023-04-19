%% start of file `JLUThesis.cls'.
%% Copyright 2022 Shem(shenjl2419@mails.jlu.edu.cn).
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License version 1.3c,
% available at http://www.latex-project.org/lppl/.


%-------------------------------------------------------------------------------
%                标识
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{JLUThesis}[2014/06/10 v1.1 Beijing Jiaotong University Thesis document class]
\LoadClass[UTF8, oneside, a4paper]{ctexbook}       % 论文使用A4纸，默认小四号字体

\RequirePackage{xcolor}
\RequirePackage{tocloft}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{setspace}
% font 
\RequirePackage{fontspec}
% cover
\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage{tabularray}

% 字体
\setmainfont[UprightFont=*,]{Times New Roman}
\setCJKfamilyfont{cusong}[Path=fonts/, AutoFakeBold = {2.17}]{SimSun.ttf}
\renewcommand*{\songti}{\CJKfamily{cusong}}
% 1.5 倍行距
\renewcommand{\baselinestretch}{1.5}

% 版面上空2.5cm，下空2cm，左空2.8cm，右空1.8cm
\geometry{a4paper, top = 25mm, bottom = 25mm, left = 28mm, right = 18mm}


%-------------------------------------------------------------------------------
%                加载配置文件
%-------------------------------------------------------------------------------
\input{JLUThesis.cfg}


%-------------------------------------------------------------------------------
%                封面设计
%-------------------------------------------------------------------------------
\newcommand{\clearpagebyprint}{\if@twoside\cleardoublepage\else\clearpage\fi}
\newcommand{\fillinblank}[2]{\CJKunderline{\makebox[#1]{#2}}}
\newcommand{\makecover}{
    \begin{titlepage}
        \newcommand{\HRule}{\rule{\linewidth}{1mm}}
        \quad \\[0.42cm]
        {\centering\includegraphics[width = 0.8\textwidth]{figures/logo.png}\\[0.77cm] }
        \center 
        \songti \zihao{-0} \bfseries 本科生毕业论文（设计）   \\[1.55cm]

        % \songti \zihao{3} \bfseries 中文题目 \hspace{-0.35cm} \underline{\makebox[10cm]{\songti \zihao{3} \cover@ctitle}}  \\[3pt]
        %                             \hspace{2cm}    \underline{\makebox[10cm]{}}  \\
        % 中文题目
        \hspace{1.2cm}
        \begin{tabular}{cp{3.8in}}
            \bfseries \fontsize{16pt}{16pt} \songti 中文题目 \hspace{-0.4cm} & \vspace{-1pt} \multirow[t]{2}{3.8in}
            {
                \setstretch{0.2}
                \centering
                \fontsize{16pt}{16pt}
                \songti
                \hspace{-0.4cm}
                \cover@ctitle
                \hspace{-0.2cm}
            }  \\
            % 下划线和文字
            \addlinespace[-17.5pt]
            \cline{2-2}
                    & \\[-1.1cm]
            \cline{2-2}
        \end{tabular}\hspace*{\fill} \\[-0.5cm]
        
        % 英文题目
        \hspace{1.2cm}
        \begin{tabular}{cp{3.8in}}
            \bfseries \fontsize{16pt}{16pt} \songti 英文题目 \hspace{-0.4cm} & \vspace{-0.1cm} \multirow[t]{2}{3.8in}
            {
                \setstretch{1.1}
                \centering
                \zihao{4}
                \hspace{-0.4cm}
                \cover@etitle
                \hspace{-0.2cm}
            }  \\
            % 下划线和文字
            \addlinespace[-18pt]
            \cline{2-2}
                    & \\[-1.1cm]
            \cline{2-2}
        \end{tabular}\hspace*{\fill} \\[3cm]
        
        \songti \zihao{3} \bfseries 学生姓名            \underline{\makebox[10cm]{\cover@author}}  \\[3pt]
        \songti \zihao{3} \bfseries 学\hspace{2em}号    \underline{\makebox[10cm]{\cover@studentid}}  \\[3pt]
        \songti \zihao{3} \bfseries 学\hspace{2em}院    \underline{\makebox[10cm]{\cover@school}}  \\[3pt]
        \songti \zihao{3} \bfseries 专\hspace{2em}业    \underline{\makebox[10cm]{\cover@major}}  \\[3pt]
        \songti \zihao{3} \bfseries 指导教师            \underline{\makebox[10cm]{\cover@mentor}} \\[1.3cm]
        
        {\songti \zihao{3} \bfseries \cover@time}
        \vfill 
    \end{titlepage}
}

\newcommand{\upcite}[1]{\textsuperscript{\textsuperscript{\cite{#1}}}}


%-------------------------------------------------------------------------------
%                页眉页脚设计
%-------------------------------------------------------------------------------
\setlength{\voffset}{-15mm}
\setlength{\topmargin}{0mm}
\setlength{\headheight}{20pt}
\setlength{\headsep}{5mm}
\setlength{\footskip}{15mm}

\fancypagestyle{style@empty}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{style@onlyfoot}{
    \fancyhf{}
	\fancyfoot[R]{\zihao{-5} \thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{style@gray}{
    \fancyhf{}
	\fancyfoot[R]{\color{gray} \zihao{-5} \thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{style@normal}{
	\fancyhead{}
	\fancyhead[C]{\zihao{-5} \songti \leftmark}
	\fancyfoot{}
	\fancyfoot[R]{\zihao{-5} \thepage}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0pt}
    \renewcommand{\headruleskip}{2.5pt}
}


%-------------------------------------------------------------------------------
%                承诺书
%-------------------------------------------------------------------------------
\newcommand{\commitment}[0]{
    \setlength{\baselineskip}{30pt}
    \chapter*{\zihao{-2} \songti \commitment@title}
    % \addcontentsline{toc}{chapter}{\commitment@title}
    \vspace{1.5cm}
    {\zihao{4} \songti \commitment@content} \\[10cm]
    \leftline{\zihao{4} \songti \hspace{4cm} \commitment@sign} \\
    \rightline{\zihao{4} \songti \commitment@time \hspace{2cm}}
    \vfill
}


%-------------------------------------------------------------------------------
%                摘要
%-------------------------------------------------------------------------------
\newcommand{\cbox}[2]{
    \begin{flushleft}
        \zihao{-4} \songti {\bfseries {#1}} 
    \end{flushleft}
    \vspace{-0.93cm}
    \newlength{\cboxwidth}
    \settowidth{\cboxwidth}{#1}
    \hspace{\cboxwidth} \parbox[m][2em][t]{30em}{\zihao{-4} \songti #2}
    \vfill
}
\newcommand{\ebox}[2]{
    \begin{flushleft}
        \zihao{-4} \songti {\bfseries {#1}} 
    \end{flushleft}
    \vspace{-0.88cm}
    \newlength{\eboxwidth}
    \settowidth{\eboxwidth}{#1}
    \hspace{\eboxwidth} \hspace{0.3cm} \parbox[m][2em][t]{37em}{\zihao{-4} \songti #2}
    \vfill
}
\newcommand{\baseabstract}[2]{
    \setlength{\baselineskip}{20pt}
    \chapter*{\zihao{3} \songti \bfseries #1}
    % \addcontentsline{toc}{chapter}{#1}
    {\zihao{-4} \songti #2}
    \vfill
}

% 中文摘要
\newcommand{\cabstract}[2]{
    \baseabstract{\abstract@cabstract}{#1}
    \cbox{\abstract@ckeywords}{#2}
}

% 英文摘要
\newcommand{\eabstract}[2]{
    \baseabstract{\abstract@eabstract}{#1}
    \ebox{\abstract@ekeywords}{#2}
}



%-------------------------------------------------------------------------------
%                目录
%-------------------------------------------------------------------------------
\renewcommand{\contentsname}{目 \hspace{2pt} 录}
% \renewcommand{\cftafterZtitle}{[\baselineskip]\mbox{}\hfill{\normalfont Page}\hfill}
\renewcommand{\cfttoctitlefont}{\hfill\Large\bfseries}        % title 前间隔
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand\cftchapfont{\songti \zihao{-4}}
\renewcommand\cftsecfont{\songti \zihao{-4}}
\renewcommand\cftsubsecfont{\songti \zihao{-4}}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftchappagefont }{}                          % 设置索引不加粗
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}       % 目录后一行连续的点
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}       % 目录后一行连续的点
\setlength{\cftbeforetoctitleskip}{0pt}                       % title 上间隔
\setlength{\cftaftertoctitleskip}{0pt}                       % title 下间隔
\setlength{\cftbeforechapskip}{5pt}                         % chapter 间隔
\setlength{\cftbeforesecskip}{5pt}                          % section 间隔
\setlength{\cftbeforesubsecskip}{5pt}                       % subsection 间隔
\setlength{\cftchapindent}{0pt}                             % 设置 chapter 部分缩进
\setlength{\cftsecindent}{10pt}	                            % 设置 section 部分缩进
\setlength{\cftsubsecindent}{20pt}                          % 设置 subsubsection 缩进
\settowidth{\cftchapnumwidth}{\cftsecfont 1.1}              % 设置 chapter 内容部分缩进
\settowidth{\cftsecnumwidth}{\cftsecfont 1.1}               % 设置 section 内容部分缩进
\settowidth{\cftsubsecnumwidth}{\cftsecfont 1.1}            % 设置 subsection 内容部分缩进

%-------------------------------------------------------------------------------
%                版面及标题格式
%-------------------------------------------------------------------------------


\ctexset {
    chapter = {
        format = \centering \zihao{-3} \songti \bfseries,
        titleformat = \hspace{-10pt},
        beforeskip = {-15pt},
        afterskip = {5pt},
        number = \arabic{chapter},
        pagestyle = style@normal
    },
    section = {
        format = \raggedright \zihao{4} \songti \bfseries,
        titleformat = \hspace{-10pt},
        beforeskip = {0pt},
        afterskip = {5pt},
    },
    subsection = {
        format = \raggedright \zihao{4} \songti \bfseries,
        titleformat = \hspace{-10pt},
        afterskip = {5pt},
    },
    subsubsection = {
        format = \zihao{-4} \songti,
        afterskip = {0pt},
    }
}


%-------------------------------------------------------------------------------
%                致谢
%-------------------------------------------------------------------------------
\newcommand{\Acknowledgements}[1]{
    \setlength{\baselineskip}{20pt}
    \chapter*{\zihao{-3} \songti 致\hspace{1em}谢}
    \addcontentsline{toc}{chapter}{致\hspace{1em}谢}
    \markboth{\zihao{-5} \songti 致\hspace{1em}谢}{\zihao{-5} \songti 致\hspace{1em}谢} % 定制页眉
    \vspace{0.5cm}
    {\songti \zihao{-4} #1}
}


\endinput