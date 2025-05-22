#!/bin/bash
uv run requirements.py 'Docs/Bicycle\ Requirements.xls' --sheet=1 --skip=5 --trim=1 -o ../parts/requisitos.tex