// imports ///////////////
#import "@preview/touying:0.6.1": *
// #import "@local/lilka:0.0.0": *
#import "@local/esch:0.0.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lilaq:0.4.0" as lq
#import "@preview/lovelace:0.3.0": *

#import "/src/assets/conf.typ": *

#show: lq.set-diagram(
  yaxis: (format-ticks: none),
)

#show: lq.set-grid(
  stroke: none,
  // stroke-sub: 0.5pt + luma(90%),
)

#let title = "Quality Diversity"


// #show: lilka
#show: slides.with(
  config-info(
    author: "Noah Syrkis",
    date: datetime(day: 8, month: 9, year: 2025),
    title: title,
  ),
  config-common(
    handout: (
      sys.inputs.at("handout", default: "false") == "true"
    ),
  ),
)

#metadata((
  title: title,
  date: datetime(year: 2025, month: 5, day: 6),
  hidden: true,
))<frontmatter>

// TODO: 1. evolutionary strategy
// 2. Map elite versus random
// 3: cmes


= Introduction

The future is a garden of forking paths @borges1962garden. Action $a$ at state
$s_t$ yields a new state $s_(t + 1)$. A different action $a'$, however, might
have yielded some different state $s'_(t + 1)$.

= Minimax

#slide[
  - Suppose we have a function that:
  - given a state and an action returns a new state,
  - and another that given a state returns who won
  - What can we do? #pause Play perfectly and never loose
][
  #meanwhile
  #figure(
    diagram(
      node((2, 0))[min],
      node((2, 1))[max],
      node((2, 2))[min],

      node((0, 0))[$a$],

      node((-1, 1))[$b$],
      node((1, 1))[$c$],

      node((-1.5, 2))[$d$],
      node((-0.5, 2))[$e$],
      node((0.5, 2))[$f$],
      node((1.5, 2))[$g$],

      node((-1.5, 2.5))[$+$],
      node((-0.5, 2.5))[$-$],
      node((0.5, 2.5))[$+$],
      node((1.5, 2.5))[$+$],

      edge((0, 0), (-1, 1), "->"),
      edge((0, 0), (1, 1), "->"),

      edge((-1, 1), (-1.5, 2), "->"),
      edge((-1, 1), (-0.5, 2), "->"),
      edge((1, 1), (0.5, 2), "->"),
      edge((1, 1), (1.5, 2), "->"),
    ),
    // caption: [Minimax tree],
  )
]


#slide[
  - We can win (or at least not loose) any game#footnote[
      that is two player, winnable, deterministic, etc.
    ] by:
    1. Calling the minimax function for all actions
    2. Storing the values of each action in a list
    3. Taking the action with the highest value
  - How can we do better? What are the issues?
][
  #figure(
    kind: "algorithm",
    supplement: [Algorithm],
    pseudocode-list(stroke: none, booktabs: true, numbered-title: [minimax(node,
      maxim)])[
      + *if* node is terminal
        + *return* the value of node

      + bestValue = $-oo$ if maxim else $oo$
      + condition = max if maxim else min

      + *for* each child of node
        + value = minimax(child, not maxim)
        + bestValue = condition(bestValue, value)
      + *return* bestValue
    ],
    // caption: [Minimax pseudo code],
  )<minimax>

]

= $alpha-beta$ pruning


#slide[
  #figure(
    diagram(
      node((-2, 0))[max],
      node((-2, 1))[min],
      node((-2, 2))[max],

      node((0, 0))[$a$],

      node((-1, 1))[$b$],
      node((1, 1))[$c$],

      node((-1.5, 2))[$d$],
      node((-0.5, 2))[$e$],
      node((0.5, 2))[$f$],
      node((1.5, 2))[$g$],

      node((-1.5, 2.5))[$+$],
      node((-0.5, 2.5))[$+$],
      node((0.5, 2.5))[$-$],
      node((1.5, 2.5))[$+$],

      edge((0, 0), (-1, 1), "->"),
      edge((0, 0), (1, 1), "->"),

      edge((-1, 1), (-1.5, 2), "->"),
      edge((-1, 1), (-0.5, 2), "->"),
      edge((1, 1), (0.5, 2), "->"),
      edge((1, 1), (1.5, 2), "--|--"),
    ),
    // caption: [Minimax tree],
  )
][
  - Skip branches worse than current floor
  - $alpha$ and $beta$ refer to those precisely floors
]

#slide[
  - @alphabeta looks daunting but the idea is:
  - Stop exploring paths you already know are bad
][

  #figure(
    kind: "algorithm",
    supplement: [Algorithm],
    pseudocode-list(
      stroke: none,
      booktabs: true,
      numbered-title: [$alpha-beta$ pruning(node, maxim, $alpha$, $beta$)],
    )[
      + *if* node is terminal
        + *return* the value of node

      + bestValue = $-oo$ if maxim else $oo$
      + condition = max if maxim else min

      + *for* each child of node
        + value = minimax(child, not maxim, $alpha$, $beta$)
        + bestValue = condition(bestValue, value)
        + $alpha$ = (condition($alpha$, value) if maxim else $alpha$)
        + $beta$ = (condition($beta$, value) if not maxim else $beta$)
        + *if* $alpha$ >= $beta$; *break*
      + *return* bestValue
    ],
  )<alphabeta>
]


