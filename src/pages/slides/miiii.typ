
// imports ///////////////
#import "@preview/touying:0.5.5": *
#import "/src/assets/lib.typ": *
#import "@preview/equate:0.2.1": equate

// head /////////////////////////////////////////////////////////////////////////
#let miiii_hash = "50115caac50c4fbfa6bce4cc"


#let title = "Mechanistic Interpretability on multi-task Irreducible Integer Identifiers"
#show: escher-theme.with(
  aspect-ratio: "16-9",
  config-info(author: "Noah Syrkis", date: datetime.today(), title: title),
  config-common(handout: false), // <- for presentations
)


#metadata((
  title: title,
  slug: "miiii",
))<frontmatter>

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)", supplement: "Eq.")

#show figure.caption: emph

// body /////////////////////////////////////////////////////////////////////////
#cover-slide()

#focus-slide[
  #figure(
    image("/src/assets/figs/miiii/polar.svg"),
    caption: [$NN < p^2$ multiples of 13 or 27 (L), 11 (M), or primes (R)],
  )
]

= Mechanistic Interpretability (MI)


#focus-slide[
  "This disgusting pile of matrices is actually just an astoundingly poorly written, elegant and consice algorithm" — Neel Nanda#footnote[Not verbatim, but the gist of it]
]

#slide[
  - Sub-symbolic nature of deep learning obscures model mechanisms #pause
  - No obvious mapping from the weights of a trained model to math notation #pause
  - MI is about reverse engineering these models, and looking closely at them #pause
  - Many low hanging fruits / practical botany phase of the science #pause
  - How does a given model work? How can we train it faster? Is it safe?
]

== Grokking

#slide[
  - Grokking @power2022 is "sudden generalization" #pause
  - MI neceitates a mechanism #pause
  - Grokking is thus convenient for MI #pause
  - #cite(<lee2024a>, form: "prose", style:"american-psychological-association") speeds up grokking by boosting slow gradients as per @grokfast
][
  // #meanwhile
  $
    h(t) &= h(t-1) alpha + g(t)(1-alpha)\
    hat(g)(t) &= g(t) + lambda h(t)
  $<grokfast>
]

== Visualizing

#slide[
  - MI use creativity ... #pause but there are tricks: #pause
    - For two-token samples, plot them varying one on each axis (@mi_tricks) #pause
    - When a matrix is periodic use Fourier #pause
    - Singular value decomp. ($upright(bold(M)) = upright(bold(U)) upright(bold(Sigma))upright(bold(V^*))$)
][
  #meanwhile
  #figure(
    stack(
      image("/src/assets/figs/miiii/nanda_U.svg", width: 90%),
      stack(
        dir: ltr,
        image("/src/assets/figs/miiii/neurs_113_nanda_one.svg", width: 45%),
        image("/src/assets/figs/miiii/neurs_113_nanda_fft_one.svg", width: 50%),
      ),
    ),
    caption: [Top singular vectors of $bold(upright(U))_W_E_cal(T)_"nanda"$ (top), varying $x_0$ and $x_1$ in sample (left) and freq. (right) space in $W_"out"_cal(T)_"miiii"$],
  )<mi_tricks>
]

= Modular Arithmetic

#slide[
  - "Seminal" MI paper by #cite(<nanda2023>, form: "prose", style:"american-psychological-association") focus on modular additon (@nanda_task)
    // #footnote[Nanda worked at Anthropic under the great Chris Olah, and popularized
    // #footnote[To the extent there is such a thing as popularity in this niece a subject] MI]
  - Their final setup trains on $p=113$
  - They train a one-layer transformer
  // #footnote[MLP would have been better / simpler according to Nanda]
  - We call their task $cal(T)_"nanda"$#pause
  - And ours, seen in @miiii_task, we call $cal(T)_"miiii"$
][
  #meanwhile
  $
    (x_0 + x_1) mod p, quad forall x_0, x_1
  $<nanda_task>
  #pause
  $
    (x_0 p^0 + x_1 p^1) mod q, quad forall q < p
  $<miiii_task>
]



// #focus-slide[
//   - Modular addition is a severely solved problem
//   - The foucs is this solution—not the problem.
// ]


= Grokking on $cal(T)_"miiii"$

#slide[

  - The model groks on $cal(T)_"miiii"$ (@training_acc)
  - Needed GrokFast #cite(<lee2024a>) on compute budget
  - Final hyperparams are seen in @hyper_param_search_result

  #figure(
    table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      inset: 15pt,
      table.header(
        "rate",
        $lambda$,
        "wd",
        $d$,
        "lr",
        "heads",
      ),

      $1 / 10$, $1 / 2$, $1 / 3$, "256", $3 / 10^4$, "4",
    ),
    caption: [Hyperparams for $cal(T)_"miiii"$],
  )<hyper_param_search_result>
][
  #figure(
    stack(
      image("/src/assets/figs/miiii/" + miiii_hash + "/acc_train_training.svg"),
      image("/src/assets/figs/miiii/" + miiii_hash + "/acc_valid_training.svg"),
    ),
    caption: [Training (top) and validation (bottom) accuracy during training on $cal(T)_"miiii"$],
  )<training_acc>
]

