// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "/src/assets/conf.typ": *


// head /////////////////////////////////////////////////////////////////////////
#let title = "Esch — Numerical Typography"

#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(
    handout: (
      sys.inputs.at("handout", default: "false") == "true"
    ),
  ),
)

#metadata((
  title: title,
  author: "Noah Syrkis",
  date: datetime.today(),
))<frontmatter>

= Symbols and Letters

- Information theoretically, an alphabet is a non-empty set of symbols #pause
- Often denoted $xi = {s_1, s_2, ...}$ or in the continuous case
  ${s_i : i in RR}$ #pause
- The family of alphabets famously include ${A, B, ..., Z}$, ${0, 1}$, and
  ${A, C, T, G}$ #pause
- A shared fact of these sets is the care with which their members have so often
  been drawn


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
  )<symbol>

]

// #slide[
// - The embryology of topography is frequently present in the symbols fenotype
// - Worked laboriously into metal plates, symbols were assembled into strings
// ]

// #focus-slide[
// #figure(stack(
// spacing: 1em,
// image("figs/multi_grid.svg", width: 100%),
// image(
// "figs/multi_anim_grid.svg",
// width: 100%,
// ),
// ))
// ]

// #focus-slide[
//   #figure(stack(
//     dir: ltr,
//     spacing: 0.5em,
//     stack(spacing: 1em, image("figs/mesh.svg", height: 50%), image(
//       "figs/sims.svg",
//       height: 50%,
//     )),
//     stack(spacing: 1em, image("figs/grid.svg", height: 50%), image(
//       "figs/anim_grid.svg",
//       height: 50%,
//     )),
//   ))
// ]


= Strings of quantity...

- esch is a framwork inspired by the aeshtics in @symbol for representing
  strings of quantity #pause
- [$8 space 2 space 4 space 2 space 6 space 8$] becomes
  [$mono(square.filled.big square.filled.tiny square.filled.small square.filled.tiny square.filled.medium square.filled.big)$]
  ... or, depending on the font,
  [$mono(circle.filled.big circle.filled.tiny circle.filled.small circle.filled.tiny circle.filled circle.filled.big)$]
  #pause
- Accordingly, negative numbers become
  [$mono(square.stroked.big square.stroked.tiny square.stroked.small square.stroked.tiny square.stroked.medium square.stroked.big)$]
  (or
  [$mono(circle.stroked.big circle.stroked.tiny circle.stroked.small circle.stroked.tiny circle.stroked circle.stroked.big)$])
  #pause
- esch—using $tanh(x) = (e^x - e^(-x)) / (e^x + e^(-x))$ to map
  $RR -> [-1, 1]$—thus targets a continuous alphabet

#focus-slide[
  #figure(
    stack(image("figs/esch-11.svg"), image("figs/esch-10.svg"), rotate(
      180deg,
      image("figs/esch-11.svg"),
    )),
    caption: [Three strings (or vectors) of varying length typed in esch],
  )
]

= ... and strings thereof...

#slide[
  - Stack esch strings to represent matrices...
  // - Show patterns not apparent in conventional matrix form

][
  // #esch(
  image("figs/nanda_y.svg", width: 80%),
  // caption: [Target for mech. interp. task @nandaProgressMeasuresGrokking2023],
  // xlabel: $x_0$,
  // ylabel: $x_1$,
  // title: [$y = x_0 + x_1 mod p, quad p=13$],
  )
]

#focus-slide[
  #figure(image("figs/multi_grid.svg", width: 100%), caption: [Four
    $16 times 16$ uniformly random matrices])
]

= ... and strings thereof

#slide[
  #figure(
    image("figs/anim_grid.svg", width: 80%),
    caption: [$16 times 16 times 80$ tensor (last dim. temporal)],
  )
][
  - Temporal interpretations of a given dimension
  - Show training dynamics in deep learning...#pause
  - ... and whatever else
]

= Meshes

#slide[
  - Allow for arbitrary positions of points
  - @neuro shows fMRI (brain scan) data @gifford2023 @allen2022
][
  #figure(
    rotate(180deg, image("figs/neuroscope.svg", width: 110%)),
    caption: [fMRI data],
  )<neuro>
]

= Simulations

#slide[
  #figure(
    image("figs/sims.svg", width: 100%),
    caption: [$tilde U(0,1) -> tilde U(0, 1)$ simulated in Parabellum
      @anneHarnessingLanguageCoordination2025
    ],
  )
][
  - Fix sizes and animate positions
]
