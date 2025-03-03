$pdf_mode = 4;  # export to PDF
$lualatex = 'lualatex --file-line-error %O %S';  # use LuaLaTeX

# set shell-escape
set_tex_cmds('--shell-escape -interaction=nonstopmode %O %S');

# $out_dir = 'build';  # for some FUCKING reason, this breaks PlantUML

# setup PlantUML
$ENV{PLANTUML_JAR} = 'plantuml-1.2025.1.jar';

# cleanup files
$clean_ext .= '%R-plantuml.tex %R-plantuml.latex %R-plantuml.txt aux bbl pytxcode svg-inkscape';
$clean_full_ext = 'build';