#' The Generalized Lindley Type II (GLIN) distribution
#'
#' @author Sofia Cadavid Rueda, \email{socadavidr@unal.edu.co}
#'
#' @description
#' These functions define the density, distribution function, quantile
#' function and random generation for the Generalized Lindley Type II,
#' GLIN(), distribution with parameters \eqn{\mu} and \eqn{\sigma}.
#'
#' @param x,q vector of positive quantiles.
#' @param p vector of probabilities.
#' @param mu vector of the mu parameter.
#' @param sigma vector of the sigma parameter.
#' @param n number of random values to return.
#' @param log,log.p logical; if TRUE, probabilities p are given as log(p).
#' @param lower.tail logical; if TRUE (default), probabilities are
#' \eqn{P[X \le x]}, otherwise, \eqn{P[X > x]}.
#'
#' @references
#' Ekhosuehi, N., Opone, F., & Odobaire, F. (2018).
#' A New Generalized Two Parameter Lindley Distribution.
#' Journal of the Nigerian Statistical Association, 30, 547--566.
#'
#' @seealso \link{GLIN}.
#'
#' @details
#' The Generalized Lindley Type II distribution with parameters
#' \code{mu} and \code{sigma} has probability density function
#'
#' \eqn{
#' f(x|\mu,\sigma)=
#' \frac{\mu^2}{\mu+1}
#' \left(
#' 1+\frac{\mu^{\sigma-2}x^{\sigma-1}}
#' {\Gamma(\sigma)}
#' \right)
#' e^{-\mu x},
#' }
#'
#' for \eqn{x>0}, \eqn{\mu>0} and \eqn{\sigma>0}.
#'
#' The distribution is a two-parameter extension of the classical
#' Lindley distribution and belongs to the class of finite mixtures
#' involving exponential and gamma components. It provides additional
#' flexibility for modeling positively skewed lifetime data.
#'
#' The original parameters of the distribution are denoted by
#' \eqn{\theta} and \eqn{\alpha}. In the GAMLSS implementation,
#' they are re-parameterized as \eqn{\mu=\theta} and \eqn{\sigma=\alpha}.
#'
#' The \eqn{r}-th raw moment is given by
#'
#' \eqn{
#' E(X^r)=
#' \frac{1}
#' {\mu^r(\mu+1)}
#' \left[
#' \mu\Gamma(r+1)
#' +
#' \frac{\Gamma(r+\sigma)}
#' {\Gamma(\sigma)}
#' \right].
#' }
#'
#' In particular, the mean is
#'
#' \eqn{
#' E(X)=
#' \frac{\mu+\sigma}
#' {\mu(\mu+1)}.
#' }
#' 
#' and the variance is
#' 
#' \eqn{
#' Var(X)=
#' \frac{\mu^2 + \mu(\sigma^2 - \sigma + 2) + \sigma}
#' {\mu^2(\mu + 1)^2}.
#' }
#'
#' The GLIN distribution is a flexible two-parameter extension of the
#' classical Lindley distribution and is suitable for modeling
#' positive lifetime and survival data.
#'
#' @return
#' \code{dGLIN} gives the density, \code{pGLIN} gives the distribution
#' function, \code{qGLIN} gives the quantile function, and
#' \code{rGLIN} generates random deviates.
#'
#' @example examples/examples_dGLIN.R
#'
#' @export
dGLIN <- function(x, mu, sigma , log = FALSE) {
  
  # Ensure same length vector
  ly    <- max(length(x), length(mu), length(sigma))
  xx    <- rep(x, length=ly)
  mu    <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  
  # Temporal change for invalid x's
  xx[x <= 0] <- 0.5
  xx[is.infinite(x)] <- 0.5
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 0 | sigma <= 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  
  # pdf in log-scale
  part1 <- 2 * log(mu) - log(mu + 1)
  term2 <- (mu^(sigma- 2) * xx^(sigma - 1)) / gamma(sigma)
  part2 <- log1p(term2)
  part3 <- -mu * xx
  p <- part1 + part2 + part3
  
  # Assing NaN for invalid mu or sigma
  p[invalid_param_values] <- NaN
  
  if (any(is.nan(p))) {
    warning("NaNs produced")
  }
  
  # Assign values for invalid x's
  p[x <= 0] <- -Inf
  p[is.infinite(x)] <- -Inf
  
  if (log == FALSE)
    p <- exp(p)
  
  return(p)
}
#' @export
#' @importFrom stats pnorm
#' @rdname dGLIN
pGLIN <- function(q, mu, sigma, lower.tail=TRUE, log.p=FALSE){
  
  # Ensure same length vector
  ly     <- max(length(q), length(mu), length(sigma))
  qq     <- rep(q, length=ly)
  mu     <- rep(mu, length=ly)
  sigma  <- rep(sigma, length=ly)
  
  # Temporal change for invalid x's
  qq[q <=0]     <- 0.5
  qq[q == Inf]  <- 0.5
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 0 | sigma <= 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  
  # The cumulative
  part1 <- (mu+1)*gamma(sigma)
  part2 <- (mu*gamma(sigma))*(1-exp(-mu*qq))
  gamma_inc_sup <- pgamma(mu* qq, shape = sigma, lower.tail = FALSE) * gamma(sigma)
  part3 <- gamma(sigma) - gamma_inc_sup
  part  <- part2 + part3
  cdf   <- part/part1
  
  # Assing NaN for invalid mu or sigma
  cdf[invalid_param_values] <- NaN
  
  if (any(is.nan(cdf))) {
    warning("NaNs produced")
  }
    
  # Assign values for invalid x's
  cdf[q <= 0]    <- 0
  cdf[q == Inf]  <- 1
  
  if (lower.tail == FALSE)
    cdf <- 1 - cdf
  if(log.p == TRUE)
    cdf <- log(cdf)
  
  return(cdf)
}
#' @importFrom stats uniroot qnorm
#' @export
#' @rdname dGLIN
qGLIN <- function(p, mu, sigma, lower.tail=TRUE, log.p=FALSE){
  if (any(mu <=0))    stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <=0)) stop(paste("sigma must be positive", "\n", ""))
  
  # To adjust the probability 
  if (log.p == TRUE)
    p <- exp(p)
  if (lower.tail == FALSE)
    p <- 1-p
  
  # Ensure same length vector 
  ly <- max(length(p), length(mu), length(sigma))
  pp <- rep(p, length=ly)
  mu <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  
  # Temporal change for invalid p's
  pp[p < 0] <- 0.5
  pp[p > 1] <- 0.5
  pp[p ==1] <- 0.5
  pp[p ==0] <- 0.5
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 0 | sigma <= 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  
  # The quantile
  q <- rep(NA, ly)
  
  for (i in seq_len(ly)) {
    q[i] <- uniroot(
      f     = function(x) pGLIN(x, mu = mu[i], sigma = sigma[i]) - pp[i],
      lower = 1e-10,
      upper = 1e6,
      tol   = 1e-8
    )$root
  }
  
  # Assing NaN for invalid mu or sigma
  q[invalid_param_values] <- NaN
  
  if (any(is.nan(q))) {
    warning("NaNs produced")
  }
  
  # To deal with invalid p's
  q[p < 0]  <- NaN
  q[p > 1]  <- NaN
  q[p == 1] <- Inf
  q[p == 0] <- 0
  
  return(q) 
}
#' @importFrom stats runif
#' @export
#' @rdname dGLIN
rGLIN <- function(n, mu, sigma) {
  if (any(mu <= 0))     stop("parameter mu has to be positive!")
  if (any(sigma <= 0))  stop("parameter sigma has to be positive!")
  if (any(n <= 0))      stop(paste("n must be a positive integer", "\n", ""))
  
  n <- ceiling(n)
  u <- runif(n=n)
  x <- qGLIN(p=u, mu=mu, sigma=sigma)
  return(x)
}
#' @importFrom stats runif
#' @export
#' @rdname dGLIN
hGLIN <- function(x, mu = 0.5, sigma = 0.5) {
  if(any(mu <= 0))
    stop("parameter mu has to be positive!")
  
  if(any(sigma <= 0))
    stop("parameter sigma has to be positive!")
  
  dGLIN(x, mu, sigma) / pGLIN(x, mu, sigma, lower.tail=FALSE)
}
