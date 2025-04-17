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
          Or[C (is_alive | in_range)][condition]
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


#[
  #show heading.where(level: 1): set heading(numbering: none)
  = References <touying:unoutlined>
  #set align(top)
  #pad(y: 2em, bibliography("/src/assets/zotero.bib", title: none))
]
