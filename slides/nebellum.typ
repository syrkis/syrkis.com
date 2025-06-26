// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *


// head /////////////////////////////////////////////////////////////////////////
#let title = "Nebellum — Semantic Signal Processing and Strategy"

#show: lilka
#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: false),
)

#metadata((
  title: title,
  date: datetime(year: 2025, month: 5, day: 6),
))<frontmatter>

#focus-slide[
  $(S, A, T, R, Omega, O, gamma)$
]

= Fog of War

#slide[
  - _Parabellum_ is a vectorized war game
  - _aic2sim_ plays parabellum, where at time $t$:
    1. Behavior trees (BT) are assigned to units based on game state $s_t$
    2. Units map observation $o_t$ to action $a_t$ based on BT, yielding
      $s_(t+1)$
  - _Nebellum_ introduces fog of war
    -
][
  #figure(image("s3/aic2sim/sims.svg", width: 100%), caption: [
    Parabellum simulation of Colosseo Quadrato in Rome
  ])<parabellum>
]


= Architecture

- test
