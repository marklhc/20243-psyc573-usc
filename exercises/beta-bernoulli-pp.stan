data {
  int<lower=0> N;  // number of observations
  array[N] int<lower=0,upper=1> y;  // y
}
parameters {
  real<lower=0,upper=1> theta;  // theta parameter
}
model {
  theta ~ beta(2, 2);  // prior: Beta(2, 2)
  y ~ bernoulli(theta);  // model: Bernoulli
}
generated quantities {
  real prior_theta = beta_rng(2, 2);
  array[N] int prior_ytilde;
  array[N] int ytilde;
  for (i in 1:N) {
    ytilde[i] = bernoulli_rng(theta);
    prior_ytilde[i] = bernoulli_rng(prior_theta);
  }
}
