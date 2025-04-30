#import "style.typ": conf

#show: conf.with(
  degree: "Máster en Ingeniería Informática",
  subject: "Calidad de Software",
  year: (24, 25),
  project: "Revisión cruzada",
  title: [Plan de Negocio Sealive],
  group: 1,
  authors: (
    (
      name: "Luis Daniel",
      surname: "Casais Mezquida",
      nia: 100429021
    ),
    (
      name: "Martin",
      surname: "Shao He",
      nia: 100451260
    ),
    (
      name: "Pablo",
      surname: "Fernández de la Puente Jaureguízar",
      surname_length: 4,
      nia: 100409646
    ),
  ),
  logo: "old",
  toc: true,
  language: "es",
)


#include "positivos.typ"
#include "formato.typ"
#include "review.typ"