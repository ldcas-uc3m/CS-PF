/*
This is a modification of GUL UC3M's Typst report template, available at
https://github.com/guluc3m/report-template-typst
*/

#let azuluc3m = rgb("#000e78")

#let cover(
  degree,
  subject,
  project,
  title,
  year,
  logo,
  group: none,
  authors: (),
  review_team: none,
  team: none,
  language: "es"
) = [
  #set align(center)
  #set text(azuluc3m)
  #set text(size: 17pt)
  #set page(header: [], footer: [])

  // logo
  #if logo == "new" [
    #image("../img/new_uc3m_logo.svg", width: 100%)
    #v(1em)
  ] else [
    #image("../img/old_uc3m_logo.svg", width: 45%)
    #v(1em)
  ]

  #emph(degree)

  #subject #year.at(0)/#year.at(1)\
  Grupo #group

  #v(3em)

  #emph(project)\
  #text(25pt, ["#title"])

  #v(1em)

  #line(length: 70%, stroke: azuluc3m)

  #v(1em)

  // authors
  _Equipo de revisión_\
  #{
    set text(19pt)
    for author in authors [
      #author.name #author.surname --- #author.nia\
    ]
  }

  #if team != none [
    Team #team
  ]

  #v(3em)


  #pagebreak()
  #counter(page).update(1)
]


/**
 * Writes authors in the short format
*/
#let shortauthors(authors: ()) = {
  for (i, author) in authors.enumerate() {

    // name
    for name in author.name.split(" ") {
      name.at(0) + ". "
    }

    // surname
    if "surname_length" in author{
      author.surname.split(" ").slice(0, count: author.surname_length).join(" ")
    } else {
      author.surname.split(" ").at(0)
    }

    // connector
    if i < authors.len() - 2 {
      ", "
    } else if i == authors.len() - 2 {
      " & "
    }
  }
}


#let conf(
  degree: "",
  subject: "",
  year: (),
  authors: (),
  project: "",
  title: "",
  group: none,
  review_team: none,
  team: none,
  language: "en",
  toc: true,
  logo: "new",
  bibliography_file: none,
  chapter_on_new_page: true,
  doc
) = {

  /* TEXT */

  set text(size: 12pt, lang: language)

  set par(leading: 0.65em, spacing: 1em, first-line-indent: 1.8em, justify: true)


  /* HEADINGS */

  set heading(numbering: "1.")
  show heading: set text(azuluc3m)
  show heading: set block(above: 1.4em, below: 1em)
  show heading.where(level: 1): it => {
    if chapter_on_new_page { pagebreak(weak: true) }
    it
  }

  // allow to set headings with selector `<nonumber` to prevent numbering
  show selector(<nonumber>): set heading(numbering: none)


  /* FIGURES */

  // figure captions w/ blue
  show figure.caption: it => {
    [
      #set text(azuluc3m, weight: "semibold")
      #it.supplement #context it.counter.display(it.numbering):
    ]
    it.body
  }


  // more space around figures
  // https://github.com/typst/typst/issues/6095#issuecomment-2755785839
  show figure: it => {
    let figure_spacing = 0.75em

    if it.placement == none {
      block(it, inset: (y: figure_spacing))
    } else if it.placement == top {
      place(
        it.placement,
        float: true,
        block(width: 100%, inset: (bottom: figure_spacing), align(center, it))
      )
    } else if it.placement == bottom {
      place(
        it.placement,
        float: true,
        block(width: 100%, inset: (top: figure_spacing), align(center, it))
      )
    }
  }

  // captions on top for tables
  show figure.where(kind: table): set figure.caption(position: top)


  /* REFERENCES */

  show ref: set text(azuluc3m)


  /* FOOTNOTES */

  // change line color
  set footnote.entry(separator: line(length: 30% + 0pt, stroke: 0.5pt + azuluc3m))

  // change footnote number color
  show footnote: set text(azuluc3m)  // in text
  show footnote.entry: it => {  // in footnote
    h(1em)  // indent
    {
      set text(azuluc3m)
      super(str(counter(footnote).at(it.note.location()).at(0)))  // number
    }
    h(.05em)  // mini-space in between number and body (same as default)
    it.note.body
  }



  /* PAGE LAYOUT */

  set page(
    paper: "a4",
    margin: (
      y: 2.5cm,
      x: 3cm,
    ),

    // header
    header: [
      #set text(azuluc3m)
      #project
      #h(1fr)
      #subject, grp. #group

      #v(-0.7em)
      #line(length: 100%, stroke: 0.4pt + azuluc3m)
    ],

    // footer
    footer: context [
      #line(length: 100%, stroke: 0.4pt + azuluc3m)
      #v(-0.4em)

      #set align(right)
      #set text(azuluc3m)
      #shortauthors(authors: authors)
      #h(1fr)
      #let page_delimeter = "of"
      #if language == "es" {
        page_delimeter = "de"
      }
      #counter(page).display(
        "pg. 1 " + page_delimeter + " 1",
        both: true,
      )
    ]
  )


  /* COVER */

  cover(
    degree,
    subject,
    project,
    title,
    year,
    logo,
    authors: authors,
    review_team: review_team,
    group: group,
    team: team,
    language: language
  )


  /* TOC */

  if toc {
    let outline_title = "Table of Contents"
    if language == "es"{
      outline_title = "Tabla de Contenidos"
    }

    set page(header: [], footer: [])

    outline(title: outline_title)
    pagebreak()
    counter(page).update(1)
  }

  doc


  /* BIBLIOGRAPHY */

  if bibliography_file != none {
    pagebreak()
    bibliography(bibliography_file, style: "ieee")
  }
}
