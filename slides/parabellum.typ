// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@local/lilka:0.0.0": *
#import "@preview/fletcher:0.5.7": *
#import "@preview/simplebnf:0.1.1": *


// head /////////////////
#let title = "Beyond Real Time Strategy — Introducing Parabellum"

#show: lilka
#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: false), // <- for presentations
)

#metadata((
  title: title,
))<frontmatter>


// body ///////////////////////
= Beyond Real Time Strategy

- Real life is high fidelity but expensive, unparallizable, and slow
- Parabellum is a StarCraft II#footnote[Famous Real-time strategy (RTS) game] like war-game simulator where:
  - Arbitrary numbers of parallel simulations can be run ... #pause
  - ... at speeds far beyond real-time ... #pause
  - ... with 10s of thousands of units each

= Functional and differential

- Written entirely in JAX @jax2018github, Parabellum is:
- trivially vectorized with JAX's `vmap` function,
- and parallellized across devices with `pmap`
- Can be integrated in deep learning training setups
- Allows for boosting model strategizing capabilities

= Simulation Design

#slide[
  - Follows the industry Gym API @towers2025
  - Trajectories are ($s_t$, $a_t$)–tuple sequences
  - As per @gameflow there are no rewards
][

  #figure(
    [
      #set text(12pt)
      #diagram(
        node-inset: 0pt,
        node-stroke: 1pt,
        spacing: 2.5em,

        // State node
        node((0, 0), [State $s_t$], radius: 3.2em, extrude: (0, 3)),
        node((1, 0), [Observation $o_t$], radius: 3.2em),
        node((2, 0), [Action $a_t$], radius: 3.2em),
        node((3, 0), [Step $t$], radius: 3.2em),


        // Edge from state to state
        edge((0, 0), (3, 0), "-|>", bend: -40deg),

        // edge from state to observation
        edge((0, 0), (1, 0), "-|>"),

        // edge from state to action
        edge((1, 0), (2, 0), "-|>"),

        // edge from action to new state (with radius 3em)
        edge((2, 0), (3, 0), "-|>"),

        edge(
          (3, 0),
          (0.33, -0.33),
          bend: -40deg,
          snap-to: (auto, none),
          "--|>",
        )[State $s_(t+1)$],
      )],
    caption: [Diagram of rewardless partially observable markov decision process (POMDP)],
  )<gameflow>
]

#page[
  // #figure(
  // image("/src/assets/figs/miiii/neuroscope.svg", width: 75%),
  // caption: [`esch` based SVG animation of a Parabellum trajectory],
  )
]

#page[
  - A given state is a (position, health, cooldown)–tuple
  - Non-changing features of the game are encoded in a scene object
  - The scene includes terrain raster map unit-type information (attack and sight ranges, etc.)
  - Any location on Earth can be loaded into the terrain #footnote[Based on OpenStreetMap data]
  - The observation includes location, health, type and team information on units in sight
]

= Projects using Parabellum

- `HIVE`: Behavior tree based approaches for unit control @anne2024
- `llllll`#footnote[#link("https://llllll.syrkis.com", "llllll.syrkis.com")]: a large language / foundation model based command and control simulator
- The Nebellum Project#footnote[#link("https://nebellum.com", "nebellum.com")]: Monitoring to what extent rules of engagement are followed in specific military encounters
// - `esch`:


#[
  #show heading.where(level: 1): set heading(numbering: none)
  = References <touying:unoutlined>
  #set align(top)
  #pad(y: 2em, bibliography("/src/assets/zotero.bib", title: none))
]
