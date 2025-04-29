%%% % -*- coding: utf-8 -*-
%%% ----------------------------------------------------------------------------
%%% ZDSS: 西藏大学硕博毕业论文模板
%%% Copyright : 2021-2025 (c) <ylxdxx@qq.com>
%%% Repository: https://gitee.com/ylxdxx/ZD-SS-template
%%% License   : The LaTeX Project Public License 1.3c
%%% ----------------------------------------------------------------------------

%LaTeX3 环增的开关
%\ExplSyntaxOn
%\ExplSyntaxOff

%在文档开始前后添加处理代码
%\AtBeginDocument{code}
%\AtEndDocument{code}


%格式声名
\NeedsTeXFormat{LaTeX2e}[2021-11-15]

\RequirePackage{expl3}


%This is a special version of the standard \ProvidesPackage macro, 
%which will automatically turn on LaTeX3 programming syntax and 
%more importantly turn it off at the end of the package. 
%It also deals properly with nested package loading, and
%so is the recommended way to use LaTeX3 syntax inside LaTeX2e packages.
\ProvidesExplPackage{ZDSS} % Package name
{2024-11-26} % Release date
{0.2} % Release version
{西藏大学硕士毕业论文模板} % Description


%\debug_on:n{all}



%
% 定义变量
%


%基本信息
\tl_new:N   \l_ZD_degree_type_tl % 学位类型
\tl_new:N   \l_ZD_thesis_title_zh_tl % 论文题目，中文
\tl_new:N   \l_ZD_thesis_title_zh_text_tl % 论文题目，中文，纯文字
\tl_new:N   \l_ZD_thesis_title_en_tl % 论文题目，英文
\tl_new:N   \l_ZD_student_name_tl % 学生姓名
\tl_new:N   \l_ZD_student_number_tl % 学生学号
\tl_new:N   \l_ZD_teacher_name_tl % 导师姓名
\tl_new:N   \l_ZD_teacher_title_tl % 导师职称
\tl_new:N   \l_ZD_college_tl % 学院
\tl_new:N   \l_ZD_major_tl % 专业
\tl_new:N   \l_ZD_research_orientation_tl % 研究方向
\tl_new:N   \l_ZD_complete_date_tl % 完成日期
\tl_new:N   \l_ZD_school_name_tl % 学校名称
\tl_new:N   \l_ZD_school_code_tl % 学校代码
\tl_new:N   \l_ZD_security_classification_tl % 论文密级
\tl_new:N   \l_ZD_degree_level_tl % 学位层级：硕士、博士
\int_new:N  \l_ZD_degree_level_int


\int_const:Nn \c_ZD_master_degree_int {1} %硕士
\tl_const:Nn \c_ZD_master_degree_tl {master}

\int_const:Nn \c_ZD_doctor_degree_int {2} %博士
\tl_const:Nn \c_ZD_doctor_degree_tl {doctor}


%功能控制
\bool_new:N   \l_ZD_terms_create_bool %是否添加术语表
\bool_new:N   \l_ZD_print_version_bool %是否生成打印版本PDF
\bool_new:N   \l_ZD_anonymously_review_bool % 是否启用盲审格式

\bool_new:N   \l_ZD_hyperlink_color_bool %是否对超链接添加颜色
\tl_new:N     \l_ZD_hyperlink_color_tl %超链接颜色

%
%这里处理从宏包在调用加载时给出的参数
%如：\documentclass[hyperlink_color=true]{ZDSS}
%
\keys_define:nn {ZDSS}
{
    hyperlink_color_is .bool_set:N = \l_ZD_hyperlink_color_bool,
    hyperlink_color .tl_set:N  = \l_ZD_hyperlink_color_tl,
    
    % 初始值
    hyperlink_color_is .initial:n = {false},
    hyperlink_color .initial:n = {blue},
    
}
\ProcessKeyOptions[ZDSS] %处理传入参数



%
%模板基本设置
%


\PassOptionsToPackage{no-math}{fontspec}%让正文中的字体设置不影响数学公式

%正文为宋体小四号字
\LoadClass[UTF8,a4paper,zihao=-4,twoside,]{ctexbook} %纸张、正文字号
%\RenewDocumentCommand{\cleardoublepage}{}{\clearpage} %用以取消 chapter 强制在奇数页，因为奇偶页眉页脚需用到 twoside 参数
\RenewDocumentCommand{\cleardoublepage}{}{ %重写 \cleardoublepage 命令
	\clearpage
	\bool_if:NTF {\l_ZD_print_version_bool}
	{
		%若为真，则需判断是否需要加入空白页
		\int_if_odd:nTF {\theMyPageAllCounter} %判断奇偶，第一章（绪论）需为装订的右页
		{} % true
		{ % false
		\thispagestyle{empty} \null \stepcounter{MyPageAllCounter} \newpage % false, 为奇，插入空白页
		}
	}
	{
		%若为假，什么都不做
	}
}
%\RequirePackage{no-math}{fontspec}%此处无效，ctexbook已经先行调用


