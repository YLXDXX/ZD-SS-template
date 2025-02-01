#  西藏大学硕博论文模板

#### 介绍
西藏大学研博毕业论文 LaTeX 模板

本项目的体积有点大，主要是为了保证 Linux、macOS、windows 三个平台下体验一致，项目直接包含了用到的几种字体

本模板采用 LaTeX3 编写，包含两种学位「硕士、博士」和三种版本「阅读、打印、盲审」，均可一键切换

一些未尽事宜，参照本科编写

## 说明

模板地址：https://gitee.com/ylxdxx/ZD-SS-template

在使用过程中有什么问题，可在上面仓库的问题区「issues」提出

#### 测试环境

- 系统：Debian 12
- 发行版：TexLive 2024
- 编译器：XeLaTeX
- 编辑器：TeXStudio

#### 编译小提示

编译成 PDF 应使用 XeLaTeX 引擎，处理参考文献应使用 Biber 引擎

有些使用 Windows 且用 TeXStudio 的同学，编译正常但参考文献的生成有问题，请进行如下排查：

1. 参考文献编译是否选择了 Biber 引擎

2. 若选择 Biber 后依然有问题，请查看编译信息，确认其是否自动执行了参考文献的编译工作，如果没有则需手动执行「Tools -> Bibliography，或直接按 `F8` 键」，再正常编译一下即可。

   如果嫌每次手动麻烦，提供两种自动方案

   - 修改 TeXStudio 编译流程
   - 换用 Latexmk ，添加 `-xelatex` 选项 



#### 其它相关

- 西藏大学本科论文模板：https://gitee.com/ylxdxx/ZD-XS-template

- 西藏大学课程论文模板：https://gitee.com/ylxdxx/ZDCourse
