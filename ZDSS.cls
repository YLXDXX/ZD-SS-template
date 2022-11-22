\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ZDSS}[shui 西藏大学研究生毕业论文模板]

%基本设置

\PassOptionsToPackage{no-math}{fontspec}%让正文中的字体设置不影响数学公式
\LoadClass[UTF8,a4paper,zihao=-4,oneside,]{ctexbook} %纸张、正文字号
%\RequirePackage{no-math}{fontspec}%此处无效，ctexbook已经先行调用




\RequirePackage[top=25mm,bottom=25mm,left=30mm,right=30mm]{geometry} %页边距



%封面信息变量
\newtoks\IDnumber
\newtoks\SecretLevel
\newtoks\TitleZh
\newtoks\TitleEn
\newtoks\Name
\newtoks\Teacher
\newtoks\JobTitle
\newtoks\Department
\newtoks\Major
\newtoks\Direction
\newtoks\Date





%字体设置


% 英文字体配置部分
%\setmainfont{Times New Roman}%英文正文
\setmainfont{times.ttf}[Path = fonts/,BoldFont = timesbd.ttf ,ItalicFont = timesi.ttf ,BoldItalicFont = timesbi.ttf ]

%\setsansfont{Source Sans Pro}%英文无衬线
%\setmonofont{Source Code Pro}%英文等宽
%这里会影响公式字体出问题，需用fontspec的no-math选项解决

% 中文字体配置部分
\setCJKmainfont[AutoFakeBold=true,AutoFakeSlant=true]{宋体}%中文正文
%\emph \textbf \bfseries  \textit \itshape 等对中文有效
%也就有了中文对应的粗体和斜体
%\setCJKsansfont{黑体}%中文无衬线
%\setCJKmonofont{楷体}%中文等宽




%自定义字体命令
%\setCJKfamilyfont{boldsong}{Source Han Serif SC Heavy}
%\setCJKfamilyfont{hwxk}{HYXiaoLiShuJ} %使用华文行楷字体
%\newcommand{\myfonta}{\CJKfamily{hwxk}}

%\addbibresource{date/refer.bib} %参考文献

\RequirePackage{graphicx} %图片png、jpg等
\RequirePackage{svg} %svg图片
\graphicspath{{picture/}} %图片存放目录,可直接引用




%单个汉字字宽 \ccwd
%em、 ex
%使用粗体：\bfseries 或者 \textbf{text} ，由于windows字体的原因，若使用加粗命令，则会变成黑体，设置成其它字体即可，例如 fontset=fontset






%\RequirePackage{titlesec}%页面样式：标题
\RequirePackage{titleps}%页面样式：页眉页脚
\RequirePackage{titletoc}%页面样式：目录
%\RequirePackage{fancyhdr}%页眉页角
%\RequirePackage{tocloft}%目录


%设置目录格式
\titlecontents{chapter}
[0pt]%左间距
{\zihao{-4}\heiti\thecontentslabel}%格式
{\texttt{\char32}}
{\zihao{-4}\heiti}%
{\titlerule*[.5pc]{$\cdot$}\contentspage}


\titlecontents{section}
[1.8\ccwd]%左间距
{\thecontentslabel\texttt{\char32}}%格式
{}
{}%
{\titlerule*[0.5pc]{$\cdot$}\contentspage}

\titlecontents{subsection}
[3.2\ccwd]%左间距
{\thecontentslabel\texttt{\char32}}%格式
{}
{}%
{\titlerule*[0.5pc]{$\cdot$}\contentspage}



%设置页眉页脚
%此处的奇偶页不同设置只有在twoside下才有效
\newpagestyle{my-body-style}[]
{
\sethead[][][]
{}{}{}
\setfoot[][\zihao{5}\thepage][]
{}{\zihao{5}\thepage}{}
}



%超链接
\RequirePackage[bookmarksnumbered,draft=false,colorlinks=true,CJKbookmarks=true,linkcolor=black,citecolor=black,urlcolor=black,hyperindex]{hyperref}
% bookmarksnumbered 在pdf书签中加入章节序号




%\RequirePackage[font=small,labelfont={bf,color=main}]{caption,subcaption}%对图片表格标题和子标题的控制
% 采用带圈数字符号代替*号脚注
%\xeCJKsetcharclass{`①}{`⑩}{1}





