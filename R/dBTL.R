#' The Beta Transformed Lomax distribution
#'
#' @author Marieth Guillen, \email{mguillen@unal.edu.co}
#'
#' @description
#' Density, distribution function, quantile function and
#' random generation for the Beta Transformed Lomax distribution with
#' parameters \code{mu}, \code{sigma} and \code{nu}.
#'
#' @param x,q vector of quantiles.
#' @param p vector of probabilities.
#' @param n number of observations.
#' @param mu parameter.
#' @param sigma parameter.
#' @param nu parameter.
#' @param log,log.p logical; if TRUE, probabilities p are given as log(p).
#' @param lower.tail logical; if TRUE (default), probabilities are
#' P[X <= x], otherwise, P[X > x].
#'
#' @references
#' Kottakkunnan, F. A New Generalization of Lomax Distribution: Estimation and Modelling for Medical Data.
#' J Stat Theory Appl 25, 19 (2026). https://doi.org/10.1007/s44199-026-00171-0
#'
#' @seealso \link{BTL}.
#'
#' @details
#' The Beta Transformed Lomax distribution with parameters \code{mu},
#' \code{sigma} and \code{nu} has density given by
#'
#' \eqn{f(x) = \frac{\log \nu}{\nu-1} \frac{\sigma}{\mu} \left(1+\frac{x}{\mu}\right)^{-(\sigma+1)} \nu^{\left(1+\frac{x}{\mu}\right)^{-\sigma}},}
#'
#' for \eqn{\nu \neq 1}, and for \eqn{\nu = 1}:
#'
#' \eqn{f(x) = \frac{\sigma}{\mu} \left(1+\frac{x}{\mu}\right)^{-(\sigma+1)},}
#'
#' for \eqn{x \geq 0}, \eqn{\mu > 0}, \eqn{\sigma > 0} and \eqn{\nu > 0}.
#'
#' @return
#' \code{dBTL} gives the density, \code{pBTL} gives the distribution
#' function, \code{qBTL} gives the quantile function and \code{rBTL}
#' generates random deviates.
#'
#' @example examples/examples_dBTL.R
#'
#' @export
#'
dBTL <- function(x, mu=1.5, sigma=1.5, nu=2, log=FALSE) {
  # Ensure same length vector
  ly    <- max(length(x), length(mu), length(sigma), length(nu))
  xx    <- rep(x, length=ly)
  mu    <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  nu    <- rep(nu, length=ly)

  # Temporal change for invalid x's
  xx[x < 0] <- 1
  xx[is.infinite(x)] <- 1

  # Temporal change for invalid mu or sigma or nu values
  invalid_param_values <- mu <= 0 | sigma <= 0 | nu <= 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  nu[invalid_param_values]    <- 1 # Temporal change

  # Pareto distribution when nu == 1
  lfy <- log(sigma) + sigma*log(mu) - (sigma+1)*log(xx+mu)
  # BTL distribution for n != 1
  i <- (nu != 1)
  lfy[i] <- log(abs(log(nu[i]))) - log(abs(nu[i] - 1)) + log(sigma[i]) - log(mu[i]) -
    (sigma[i]+1)*log(1+xx[i]/mu[i]) +(1+xx[i]/mu[i])^(-sigma[i])*log(nu[i])

  # Assing NaN for invalid mu or sigma
  lfy[invalid_param_values] <- NaN

  if (any(is.nan(lfy))) {
    warning("NaNs produced")
  }

  # Assign values for invalid x's
  lfy[x < 0] <- -Inf
  lfy[is.infinite(x)] <- -Inf

  # Log-densidad
  if (log == FALSE)
    lfy <- exp(lfy)
  return(lfy)
}
#' @export
#' @rdname dBTL
pBTL <- function(q, mu=1.5, sigma=1.5, nu=2, lower.tail=TRUE, log.p=FALSE){
  # Ensure same length vector
  ly    <- max(length(q), length(mu), length(sigma), length(nu))
  qq    <- rep(q, length=ly)
  mu    <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  nu    <- rep(nu, length=ly)

  # Temporal change for invalid x's
  qq[q <= 0] <- 1
  qq[q == Inf] <- 1

  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 0 | sigma <= 0 | nu <= 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  nu[invalid_param_values]    <- 1 # Temporal change

  # The cumulative for nu == 1
  cdf <-  1 - ((mu/(mu+qq))^(sigma))
  # The cumulative for n != 1
  i <- (nu != 1)
  cdf[i] <- (nu[i] / (nu[i] - 1)) * (1 - nu[i]^((1 + qq[i] / mu[i])^(-sigma[i]) - 1))

  # Assing NaN for invalid mu or sigma
  cdf[invalid_param_values] <- NaN

  if (any(is.nan(cdf))) {
    warning("NaNs produced")
  }

  # Assign values for invalid x's
  cdf[q <= 0] <- 0
  cdf[q == Inf] <- 1

  if (lower.tail == FALSE)
    cdf <- 1 - cdf
  if (log.p == TRUE)
    cdf <- log(cdf)

  return(cdf)
}
#' @export
#' @rdname dBTL
qBTL <- function(p, mu=1.5, sigma=1.5, nu=2, lower.tail=TRUE, log.p=FALSE) {

  # To adjust the probability
  if (log.p == TRUE)
    p <- exp(p)
  if (lower.tail == FALSE)
    p <- 1 - p

  # Ensure same length vector
  ly    <- max(length(p), length(mu), length(sigma))
  pp    <- rep(p, length=ly)
  mu    <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  nu    <- rep(nu, length=ly)

  # Temporal change for invalid p's
  pp[p < 0]  <-  0.1
  pp[p > 1]  <-  0.1
  pp[p == 1] <-  0.1
  pp[p == 0] <-  0.1

  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 0 | sigma <= 0 | nu <= 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  nu[invalid_param_values]    <- 1 # Temporal change

  # The quantile for nu == 1
  q <- mu * ((1-pp)^(-1/sigma)-1)
  # The quantile for nu != 1
  i <- nu != 1
  q[i] <- mu[i] * ((log(nu[i]-pp[i] * (nu[i] - 1))/log(nu[i]))^(-1 / sigma[i]) - 1)

  # Assing NaN for invalid mu or sigma
  q[invalid_param_values] <- NaN

  if (any(is.nan(q))) {
    warning("NaNs produced")
  }

  # To deal with invalid p's
  q[p <  0] <- NaN
  q[p >  1] <- NaN
  q[p == 0] <- 0
  q[p == 1] <- Inf

  return(q)
}
#'
#' @importFrom stats runif
#' @export
#' @rdname dBTL
rBTL <- function(n, mu=1.5, sigma=1.5, nu=2) {
  if (any(n <= 0)) stop(paste("n must be a positive integer", "\n", ""))

  n <- ceiling(n)
  u <- runif(n=n)
  x <- qBTL(p=u, mu=mu, sigma=sigma, nu=nu)
  return(x)
}