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
\ProvidesClass{JLUThesis}[2023/05/17 v1.3 jilin University Thesis document class]
\LoadClass[UTF8, oneside, a4paper, 12pt]{ctexbook}       % 论文使用A4纸，默认小四号字体

\RequirePackage{xcolor}
\RequirePackage{tocloft}
% 表格
\RequirePackage{multirow}
\RequirePackage{booktabs}
% figure
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{graphicx}
% figure - 标号
\RequirePackage{caption}
% 行距调节
\RequirePackage{setspace}
% font 
\RequirePackage{fontspec}
% cover
\RequirePackage{tabularray}
\RequirePackage{adjustbox}
\RequirePackage{calc}
% cite
\RequirePackage{gbt7714}

% 字体
\setmainfont[UprightFont=*,]{Times New Roman}
\setCJKfamilyfont{cusong}[Path=fonts/, AutoFakeBold = {2.17}]{SimSun.ttf}
\renewcommand*{\songti}{\CJKfamily{cusong}}
% 1.5 倍行距
\renewcommand{\baselinestretch}{1.75}
% 版面上空2.5cm，下空2.5cm，左空2.8cm，右空1.8cm
\geometry{a4paper, top = 25mm, bottom = 38mm, left = 28mm, right = 18mm}
% 去掉图片标号后面的冒号
\captionsetup[figure]{labelsep=space}

%-------------------------------------------------------------------------------
%                加载配置文件
%-------------------------------------------------------------------------------
\input{JLUThesis.cfg}

% cfg 样式设置
% 图片和公式标号 
    % 全局
\ifnum \cfgstyle@fetindex = 0
    \counterwithout{figure}{chapter}
    \counterwithout{equation}{chapter}
    \counterwithout{table}{chapter}
\fi
    % 图 3.2 <figlabel>
\ifnum \cfgstyle@fetindex = 1
    \counterwithin{figure}{chapter}
    \counterwithin{equation}{chapter}
    \counterwithin{table}{chapter}
\fi
    % 图 3-2 <figlabel>
\ifnum \cfgstyle@fetindex = 2
    \RequirePackage{subcaption}
    \counterwithin{figure}{chapter}
    \counterwithin{equation}{chapter}
    \counterwithin{table}{chapter}
    \renewcommand {\thetable} {\thechapter{}-\arabic{table}} 
    \renewcommand {\thefigure} {\thechapter{}-\arabic{figure}}

\fi
% 引用
\ifnum \cfgstyle@citation = 0
    \bibliographystyle{gbt7714-numerical}
\else
    \bibliographystyle{gbt7714-author-year}
\fi

%-------------------------------------------------------------------------------
%                页眉页脚设计
%-------------------------------------------------------------------------------
\setlength{\voffset}{-10mm}
% 页眉上边距
\setlength{\topmargin}{0mm}
\setlength{\headheight}{20pt}
% 页眉与正文间距
\setlength{\headsep}{7mm}
% 页脚与正文间距
\setlength{\footskip}{18pt}

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
	\renewcommand{\headrulewidth}{1pt}
	\renewcommand{\footrulewidth}{0pt}
    \renewcommand{\headruleskip}{2.5pt}
}
\fancypagestyle{plain}{
    \fancyhf{}
    \fancyfoot[R]{\color{gray} \zihao{-5} \thepage}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}


%-------------------------------------------------------------------------------
%                封面设计
%-------------------------------------------------------------------------------
% reference: https://zhuanlan.zhihu.com/p/591074817
% Make a few tweaks to this code

% inner temp length
\newlength\@tempTitleHt
\newlength\@tempTitleMaxWd

\newlength{\lwtm}
\setlength{\lwtm}{\widthof{中文题目：}}

% length used as parameters， "Wd" is a shorthand for "Width"
% 设定不同的单行与多行的最大行长度
\newlength\titleSingleLineMaxWd
\newlength\titleMultiLineMaxWd
\newlength\titleLRExtraWd
\newlength\titleSepWd

\setlength\titleSingleLineMaxWd{0.6\textwidth}
\setlength\titleMultiLineMaxWd{0.5\textwidth}
\setlength\titleLRExtraWd{.4em}
\setlength\titleSepWd{0.1em}

% draw a fixed-width underline
\newcommand{\titleUnderline}{
  \rule[-.3em]{\titleSingleLineMaxWd + \titleLRExtraWd}{.5pt}
}

\newcommand{\@titleBox}[1]{
    \parbox[t]{\@tempTitleMaxWd}{#1}
}

% title content typesetter
\newcommand\titleBox[1]{
    \setlength\@tempTitleMaxWd\titleSingleLineMaxWd
    % Measure the total height of #1 subject to \titleSingleLineMaxWd.
    % Here \@titleBox is necessary when #1 contains "\\".
    \settototalheight\@tempTitleHt{\@titleBox{#1}}
    \ifdim\@tempTitleHt=0pt%
        % case 1: #1 causes empty output
        \titleUnderline
    \else
        % Change to LR mode, for inserting a zero-width box right after.
        \leavevmode
        % note: Use \normalbaseineskip instead of \baselineskip, 
        %       since the latter is set to 0pt inside tabular env.
        \ifdim\@tempTitleHt>\normalbaselineskip
            % case 2: #1 is fit for multilines, or contains `\\`, hence
            %         \titleMultiLineMaxWd is used instead, and the total 
            %         height of #1 subject to new max width is re-measured.
            \setlength\@tempTitleMaxWd\titleMultiLineMaxWd
            \settototalheight\@tempTitleHt{\@titleBox{#1}}
            % \rlap{\smash{...}} typesets content of its argument normally 
            % but sets it into a zero sized box. Here \@titleBox set 
            % (possiblly) multi-line text into a single box, since \smash 
            % only takes in argument spreading one line.
            %
            % Every line of title content needs an underline, hense we do
            % a loop to typeset one underline for every line the title 
            % content actually spreads.
            \hspace{-0.4cm}
            \rlap{\smash{
                \@titleBox
                {
                    \@whiledim\@tempTitleHt>0pt
                    \do{
                        \rlap{\titleUnderline}
                        \addtolength\@tempTitleHt{-\normalbaselineskip}
                    }
                }
            }}
            % % Insert h-offset to manually center the title content.
            \hspace{\dimexpr\titleLRExtraWd + .5\titleSingleLineMaxWd - .5\titleMultiLineMaxWd\relax}
            \@titleBox{\centering \linespread{2}\selectfont #1}
        \else
            % case 3: #1 is fit for one line
            \rlap{\titleUnderline}
            \@titleBox{\centering #1}
            \fi
    \fi
}
% main macro, using a simple table
\newcommand{\multilingualTitles}[2]{
    \noindent \centering \setstretch{2} 
    % 带有两列的表格，第一列使用左对齐方式，第二列使用固定宽度的自动换行方式。
    % 其中，\titleSepWd 和 \titleSingleLineMaxWd 分别表示列之间的间隔宽度和第二列的最大宽度。
    \begin{tabular}{l @{\hspace{\titleSepWd}} p{\titleSingleLineMaxWd + \titleLRExtraWd}}
        {\bfseries \zihao{3} \songti 中文题目} & \titleBox{#1} \\
                                                        &      \\[-20pt]
        {\bfseries \zihao{3} \songti 英文题目} & \titleBox{#2}
    \end{tabular}
}

\newcommand{\makecover}{
    \pagestyle{style@empty}
    \begin{titlepage}
        \newcommand{\HRule}{\rule{\linewidth}{1mm}}
        \quad \\[0.42cm]
        {\centering\includegraphics[width = 0.8\textwidth]{figures/logo.png}\\[0.77cm] }
        \center
        {\songti \zihao{-0} \bfseries 本科生毕业论文（设计）}   \\[1.55cm]
        
        \multilingualTitles
        {\bfseries \fontsize{16pt}{16pt} \songti \cover@ctitle}
        {\bfseries \cover@etitle }

        \vspace{3cm}
        \setstretch{1.5} 
        \songti \zihao{3} \bfseries 学生姓名            \underline{\makebox[10cm]{\cover@author}}  \\[3pt]
        \songti \zihao{3} \bfseries 学\hspace{2em}号    \underline{\makebox[10cm]{\cover@studentid}}  \\[3pt]
        \songti \zihao{3} \bfseries 学\hspace{2em}院    \underline{\makebox[10cm]{\cover@school}}  \\[3pt]
        \songti \zihao{3} \bfseries 专\hspace{2em}业    \underline{\makebox[10cm]{\cover@major}}  \\[3pt]
        \songti \zihao{3} \bfseries 指导教师            \underline{\makebox[10cm]{\cover@mentor}} \\[1.3cm]
        
        {\songti \zihao{3} \bfseries \cover@time}
        \vfill 
    \end{titlepage}
}

\newcommand{\coverstyle}{
    \pagestyle{style@empty}
    \ctexset {chapter = {pagestyle = style@empty}}
}

\newcommand{\headerstyle}{
    \pagenumbering{Roman}
    \setcounter{page}{0}
    \pagestyle{style@gray}
    \ctexset {chapter = {pagestyle = style@gray}}
}

\newcommand{\contentstyle}{
    \pagenumbering{arabic} 
    \setcounter{page}{1}
    \pagestyle{style@normal}
    \ctexset {chapter = {pagestyle = style@normal}}
    \zihao{-4}
}


%-------------------------------------------------------------------------------
%                承诺书
%-------------------------------------------------------------------------------
\newcommand{\commitment}{
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
    \newlength{\cboxwidth}
    \settowidth{\cboxwidth}{#1}
    \begin{flushleft}
        \vspace{-0.97cm}
        \hspace{\cboxwidth} \parbox[m][2em][t]{\dimexpr\linewidth-\cboxwidth-0.3cm}{\zihao{-4} \songti #2}
    \end{flushleft}
    \vfill
}
\newcommand{\ebox}[2]{
    \newlength{\eboxwidth}
    \settowidth{\eboxwidth}{#1}
    \begin{flushleft}
        \vspace{-0.91cm}
        \hspace{\eboxwidth} \parbox[m][2em][t]{\dimexpr\linewidth-\eboxwidth-0.3cm}{\zihao{-4} \songti #2}
    \end{flushleft}
    \vfill
}
\newcommand{\baseabstract}[3]{
    \setlength{\baselineskip}{20pt}
    \chapter*{\zihao{3} \songti \bfseries #1}
    % \addcontentsline{toc}{chapter}{#1}
    {\zihao{-4} \songti #2}
    \vfill
    \begin{flushleft}
        \zihao{-4} \songti {\bfseries {#3}}
    \end{flushleft}
}

% 中文摘要
\newcommand{\cabstract}[2]{
    \baseabstract{\abstract@cabstract}{#1}{\abstract@ckeywords}
    \cbox{\abstract@ckeywords}{#2}
}

% 英文摘要
\newcommand{\eabstract}[2]{
    \baseabstract{\abstract@eabstract}{#1}{\abstract@ekeywords}
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
\setlength{\cftbeforesubsecskip}{10pt}                       % subsection 间隔
\setlength{\cftchapindent}{0pt}                             % 设置 chapter 部分缩进
\setlength{\cftsecindent}{10pt}	                            % 设置 section 部分缩进
\setlength{\cftsubsecindent}{20pt}                          % 设置 subsubsection 缩进
\settowidth{\cftchapnumwidth}{\cftsecfont 1.1}              % 设置 chapter 内容部分缩进
\settowidth{\cftsecnumwidth}{\cftsecfont 1.1}               % 设置 section 内容部分缩进
\settowidth{\cftsubsecnumwidth}{\cftsecfont 1.1}            % 设置 subsection 内容部分缩进

%-------------------------------------------------------------------------------
%                章节标题格式
%-------------------------------------------------------------------------------
\ctexset {
    chapter = {
        format = \centering \zihao{-3} \songti \bfseries,
        titleformat = \hspace{-10pt},
        beforeskip = {-21pt},
        afterskip = {11pt},
        number = \arabic{chapter},
        pagestyle = style@normal
    },
    section = {
        format = \raggedright \zihao{4} \songti \bfseries,
        titleformat = \hspace{-10pt},
        beforeskip = {0pt},
        afterskip = {3pt},
    },
    subsection = {
        format = \raggedright \zihao{4} \songti \bfseries,
        titleformat = \hspace{-10pt},
        beforeskip = {0pt},
        afterskip = {3pt},
    },
    subsubsection = {
        format = \zihao{-4} \songti,
        afterskip = {0pt},
    }
}

% 图片 --- 图片路径，图片标题，图片引用名
\newcommand{\insertfig}[3]{
    \begin{figure}[htb] %H为当前位置，!htb为忽略美学标准，htbp为浮动图形
        % 图片与上下文的间距
        \setlength{\intextsep}{10pt}
        \setlength{\belowcaptionskip}{0cm} %调整图片标题与下文距离
        \centering %图片居中
        \includegraphics[width=0.9\textwidth]{#1} %插入图片，[]中设置图片大小，{}中是图片文件名
        \caption{#2} % 最终文档中希望显示的图片标题
        \label{#3} % 用于文内引用的标签
    \end{figure}
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