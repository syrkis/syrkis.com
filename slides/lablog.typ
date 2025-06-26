// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@preview/arborly:0.3.1": tree
#import "@preview/diagraph:0.3.3": raw-render
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes
#import "@local/lilka:0.0.0": *
#import "@local/esch:0.0.0": *

#show: lilka
// #show raw.where(lang: "dot-render"): it => render-image(it.text)

// head /////////////////////////////////////////////////////////////////////////
#let title = "Lab Log"

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
  date: datetime.today(),
))<frontmatter>



// body //////////////////////////////////////////
= c2sim

#slide[

  #figure(
    // #import fletcher.shapes: diamond
    // #set text(font: "Comic Neue", weight: 600) // testing: omit

    [
      #set text(10pt)
      #diagram(
        node-inset: 1em,
        node-stroke: 1pt,
        spacing: 2.5em,


        // State node
        node((-1, 0.25), [$s_t$], extrude: (0, 3), radius: 2.5em),
        node((0.5, 1.5), [$pi$], radius: 2.5em),
        node((0, 0.5), [$i_t$], radius: 2.5em),
        node((0.5, -0.5), [$o_t$], radius: 2.5em),
        node((2, 0), [$a_t$], radius: 2.5em),
        // node((3, 0.25), [Step], radius: 2.5em),
        node((1, 0.5), [$lambda->b_t$], radius: 2.5em),


        // s_t to intel and plan
        edge((0, 0.5), (1, 0.5), "-|>"),
        edge((-1, 0.25), (0, 0.5), "-|>"),
        edge((0.5, 1.5), (1, 0.5), "-|>"),

        // Edge from state to state
        edge((-1, 0.25), (-1, 0.25), "--|>", bend: 110deg)[$quad quad s_(t+1)$],
        // edge((-1, 0.25), (1, 0.5), "--|>", bend: 25deg),

        // edge from state to observation
        edge((-1, 0.25), (0.5, -0.5), "-|>"), //, bend: 35deg),
        // edge((-1, 0.25), (1, 0.5), "-|>"),

        // edge from state to action
        edge((0.5, -0.5), (2, 0), "-|>"),
        edge((1, 0.5), (2, 0), "-|>"),

        // edge from action to new state (with radius 3em)
        // edge((2, 0), (3, 0.25), "-|>"),
        edge((2, 0), (-1, 0.25), bend: -60deg, "--|>"),
      )
    ],
    caption: [State $s_t$, intel $i_t$, behavior $b_t$ (assigned to units by
      policy $pi$ weighing $i_t$), and action $a_t$ (by $b_t$ weighing
      observation $o_t$)],
  )
][
  // - In real world state $s_t$ is estimated from intel $i_t$
  - Policy / plan $pi$ gets intel _about_ $s_t$ (not $s_t$ itself)
  - `intel_fn` that map $s_t$ to $i_t$ (see @intel).
  - Next: use intel (not state) during plan eval #pause
  // - Currently $lambda$ is the identity function
  - For now $lambda$ is identity, but could do MCTS
  // Make $lambda$ Monte Carlo search instead of identity?
]

// = Mechanistic Interpretability

// = aic2sim

// = `esch`
// #figure(raw-render(
//   ```dot
//   digraph G {
//   A [label="alpha move knight scout"]
//   B [label="bravo move queen scout"]
//   C [label="alpha attack king scout"]

//   A -> C
//   B -> C
//   }
//   ```,
//   labels: ("A": "Node A", "B": "Node B", "C": "Node C"),
// ))


// #figure(
// tree(style: (fit: "band"))[F [S [C [ in_range enemy ]] [A [ shoot closest ]] ]
// [A [ move target ]]
// ],
// caption: [behavior tree],
// )