= Embeddings

#slide[
  - The pos. embs. of @pos_emb shows $cal(T)_"nanda"$ is commutative and $cal(T)_"miiii"$ is not
  - Pearsons correlation is $0.95$ for $cal(T)_"nanda"$ and $-0.64$ for $cal(T)_"miiii"$
  - Conjecture: The pos. embs. correct for non-commutativity of $cal(T)_"miiii"$
][
  #figure(
    image("/src/assets/figs/miiii/pos_emb.svg", width: 100%),
    caption: [Positional embeddings for $cal(T)_"nanda"$ (top) and $cal(T)_"miiii"$ (bottom).],
  )<pos_emb>
]

== Token Embeddings

#slide[
  - For $cal(T)_"nanda"$ token embs. are essentially linear combinations of 5 frequencies ($omega$)
  - For $cal(T)_"miiii"$ more frequencies are in play
  - Each $cal(T)_"miiii"$ subtask targets unique prime
  - Possibility: One basis per prime task
][
  #figure(
    stack(
      spacing: 1em,
      // image("figs/fourier_basis_m.svg"),
      image("/src/assets/figs/miiii/fourier_nanda_m.svg"),
      image("/src/assets/figs/miiii/fourier_miiii_m.svg"),
    ),
    caption: [$cal(T)_"nanda"$ (top) and $cal(T)_"miiii"$ (bottom) token embeddings in Fourier basis],
  )<tok_emb>
]

#slide[
  - Masking $q in {2,3,5,7}$ yields we see a slight decrease in token emb. freqs. #pause
  - Sanity check: $cal(T)_"bline"$ has no periodicity
  - Conjecture: The tok. embs. encode a basis per subtask
][
  #figure(
    stack(
      spacing: 1em,
      // image("figs/fourier_basis_m.svg"),
      image("/src/assets/figs/miiii/fourier_masks_m.svg"),
      image("/src/assets/figs/miiii/fourier_basis_m.svg"),
    ),
    caption: [$cal(T)_"nanda"$ (top) and $cal(T)_"miiii"$ (bottom) token embeddings in Fourier basis],
  )<tok_emb>
]

= Neurons

#slide[
  - @neurs shows transformer MLP neuron activations as $x_0$, $x_1$ vary on each axis
  - Inspite of the dense Fourier basis of $W_E_cal(T)_"miiii"$ the periodicity is clear
][
  #figure(
    stack(
      image("/src/assets/figs/miiii/neurs_113_nanda.svg"),
      image("/src/assets/figs/miiii/neurs_113_miiii.svg"),
    ),
    caption: [Activations of first three neurons for $cal(T)_"nanda"$ (top) and $cal(T)_"miiii"$ (bottom)],
  )<neurs>
]

#slide[
  - (Probably redundant) sanity check: @fft_neurs confirms neurons are periodic
  - See some freqs. $omega$ rise into significance
  - Lets log $|omega > mu_omega + 2 sigma_omega|$ while training
][
  #figure(
    stack(
      image("/src/assets/figs/miiii/neurs_113_nanda_fft.svg"),
      image("/src/assets/figs/miiii/neurs_113_miiii_fft.svg"),
    ),
    caption: [FFT of Activations of first three neurons for $cal(T)_"nanda"$ (top) and $cal(T)_"miiii"$ (bottom)],
  )<fft_neurs>
]

#focus-slide[
  #figure(
    stack(
      // image("figs/neurs_113_miiii_fft.svg"),
      image("/src/assets/figs/miiii/miiii_large_finding.svg", width: 100%),
    ),
    caption: [Number of neurons with frequency $omega$ above the theshold $mu_omega + 2 sigma_omega$],
  )<spike>
]


= $omega$-Spike

#slide[
  // - We reach our central finding
  - Neurs. periodic on solving $q in {2,3,5,7}$
  - When we generalize to the reamining tasks, many frequencies activate
  // - Quickly after generalization $omega$'s merge
  - Those $omega$'s are not useful for memory and not useful after generalization
  #figure(
    table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: center,
      inset: 10pt,
      table.header(
        [*epoch*],
        "256",
        "1024",
        "4096",
        "16384",
        "65536",
      ),

      $bold(|omega|)$, $0$, $0$, $10$, $18$, "10",
    ),
    caption: [active $omega$'s through training],
  )<tableeeee>
][
  #figure(
    stack(
      image("/src/assets/figs/miiii/miiii_large_finding.svg", width: 96.5%),
      image(
        "/src/assets/figs/miiii/" + miiii_hash + "/acc_valid_training.svg",
        width: 100%,
      ),
    ),
    caption: [@spike (top) and validation accuracy from @training_acc (bottom)],
  )
]


#set align(top)
#show heading.where(level: 1): set heading(numbering: none)
= References <touying:unoutlined>
#bibliography("/src/assets/zotero.bib", title: none, style: "ieee")
