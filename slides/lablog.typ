// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *
#show: lilka


// head /////////////////////////////////////////////////////////////////////////
#let title = "Lab Log"

#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: (
    sys.inputs.at("handout", default: "false") == "true"
  )),
)

#metadata((
  title: title,
))<frontmatter>



// body //////////////////////////////////////////
= Parabellum

#slide[
  - Blog post (draft) at virian.com/parabellum
  - Running millions of units
  - On #link("https://parabellum.syrkis.com", `parabellum.syrkis.com`) (no backend)
  - No code change#footnote[#link("https://github.com/syrkis/parabellum", "github.com/syrkis/parabellum")]
  - Gymnasium like (could be used with RL, etc.)
  - TODO: add unit communication? Promote?
][
  #figure(
    image("s3/esch/parabellum_new.svg", width: 80%),
    caption: [Random actions taken in Parabellum

      (shown with #link("https://github.com/syrkis/esch", `esch`))
    ],
  )
]

= btc2sim

- Not updated code #footnote[#link("https://github.com/syrkis/btc2sim", "github.com/syrkis/btc2sim")]
- TODO:
  - Add more atomics / grammar
  - Speed test to keep parabellum millions

= JAX Plan

- Trying to use `jraph` for storing plan (graph)

// = MIIII

// - Test

// = EEMBRYO

// - Running in minecraft?

// = Socioscope

// - Constructing graphs in julia

= Reading

-

#[
  #show heading.where(level: 1): set heading(numbering: none)
  = Index of Sources <touying:unoutlined>
  #set align(top)
  #pad(y: 2em, bibliography("zotero.bib", title: none, style: "ieee"))
]
