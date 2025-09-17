// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "../src/assets/lib.typ": *
// #import "@local/lilka:0.0.0": *
#import "@preview/fletcher:0.5.7": *
#import "@preview/simplebnf:0.1.1": *


// head /////////////////////////////////////////////////////////////////////////
#let title = "A Modern Array Language for Artificial Life Research"

#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: false),
)

#metadata((
  title: title,
  date: datetime(year: 2025, month: 5, day: 6),
  hidden: true,
))<frontmatter>

= Introduction

- Uiua is a language for extremely quick prototyping
- RHOS: example of art project
- Sortsol: example of an aritfical life project

= What is Uiua?


#slide[

  - Stack based array langauge written in Rust
  - It uses glyphs (similarly to APL, BQN, and J)
][
  #figure(
    ```python
    1 2 3  # 1 2 3
    + +    # 6
    ```,
  )
]



= RHOS

#slide[
  ```
  R ← ⁿ : e¯÷ × 2 ⁿ2 : √ /+ ⁿ2 ⌵
  G ← ≡ ₁ R ⌵ - ⌊ ÷ 2 ⊸ ⧻ ⇡ ⊟ .
  D ← ÷ ⊸ ⍥ / ↥ 2 √ ⌵ - ⊸ ↻ 0_1
  ```
][

  #figure(
    stack(
      dir: ltr,
      spacing: 1em,
      image("s3/rhos/out.png", width: 50%),
      image("s3/rhos/out 6.png", width: 50%),
    ),
    caption: [Derivatives of ... of ... rotated Gaussians],
  )
]

= Sortsol

#slide[

  #figure(
    stack(
      dir: ltr,
      image("s3/sortsol/1.png", height: 40%),
      image("s3/sortsol/2.png", height: 40%),
      image("s3/sortsol/3.png", height: 40%),
      image("s3/sortsol/4.png", height: 40%),
      image("s3/sortsol/5.png", height: 40%),
    ),
    caption: [Five steps in a random swarm simulation],
  )
]


#focus-slide[


  #figure(
    grid(
      columns: (1fr, 1fr),
      inset: 1em,
      ```python
      lambda x, y, z: x + y + z
      ```,
      `+ +`,

      [Python], [Uiua],
    ),
  )


]

= Getting started
1. Play around at uiua.org.
2. Marvel at the fact that:
