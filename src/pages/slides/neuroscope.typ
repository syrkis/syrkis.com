
// imports ///////////////
#import "@preview/prequery:0.1.0"
#import "@preview/touying:0.5.5": *
#import "@preview/equate:0.2.1": equate
#import "/src/assets/lib.typ": *


// head /////////////////
#let title = "Deep Decoding the Cerebral Cortex"
#show: escher-theme.with(
  aspect-ratio: "16-9",
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: false), // <- for presentations
)

#metadata((
  title: title,
  slug: "neuroscope",
))<frontmatter>

// body ///////////////////////
#cover-slide()


= Title

Hello, Touying!

= second

Hello, Typst!

= bub

Hello, Typst!

= blah

Hello, Typst!
