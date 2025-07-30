// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *


// head /////////////////////////////////////////////////////////////////////////
#let title = "Neuroscope"

#show: lilka
#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: false),
)

#metadata((
  title: title,
  date: datetime(year: 2025, month: 5, day: 6),
))<frontmatter>


= test

#lorem(100)
