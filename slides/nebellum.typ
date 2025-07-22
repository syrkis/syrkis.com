// imports ///////////////
#import "@preview/arborly:0.3.1": tree
#import "@preview/diagraph:0.3.3": raw-render
#import "@preview/lovelace:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes
#import "@local/esch:0.0.0": *
#import "@preview/lilaq:0.3.0" as lq
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *



// head /////////////////////////////////////////////////////////////////////////
#let title = "Nebellum — A Semantic Signal Processing Framework"

#show: lilka

#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(
    handout: (
      sys.inputs.at("handout", default: "true") == "true"
    ),
  ),
)

#metadata((
  title: title,
  date: datetime(year: 2025, month: 5, day: 6),
))<frontmatter>

= Introduction

#slide[

  Nebellum is a _semantic_ signal processing framework. It levrages a multimodal
  large language model, Gemma @teamGemma3Technical2025, to decode pieces of
  intel, and a vectorized war game, Parabellum @syrkisParabellum2025, to assign
  importance to said pieces
][
  #figure(image("s3/nebellum/seqs.svg", width: 100%), caption: [
    Parabellum simulation of Colosseo Quadrato in Rome
  ])<parabellum>
]


= Architecture

#slide[
  - Low level behavior is controlled by assigning behavior trees $b$ and target
    positions
  - Behavior trees map observations (info on units in sight range) to actions
    (move or shoot vector)
  - Unit behavior (and target) is assigned by evaluating plan $p$ at time $t$
  - Plan evaluation happens $m$ (evenly spaced) times throughout an $n$ step
    episode
  // - Note that occurs on the unit level, and plan occurs on the team level
]


#slide[
][
  #figure(
    stack(
      spacing: 2em,
      dir: ltr,
      diagram(
        node-stroke: 1pt,
        node((0, 0), radius: 1em, extrude: -0.2em)[-],

        node((-0.5, 1), radius: 1em, extrude: -0.2em)[+],
        node((0.5, 1), radius: 1em, extrude: -0.2em)[A],

        node((-1, 2), radius: 1em, extrude: -0.2em)[C],
        node((0, 2), radius: 1em, extrude: -0.2em)[A],

        edge((0, 0), (-0.5, 1), "-|>"),
        edge((0, 0), (0.5, 1), "-|>"),

        edge((-0.5, 1), (-1, 2), "-|>"),
        edge((-0.5, 1), (0, 2), "-|>"),
      ),
      diagram(
        node-stroke: 1pt,
        node((-0.5, 0), radius: 1em, extrude: -0.2em)[A],
        node((0.5, 0), radius: 1em, extrude: -0.2em)[B],
        node((0, 1), radius: 1em, extrude: -0.2em)[C],
        node((0, 2), radius: 1em, extrude: -0.2em)[D],

        edge((-0.5, 0), (0, 1), "-|>"),
        edge((0.5, 0), (0, 1), "-|>"),
        edge((0, 1), (0, 2), "-|>"),
        edge((-0.5, 0), (0, 2), "-|>", bend: -20deg),
      ),
    ),
    caption: [(left) Behavior that attacks if an enemy is in range and moves to
      target if not. (right) plan that waits for],
  )
]

#slide[
  Each of the $m$ plan evaluations consits of:

  1. Analysis: estimating the state $hat(s)_t$ by combining unit observation
    $o_t$ with intel $i_t$
  2. Simulation: setting $k$ simulations in motions based on $hat(s)_t$ to gauge
    the importance of $i_t$
][
  #figure(
    diagram(
      node((0, 0), $s_t$),
      node((1, -0.5), $i_t$),
      node((1, 0.5), $o_t$),
      node((2, 0), $hat(s)_t$),
      node((3, 0), $vec(hat(s)_m_1 \ hat(s)_m_2 \ dots.v \ hat(s)_m_k)$),

      // s_t to hat(s)_t
      edge((0, 0), (1, -0.5), "->"),
      edge((0, 0), (1, 0.5), "->"),
      edge((1, 0.5), (2, 0), "->"),
      edge((1, -0.5), (2, 0), "->"),

      // hat(s)_t to hat(s)_n
      edge((2, 0), (3, 0), "~>", bend: 25deg),
      edge((2, 0), (3, 0), "~>"),
      edge((2, 0), (3, 0), "~>", bend: -25deg),
    ),
    caption: [At time $t$ we have state $s_t$, intel $i_t$ and observation
      $o_t$. These are combined into $hat(s)_t$, the basis $k$ different $m$
      step trajectories],
  )
]


== Analysis

#slide[

  - Intel $i_t$ is generated on all units in $s_t$ encoding position and health
    in natural language #pause
  - Each piece of intel is fed to Gemma for analysis and combination into state
    estimate $hat(s)_t$ #pause
  - For each team, $k$ intel subsets are made from a random masking of enemy
    units out of sight #pause
  - For each intel subset $i_(t j) : j in [1, k]$ state $hat(s)_(t j)$ is made
    by masking info in $hat(s)_t$ from intel _not_ in $i_(t j)$
][]

== Simulation

#slide[
  - The plan $p$ is evaluated for each of the $k$ states
    $hat(s)_(t j) : j in [1, k]$ yielding the $k$ behaviors $b_j$
  - From $hat(s)_t$, $k$ trajectories (one for each behavior $b_j$) of length
    $round(n / m)$ are run and recorded
  // - Each trajectory is initiated with a unqiue random seed to ensure

][
  #figure(
    stack(
      image("s3/nebellum/sims_sim.svg", width: 90%),
      image("s3/nebellum/sims_sim.svg", width: 90%),
    ),
    caption: [Simulated futures based on would be behaviors based on different
      pieces of intel],
  )
]



= Performace

- Test

#[
  #show heading.where(level: 1): set heading(numbering: none)
  = Index of Sources <touying:unoutlined>
  #set align(top)
  #pad(y: 2em, bibliography("zotero.bib", title: none, style: "ieee"))
]
