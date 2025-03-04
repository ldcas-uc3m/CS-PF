#!/bin/bash

set -e

if [ ! -f plantuml.jar ]; then
    # download plantuml
    wget https://github.com/plantuml/plantuml/releases/download/v1.2025.1/plantuml.jar
fi

for diagram in src/*.puml; do
    java -jar plantuml.jar -o .. -tsvg "src/$filename"
done