# [PlantUML](https://plantuml.com/) diagrams

## Requirements
- [Java](https://www.java.com/)
- The latest version of the [`plantuml.jar` file](https://plantuml.com/es/download)

<!-- > [!NOTE]
> For some GOD FORSAKEN REASON, I was only able to make it export to PDF with the [`plantuml-pdf-1.2025.1.jar`](https://github.com/plantuml/plantuml/releases/download/v1.2025.1/plantuml-pdf-1.2025.1.jar) file... -->


## Compilation
We'll export the files to the parent folder in SVG format.
```
java -jar </path/to/plantuml.jar> -o .. -tsvg <diagram>.puml
```


## VS Code
The recommended extension is [`jebbs.plantuml`](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml).