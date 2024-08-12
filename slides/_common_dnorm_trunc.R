dnorm_trunc <- function(x, mean = 0, sd = 1, ll = 0, ul = 1) {
    out <- dnorm(x, mean, sd) / (pnorm(ul, mean, sd) - pnorm(ll, mean, sd))
    out[x > ul | x < ll] <- 0
    out
}
qnorm_trunc <- function(p, mean = 0, sd = 1, ll = 0, ul = 1) {
    cdf_ll <- pnorm(ll, mean = mean, sd = sd)
    cdf_ul <- pnorm(ul, mean = mean, sd = sd)
    qnorm(cdf_ll + p * (cdf_ul - cdf_ll), mean = mean, sd = sd)
}
rnorm_trunc <- function(n, mean = 0, sd = 1, ll = 0, ul = 1) {
    p <- runif(n)
    qnorm_trunc(p, mean = mean, sd = sd, ll = ll, ul = ul)
}
compute_lik <- function(x, pts = grid, sd = 0.2, binwidth = .01) {
    lik_vals <- vapply(x, dnorm_trunc,
        mean = pts, sd = sd,
        FUN.VALUE = numeric(length(pts))
    )
    lik <- apply(lik_vals, 1, prod)
    lik / sum(lik) / binwidth
}
update_probs <- function(prior_probs, lik, binwidth = .01) {
    post_probs <- prior_probs * lik
    post_probs / sum(post_probs) / binwidth
}