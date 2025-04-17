"""
Script to transform Requirements from SES Engineering Studio into LaTeX tables.

Python dependencies: ["pandas>=2.2.3", "xlrd>=2.0.1"]
LaTeX depencencies: `calc`, `booktabs`, `placeins`

Usage: python requirements.py <INPUT-FILE> -o <OUTPUT-FILE>

@author: Luis Daniel Casais Mezquida <luisdaniel.casais@alumnos.uc3m.es>
"""

import argparse
from string import Template

import pandas as pd  # `xlrd` is also required


# parser config
parser = argparse.ArgumentParser(
    description="Transforms Requirements from SES Engineering Studio into LaTeX code.",
)
parser.add_argument(
    "input",
    help="Input XLS file",
    # "input", type=argparse.FileType("r"), help="Input XLS file"  # for some reason pandas shits itself if I use this
)
parser.add_argument(
    "-o",
    "--output",
    type=argparse.FileType("a"),
    default="-",
    help="Output file (appends to file)",
)


# requires LaTeX packages `calc`, `booktabs`, and `placeins`
REQUIREMENT_MACRO = r"""
\newcommand{\requirement}[3]{%
\begin{table}[htbp]
  \centering
  \noindent
  \begin{tabular}{@{}p{83pt}@{}p{.85\columnwidth-83pt}@{}}
    \toprule
    \multicolumn{2}{@{}l}{\bfseries{#1}} \\
    \hline
    \textbf{Description}   & {#2} \\
    \textbf{Quality Level} & {#3} \\
    \bottomrule
  \end{tabular}
  \caption{Requirement #1}
  \label{req:#1}
\end{table}
}


"""


TABLE_TEMPLATE = Template(r"""
\requirement{$id}
  {
    $description
  }
  {$level}
""")


def escape_latex_sequences(text: str) -> str:
    """
    Escapes the LaTeX special sequences
    """
    return text.replace("%", "\\%").replace("$", "\\$").replace("_", "\\_")


def generate_type_requirements(
    sheet_index: int,
    type: str,
    prefix: str,
    fin: str,
    fout: argparse.FileType,
):
    """
    Writes the requirements from the specified type to the output file

    :param sheet_index: Index of the XLS sheet
    :param type: Requirement type
    :param prefix: Requirement ID prefix
    :param fin: Input file
    :param fout: Output file
    """

    fout.write(f"\n\n\\subsection{{{type} requirements}}\n\n")

    for _, req in pd.read_excel(fin, sheet_name=sheet_index).iterrows():
        fout.write(
            TABLE_TEMPLATE.substitute(
                id=f"{prefix}-{req.Code:02}",
                description=escape_latex_sequences(req.Description),
                level=req.QualityLevel,
            )
        )


if __name__ == "__main__":
    # parse arguments
    args = parser.parse_args()

    # add macro
    args.output.write(REQUIREMENT_MACRO)

    # generate stakeholder reqs
    generate_type_requirements(
        sheet_index=0,
        type="Stakeholder",
        prefix="STR",
        fin=args.input,
        fout=args.output,
    )

    args.output.write(
        "\n\n\\FloatBarrier  % prevents previous tables from being placed below this point\n\n"
    )

    # generate system reqs
    generate_type_requirements(
        sheet_index=0,
        type="System",
        prefix="SYS",
        fin=args.input,
        fout=args.output,
    )
