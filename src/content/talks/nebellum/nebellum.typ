// imports /////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes
#import "/src/assets/conf.typ": *
#import "appendix.typ": appendix

// head /////////////////////////////////////////////////////////////////////////
#let title = "A Semantic Signal Processing Framework"
#let date = datetime.today()
#let info = config-info(author: "Noah Syrkis", date: date, title: title)
#let handout = sys.inputs.at("handout", default: "true") == "true"
#show: slides.with(appendix: appendix, info, config-common(handout: handout))
#metadata((
  title: title,
  date: date,
  cover: "/src/content/talks/miiii/figs/polar.svg",
  hidden: true,
))<frontmatter>


//  body ///////////////////////////////////////////////////////////////////////
#focus-slide[
  #let data = (
    s_t: (0, 0),
    s_s: (-1, 2),
    s_b: (0, 2),
    s_m: (1, 2),
    gemma_270m: (1, 1),
    text_intel: (1, 0),
    // gemma_4b: (2, 1),
  )
  #figure(
    diagram(
      // States at time t
      node(data.s_t)[$s_(italic("true"))$#linebreak() True State],
      node(data.s_s)[$s_(italic("seen"))$#linebreak()State in sight],
      node(data.s_b)[$s_(italic("best"))$#linebreak()$s_(italic("seen"))$ + all
        intel],
      node(
        data.s_m,
      )[$arrow(s)_(italic("mask"))$#linebreak()$s_(italic("seen"))$ + random
        intel],


      // Gemma
      node(data.text_intel)[Text intel],
      node(data.gemma_270m)[Gemma 270M#linebreak()Text model],
      // node(data.gemma_4b)[Gemma 4B#linebreak()Vision-text model],

      edge(data.s_t, data.s_s, "->"),
      edge(data.s_t, data.text_intel, "->"),
      edge(data.text_intel, data.gemma_270m, "->"),
      edge(data.gemma_270m, data.s_b, "->"),
      edge(data.gemma_270m, data.s_m, "-->"),
      edge(data.s_s, data.s_b, "->"),
      edge(data.s_s, data.s_m, "->", bend: -45deg),
    ),
  )
]

#slide[
  - New RNG dimension for each of $k$ sim sims
  - Quantization of state (@quant) during play
  - Today: improve masking (uniform in space)
][
  #figure(
    stack(
      dir: ltr,
      image("figs/noah.gif", height: 50%),
      grid(
        columns: 2,
        inset: 0.5em,
        image("figs/noah_0.gif", height: 25%),
        image("figs/noah_1.gif", height: 25%),

        image("figs/noah_2.gif", height: 25%),
        image("figs/noah_3.gif", height: 25%),
      ),
    ),
    caption: [A single base simulation $arrow(s)_t$ (left) and four imagined
      simulations $arrow(overline(s))_t$(right)],
  )<quant>
]


= Introduction

#slide[

  Nebellum is a _semantic_ signal processing framework. It leverages a
  multimodal large language model, Gemma, to decode pieces of intel, and a
  vectorized war game, Parabellum, to assign _importance_ to those pieces.

][
  #figure(image("figs/sims_sim copy.svg", width: 100%), caption: [
    Parabellum simulation of Colosseo Quadrato in Rome
  ])<parabellum>
]

== Notation

