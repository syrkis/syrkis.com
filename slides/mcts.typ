// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *
#import "@local/esch:0.0.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lovelace:0.3.0": *


#let title = "Monte Carlo Tree Search"


#show: lilka
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


= MCTS

#slide[
  - Monte Carlo (random) tree search
  - Core idea: sample from bottom of each branchj
  - How much to sample from each branch?
  - How should we reach the bottom?
][
  #figure(diagram(
    node((0, 0))[$a$],

    node((-0.5, 1))[$b$],
    node((0.5, 1))[$c$],

    node((-0.5, 2))[$triangle$],
    node((-0.5, 1.5))[$dots.c$],

    node((0.5, 2))[$triangle$],
    node((0.5, 1.5))[$dots.c$],

    edge((0, 0), (0.5, 1), "->"),
    edge((0, 0), (-0.5, 1), "->"),

    edge((-0.5, 1), (-0.5, 2), "~>", bend: -30deg),
    edge((-0.5, 1), (-0.5, 2), "~>", bend: 30deg),

    edge((0.5, 1), (0.5, 2), "~>", bend: -30deg),
    edge((0.5, 1), (0.5, 2), "~>", bend: 30deg),
  ))
]

#slide[

][

]