%每页上方（天头）：25.4mm、下方（地脚）:25.4mm、左侧（订口）:31.8mm、右侧（切口）:31.8mm。
\RequirePackage[top=25.4mm,bottom=25.4mm,left=31.8mm,right=31.8mm]{geometry} %页边距



\RequirePackage[bodytextleadingratio=1.8333]{zhlineskip} %设置正文行间距
%行距是指一行字体加空白区域的总距离，而不仅仅是间隔区域
%并且行距由字体大小决定，比如10号字体下的单倍行距为10*1.3 = 13 磅。
%正文字体小四号，为12磅，即「12bp」
%小四字体下1.25倍行距对应的bp数为12*1.3*1.25 
%
%正文行间距固定为22磅
%LaTeX正文基础行距1.2
%在一般情况下，CTEX 会默认用 linespread=1.3 这个文档类选项将中文的行距
%设置为字号的 1.56 倍（基础行距是字号的 1.2 倍，而 1.2 × 1.3 = 1.56）。
%对应的行间距倍数为 22/12=1.8333
%可通过\the\baselineskip查看当前行距
%其\baselineskip表示两行基准线之间的距离
%在英文中调整行间距
%一般用\renewcommand{\baselinestretch}{1.2} 或 \linespread{1.2}


%
%字体设置
%

% 英文字体配置部分
%\setmainfont{Times New Roman}%英文正文
\setmainfont{times.ttf}[Path = fonts/, BoldFont = timesbd.ttf, ItalicFont = timesi.ttf, BoldItalicFont = timesbi.ttf]

%\setsansfont{Source Sans Pro}%英文无衬线
%\setmonofont{Source Code Pro}%英文等宽
%这里会影响公式字体出问题，需用fontspec的no-math选项解决，见上
%
% 中文字体配置部分
%

\xeCJKsetup{AutoFallBack=true} %用于生僻字显示

%自定义字体命令
\setCJKfamilyfont{WinSongTi}[Path = fonts/,AutoFakeBold=2,AutoFakeSlant=true,
							FallBack={[Path = fonts/,AutoFakeBold=2,AutoFakeSlant=true,]{simsunb.ttf}},]{simsun.ttc} %宋体
\setCJKfamilyfont{WinKaiTi}[Path = fonts/,AutoFakeBold=2,AutoFakeSlant=true,]{simkai.ttf} %楷体
\setCJKfamilyfont{WinHeiTi}[Path = fonts/,AutoFakeSlant=true,]{simhei.ttf} %黑体
%相要使用的话用 \CJKfamily{WinSongTi} 即可

%\setCJKmainfont[AutoFakeBold=true,AutoFakeSlant=true]{宋体}%中文正文
\setCJKmainfont[Path = fonts/,AutoFakeBold=2,AutoFakeSlant=true,
				FallBack={[Path = fonts/,AutoFakeBold=2,AutoFakeSlant=true,]{simsunb.ttf}},]{simsun.ttc} %正文宋体

%重定义 ctexbook 中一些字体命令
\RenewDocumentCommand{\songti}{}{\CJKfamily{WinSongTi}}
\RenewDocumentCommand{\kaishu}{}{\CJKfamily{WinKaiTi}}
\RenewDocumentCommand{\heiti}{}{\CJKfamily{WinHeiTi}}

%\emph \textbf \bfseries  \textit \itshape 等对中文有效
%也就有了中文对应的粗体和斜体
%\setCJKsansfont{黑体}%中文无衬线
%\setCJKmonofont{楷体}%中文等宽



%单个汉字字宽 \ccwd
%em、 ex
%使用粗体：\bfseries 或者 \textbf{text} 
%由于windows字体的原因，若使用加粗命令，则会变成黑体，设置成其它字体即可，例如 fontset=fontset


%\RequirePackage{titlesec}%页面样式：标题
\RequirePackage{titleps}%页面样式：页眉页脚
\RequirePackage{titletoc}%页面样式：目录
%\RequirePackage{fancyhdr}%页眉页角
%\RequirePackage{tocloft}%目录


%设置目录格式
%共显示三级
\titlecontents{chapter}
[0pt]%左间距
{\zihao{-4}\heiti\thecontentslabel}%格式
{\texttt{\char32}}
{\zihao{-4}\heiti}%
{~\space\titlerule*[.5pc]{$\cdot$}\contentspage}

\titlecontents{section}
[1.8\ccwd]%左间距
{\thecontentslabel\texttt{\char32}}%格式
{}
{}%
{~\space\titlerule*[0.5pc]{$\cdot$}\contentspage}

\titlecontents{subsection}
[3.2\ccwd]%左间距
{\thecontentslabel\texttt{\char32}}%格式
{}
{}%
{~\space\titlerule*[0.5pc]{$\cdot$}\contentspage}



