// imports ///////////////
#import "/src/assets/conf.typ": *
#import "appendix.typ": appendix

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/lovelace:0.3.0": *

#show: lq.set-diagram(yaxis: (format-ticks: none))
#show: lq.set-grid(stroke: none)

#let title = "A Modern Array Language for Artificial Life Research"
#let date = datetime(year: 2025, month: 10, day: 6)

#show: slides.with(
  appendix: appendix,

  config-info(
    author: "Noah Syrkis",
    date: date,
    title: title,
  ),
  config-common(
    handout: (sys.inputs.at("handout", default: "false") == "true"),
  ),
)

#metadata((
  title: title,
  date: date,
  hidden: true,
  cover: "/src/content/talks/nebellum/figs/diff.svg",
))<frontmatter>


= Motivation

For legacy reasons ALife research overwhelmingly largely use Python. This talk
presents an alternative: Uiua, a stack based array language written in Rust
inspired by APL. Working with non-coders (architects and artists), I've found
that they find Uiua intuitive. Further, Uiua's array orientedness and visual
compactness makes it a winner (for me), and it's already used in neuroevolutiuon
@kaikalii_evonet_github

#figure(
  grid(
    columns: (1fr, 1fr),
    inset: 1em,
    ```
    lambda x, y, z: x + y + z
    ```,
    ```
    + +
    ```,

    "Python", "Uiua",
  ),
  caption: [Two implementations of anonymous function that adds three numbers],
)<tripadd>


// = The Stack

= Glyphs

Uiua uses special symbols (glyphs). Two frequent initial reactions to these are
intrigue (can you feel it?) and incredulity #footnote[I just got my drivers
  license and learning the signs of the road was harder than learning Uiua]. If
you play with Uiua both quickly subside. A few common glyphs are:

#figure(
  grid(
    inset: 1em,
    columns: 9,
    `.`, `:`, `ₙ`, `⚂`, `⇡`, `⧻`, `⌊`, `⌵`, `≡`,
    [duplicate],
    [flip],
    [power],
    [random],
    [range],
    [shape],
    [floor],
    [abs],
    [map],
  ),
  caption: [A few common glyphs],
)<glyphs>


#slide[

  Some glyphs are more high-level. To visualize points, you could use `⍜`
  (under), which transforms, applies a function, and undoes transform, on an
  $n times n$ array of zeros, by selecting the index of the particles in the
  array (transform), adding 1 (function), and putting the values back in the
  array.

  #figure(
    grid(
      columns: (1fr, 1fr, 1fr),
      inset: 0.75em,
      align: center,
      `∧ fold`, `⍜ under`, `≡ rows`,
      [Apply a function to aggregate arrays],
      [Operate on a transformed array, then undo transform],
      [Apply a function to each row of an array],

      [`∧+ [1 2 3] 10` $->$ `16`],
      [`⍜+(×2) 1 5` $->$ `11`],
      [`≡∧+ [1_2 4_5] 0` $->$ `3_9`],
    ),
    caption: [Glyphs with descriptions and examples],
  )<fns2>

]

= The Stack

#slide[

  - Functions pop and push values on the stack
  - Functions apply seamlessly across array dims
][

  #box[

    ```
      1 2 3   # stack: 1 2 3
    ```
    #pause
    ```
      + +     # stack: 6
    ```#pause

    ```
      ⇡       # stack: [0 1 2 3 4 5]
    ```
    #pause
    ```
      + 1     # stack: [1 2 3 4 5 6]
    ```
    #pause
    ```
      \+      # stack: [1 3 6 10 15 21]
    ```#pause
    ```
      /+      # stack: 56
    ```
  ]
]

= Example: RHOS

#slide[
  ```
  R ← ⁿ:e ¯÷ ×2 ⁿ2 : √ /+ ⁿ2 ⌵
  ```

  ```
  G ← ≡₁R ⌵ - ⌊ ÷ 2 ⊸ ⧻ ⇡ ⊟ .
  ```

  ```
  D ← ÷ ⊸⍥/↥ 2 √ ⌵ - ⊸ ↻ 0_1
  ```
][

  #figure(
    stack(
      // columns: 1,
      // inset: 1em,
      image("figs/out 6.png", width: 45%),
      image("figs/out 7.png", width: 45%),
      // image("figs/out.png", height: 33%),
      // image("figs/inverted_zero.png", height: 50%),
    ),
    caption: [Two works from RHOS],
  )
]

= Example: Sortsol

#slide[

  #grid(
    columns: (1fr, 1fr),
    box[
      ```
      Init ← + ÷ 2 W × S - 0.5 gen N_2
      Step ← + × S -0.5 gen N_2
      Draw ←  ⍜(⊡|+1) ↥ 0 ↧ -1 W ⌊ : × 0 °△ W_W
      ```
    ],
    figure(image("figs/out.gif"), caption: [200 steps of a simple particle
      simulation with particles moving randomly]),
  )
]
