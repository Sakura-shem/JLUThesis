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
\ProvidesClass{JLUThesis}[2023/05/17 v1.2 jilin University Thesis document class]
\LoadClass[UTF8, oneside, a4paper, 12pt]{ctexbook}       % 论文使用A4纸，默认小四号字体


\RequirePackage{xcolor}
\RequirePackage{tocloft}
% figure
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{graphicx}
% 行距调节
\RequirePackage{setspace}
% font 
\RequirePackage{fontspec}
% cover
\RequirePackage{tabularray}
\RequirePackage{adjustbox}
\RequirePackage{calc}
% cite
\RequirePackage[backref]{hyperref} 

% 字体
\setmainfont[UprightFont=*,]{Times New Roman}
\setCJKfamilyfont{cusong}[Path=fonts/, AutoFakeBold = {2.17}]{SimSun.ttf}
\renewcommand*{\songti}{\CJKfamily{cusong}}
% 1.5 倍行距
\renewcommand{\baselinestretch}{1.5}

% 版面上空2.5cm，下空2cm，左空2.8cm，右空1.8cm
\geometry{a4paper, top = 25mm, bottom = 25mm, left = 28mm, right = 18mm}

% 图片编号 -- 全局
\counterwithout{figure}{chapter}

%-------------------------------------------------------------------------------
%                加载配置文件
%-------------------------------------------------------------------------------
\input{JLUThesis.cfg}


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
    \begin{titlepage}
        \newcommand{\HRule}{\rule{\linewidth}{1mm}}
        \quad \\[0.42cm]
        {\centering\includegraphics[width = 0.8\textwidth]{figures/logo.png}\\[0.77cm] }
        \center
        {\songti \zihao{-0} \bfseries 本科生毕业论文（设计）}   \\[1.55cm]
        
        \multilingualTitles
        {\bfseries \fontsize{16pt}{16pt} \songti 很长长长长长长长长长长长长长长长长长的标题}
        {\bfseries Very Looong Looo }

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

% 引用
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
\setlength{\cftbeforesubsecskip}{5pt}                       % subsection 间隔
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

% 图片 --- 图片路径，图片标题，图片引用名
\newcommand{\insertfig}[3]{
    \begin{figure}[htbp] %H为当前位置，!htb为忽略美学标准，htbp为浮动图形
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