#focus-slide[
  Break
]

= MCTS

#slide[
  - Monte Carlo (random) tree search @browne2012
  - Core idea: sample from bottom of each branch
  - How much to sample from each branch?
  - How should we reach the bottom?
][

  #let nodePos = (
    (0, 0),
    (-1, 1),
    (1, 1),
    (-1, 2),
    (-1, 1.5),
    (-1, 2.3),
    (0.5, 2),
    (1.5, 2),
  )
  #figure(diagram(
    node(nodePos.at(0))[$a$],

    node(nodePos.at(1))[$b$],
    node(nodePos.at(2))[$c$],

    node(nodePos.at(3))[$triangle$],
    node(nodePos.at(4))[$dots.c$],

    node(nodePos.at(6))[$d$],
    node(nodePos.at(7))[$e$],

    edge(nodePos.at(0), nodePos.at(2), "->"),
    edge(nodePos.at(0), nodePos.at(1), "->"),

    edge(nodePos.at(1), nodePos.at(3), "~>", bend: -30deg),
    edge(nodePos.at(1), nodePos.at(3), "<~", bend: 30deg),

    edge(nodePos.at(2), nodePos.at(6), "->"),
    edge(nodePos.at(2), nodePos.at(7), "->"),

    // edge((0.5, 1), (0.5, 2), "~>", bend: -30deg),
    // edge((0.5, 1), (0.5, 2), "~>", bend: 30deg),
  ))
]


== Explore /  exploit


#slide[

  - When do we exploit the best tool we have?
  - When should we explore for a new tool?
  - There is a good entropy based solution @robbinsASPECTSSEQUENTIALDESIGN1952

][
  #let x = lq.linspace(0, 1)
  #let gauss(x, mu, sigma) = (
    (1 / (sigma * calc.sqrt(2 * calc.pi)))
      * calc.pow(
        calc.e,
        -(calc.pow(x - mu, 2) / (2 * calc.pow(sigma, 2))),
      )
  )


  #figure(
    lq.diagram(
      legend: (position: top + left, stroke: none, fill: none),
      width: 12cm,
      height: 8cm,
      lq.plot(
        x,
        x.map(x => gauss(x, 0.75, 0.05)),
        mark: none,
        smooth: true,
        stroke: (paint: black),
        label: [$cal(N)(0.75, 0.05)$],
      ),
      lq.plot(
        x,
        x.map(x => gauss(x, 0.5, 0.5)),
        mark: none,
        smooth: true,
        stroke: (paint: black, dash: "dashed"),
        label: [$cal(N)(0.5, 0.5)$],
      ),
    ),
    caption: [
      Which distribution would you sample from? Which is more likely to reach
      $1$?
    ],
  )
]

= Python

#slide[
  - You will see code that looks like @code
  - In some games $s!=o$, so we need seperate `obs`
  - Multi player setup will have inner player loop
][
  #figure(
    kind: "script",
    supplement: "Script",
    ```
    import gymnasium as gym
    env = gym.game("tic_tac_toe")
    state, done = env.init()

    while not done:
      action = action_fn(state)
      state, done = env.step(state, action)
    ```,
    caption: [Playing games in Python usually look something like this],
  )<code>
]

// == Packages

#slide[
  - Some useful packages
  - Understanding gymnasium is a must
  - Get comfy with `.reset` and `.step`
  - Sometimes `state` has a valid action mask!
][
  #table(
    columns: (auto, 1fr),
    inset: 1em,
    [`aigs`], [package for our course],
    // [`gymnasium` @towersGymnasiumStandardInterface2025], [Basic env package],
    // [`petting-zoo` @terry2021pettingzoo], [gym for multiplayer],
    // [`pgx` @koyamada2023pgx], [parallel envs],
    // [`mlxp` @arbelMLXPFrameworkConducting2024], [experiment tracking],
    // [`parabellum` @syrkisParabellum2025], [shameless plug],
  )
]

// = Abrolhos

// - We haven't actually _looked_ at the board
// - Humans don't mentally finish $n$ games
// // - Often have a value function $v(s) -> {+, -}$
// - We've learned a set of patterns that we liks or not
// - The sampling in MCTS could be used to learn those patterns
// - Taken it its extreme in 2024 an algorithm _only_ looked at the board
//   @ruossGrandmasterLevelChessSearch2024

// #[
// #show heading.where(level: 1): set heading(numbering: none)
// = Index of Sources <touying:unoutlined>
// #set align(top)
// #pad(y: 2em, bibliography(
// "/src/assets/zotero.bib",
// title: none,
// style: "ieee",
// ))
// ]