%设置页眉页脚
%此处的奇偶页不同设置只有在twoside下才有效
\newcounter{MyPageAllCounter} %用于总页数的计数器
\bool_if:NTF {\l_ZD_print_version_bool}
{
	%为真
	\setcounter{MyPageAllCounter}{5} %封面+声明+空白页占 4 页，从 5 页开始
}
{
	%为假
	\setcounter{MyPageAllCounter}{3} %封面和声明占 2 页，从 3 页开始
}


%正文部分页眉页脚
\newpagestyle{my-body-style}[]
{
%其中 MyPageAllCounter 计数器用于记录总页数
\sethead[\stepcounter{MyPageAllCounter}][西藏大学硕士学位论文][] % even
{\stepcounter{MyPageAllCounter}}{\tl_use:N \l_ZD_thesis_title_zh_text_tl}{} % odd
\setfoot[][\footnotesize--~\thepage~\space--][] % even
{}{\footnotesize--~\thepage~\space--}{} % odd
\setheadrule{.4pt} %页眉线
}

%前面摘要相关页眉页脚
\newpagestyle{my-pre-body-style}[]
{
%其中 MyPageAllCounter 计数器用于记录总页数
\sethead[\stepcounter{MyPageAllCounter}][西藏大学硕士学位论文][] % even
{\stepcounter{MyPageAllCounter}}{\tl_use:N \l_ZD_thesis_title_zh_text_tl}{} % odd
\setfoot[][\footnotesize--~\thepage~\space--][] % even
{}{\footnotesize--~\thepage~\space--}{} % odd
\setheadrule{.4pt} %页眉线
}


%超链接
% bookmarksnumbered 在pdf书签中加入章节序号
\bool_if:NTF {\l_ZD_hyperlink_color_bool}
{
\RequirePackage[bookmarksnumbered,draft=false,CJKbookmarks=true,
				colorlinks=true,
				linkcolor=\tl_use:N \l_ZD_hyperlink_color_tl,
				citecolor=\tl_use:N \l_ZD_hyperlink_color_tl,
				urlcolor=\tl_use:N \l_ZD_hyperlink_color_tl,
				anchorcolor=\tl_use:N \l_ZD_hyperlink_color_tl,
				filecolor=\tl_use:N \l_ZD_hyperlink_color_tl,
				hyperindex]{hyperref}
}
{
\RequirePackage[bookmarksnumbered,draft=false,CJKbookmarks=true,
				colorlinks=false,hyperindex,hidelinks]{hyperref}
}



%\RequirePackage[font=small,labelfont={bf,color=main}]{caption,subcaption}%对图片表格标题和子标题的控制
% 采用带圈数字符号代替*号脚注
%\xeCJKsetcharclass{`①}{`⑩}{1}


%载入必要的宏包
\RequirePackage{tabularray} % 表格
%\RequirePackage{booktabs} %表格
\UseTblrLibrary{booktabs} % 在 tabularray 中使用传统三线表 \toprule \midrule \bottomrule
\RequirePackage{threeparttable}  %表格注释 
\RequirePackage{tikz} % 绘图
\RequirePackage{graphicx} %图片png、jpg等
\RequirePackage{svg} %svg图片
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
\RequirePackage[upright=true]{derivative}%分数、导数、微分、偏微分、增量改变量等符号
\RequirePackage{braket} %量子算符宏包 
\RequirePackage{esint} % various fancy integral symbols %积分符号
\RequirePackage{enumitem}%列表
\RequirePackage{bm} %加粗 \bm{}
\RequirePackage{physics} %物理常用符号
\RequirePackage{algorithm2e} %算法排版
\RequirePackage{gensymb} %度 \degree
\RequirePackage{minted} %%插入代码
\RequirePackage{zhlipsum}%中文假文\zhlipsum[2-4]
\RequirePackage{lipsum}%英文徦文






%攻读学位期间论文发表环境
%\newlist{publications}{enumerate}{1}
%\setlist[publications]{label=[\arabic*],itemsep=3bp,resume,}
%已使用参考文献的 refsection 环境替代



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
	beforeskip=-8bp, %0.8*16bp
	afterskip=24bp, %2*12bp %空两行
},
section = {
	%name = {（,）},
	%number = \chinese{section},
	format= \raggedright\zihao{4}\heiti,
	%aftername =,
	beforeskip=6bp, %0.5*12bp
	afterskip=12bp, %1*12bp%空一行
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
	beforeskip=3bp, %0.5*12bp
	afterskip=3bp, %0.5*12bp
},
contentsname = 目\hspace{\ccwd}录,
}



%对图片表格标题和子标题的控制
%Figures, Subfigures and Tables
\RequirePackage{caption}
\RequirePackage{bicaption} %双语表题
\RequirePackage{subcaption}



