
// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *
#import "@preview/fletcher:0.5.7": *
#import "@preview/simplebnf:0.1.1": *



// head /////////////////
#let title = "Deep Decoding the Cerebral Cortex"
#show: lilka
#show: slides.with(
  aspect-ratio: "16-9",
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: false), // <- for presentations
)

#metadata((
  title: title,
  slug: "neuroscope",
))<frontmatter>

// body ///////////////////////
= Title

Hello, Touying!

= second

Hello, Typst!

= bub

Hello, Typst!

= blah

Hello, Typst!
