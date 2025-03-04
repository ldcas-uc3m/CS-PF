# [PlantUML](https://plantuml.com/) diagrams

## Requirements
- [Java](https://www.java.com/)
- The latest version of the [`plantuml.jar` file](https://plantuml.com/es/download)

<!-- > [!NOTE]
> For some GOD FORSAKEN REASON, I was only able to make it export to PDF with the [`plantuml-pdf-1.2025.1.jar`](https://github.com/plantuml/plantuml/releases/download/v1.2025.1/plantuml-pdf-1.2025.1.jar) file... -->


## Compilation
We'll export the source files inside `src` to the current directory, in SVG format:
```
java -jar </path/to/plantuml.jar> -o .. -tsvg src/<diagram>.puml
```

To simplify the process, a bash script ([`compile.sh`](compile.sh)) is provided.


## VS Code
The recommended extension is [`jebbs.plantuml`](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml).