// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *
#import "@preview/fletcher:0.5.7": *
#import "@preview/simplebnf:0.1.1": *


// head /////////////////////////////////////////////////////////////////////////
#let title = "Esch — A Framework for Numerical Typography"

#show: lilka
#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: true),
)

#metadata((
  title: title,
  date: datetime(year: 2025, month: 5, day: 6),
))<frontmatter>

#focus-slide[
  #figure(stack(
    // spacing: 1em,
    image("s3/esch/multi_grid.svg", width: 100%),
    image(
      "s3/esch/multi_anim_grid.svg",
      width: 100%,
    ),
  ))
]

#focus-slide[
  #figure(stack(
    dir: ltr,
    spacing: 0.5em,
    stack(spacing: 1em, image("s3/esch/mesh.svg", height: 50%), image(
      "s3/esch/sims.svg",
      height: 50%,
    )),
    stack(spacing: 1em, image("s3/esch/grid.svg", height: 50%), image(
      "s3/esch/anim_grid.svg",
      height: 50%,
    )),
  ))
]



= Symbols and Letters

- Information theoretically, an alphabet is a non-empty set of symbols #pause
- Often denoted $xi = {s_1, s_2, ...}$ or in the continuous case
  ${s_i : i in RR}$ #pause
- The family of alphabets famously include ${A, B, ..., Z}$, ${0, 1}$, and
  ${A, C, T, G}$ #pause
- A shared quality between all symbols is the care with which they so often are
  drawn


#slide[
  #figure(
    stack(
      spacing: 1em,
      $bb(A space B space C space D space E space F space G space H space I space J space K space L space M space N space O space P space Q space R space S space T space U space V space X space Y space Z)$,
      // pause,
      $frak(A space B space C space D space E space F space G space H space I space J space K space L space M space N space O space P space Q space R space S space T space U space V space X space Y space Z)$,
      // pause,
      "А Б В Г Д Е Ё Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ъ Ы Ь Э Ю Я",
      v(0.5em),
    ),
    caption: [The Latin alphabet in double-struck (top) and Fraktur (middle),

      and the Cyrillics in Libertinus Serif (bottom)],
  )

]

#slide[
  - The embryology of topography is frequently present in the symbols fenotype
  - Worked laboriously into metal plates, symbols were assembled into strings
]

= Drawing ${s_i : i in RR}$

- ESCH is a typography for representing quantity and strings here of
- [$8 space 2 space 4 space 2 space 6 space 8$] becomes
  [$square.filled.big square.filled.tiny square.filled.small square.filled.tiny square.filled.medium square.filled.big$]
  ... or, depending on the font,
  [$circle.filled.big circle.filled.tiny circle.filled.small circle.filled.tiny circle.filled circle.filled.big$]
- Negative numbers become
  [$square.stroked.big square.stroked.tiny square.stroked.small square.stroked.tiny square.stroked.medium square.stroked.big$]
  (or
  [$circle.stroked.big circle.stroked.tiny circle.stroked.small circle.stroked.tiny circle.stroked circle.stroked.big$])


= ${M in RR^(n times m)}$

#slide[
  -
][
  #figure(image("s3/esch/grid.svg", width: 100%), caption: [Esch representation
    of $J_(5,10)$])
]

#focus-slide[
  #figure(image("s3/esch/anim_grid.svg", width: 100%), caption: [Esch of
    $A in RR^(5 times 10 times 100)$ (last dimension is temporal)])
]

= Position and Quantity

#figure(image("s3/esch/neuroscope.svg", width: 70%), caption: [Esch
  representation of $J_(5,10)$])

= Simulation and Simulacra

#figure(image("s3/esch/anim_sims.svg", height: 60%), caption: [Esch
  representation of random actions in Parabellum @anne2025])

#[
  #show heading.where(level: 1): set heading(numbering: none)
  = References <touying:unoutlined>
  #set align(top)
  #pad(y: 2em, bibliography("/src/assets/zotero.bib", title: none))
]

#appendix[
  = Trees vs. Arrays<array>

  #slide[
    - Trees versus arrays
    - Leaf nodes are actions and conditions
    - Rest are sequence or fallback combinators
  ]
]