#slide[
  This is simulation heavy project. We have true game states, various kinds of
  estimated game states, as well as simulated game states
][
  #figure(
    table(
      align: left,
      columns: (auto, auto),
      inset: 1em,
      stroke: none,
      [$s_t$], [A true game state at time $t$],
      [$s'_t$], [Simulated game state based on $s_t$],
      [$hat(s)_t$], [An intel subset based _estimate_ of $s_t$],
      [$hat(s)'_t$], [Simulated game state based on $s'_t$],
      [$overline(s)_t$], [Estimte of $s_t$ based on all intel],
      [$overline(s)'_t$], [Simulated state based on $overline(s)_t$],
    ),
  )]

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
  #let behaviorNodePos = (
    (0, 0),
    (-0.5, 1),
    (0.5, 1),
    (-1, 2),
    (0, 2),
    (-1, 0),
    (1, 0),
  )

  #figure(
    diagram(
      node-stroke: 1pt,
      node(behaviorNodePos.at(5), stroke: none)[$o_t$],
      node(behaviorNodePos.at(6), stroke: none)[$a_t$],
      node(behaviorNodePos.at(0), radius: 1em, extrude: -0.2em)[–],

      node(behaviorNodePos.at(1), radius: 1em, extrude: -0.2em)[+],
      node(behaviorNodePos.at(2), radius: 1em, extrude: -0.2em)[$A''$],

      node(behaviorNodePos.at(3), radius: 1em, extrude: -0.2em)[$C$],
      node(behaviorNodePos.at(4), radius: 1em, extrude: -0.2em)[$A'$],

      edge(behaviorNodePos.at(5), behaviorNodePos.at(0), "--|>"),
      edge(behaviorNodePos.at(0), behaviorNodePos.at(6), "--|>"),

      edge(behaviorNodePos.at(0), behaviorNodePos.at(1), "<|-|>"),
      edge(behaviorNodePos.at(0), behaviorNodePos.at(2), "<|-|>"),

      edge(behaviorNodePos.at(1), behaviorNodePos.at(3), "<|-|>"),
      edge(behaviorNodePos.at(1), behaviorNodePos.at(4), "<|-|>"),
    ),
    caption: [Behavior tree receiving a unit observation $o_t$ and returning a
      unit action $a_t$],
  )<bt>
][
  - Leafs are conditions ($C$) or actions ($A$)
  - Non-leafs are sequnces (+) or fallbacks (-)
  - They require all (+) or one (-) child success
  - In @bt, if $C$ succeds $A'$ runs else $A''$ runs
  - _"if enemy is in reach shoot enemy else move up"_
]


#slide[
  - Plan evaluation maps state $s_t$ to behavior $b_t$
  - @plan shows a graph with nodes that contain unit group $g$, target $t$ and
    behavior $b$
  - Targets can be positional ($g$ shall go near $t$) ...
  - ... or adversarial ($g$ shall kill enemies near $t$)

][
  #let planNodePos = ((-0.75, 0), (0.75, 0), (0, 0.75), (-0.5, 1.75))

  #figure(
    diagram(
      node-stroke: 1pt,
      node-corner-radius: 10pt,
      node(
        planNodePos.at(0),
        inset: 0.2em,
        extrude: -0.2em,
      )[$"group":alpha$

        $"target":A$

        $"bt":aleph$

      ],

      node(
        planNodePos.at(1),
        inset: 0.2em,
        extrude: -0.2em,
      )[$"group":beta$

        $"target":B$

        $"bt":bet$],

      node(
        planNodePos.at(2),
        inset: 0.2em,
        extrude: -0.2em,
      )[$"group":gamma$

        $"target":C$

        $"bt":gimel$],

      node(
        planNodePos.at(3),
        inset: 0.2em,
        extrude: -0.2em,
      )[$"group":delta$

        $"target":D$

        $"bt":dalet$],

      edge(planNodePos.at(0), planNodePos.at(2), "-|>"),
      edge(planNodePos.at(1), planNodePos.at(2), "-|>"),
      edge(planNodePos.at(0), planNodePos.at(3), "-|>", bend: -30deg),
      edge(planNodePos.at(2), planNodePos.at(3), "-|>"),
    ),
    caption: [Example of plan data structure],
  )<plan>
]

