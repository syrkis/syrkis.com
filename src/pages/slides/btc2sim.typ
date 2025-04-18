// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *
#import "@preview/fletcher:0.5.7": *
#import "@preview/simplebnf:0.1.1": *



// head /////////////////
#let title = "Behavior Tree Based Simulated Command and Control"
#show: lilka
#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: false), // <- for presentations
)


#let bt = [
  #diagram(
    node-inset: 0pt,
    node-stroke: 1.5pt,
    edge-stroke: 1pt,
    spacing: 1em,

    // Root node
    // node((0, -2), [State], radius: 1.5em),

    node((0, 0), [$F$], radius: 1em),

    // Layer 2
    node((-2, 2), [$A_0$], radius: 1em, stroke: (dash: "dashed")),
    node((0, 2), [$S$], radius: 1em, stroke: (dash: "dashed")),
    node((2, 2), [$A_2$], radius: 1em, stroke: 3pt),

    // Layer 3
    node((-1, 4), [$C_0$], radius: 1em, stroke: (dash: "dashed")),
    node((1, 4), [$A_1$], radius: 1em),

    // State to root
    edge((0, 0), (2, -1), "-|>", bend: 20deg)[$a_t$],
    edge((0, 0), (-2, -1), "<|-", bend: -20deg)[$o_t$],


    // Root to layer 2
    edge((0, 0), (-2, 2), "<|--|>"),
    edge((0, 0), (0, 2), "<|--|>"),
    edge((0, 0), (2, 2), "<|-|>"),

    // Layer 2 to 3
    edge((0, 2), (-1, 4), "<|--|>"),
    edge((0, 2), (1, 4), "--/--"),
  )]

#metadata((
  title: title,
  slug: "btc2sim",
))<frontmatter>

// body ///////////////////////


= Granular decision making

- Control problems are inherently hierarchical
- An order from a general commanding the task of a betalion is high-level
- In action of each individual solder is not specified there
- The simulation strategic encounters has been saturated with deep learning algorithms
- @colledanchise2018


= Behavior Tree Grammar

#slide[
  - The domain specific language (DSL) shown in @dsl specifies unit behavior
][
  #figure(
    bnf(
      Prod(
        delim: $→$,

        emph[root],
        {
          Or[#emph[tree] $(triangle.stroked.r$ #emph[tree])$star$][program]
        },
      ),
      Prod(
        delim: $→$,
        emph[tree],
        {
          Or[#emph[leaf] | #emph[node]][node or leaf]
        },
      ),
      Prod(
        delim: $→$,
        emph[leaf],
        {
          Or[A (#emph[move] | #emph[stand])][action]
          Or[C ( #emph[reach] )][condition]
        },
      ),
      Prod(
        delim: $→$,
        emph[node],
        {
          Or[S (#emph[root])][sequence]
          Or[F (#emph[root])][fallback]
        },
      ),
      Prod(
        delim: $→$,
        emph[move],
        {
          Or[#emph[move direction]][move action]
        },
      ),
      Prod(
        delim: $→$,
        emph[direction],
        {
          Or[to | from][direction]
        },
      ),
    ),
    caption: [Behavior tree grammar],
  )<dsl>
]


= Behavior Tree Arrays

#slide[
  - Trees versus arrays
  - Leaf nodes are actions and conditions
  - Rest are sequence or fallback combinators
][

  #figure(
    bt,
    caption: [Behavior tree example],
  )<tree>
]


#slide[
  #figure(
    stack(
      dir: ltr,
      spacing: 4em,
      bt,
      table(
        columns: 4,
        align: center,
        inset: 10pt,
        [*index*], [*parent*], [*follows*], [*skips*],
        [$A_0$], [F], [–], [3],
        [$C_0$], [S], [S], [1],
        [$A_1$], [S], [F], [1],
        [$A_2$], [F], [S], [0],
      ),
    ),
    caption: [Behavior tree (left) and corresponding behavior array (right)],
    supplement: "Figure",
  )
]

#[
  #show heading.where(level: 1): set heading(numbering: none)
  = References <touying:unoutlined>
  #set align(top)
  #pad(y: 2em, bibliography("/src/assets/zotero.bib", title: none))
]
