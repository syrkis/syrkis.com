// imports ///////////////
#import "@preview/arborly:0.3.1": tree
#import "@preview/diagraph:0.3.3": raw-render
#import "@preview/lovelace:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes
#import "@local/esch:0.0.0": *
#import "@preview/lilaq:0.3.0" as lq
#import "/src/assets/conf.typ": *



// head /////////////////////////////////////////////////////////////////////////
#let title = "Socioscope — Cultural Geometry Based Cybernetic Sensor"

// #show: lilka

#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(
    handout: (
      sys.inputs.at("handout", default: "true") == "true"
    ),
  ),
)

#metadata((
  title: title,
  date: datetime(year: 2025, month: 5, day: 6),
))<frontmatter>


= Introduction

#slide[][]


// #[
// #show heading.where(level: 1): set heading(numbering: none)
// = Index of Sources <touying:unoutlined>
// #set align(top)
// #pad(y: 2em, bibliography(
// "/src/assets/zotero.bib",
// title: none,
// style: "ieee",
// ))
// ]