%图片、表格标题的设置
\DeclareCaptionFormat{My-Format}{\zihao{5}{\heiti #1#2} \quad #3\par}

\captionsetup{format=My-Format,justification=centering}%图、表等标题样式设定
\captionsetup[sub]{format=My-Format,justification=centering}%图、表等标题样式设定
\captionsetup{labelsep=space} %表的标号与名字间的分隔

%图表标号
\renewcommand{\thefigure}{\thechapter--\arabic{figure}}
\renewcommand{\thetable}{\thechapter--\arabic{table}}

%双语标题设置
\captionsetup[figure][bi-first]{name=图}
\captionsetup[figure][bi-second]{name=Fig.}
\captionsetup[table][bi-first]{name=表}
\captionsetup[table][bi-second]{name=Tab.}

%算法标题
\counterwithin*{algocf}{chapter}
\SetAlgorithmName{算法}{算法}{算法} %将算法环境标题由 Algorithm --> 算法
\renewcommand{\thealgocf}{\thechapter--\arabic{algocf}}
\SetAlgoCaptionSeparator{\space\space\space}
\SetAlCapFnt{\zihao{5}\heiti}
\SetAlCapNameFnt{\zihao{5}}

%公式编号
%\DeclareDocumentCommand{\theequation}{}{\thechapter--\arabic{equation}} % 这里不能使用 LaTeX3 的语法来定义
%https://tex.stackexchange.com/questions/61756/how-to-change-equation-numbering-style
\long\def\theequation{\ifnum \c@chapter > \z@ \thechapter --\fi \@arabic \c@equation}


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


%设置脚注
\renewcommand*\thefootnote{\mykkctr{footnote}}

\RequirePackage[hang,flushmargin]{footmisc} %脚注悬挂对齐

% old: superscript style
% \def\@makefnmark{\hbox{\@textsuperscript{\normalfont\@thefnmark}}}

% new: normal style, lower baseline
\def\@makefnmark@nosuperscript{\lower .0ex \hbox{\normalfont\@thefnmark}\;}

%将脚注里的上标转为正常字符
\renewcommand{\@makefntext}[1]{%
    \ifFN@hangfoot
      \bgroup
      \setbox\@tempboxa\hbox{%
        \ifdim\footnotemargin>0pt
          \hb@xt@\footnotemargin{\@makefnmark@nosuperscript\hss}%
        \else
          \@makefnmark@nosuperscript
        \fi
      }%
      \leftmargin\wd\@tempboxa
      \rightmargin\z@
      \linewidth \columnwidth
      \advance \linewidth -\leftmargin
      \parshape \@ne \leftmargin \linewidth
      \footnotesize
      \@setpar{{\@@par}}%
      \leavevmode
      \llap{\box\@tempboxa}%
      \parskip\hangfootparskip\relax
      \parindent\hangfootparindent\relax
    \else
      \parindent1em
      \noindent
      \ifdim\footnotemargin>\z@
        \hb@xt@ \footnotemargin{\hss\@makefnmark@nosuperscript}%
      \else
        \ifdim\footnotemargin=\z@
          \llap{\@makefnmark@nosuperscript}%
        \else
          \llap{\hb@xt@ -\footnotemargin{\@makefnmark@nosuperscript\hss}}%
        \fi
      \fi
    \fi
    \footnotelayout#1%
    \ifFN@hangfoot
      \par\egroup
    \fi
}

%注释与正文之间加细线分隔
\RequirePackage{xpatch}
% shorten footnote rule
\xpatchcmd\footnoterule
{.4\columnwidth}
{1.7in height 1bp } %线宽度为1磅，线的长度不应超过纸张的三分之一宽度
{}{\fail}

%\renewcommand{\footnotesize}{\zihao{5}\songti} %脚注字宋体5号字


%
%参考文献
%

%旧方法
%参考 https://ctan.org/pkg/gbt7714 
%\RequirePackage[sort&compress]{gbt7714}
%\bibliographystyle{gbt7714-numerical}%选择参考文献样式「顺序编码制」
%需要使用 bibtex 引擎编译
%\bibliography{date/refer.bib} %参考文献相关文件，此句在需要生成参考文献的地方加入

%新方法
%参考 https://ctan.org/pkg/biblatex-gb7714-2015 
\RequirePackage[backend=biber, style=gb7714-2015, gbalign=gb7714-2015, gbpub=true]{biblatex}
%\addbibresource[location=local]{date/refer.bib} %参考文献源文件
\setlength{\biblabelsep}{3mm} %参考文标签和内容间的间隔
%需使用 biber 引擎编译
%\printbibliography[heading=bibliography,title=参考文献] %打印参考文献表，此句在需要生成参考文献的地方加入




%
%
%下面是本模板自定义的一些功能与命令
%采用LaTeX3语法编写
%
%



%基本信息键值对
\keys_define:nn { ZD_basic_information }
{
    degree_type .tl_set:N  = \l_ZD_degree_type_tl,
    thesis_title_zh .tl_set:N  = \l_ZD_thesis_title_zh_tl,
    thesis_title_zh_text .tl_set:N  = \l_ZD_thesis_title_zh_text_tl,
    thesis_title_en .tl_set:N  = \l_ZD_thesis_title_en_tl,
    student_name .tl_set:N  = \l_ZD_student_name_tl,
    student_number .tl_set:N  = \l_ZD_student_number_tl,
    teacher_name .tl_set:N = \l_ZD_teacher_name_tl,
    teacher_title .tl_set:N = \l_ZD_teacher_title_tl,
    college .tl_set:N = \l_ZD_college_tl,
    major .tl_set:N = \l_ZD_major_tl,
    research_orientation .tl_set:N = \l_ZD_research_orientation_tl,
    complete_date .tl_set:N = \l_ZD_complete_date_tl,
    school_name .tl_set:N  = \l_ZD_school_name_tl,
    school_code .tl_set:N  = \l_ZD_school_code_tl,
    security_classification .tl_set:N  = \l_ZD_security_classification_tl,
    degree_level .tl_set:N  = \l_ZD_degree_level_tl,
    
    terms_create .bool_set:N = \l_ZD_terms_create_bool,
    print_version .bool_set:N = \l_ZD_print_version_bool,
    anonymously_review .bool_set:N = \l_ZD_anonymously_review_bool,
    
    % 初始值
    degree_type .initial:n  = { 学术学位 },
    school_name .initial:n  = { 西藏大学 },
    school_code .initial:n  = { 10694 },
    security_classification .initial:n  = { 公开 },
    terms_create .initial:n = {false},
    print_version .initial:n = {false},
    anonymously_review .initial:n = {false},
}


%文档中基本信息填充名令
\NewDocumentCommand \BasicInfomation { m }
{
    \keys_set:nn { ZD_basic_information } { #1 }
    
    \bool_if:NTF {\l_ZD_anonymously_review_bool}
    {
		%启用盲审格式时，隐去有关信息
		%\regex_replace_all:nnN{.}{＊}{\l_ZD_student_name_tl} %姓名
		%\regex_replace_all:nnN{.}{*}{\l_ZD_student_number_tl} %学号
		%\regex_replace_all:nnN{.}{＊}{\l_ZD_teacher_name_tl} %导师姓名
		%\regex_replace_all:nnN{.}{＊}{\l_ZD_teacher_title_tl} %导师职称
		
		\tl_set:Nn \l_ZD_student_name_tl {} %姓名
		\tl_set:Nn \l_ZD_student_number_tl {} %学号
		\tl_set:Nn \l_ZD_teacher_name_tl {} %导师姓名
		\tl_set:Nn \l_ZD_teacher_title_tl {} %导师职称
		\tl_set:Nn \l_ZD_complete_date_tl {} %完成日期
		\tl_set:Nn \l_ZD_college_tl {} % 学院
		\tl_set:Nn \l_ZD_major_tl {} % 专业
		\tl_set:Nn \l_ZD_research_orientation_tl {} % 研究方向
		\tl_set:Nn \l_ZD_security_classification_tl {} % 密级
		
		%设置打印PDF版本为假
		\bool_set_false:N \l_ZD_print_version_bool
    }
    {}
    
    \tl_if_eq:NNTF \l_ZD_degree_level_tl \c_ZD_master_degree_tl 
    {
		\int_set_eq:NN \l_ZD_degree_level_int \c_ZD_master_degree_int
    }
    {
		\tl_if_eq:NNTF \l_ZD_degree_level_tl \c_ZD_doctor_degree_tl
		{
			\int_set_eq:NN \l_ZD_degree_level_int \c_ZD_doctor_degree_int
		}
		{
			\PackageError { setting } { degree~level~ `\tl_use:N \l_ZD_degree_level_tl' ~not~defined } { }
		}
    }
    
}

%
% 定义错误消息
%
\msg_new:nnn { ZD_Msg_Cover } { Teacher_Info_Mismatch } %导师信息匹配错误
{
  ERROR: ~ The ~ Cover ~ Teacher ~ Info ~ Mismatch.
}

\msg_new:nnn { ZD_Msg_Cover } { Teacher_Num_Many } %导师数量过多
{
  ERROR: ~ The ~ Cover ~ Teacher ~ Number ~ Too ~ Many.
}


%封面绘制

%封面的表格「填写相关内容」
%这表格里，需作判断，进行各种格式设定
%需要利用 tabularray 中的 expand 选项
%选把表格的内容生成好，再传入表格中即可
\NewExpandableDocumentCommand \CoverDrawInfoTableBody { }
{
	%这里不能用两个\space，会被压缩成一个
	姓名：~ & \exp_not:n{\texttt{\char32}\texttt{\char32}} & \tl_use:N \l_ZD_student_name_tl \\
	%这里，指导教师可能有多位，需要进行处理，采取不同对应的排版

	% 检查两个序列的长度是否相同
	\int_compare:nTF { \seq_count:N \l_tmpa_seq = \seq_count:N \l_tmpb_seq }
	{
		%长度相同
		\int_case:nnTF {\seq_count:N \l_tmpa_seq}
		{
			{0}
			{
				指导教师：~ & & 
							\tl_use:N \l_ZD_teacher_name_tl 
							\exp_not:n{ \hspace{\ccwd} \hspace{\ccwd} }
							\tl_use:N \l_ZD_teacher_title_tl
							\\
			}
			{1}
			{
				指导教师：~ & & 
							\tl_use:N \l_ZD_teacher_name_tl 
							\exp_not:n{ \hspace{\ccwd} \hspace{\ccwd} }
							\tl_use:N \l_ZD_teacher_title_tl
							\\
			}
			{2}
			{
				指导教师：~ & & 
							\seq_item:Nn \l_tmpa_seq {1}
							\exp_not:n{ \hspace{\ccwd} \hspace{\ccwd} }
							\seq_item:Nn \l_tmpb_seq {1}
							\\
							& & 
							\seq_item:Nn \l_tmpa_seq {2}
							\exp_not:n{ \hspace{\ccwd} \hspace{\ccwd} }
							\seq_item:Nn \l_tmpb_seq {2}
							\\
			}
			{3}
			{
				指导教师：~ & & 
							\seq_item:Nn \l_tmpa_seq {1}
							\exp_not:n{ \hspace{\ccwd} \hspace{\ccwd} }
							\seq_item:Nn \l_tmpb_seq {1}
							\\
							& & 
							\seq_item:Nn \l_tmpa_seq {2}
							\exp_not:n{ \hspace{\ccwd} \hspace{\ccwd} }
							\seq_item:Nn \l_tmpb_seq {2}
							\\
							& & 
							\seq_item:Nn \l_tmpa_seq {3}
							\exp_not:n{ \hspace{\ccwd} \hspace{\ccwd} }
							\seq_item:Nn \l_tmpb_seq {3}
							\\
			}
		}
		{}
		{
		%导师数量过多，报错
		\msg_error:nn { ZD_Msg_Cover } { Teacher_Num_Many }
		}
	}
	{
		% 如果长度不同，报错
		\msg_error:nn { ZD_Msg_Cover } { Teacher_Info_Mismatch }
	}
	
	
	学院：~ & & \tl_use:N \l_ZD_college_tl \\
	专业：~ & & \tl_use:N \l_ZD_major_tl \\
	研究方向：~ & & \tl_use:N \l_ZD_research_orientation_tl\\
	完成日期：~ & & \tl_use:N \l_ZD_complete_date_tl \\
}


\NewDocumentCommand \CoverDraw { }
{
\thispagestyle{empty}
\begingroup %控制行间距和字体范围
%右上角信息框
\begin{center}
	\flushright 
	\songti\small
	\begin{tikzpicture}[remember~picture,overlay]
		\node[inner~sep=0pt,anchor=north~east] (whitehead) at ([yshift=-19mm,xshift=-17mm]current~page.north~east)
		{\begin{tblr}{
					colspec={|cm{5.5\ccwd}|},
					hline{1,4} ,
				} 
				\makebox[5em][s]{{学校代码：}}\hspace*{-1em} & \tl_use:N \l_ZD_school_code_tl\\
				\makebox[5em][s]{{学号：}}\hspace*{-1em} & \tl_use:N \l_ZD_student_number_tl\\
				\makebox[5em][s]{{密级：}}\hspace*{-1em} & \tl_use:N \l_ZD_security_classification_tl
        \end{tblr}
		};
	\end{tikzpicture}
    %\\ \vspace*{4mm}
\end{center}%
\begin{center}
    \linespread{1} %单倍行间距 
	\centering
	\vspace*{14mm}
	\includegraphics[height=46mm]{pic/logo/png/dpi_300/all_new.png} %图标
	\\
	%硕士和博士这里有区别
	\int_case:nn \l_ZD_degree_level_int %根据 \l_ZD_degree_level_int 的值来确定不同的情况
	{
		{\c_ZD_master_degree_int} %硕士的情况
		{
			\vspace*{11mm}
			{
			\songti\LARGE
			\textbf{硕 \hspace{\ccwd} 士 \hspace{\ccwd} 学 \hspace{\ccwd} 位 \hspace{\ccwd} 论 \hspace{\ccwd} 文}
			\par
			\vspace*{2mm}
			}
			{
			\songti\large
			\textbf{（ \tl_use:N \l_ZD_degree_type_tl ）} %学位类型
			\par
			\vspace*{6mm}
			}
		}
		{\c_ZD_doctor_degree_int} %博士的情况
		{
			\vspace*{11mm}
			{
			\songti\LARGE
			\textbf{博 \hspace{\ccwd} 士 \hspace{\ccwd} 学 \hspace{\ccwd} 位 \hspace{\ccwd} 论 \hspace{\ccwd} 文}
			\par
			\vspace*{14mm}
			}
		}
	}
	{
	\kaishu\zihao{1}
	\tl_use:N \l_ZD_thesis_title_zh_tl %论文题目：中文
	\par
	\vspace*{3mm}
	\LARGE %英文字体比中文字体小
	\tl_use:N \l_ZD_thesis_title_en_tl %论文题目英文
	\par
	\vspace*{18mm}
	}
	{
	\songti\zihao{4}
	\seq_set_split:NnV \l_tmpa_seq { , } {\l_ZD_teacher_name_tl} %使用系统提供的临时变量
	\seq_set_split:NnV \l_tmpb_seq { , } {\l_ZD_teacher_title_tl}
	\begin{tblr}[expand=\expanded]{%表格设定
			colspec={lcm{12\ccwd}},
			hline{1}={white},
			hlines = {2-3}{solid},
			columns = {leftsep=0pt, rightsep=0pt,},
			rows = {abovesep=9pt,belowsep=-1pt},
			cell{1-8}{1} = {cmd=\makebox[5\ccwd][s]},
		}
		%表格的主体，由命令生成
		\expanded{\CoverDrawInfoTableBody}
	\end{tblr}
	}
\end{center}
\endgroup
\clearpage

\bool_if:NTF {\l_ZD_print_version_bool}
{
	%若为真，则需加入空白页
	\thispagestyle{empty} \null \newpage % 插入空白页
}
{
	\newpage
}

}

%作者声名

\NewDocumentCommand \AuthorStatement { }
{
	%声明页
	\thispagestyle{empty}
	\begin{center}
	\heiti \Large
	西藏大学研究生学位论文作者声明
	\par
	\vspace{18bp} %相当于空一行
	\end{center}
	\begingroup %控制行间距和字体范围
	\linespread{1.8} %单倍行间距
	\zihao{4}
	\par
	本人声明：本人呈交的学位论文是本人在导师指导下取得的研究成果。
	对前人及其他人员对本文的启发和贡献已在论文中做出了明确的声明，并表示了谢意。
	论文中除了特别加以标注和致谢的地方外，不包含其他人和其它机构已经发表或者撰写过的研究成果。
	\par
	本人同意学校根据《中华人民共和国学位条例暂行实施办法》等有关规定保留本人学位论文
	并向国家有关部门或资料库送交论文或者电子版，允许论文被查阅和借阅；
	本人授权西藏大学可以将本人学位论文的全部或者部分内容编入有关数据库进行检索，
	可以采用影印、缩印或者其它复制手段和汇编学位论文（保密论文在解密后应遵守此规定）。


	\begin{center}
		\centering
		\zihao{4}
		\begin{tblr}{colspec={XX},
			leftsep=0pt,
			rightsep=0pt,
		}
	&&\\
	&&\\
	学位论文作者签名：         &  \hspace{8mm}    指导教师签名： \\
	&&\\
	签字日期：\texttt{\char32}\texttt{\char32}年\texttt{\char32}\texttt{\char32}月\texttt{\char32}\texttt{\char32}日 
	&  \hspace{8mm}   
	签字日期：\texttt{\char32}\texttt{\char32}年\texttt{\char32}\texttt{\char32}月\texttt{\char32}\texttt{\char32}日
	\end{tblr}
	\end{center}
	\endgroup
	\clearpage

	\bool_if:NTF {\l_ZD_print_version_bool}
	{
		%若为真，则需加入空白页
		\thispagestyle{empty} \null \newpage % 插入空白页
	}
	{
		\newpage
	}
}



%中文摘要
\NewDocumentCommand \ZhAbstract { }
{
\pagestyle{my-pre-body-style} %前面摘要相关页眉页脚
\pagenumbering{Roman} %页码罗码计数
\setcounter{page}{1} %设定计数器

\phantomsection %让超链接能够正确链接，一般是加入目录用
\addcontentsline{toc}{chapter}{摘\hspace{\ccwd}要}
\begin{center}
\heiti\zihao{-2}
\vspace*{-4mm}
摘\hspace{\ccwd}要
\par
\vspace{12bp}
\end{center}
%\chapter*{摘\hspace{\ccwd}要} %与后面正文标题一致
}
\NewDocumentCommand \ZhAbstractKeyWord { m }
{
\par
\vspace{12bp} %相当于空一行
\noindent {\heiti 关键词：}~#1
\clearpage
}


%英文摘要
\NewDocumentCommand \EnAbstract { }
{
\bool_if:NTF {\l_ZD_print_version_bool}
{
	%若为真，则需判断是否需要加入空白页
	\int_if_odd:nTF {\theMyPageAllCounter} %判断奇偶
	{} % true
	{ % false
	\thispagestyle{empty} \null \stepcounter{MyPageAllCounter} \newpage % false, 为奇，插入空白页
	}
}
{
%若为假，什么都不做
}

\phantomsection %让超链接能够正确链接，一般是加入目录用
\addcontentsline{toc}{chapter}{ABSTRACT}
\begin{center}
\zihao{-2}
\vspace*{-4mm}
\textbf{ABSTRACT}
\par
\vspace{10bp}
\end{center}
%\chapter*{\textbf{ABSTRACT}} %与后面正文标题一致
}
\NewDocumentCommand \EnAbstractKeyWord { m }
{
\par
\vspace{12bp} %相当于空一行
\noindent \textbf{KEY~WORDS:}~\space #1
\clearpage
}


\RequirePackage{multicol} %两行排术语表
%目录自动创建
\NewDocumentCommand \TOCautoCreate {  }
{
\bool_if:NTF {\l_ZD_print_version_bool}
{
	%若为真，则需判断是否需要加入空白页
	\int_if_odd:nTF {\theMyPageAllCounter} %判断奇偶
	{} % true
	{ % false
	\thispagestyle{empty} \null \stepcounter{MyPageAllCounter} \newpage % false, 为奇，插入空白页
	}
}
{
%若为假，什么都不做
}

%添加「目录」到目录项
\phantomsection %让超链接能够正确链接，一般是加入目录用
\addcontentsline{toc}{chapter}{\contentsname}

\tableofcontents %创建目录
\clearpage

\bool_if:NTF {\l_ZD_terms_create_bool}
{
%若为真，创建术语表
\phantomsection %让超链接能够正确链接，一般是加入目录用
\addcontentsline{toc}{chapter}{中英术语表}
\chapter*{中英术语表}
\begin{multicols}{2}
	\begin{itemize}
		\setlength\itemsep{0mm}
		\input{date/terms.txt}
	\end{itemize}
\end{multicols}
\clearpage
}
{
%若为假，什么都不做
}


\bool_if:NTF {\l_ZD_print_version_bool}
{
	%若为真，则需判断是否需要加入空白页
	\int_if_odd:nTF {\theMyPageAllCounter} %判断奇偶
	{} % true
	{ % false
	\thispagestyle{empty} \null \stepcounter{MyPageAllCounter} \newpage % false, 为奇，插入空白页
	}
}
{
%若为假，什么都不做
}

%正文部分页眉页脚，页码编号
\setcounter{page}{1} %正文页码计数开始
\pagenumbering{arabic} %页码数字计数
\pagestyle{my-body-style} %正文部分页眉页脚
}



%
%术语表自动创建
%
%create new I/O write variable
\iow_new:N \l_temp_trems_iow

%文档开头执行
\AtBeginDocument {
	%打开文件
	\iow_open:Nn \l_temp_trems_iow { date/terms_temp.txt }
}

%文档未尾执行
\AtEndDocument {
	
	
	%关闭文件
	\iow_close:N \l_temp_trems_iow
	
	
	%将术语相关信息，从临时文件写入固定文件，供第二次编译调用
	
	%打开文件
	%变量 \g_tmpa_iow \g_tmpa_ior 原生提供
	\iow_open:Nn \g_tmpa_iow { date/terms.txt }
	\ior_open:Nn \g_tmpa_ior { date/terms_temp.txt }
	
	
	%变量 \l_tmpa_str 原生提供
	\ior_str_map_variable:NNn \g_tmpa_ior \l_tmpa_str {
	\iow_now:Nx \g_tmpa_iow {\l_tmpa_str}
	}
	
	%关闭文件
	\ior_close:N \g_tmpa_ior
	\iow_close:N \g_tmpa_iow
}


\NewExpandableDocumentCommand{\myterm}{O{0}mm}
{%
	\int_case:nnF {#1}
	{%
		{0}%默认显示中英文
		{%
			#2(#3)%
			%仅在默认显示中英文的情况下，才将相应的术语写入术语表
			%将术语写入文件，制作术语表
			\iow_now:Nx \l_temp_trems_iow {%
				\c_backslash_str item
				^^J %换行符
				%#2~\c_backslash_str quad~#3
				#2：#3
				}%
		}
		{1}%仅显示中文
		{#2}
		{2}{}%不显示任何信息
	}
	{\textcolor{red}{未定义参数}}%
}


%参考文献自动创建
\NewDocumentCommand \RefautoCreate {  }
{
\clearpage
\phantomsection %让超链接能够正确链接，一般是加入目录用
\addcontentsline{toc}{chapter}{参考文献}
\printbibliography[heading=bibliography,title=参考文献] %打印参考文献表
}


%附录开始
\NewDocumentCommand \AppendixStart {  }
{
\appendix %附录开始
}


%其它内容开始
\NewDocumentCommand \OtherStart { mm }
{
% 设置相关科研成果目录和致谢的标题
\ctexset{
	chapter/numbering=false,
	section/numbering=false,
	subsection/numbering=false,
	subsubsection/numbering=false,
}

%根据盲审是否启用，决定致谢和学术成果的显示
\bool_if:NTF {\l_ZD_anonymously_review_bool}
{ #2 }
{ #1 }
}

