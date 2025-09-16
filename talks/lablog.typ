// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@preview/arborly:0.3.1": tree
#import "@preview/diagraph:0.3.3": raw-render
#import "@preview/lovelace:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes
#import "@local/lilka:0.0.0": *
#import "@local/esch:0.0.0": *
#import "@preview/lilaq:0.3.0" as lq

#show: lq.set-grid(stroke: white)
#show: lilka

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
  hidden: true,
))<frontmatter>



// body //////////////////////////////////////////
= August 27th, 2025

#slide[

  - Gemma did 8k intel pieces in 90 sec. on V100
  - Successfully computing intel on $n/ln(n)$ units
  - Test ran with 280k total units (runs in minutes)
  - Opting for generating .gif instead of www?
  - _Issue_: plan / bt split too coarse for big map?
  - _next_: Add color to gif, and run test 2 step plan

][

  #figure(image("s3/nebellum/noah.gif", width: 100%), caption: [Simulating 8.000
    units in 420 by 420 map])<gif>

]
= Updates

- Gemma3 270M is now working with our code (sent pull request to Google) #pause
- 270M helps a lot during development (and might be enough with fine tuning)
  #pause
- Now estimating importance _real time_ inside simulation loop by #pause
  1. computing imagined trajs based on _all_ intel, and #pause
  2. computing many traj baesd on random subset of intel, and #pause
  3. fitting linear model to mask matrix, predicting distance to 1) and
    _sorting_
    #pause
- Beginning to reintegrate Nebellum into Svelte frontend (Use APP-6E NATO
  symbols?) #pause
- Next weeks is just scaling, integrating with front end, debugging, clear
  examples, etc.
- `pcgym` (modified Togelius `gym-pcgrl`) for lab (and other) use #pause

= Gemma

#slide[
  - Comes in 1b, 4b, 12b, and 27b (and all in 4int)
  - 99 custom tokens (using `<pos>` and `<hp>`)
  - We can now `vmap` across pieces of intel...
  - ... and use Gemma inside `jit`, `scan` and `vmap`
][
  #figure(
    ```
    <start_of_turn>user
    {instruction}
    {intel}<end_of_turn>
    <start_of_turn>model
    {response}
    ```,
    caption: [Gemma intel template],
  )
]

= Nebellum

#slide[

  #figure(
    diagram(
      node((0, 0), $s_t$),
      node((1, -0.5), $i_t$),
      node((1, 0.5), $s_t_m$),
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
    caption: [At time $t in {1, 2, ..., n}$ we have state $s_t$, intel $i_t$
      and, masked state $s_t_m$. We combine these into $hat(s)_t$. Simulating
      $k$ trajectories $arrow(hat(s))_m$, $hat(s)_t$ is used to estimate the
      importance of different aspects of $hat(s)_t$.
    ],
  )
][
  - `encode` maps $s_t$ to intel $i_t$ and masked state $s_m$
  - `decode` maps $i_t$ and $s_m$ to estimated state $hat(s)_t$ #pause
  - `sample` maps $hat(s)_t$ to $k$ potential final states $arrow(hat(s))_n$
]

#slide[
  #figure(
    stack(
      stack(
        dir: ltr,
        image("s3/nebellum/seqs.svg", width: 45%),
        stack(
          image("s3/nebellum/sims.svg", width: 45%),
          image("s3/nebellum/sims.svg", width: 45%),
        ),
      ),
      image("s3/nebellum/diff.svg", width: 90%),
    ),
    caption: [
      A 100 step trajectory (left) and four associated imagined trajectories

      (right) with starting at time points 1, 25, 50, and 75
    ],
  )
]

== Intel
#slide[
  - Recall distance was _increasing_ in previous map
  - Map dictates convergence vs. divergence?
  - Relationship between masks and dynamics

][
  #figure(
    stack(
      esch(
        image("s3/nebellum/noah.svg", width: 100%),
        xlabel: [time],
        ylabel: [$k$],
        caption: [Distance between $hat(s)_i_k$ and $s_i$ over time],
      ),
      // rotate(image("s3/nebellum/goya.svg", width: 100%), 90deg),
    ),
  )
]

