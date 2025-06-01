// imports ///////////////
#import "@preview/touying:0.6.1": *
#import "@preview/arborly:0.3.1": tree
#import "@preview/diagraph:0.3.3": raw-render
#import "@local/lilka:0.0.0": *

#show: lilka
// #show raw.where(lang: "dot-render"): it => render-image(it.text)

// head /////////////////////////////////////////////////////////////////////////
#let title = "Lab Log"

#show: slides.with(
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(
    handout: (
      sys.inputs.at("handout", default: "false") == "true"
    ),
  ),
)

#metadata((
  title: title,
  date: datetime.today(),
))<frontmatter>



// body //////////////////////////////////////////

= btc2sim

- I want to move plan logic into the code #footnote[#link(
      "https://github.com/syrkis/btc2sim",
      "github.com/syrkis/btc2sim",
    )]
- TODO:
  - Add more atomics / grammar
  - Speed test to keep parabellum millions
- Plan a an directed acyclic graph.
- Trying to use `jraph` for storing plan (graph)

== Language


#figure(raw-render(
  ```dot
  digraph G {
  A [label="alpha move knight scout"]
  B [label="bravo move queen scout"]
  C [label="alpha attack king scout"]

  A -> C
  B -> C
  }
  ```,
  labels: ("A": "Node A", "B": "Node B", "C": "Node C"),
))

= Parabellum

// #figure(
// tree(style: (fit: "band"))[F [S [C [ in_range enemy ]] [A [ shoot closest ]] ]
// [A [ move target ]]
// ],
// caption: [behavior tree],
// )

#slide[
  - Blog post (draft) at virian.com/parabellum
  - Running millions of units
  - On #link("https://parabellum.syrkis.com", `parabellum.syrkis.com`) (no
    backend)
  - No code change#footnote[#link(
        "https://github.com/syrkis/parabellum",
        "github.com/syrkis/parabellum",
      )]
  - Gymnasium like (could be used with RL, etc.)
  - TODO: add unit communication? Promote?
][
  #figure(image("s3/btc2sim/sim.svg", height: 80%), caption: [Random actions
    taken in Parabellum

    // (shown with #link("https://github.com/syrkis/esch", `esch`))
  ])
]


= MIIII

- Aiming for ICLR
- Need to write Anders

= Other

// - Awaiting response from Janette Systematic
- Talked to Kristian Knus (Senior Manager, defence operations, Systematic)
  - He said timing was exceptionally good, and that they will contact ITU
    directly.
    - Sebastian will hear from them (seems a bit elaborate, but this is big
      business stuff)
- Conflict between user study and $10^6$ unit sims (given current approach)
  - Could visualize distribution of units groups?
  - Decide now if $10^6$ is must (all levels of code has to support)

= TODO

- [ ] JAX plan data structure
- [ ] gun shots and colors on svg plots (and small multiples)
- [x] Assign bt to units in jax-native way
- [x] Add more atomics to `bct2sim`
- [ ] Setup backend to run persitently on some server
- [ ] User study plan (nice to have, etc.)
- [ ] Do speed test (improvements) for `btc2sim` supporting $10^6+$ units

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
  = PLANAX

  ```python
  def plan_fn(plan, state):
      target = random.randint(rng, (env.num_units,), 0, marks.shape[0])
      idxs = random.randint(rng, (env.num_units,), 0, 2)  # random bt idxs for units
      behavior = tree.map(lambda x: jnp.take(x, idxs, axis=0), bts)  # behavior
      return behavior, target
  ```

  = Memory hack

  ```python
  def knn(coords, k, n):
      def aux(inputs):
          batch_coord, batch_norms = inputs
          dots = jnp.dot(batch_coord, coords.T)
          dist = jnp.maximum(batch_norms[:, None] + norms[None, :] - 2 * dots, 0)
          return lax.approx_min_k(dist, k=k)

      norms = jnp.sum(coords**2, axis=1)
      dist, idxs = lax.map(aux, (coords.reshape((n, n, 2)), norms.reshape(n, n)))
      return dist.reshape((-1, k)), idxs.reshape((-1, k))
  ```
]