// #slide[
// - Blog post (draft) at virian.com/parabellum
// - Running millions of units
// - On #link("https://parabellum.syrkis.com", `parabellum.syrkis.com`) (no
// backend)
// - No code change#footnote[#link(
// "https://github.com/syrkis/parabellum",
// "github.com/syrkis/parabellum",
// )]
// - Gymnasium like (could be used with RL, etc.)
// - TODO: add unit communication? Promote?
// ][
// #figure(image("s3/aic2sim/sims.svg", height: 80%), caption: [Random actions
// taken in Parabellum
//
// (shown with #link("https://github.com/syrkis/esch", `esch`))
// ])
// ]

= miiii

#slide[
  - Grads have leaning and memory comps @lee2024a
  - @noah Indicate a third, support-wheel comp
  - Goal: publish in ICLR (better establish comp?)
][

  // stack
  #[
    #esch(
      image("s3/miiii/miiii_large_finding.svg", width: 105%),
      title: [Frequency spike in MLP layer around generalization],
      xlabel: [Train steps],
      ylabel: [$omega$],
      caption: [The spike in active frequencies during generalization indicate
        the presence of a non-generalizing and non-overfitting gradient
        component],
    )<noah>
  ]
]

// - Aiming for ICLR
// - Need to write Anders

// = Other

// - Awaiting response from Janette Systematic
// - Talked to Kristian Knus (Senior Manager, defence operations, Systematic)
// - He said timing was exceptionally good, and that they will contact ITU
// directly.
// - Sebastian will hear from them (seems a bit elaborate, but this is big
// business stuff)
// - Conflict between user study and $10^6$ unit sims (given current approach)
// - Could visualize distribution of units groups?
// - Decide now if $10^6$ is must (all levels of code has to support)

// = TODO

// - [ ] JAX plan data structure
// - [ ] gun shots and colors on svg plots (and small multiples)
// - [x] Assign bt to units in jax-native way
// - [x] Add more atomics to `bct2sim`
// - [ ] Setup backend to run persitently on some server
// - [ ] User study plan (nice to have, etc.)
// - [ ] Do speed test (improvements) for `btc2sim` supporting $10^6+$ units

// = EEMBRYO

// - Running in minecraft?

// = Socioscope

// - Constructing graphs in julia

// = Reading

// -

#[
  #show heading.where(level: 1): set heading(numbering: none)
  = Index of Sources <touying:unoutlined>
  #set align(top)
  #pad(y: 2em, bibliography("zotero.bib", title: none, style: "ieee"))
]

#appendix[

  = Intel templates<intel>

  #block[

    #set text(size: 10pt)
    ```
    > "Breaking news from the battlefield: Allied forces report enemy combatant spotted at {pos} with approximately {hp} health remaining."
    > "Hey, did you hear? My cousin saw someone lurking around {pos} yesterday. They looked pretty beat up, maybe only {hp} health left. Be careful out there."
    > "URGENT DISPATCH: Target acquired at coordinates {pos}. Visual assessment indicates {hp} vitality points. Proceed with caution."
    > "Journal Entry, Day 47: Today I encountered a strange figure at {pos}. They appeared wounded, perhaps {hp} strength remaining.."
    > "According to reliable sources, an individual was recently sighted at {pos} in poor condition, estimated at {hp} health. Local authorities knows."
    > "Overheard at the tavern: 'I'm telling you, I saw them clear as day at {pos}! Could barely stand, maybe {hp} health at most. Something's not right.'"
    > "Scout's Log: Entity detected at position {pos}. Current status: {hp} hit points. Monitoring situation closely."
    > "My grandmother always said to watch out for strangers at {pos}. Well, I just saw one there, and they only had about {hp} health by the looks of it."
    > "MEDICAL REPORT: Patient last seen at location {pos} with critical injuries. Estimated {hp} health remaining. Immediate assistance required."
    > "Text message received: 'omg just saw someone at {pos}!! they look hurt bad, maybe like {hp} health?? should we call someone???'"
    ```
  ]
]