#slide[
  #esch(
    rotate(image("s3/nebellum/goya.svg", width: 100%), 90deg),
    xlabel: [Unit],
    ylabel: [$k$],
  )

][
  #figure(
    stack(
      esch(
        image("s3/nebellum/noah.svg", width: 100%),
        xlabel: [time],
        ylabel: [$k$],
        // caption: [Distance between $hat(s)_i_k$ and $s_i$ over time],
      ),
      // rotate(image("s3/nebellum/goya.svg", width: 100%), 90deg),
    ),
  )

]



#slide[
  // #set text(size: 12pt)
  #figure(
    table(
      stroke: none,
      columns: 3,
      inset: 1em,
      lq.diagram(
        lq.scatter(
          ..lq.load-txt(read("s3/c2sim/state_hat_pos.csv")),
          color: black,
          // size: 0.1em,
        ),
        title: $hat(s)$,
        yaxis: none,
        xaxis: none,
        width: 8cm,
        height: 8cm,
      ),
      lq.diagram(
        lq.scatter(
          ..lq.load-txt(read("s3/c2sim/state_pos.csv")),
          color: black,
          // size: 0.1em,
        ),
        title: $s$,
        yaxis: none,
        xaxis: none,
        width: 8cm,
        height: 8cm,
      ),
      //
      lq.diagram(
        lq.scatter(
          ..lq.load-txt(read("s3/c2sim/state_m_pos.csv")),
          color: black,
          // size: 0.1em,
        ),
        title: $s_m$,
        yaxis: none,
        xaxis: none,
        width: 8cm,
        height: 8cm,
      ),
      [$"CD"(hat(s), s) = 102$],
      [$"CD"(s, s_m) = 686$],
      //
      [$"CD"(hat(s), s_m) = 712$],
    ),
    caption: [TLDR: It works! $hat(s)$, $s$, and $s_m$ and associated Chamfer
      Distances. Note $s$ is much closer to the estimate $hat(s)$ than the
      masked $s_m$, showing that the LMM's processing of intel $i$ is helpful.],
  )
]



== `detel_fn(intel_fn(s))`

#slide[
  - Using `gamma` (`jax` native and easy fine tuning)
  - As per @code we:
    1. We generate language intel $i_t$ from state $s_t$
    2. Mask away some (maybe all) of state ($s_(m t)$)
    3. Decode $i_t$ and $s_(m t)$ to get estimate $s_hat(t)$
  - See @intel for intel string templates
  - Status: did `intel_fn` and doing `detel_fn`

][
  #block[
    // #set text(size: 10pt)
    #figure(
      stack(
        pseudocode-list(booktabs: true, stroke: none, indentation: 1em)[
          + *Function* IntelFunction($s_t$)
            + Generate mask for units not in sight
            + Generate $i_t$ from $s_t$ (could be lies)
            + Hide parts of $s_t$ using mask to produce $s_(m t)$
            // mask only enemy not in sight of ally
            + *return* $i_t$, $s_(m t)$
          + *end*
          +
          + *Function* DetelFunction($i_t$, $s_(m t)$)
            + Create prompt requesting indices to update
            + Use model to interpret $i_t$ and $s_(m t)$
            + Update $s_(m t)$ with interpreted values
            + *return* updated state estimate $hat(s)_t$
          + *end*
          + $hat(s)_t)$ = DetelFunction(IntelFunction($s_t$))
          // + Output example $i_t$ entry
        ],
        v(1em),
      ),
      caption: [Pseudo code],
    )<code>
  ]
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

= MIIII

#slide[

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
][
  - Grads have leaning and memory comps @leeGrokfastAcceleratedGrokking2024
  - @noah Indicate a third, support-wheel comp
  - Goal: publish in ICLR (better establish comp?)
  - Now: chaning to better show spike across runs
]


= AIGS

#slide[
  #align(center)[MCTS]

  - Connect 4 pettingZoo @terry2021pettingzoo
  - Implement MCTS
  - Tweak params and compete
][
  #align(center)[DRL]
  - Get unity ml-agent to run
  - pick game. Use PPO.
  - play against
][
  #align(center)[QD]
  - implement map elite
  - generate dataset of levels
  - Play lebel with drl bot
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
