= Consideraciones sobre el contenido del documento
A continuación, se mencionarán los aspectos, tanto positivos como negativos, de
cada uno de los apartados del documento.

== Descripción de la empresa
La sección presenta y describe correctamente la misión, visión y valores de la empresa, y deja claro el porqué de cada uno de ellos.


== Arquitectura y sistema
En general, se explica correctamente la arquitectura y el diseño del sistema,
definiendo los distintos componentes. Con respecto al funcionamiento del
sistema, nos surgen algunas dudas.

En la página 5 se menciona que #quote([El barco nodriza funciona mediante
energía solar [...]]), y esto nos hace preguntarnos si el navío va a estar
alimentado exclusivamente por energía solar. Si ese es el caso, ¿qué ocurriría
cuando no haya luz solar?

En el siguiente párrafo también se menciona que #quote([la gestión, control y
seguimiento de problemas [...] se efectúa desde un sistema de control
centralizado a bordo del barco [...] y otro en tierra, en una de las sedes de
Sealive situada en Tenerife]). Nos resulta un poco extraño que, operando los
barcos en el Mediterráneo, el centro de control esté a más de 3,000 km en el
Océano Atlántico, aunque asumimos que habría algún tipo de centro de control
intermedio en el embarcadero desde donde saliesen los barcos.

En el Diagrama de Componentes de la página 6, creemos que sería necesario algún
tipo de componente de navegación en el dron submarino, dado que éste realiza una
navegación autónoma.

Con respecto al Diagrama de Despliegue de la página 8, opinamos que los _frames_ de "Servidor de barco: Servidor JANUS", "Servidor de barco: Redis" y "Servidor de barco: HTTP" deberían ser componentes de un único _frame_ "Servidor de barco". También vemos necesario usar el símbolo de la base de datos (un cilindro) en los elementos de "PostgreSQL" y "#strike([Servidor de barco: ])JANUS". Por último, se deberían mostrar los componentes mencionados en el Diagrama de Componentes en éste diagrama.


== Aplicación de estándares ITIL e ISO15288 <sec:estandares>
La aplicación de los distintos estándares nos ha sorprendido gratamente, ya que
se adecúa al sistema y está correctamente descrito y justificado. Sin embargo,
en ningún punto se menciona qué entradas del proceso corresponden a qué
actividad, ni qué salidas provienen de qué actividad.

Las figuras de las páginas 9 y 15, que sirven a modo de introducción al proceso,
cuentan con el texto de las entradas y las salidas duplicado, y en otro idioma,
lo cual nos parece reiterativo y algo confuso. Por otro lado, no vemos necesario
la inclusión de estos diagramas, ya que consideramos que los Diagramas de
Actividad, si se incluyeran las entradas y salidas, serían suficientes.

También cabe mencionar que la redacción de la descripción de las actividades del
primer proceso es algo pobre, pareciendo casi una enumeración, en contraste con
las del segundo proceso.

Otro aspecto positivo es la descripción de las subactividades en el proceso de
Operación, y los diagramas de actividad, los cuales clarifican el flujo del
proceso.

Con respecto a las matrices RACI, los roles no vienen especificados, aunque es
cierto que algunos de ellos (aunque no todos) se mencionan en el organigrama. La
matriz del primer proceso, en la actividad de "Identificación de Configuración"
no cuenta con ningún rol que sea el #quote([Responsable final de que la
actividad se realice (A)]), y en la segunda matriz, la actividad de
"Planificación de la operación" tampoco cuenta con ningún rol que sea el
#quote([Responsable de realizar la actividad (R)]). Tampoco aparece ninguna
introducción a la matriz RACI del segundo proceso.


== Organigrama
La estructura organizativa está bien definida y jerarquizada. Se entiende claramente la función de cada equipo, las relaciones de dependencia y la coordinación entre ellos. Es un acierto haber incluido equipos específicos como el de Desarrollo de IA, el de Configuración y el Comité de Cambios, ya que estos reflejan un enfoque profesional y técnico en la gestión de un sistema complejo como el de los ROVs.

Sin embargo, se echa en falta una indicación explícita del tamaño aproximado de cada equipo, lo cual ayudaría a entender mejor la carga de trabajo y la distribución de responsabilidades. 

== Plan económico
El análisis económico es bastante detallado, con desglose claro de inversión inicial, costes operativos y fuentes de ingresos. La presentación de rangos para los valores económicos aporta flexibilidad y demuestra que se han considerado distintas escalas de operación. También se valora positivamente la inclusión de flujos de caja y la cuenta de resultados simplificada.

No obstante, algunos supuestos podrían explicarse mejor, como por ejemplo la procedencia exacta de las subvenciones esperadas o el grado de certeza sobre los contratos de servicio. También sería recomendable aclarar cómo se pretende financiar la inversión inicial tan elevada (hasta 23.1M €).

Además, dado que se prevé que la rentabilidad neta llegue a muy largo plazo (más de 7 años), podría ser útil incluir estrategias de mitigación de riesgo financiero o posibles planes de escalado progresivo.

== Presentación
La presentación realizada por el equipo nos pareció de una muy alta calidad,
tanto de los materiales usados para la misma como de la exposición por parte de
los miembros del equipo. Se expusieron correctamente las ideas y se contestaron
satisfactoriamente las preguntas realizadas.
