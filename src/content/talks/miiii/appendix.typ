#let appendix = [
  = Stochastic Signal Processing

  We denote the weights of a model as $theta$. The gradient of $theta$ with
  respect to our loss function at time $t$ we denote $g(t)$. As we train the
  model, $g(t)$ varies, going up and down. This can be thought of as a stocastic
  signal. We can represent this signal with a Fourier basis. GrokFast posits
  that the slow varying frequencies contribute to grokking. Higer frequencies
  are then muted, and grokking is indeed accelerated.

  = Discrete Fourier Transform

  Function can be expressed as a linear combination of cosine and sine waves. A
  similar thing can be done for data / vectors.

  = Singular Value Decomposition <svd>

  An $n times m$ matrix $M$ can be represented as a $U Sigma V^*$, where $U$ is
  an $m times m$ complex unitary matrix, $Sigma$ a rectangular $m times n$
  diagonal matrix (padded with zeros), and $V$ an $n times n$ complex unitary
  matrix. Multiplying by $M$ can thus be viewed as first rotating in the
  $m$-space with $U$, then scaling by $Sigma$ and then rotating by $V$ in the
  $n$-space.
]
