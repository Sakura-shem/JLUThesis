# JLU-Thesis - 吉林大学 LaTeX 论文模板
此项目提供用于排版吉林大学 本科生 毕业论文的LaTeX模板。
基于 2019级 通信工程学院 模板制作。

The Project provides a Latex template for JiLin university Graduation Thesis.
Make it based on the word template of 2019's School of Communication Engineering.

## Example
<div style="text-align: center">
    <img width="1884" alt="Snipaste_2023-04-18_01-01-44" src="https://user-images.githubusercontent.com/78149191/232962109-3aac7740-4edd-4eb5-ba02-bb13a3fad74d.png"> <br>
    <p align="center">Example</p>
</div>


[Example PDF](https://github.com/Sakura-shem/JLUThesis/blob/master/main.pdf)

## Usage
**star ⭐**
- Online: Overleaf website
  - Download [JLU-Thesis-Overleaf.zip](./JLU-Thesis-Overleaf.zip);
  - Create project by import zip file;
  - Choose Compiler as XeLaTex;
  - **OverLeaf can't edit cfg file. you can edit it offline then upload**
  - **OverLeaf zip file may not the latest. you can replace cls and cfg file to keep latest.**
- Local: Miktex + vscode；
### Change style
you can edit the .cfg file to change the style. Here are the available parameters and the correspording styles.

如果你需要更改某些样式，你可以更改 .cfg 对应的参数。下面是支持的参数和对应的效果解释。

- \cfgstyle@fetindex：How pictures, tables, formulas are numbered.
    - 0: gloabl
    - 1: 图 3.2 \<figlabel>
    - 图 3-2 \<figlabel>
- \def\cfgstyle@citation{0}: The style of citation.
    - 0: gbt7714-numerical
    - 1: gbt7714-author-year 

## Todo
- 优化细节。

## Thanks
- [bjtuThesis](https://github.com/csarron/bsThesisWHU)