#slide[
  #figure(
    diagram(
      node((0, 0), $s_t$),
      node((1, -0.5), $i_t$),
      node((1, 0.5), $o_t$),
      node((2, 0), $hat(s)_t$),
      node(
        (3, 0),
        $vec(hat(s)'_((t+m) 1) \ hat(s)'_((t+m) 2) \ dots.v \ hat(s)'_((t+m) k))$,
      ),

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
      $o_t$. These are combined into $hat(s)_t$, the basis for $k$ different $m$
      step trajectories],
  )
][
  Each of the $k$ plan evaluations consists of:

  1. Analysis: estimating the state $hat(s)_t$ by combining unit observation
    $o_t$ with intel $i_t$
  2. Simulation: setting $k$ _imagined_ simulations in motion based on
    $hat(s)_t$
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
][
  #figure(stack(
    spacing: 1em,
    table(
      inset: 0.5em,
      align: horizon,

      [`{pos}!! look hurt, maybe {hp} health?'`],
      [#align(center, $dots.v$)],
      [`a stranger at {pos}. health {hp}?`],
    ),
    $arrow.b$,
    table(
      columns: (100pt, 100pt),
      inset: 0.5em,
      // [*pos*], [*hp*],
      [(x, y)], [01],
      [$dots.v$], [$dots.v$],
      [(x, y)], [01],
    ),
    $arrow.b$,
    $mat(hat(s)_(t 1), hat(s)_(t 2), ..., hat(s)_(t k))$,
  ))
]

== Simulation

#slide[
  #figure(
    stack(
      image("figs/sims_sim.svg", width: 90%),
      image("figs/sims_sim.svg", width: 90%),
    ),
    caption: [Simulated futures based on would be behaviors based on different
      pieces of intel],
  )
][
  - The plan $p$ is evaluated for each of the $k$ states
    $hat(s)_(t j) : j in [1, k]$ yielding the $k$ behaviors $b_j$
  - From $s_t$ or $hat(s)_(t j)$, $k$ trajectories (one for each behavior $b_j$)
    of length $round(n / m)$ are run and recorded
]

#slide[
  - Using $s_t$ as simulation basis we can assign importance to different
    aspects of the intel $i_(t j)$
  - Using $hat(s)_(t j)$ we can assign importance to different aspects of the
    current state $s_t$
]


= Evaluation

#slide[
  - As expected the delta starts small
  - Divergence occus under some conditions
  - For a subset of these, it converges again
][
  #esch(
    image("figs/diff.svg", height: 80%),
    title: [Difference in position between $s_(t+m)$ and $hat(s)_(t+m)$],
    ylabel: [Sims],
    xlabel: [Time],
    caption: [Diverence between true state $s_t$ and simulated states.
      Simulations are based on $s_t$ (not $hat(s)_t$. They thus difer in
      behavior and random seed.],
  )
]

#slide[
  #figure(
    esch(
      stack(
        dir: ttb,
        spacing: 1em,
        esch(
          image("figs/importance_red.svg", width: 95%),
          // ylabel: [Blue],
        ),
        $——————————$,
        esch(
          image(
            "figs/importance_blue.svg",
            width: 95%,
          ),
          // ylabel: [Red],
          xlabel: [Intel],
          x-offset: 1em,
        ),
      ),
      caption: [Linear regression $beta$ values of importance of different
        pieces of intel],
      ylabel: [Team],
      y-offset: -2em,
    ),
  )

][
  - In subplots rows is epoch and cols is time
  - We see that there _is_ a pattern
  - Sometimes somethings predict the future ...
  - ... other times other things predict the future
]

= Future

- [x] Compute importance score
- [ ] Highlight which intel is important
- [ ] Add importance overlay to location on top of map (nice UI)
- [ ] Multiple trajectories $s'$ per intel subset (for robustness)
- [ ] Hide true enemy plan, infering it from $o_t$ and $i_t$
// - [ ] Fine tune Gemma to various things
- [ ] Non visible enemy units could be sampled uniformly?


// #[
// #show heading.where(level: 1): set heading(numbering: none)
// = Index of Sources <touying:unoutlined>
// #set align(top)
// #bibliography("/src/assets/zotero.bib")
// ]