%基本宏包
\RequirePackage{tabularray}%表格
\RequirePackage{tikz}%绘图
\RequirePackage{mathdots} %添加斜向省略号
\RequirePackage{xcolor}%定义了一些颜色
\RequirePackage{enumerate} %列项序号编号
\RequirePackage{extarrows} %箭头等号上添加文字
\RequirePackage{amssymb} %数学公式符号
\RequirePackage{amsmath} %数学公式
\RequirePackage{mathtools} %数学公式扩展宏包,提供了公式编号定制和更多的符号、矩阵等。
\RequirePackage{cases} %使用括号对公式等进行并列排列
%\RequirePackage{amsthm}%证明定理等环境，与精细设定ntheorem有冲突
\RequirePackage{amsfonts} %用来输入各种符号的特殊形态，例如字母的花体、空心体等，配合amssymb使用
\RequirePackage{mathrsfs} %数学中的花体(不是太花的)
\RequirePackage[upright=true]{derivative}%分数导数微分偏微分增量改变量等 
\RequirePackage{tabularray} %表格
\RequirePackage{braket} %量子算符宏包 
\RequirePackage{esint} % various fancy integral symbols %积分符号
\RequirePackage{xcolor}%定义了一些颜色
\RequirePackage{booktabs}%表格
\RequirePackage{threeparttable}  %表格注释 
\RequirePackage{enumitem}%列表


%攻读学位期间论文发表环境
\newlist{publications}{enumerate}{1}
\setlist[publications]{label=[\arabic*],itemsep=3bp,resume,}








\RequirePackage[bodytextleadingratio=1.9166]{zhlineskip} %设置正文行间距
%行距是指一行字体加空白区域的总距离，而不仅仅是间隔区域
%并且行距由字体大小决定，比如10号字体下的单倍行距为10*1.3 = 13 磅。
%正文字体小四号，为12磅，即「12bp」
%小四字体下1.25倍行距对应的bp数为12*1.3*1.25 
%
%正文行间距固定为23磅
%LaTeX正文基础行距1.2
%在一般情况下，CTEX 会默认用 linespread=1.3 这个文档类选项将中文的行距
%设置为字号的 1.56 倍（基础行距是字号的 1.2 倍，而 1.2 × 1.3 = 1.56）。
%对应的行间距倍数为 23/12=1.9166
%可通过\the\baselineskip查看当前行距
%其\baselineskip表示两行基准线之间的距离
%在英文中调整行间距
%一般用\renewcommand{\baselinestretch}{1.2} 或 \linespread{1.2}



\ctexset{
tocdepth = subsection, %目录编号层数
secnumdepth = subsubsection, %章节标题编号层数
appendix/numbering=true,
appendix/name = {附录},
%figurename = 图,
%tablename =表,
chapter = {
	pagestyle = my-body-style,
	name = {第,章},
	format= \centering\zihao{3}\heiti,
	%aftername =,
	beforeskip=12.8bp, %0.8*16bp
	afterskip=32bp, %2*16bp %空两行
},
section = {
	%name = {（,）},
	%number = \chinese{section},
	format= \raggedright\zihao{4}\heiti,
	%aftername =,
	beforeskip=14bp, %1*14bp
	%afterskip=14bp, %1*14bp%空一行
},
subsection = {
	%name = {,．},
	%number = \arabic{section},
	format=\raggedright \zihao{-4}\heiti,
	%aftername =,
	beforeskip=6bp, %0.5*12bp
	afterskip=6bp, %0.5*12bp
},
subsubsection = {
	%name = {（,）},
	%number = \arabic{section},
	format= \raggedright\zihao{-4}\heiti,
	%aftername =,
	beforeskip=6bp, %0.5*12bp
	afterskip=6bp, %0.5*12bp
},
contentsname = 目\texttt{\char32}录,
}









%对图片表格标题和子标题的控制
%Figures, Subfigures and Tables
\RequirePackage{caption}
\RequirePackage{subcaption}

