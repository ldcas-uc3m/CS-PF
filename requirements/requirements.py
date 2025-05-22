"""
Script to transform Requirements from SES Engineering Studio into LaTeX tables.

Python dependencies: ["pandas>=2.2.3", "xlrd>=2.0.1"]
LaTeX depencencies: `calc`, `booktabs`, `placeins`

Usage: python requirements.py <INPUT-FILE> -o <OUTPUT-FILE>

@author: Luis Daniel Casais Mezquida <luisdaniel.casais@alumnos.uc3m.es>
"""

import argparse
from string import Template
from math import floor

import pandas as pd  # `xlrd` is also required


# parser config
parser = argparse.ArgumentParser(
    description="Transforms Requirements from SES Engineering Studio into LaTeX markup. Please make sure to import the `calc`, `booktabs`, and `placeins` LaTeX packages",
    formatter_class=argparse.ArgumentDefaultsHelpFormatter,
)
parser.add_argument(
    "input",
    help="input XLS file",
    # "input", type=argparse.FileType("r"), help="Input XLS file"  # for some reason pandas shits itself if I use this
)
parser.add_argument(
    "-o",
    "--output",
    type=argparse.FileType("a"),
    default="-",
    help="output file (appends to file)",
)
parser.add_argument(
    "--sheet", type=int, default=0, help="sheet index of the requirements"
)
parser.add_argument(
    "--prefix",
    type=str,
    default="REQ",
    help="prefix for the requirement ID",
)
parser.add_argument(
    "--skip",
    type=int,
    help="number of requirements to skip",
)
parser.add_argument(
    "--trim",
    type=int,
    help="number of requirements to cut from the end",
)


# LaTeX templates

# requires LaTeX packages `calc`, `booktabs`, and `placeins`
REQUIREMENT_MACRO = r"""
% \requirement{<id>}{<description>}{<quality>}
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


FIX_TEMPLATE = Template(r"""
% enable obscene amount of tables without breaks
\maxdeadcycles=$cycles
\extrafloats{$floats}


""")


TABLE_TEMPLATE = Template(r"""
\requirement{$id}
  {
    $description
  }
  {$quality}
""")


QUALITY_LEVEL_MAP = {3: "High", 2: "Medium", 1: "Low"}


def escape_latex_sequences(text: str) -> str:
    """
    Escapes the LaTeX special sequences
    """
    return text.replace("%", "\\%").replace("$", "\\$").replace("_", "\\_")


def generate_requirements(
    sheet_index: int,
    prefix: str,
    fin: str,
    fout: argparse.FileType,
    skip: int | None,
    trim: int | None
):
    """
    Writes the requirements from the specified type to the output file

    :param sheet_index: Index of the XLS sheet
    :param type: Requirement type
    :param prefix: Requirement ID prefix
    :param fin: Input file
    :param fout: Output file
    :param skip: Requirements to skip
    :param skip: Requirements to cut from the end
    """

    requirements = pd.read_excel(fin, sheet_name=sheet_index)

    if skip:
        requirements = requirements.iloc[skip:].reset_index()

    if trim:
        requirements = requirements.iloc[:-trim]

    if len(requirements) >= 50:
        # too many floating elements (tables) for LaTeX
        # see https://tex.stackexchange.com/questions/409796/todonotes-output-loop-100-consecutive-dead-cycles-after-50-todo-on-a-page
        # and https://tex.stackexchange.com/questions/46512/too-many-unprocessed-floats
        fout.write(
            FIX_TEMPLATE.substitute(
                cycles=200 * floor(len(requirements) / 50),
                floats=len(requirements),
            )
        )

    for i, req in requirements.iterrows():
        fout.write(
            TABLE_TEMPLATE.substitute(
                id=f"{prefix}-{i + 1:02}" if prefix else f"{req.Code:02}",
                description=escape_latex_sequences(req.Description),
                # quality=req.QualityLevel,
                quality=QUALITY_LEVEL_MAP.get(req.NumericQuality, "N/A"),  # our excel got fucked up and we had to manually add the number of stars
            )
        )


if __name__ == "__main__":
    # parse arguments
    args = parser.parse_args()

    # add macro
    args.output.write(REQUIREMENT_MACRO)

    # generate reqs
    generate_requirements(
        sheet_index=args.sheet,
        prefix=args.prefix,
        fin=args.input,
        fout=args.output,
        skip=args.skip,
        trim=args.trim
    )