%图片、表格标题的设置
\DeclareCaptionFormat{My-Format}{\zihao{5}\kaishu #1#2#3\par}

\captionsetup{format=My-Format,justification=centering}%图、表等标题样式设定
\captionsetup[sub]{format=My-Format,justification=centering}%图、表等标题样式设定
\captionsetup{labelsep=space} %表的标号与名字间的分隔

%图表标号
\renewcommand{\thefigure}{\thechapter--\arabic{figure}}
\renewcommand{\thetable}{\thechapter--\arabic{table}}







%脚注使用带圈数字
%https://www.latexstudio.net/archives/51644.html

\newfontfamily\nmfont[Path=fonts/]{SH-number-Regular.otf} %安装后的字体名称 SH number Regular
%%定义带圈数字命令
\newcommand{\myquan}[1]{{\nmfont \symbol{#1}}}
\newcommand{\mykk}[1]{\myquan{\numexpr32+#1}}%\kk{<参数范围1-95>}96、97、98、99分别用\quan{196} \quan{197} \quan{199} \quan{201}
\newcommand*\mykkctr[1]{%
	\protect\mykk{\number\numexpr\value{#1}\relax}}


%这字体有个问题，显示无误，但对应的Unicode有问题，复制带圈文字会出错
%更好的是使用Source Han Serif 的字体
%方法如下
%\RequirePackage{fontspec,xunicode-addon}
%\newfontfamily\mynmfont{SH-number-Regular.otf}\setmainfont{Source Han Serif}
% {\mynmfont\textcircled{25}}
%这样Source Han Serif和textcircled配合，可以有很好的效果
%甚至可以用中文{\mynmfont\textcircled{中}}


%\numberwithin{footnote}{part} %令脚注的计数器与部挂钩
\counterwithout*{footnote}{chapter}%取消脚注计数器跟章节的关联


%设置脚注样式
\renewcommand*\thefootnote{\mykkctr{footnote}}


%在页面底部的脚注内容中，取消编号的上标样式
%https://zhuanlan.zhihu.com/p/74515148
\RequirePackage{xpatch}

% cancel the superscript style of counter used in footnote text
\xpatchcmd\@makefntext
{{\hss\@makefnmark}}
{{\hss\@makefnmark@nosuperscript}\space}
{}{\fail}

% old: superscript style
% \def\@makefnmark{\hbox{\@textsuperscript{\normalfont\@thefnmark}}}

% new: normal style, lower baseline
\def\@makefnmark@nosuperscript{\lower .0ex \hbox{\normalfont\@thefnmark}}

%注释与正文之间加细线分隔
% shorten footnote rule
\xpatchcmd\footnoterule
{.4\columnwidth}
{1.7in height 1bp } %线宽度为1磅，线的长度不应超过纸张的三分之一宽度
{}{\fail}

%\renewcommand{\footnotesize}{\zihao{5}\songti} %脚注字宋体5号字


%公式编号
\renewcommand{\theequation}{\thechapter--\arabic{equation}}


%参考文献
\RequirePackage[sort&compress]{gbt7714}
\bibliographystyle{gbt7714-numerical}%选择参考文献样式「顺序编码制」
%需要使用bibtex引擎编译






\RequirePackage{zhlipsum}%中文假文\zhlipsum[2-4]
\RequirePackage{lipsum}%英文徦文




%
%下面是自定义命令部分
%




%封面

\setCJKfamilyfont{hwzs}{华文中宋} %使用华文中宋
\setCJKfamilyfont{hwxw}{华文新魏} %使用华文新魏

\newcommand{\cover}{
\thispagestyle{empty}
\begin{center}
	\flushright 
	\songti\zihao{5}
	\begin{tikzpicture}[remember picture,overlay]
		\node[inner sep=0pt,anchor=west] (whitehead) at ([yshift=-3.5cm,xshift=140mm]current page.north west)
		{\begin{tblr}{
					colspec={|cm{6.5\ccwd}|},
					hline{1,4} ,
				} 
				\makebox[5em][s]{{学校代码：}}\hspace*{-1em} &10694\\
				\makebox[5em][s]{{学号：}}\hspace*{-1em} &\the\IDnumber\\
				\makebox[5em][s]{{密级：}}\hspace*{-1em} &\the\SecretLevel\\
		\end{tblr}};
	\end{tikzpicture}
	\\\vspace*{2cm}
\end{center}
\begin{center}
	\centering
	\includegraphics{picture/西藏大学.png}\\\vspace{1cm}
	{\CJKfamily{hwzs}\zihao{-0}硕 \space 士 \space 学 \space 位 \space 论 \space 文}\\\vspace{0.8cm}%示例中为2cm，加英文标题缩小
	{\CJKfamily{hwxw}\zihao{-1}\the\TitleZh}\\
    {\zihao{3}\the\TitleEn}
	\\\vspace{1.3cm}%示列中为2.5cm，加英文标题缩小
	\zihao{3}\songti
		\begin{tblr}{
			colspec={lcm{13\ccwd}},
			hline{1}={white},
			hlines = {2-3}{solid},
			leftsep=0pt,
			rightsep=0pt,
		} %这里不能用两个\space，会被压缩成一个
		\makebox[7.13em][s]{姓名：} & \texttt{\char32}\texttt{\char32} &\the\Name\\
		\makebox[7.13em][s]{指导教师：}& &\the\Teacher \texttt{\char32} \the\JobTitle\\
		\makebox[7em][s]{院（部、中心）：}&&\the\Department\\
		\makebox[7.13em][s]{专业：}&&\the\Major\\
		\makebox[7.13em][s]{研究方向：}&&\the\Direction\\
		\makebox[7.13em][s]{完成日期：}&&\the\Date\\
	\end{tblr}
\end{center}
\clearpage
%\newpage\null\thispagestyle{empty}\newpage
}




%声明
\newcommand{\statement}{
\thispagestyle{empty}
\begin{center}
	\zihao{2}\CJKfamily{hwzs}
	西藏大学研究生学位论文作者声明

\end{center}

{\zihao{4}\linespread{2}\selectfont 
本人声明：本人呈交的学位论文是本人在导师指导下取得的研究成果。对前人及其他人员对本文的启发和贡献已在论文中做出了明确的声明，并表示了谢意。论文中除了特别加以标注和致谢的地方外，不包含其他人和其它机构已经发表或者撰写过的研究成果。

本人同意学校根据《中华人民共和国学位条例暂行实施办法》等有关规定保留本人学位论文并向国家有关部门或资料库送交论文或者电子版，允许论文被查阅和借阅；本人授权西藏大学可以将本人学位论文的全部或者部分内容编入有关数据库进行检索，可以采用影印、缩印或者其它复制手段和汇编学位论文（保密论文在解密后应遵守此规定）。
\par
}
\begin{center}
	\centering
	\zihao{4}
	\begin{tblr}{colspec={XX},
		leftsep=0pt,
		rightsep=0pt,
	}
&&\\&&\\
		学位论文作者签名：         &      指导教师签名： \\&&\\
		签字日期：\texttt{\char32}\texttt{\char32}年\texttt{\char32}\texttt{\char32}月\texttt{\char32}\texttt{\char32}日    &     签字日期：\texttt{\char32}\texttt{\char32}年\texttt{\char32}\texttt{\char32}月\texttt{\char32}\texttt{\char32}日
	\end{tblr}
	
\end{center}
\clearpage
%\newpage\null\thispagestyle{empty}\newpage
}




%中文摘要
\newcommand{\ZhAbstract}[2]{
\pagestyle{empty}
\begin{center}
	\heiti\zihao{3}
	~\\ %空一行
	摘\hspace{\ccwd}要
\end{center}
{\zihao{4}\songti %\linespread{1.5}\selectfont %1.5倍行距
	~\par %空一行
	#1
\par
}
~\\ %空一行
\noindent {\zihao{4}\heiti 关键词}： {\zihao{4}\songti #2}
\clearpage
}




%英文摘要
\newcommand{\EnAbstract}[2]{
\pagestyle{empty}
\begin{center}
	\zihao{3}
	~\\ %空一行
	\textbf{ABSTRACT}
\end{center}
{\zihao{4}%\linespread{1.5}\selectfont %1.5倍行距
	~\par %空一行
	#1
\par
}
~\\ %空一行
\noindent {\zihao{4}\textbf{KEY WORDS}}： {\zihao{4}#2} 
\clearpage
}



%目录
\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{empty}}} 
\newcommand{\mulucreat}{
	\pagestyle{empty}
	\tableofcontents
	\clearpage
	\setcounter{page}{1}
	\pagestyle{my-body-style}
}





%参考文献
%需要使用bibtex引擎编译
\newcommand{\PrintBibliography}{
\clearpage
\phantomsection %让超链接能够正确链接，一般是加入目录用
\addcontentsline{toc}{chapter}{参考文献}
}




%附录
\newcommand{\Appendix}{
\appendix%附录开始
\iffalse
%附录前面需加入\appendix命令
\ctexset{
section = {
	name = {附,\ },
	number =\Alph{chapter}.\arabic{section},
},
subsection = {
	name = {附,\ },
	number =\Alph{chapter}.\arabic{section}.\arabic{subsection},
},
subsubsection = {
	name = {附,\ },
	number =\Alph{chapter}.\arabic{section}.\arabic{subsection}.\arabic{subsubsection},
},}
\fi
}




%相关科研成果目录和致谢
\newcommand{\ResearchThinks}{
	\ctexset{chapter/numbering=false} %设置相关科研成果目录和致谢的标题
	\ctexset{chapter/numbering=false,} %设置相关科研成果目录和致谢的标题
	\ctexset{section/numbering=false,} %设置相关科研成果目录和致谢的标题
	\ctexset{subsection/numbering=false,} %设置相关科研成果目录和致谢的标题
	\ctexset{subsubsection/numbering=false,} %设置相关科研成果目录和致谢的标题
}

%相关科研成果目录和致谢的标题也可以手动设置
%例如
%\chapter*{\texorpdfstring{致\hspace{2\ccwd}谢}{致谢}}
%\phantomsection %让超链接能够正确链接，一般是加入目录用
%\addcontentsline{toc}{chapter}{\texorpdfstring{致谢}{致谢}}



