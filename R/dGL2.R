#' The Generalized Lindley Type II (GL2) distribution
#'
#' @author Sofia Cadavid Rueda, \email{socadavidr@unal.edu.co}
#'
#' @description
#' These functions define the density, distribution function, quantile
#' function and random generation for the Generalized Lindley Type II,
#' GL2(), distribution with parameters \eqn{\mu} and \eqn{\sigma}.
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
#' @seealso \link{GL2}.
#'
#' @details
#' The Generalized Lindley Type II distribution with parameters
#' \eqn{\mu > 0} and \eqn{\sigma > 0} has support \eqn{x > 0}
#' and probability density function given by
#'
#' \eqn{
#' f(x|\mu,\sigma)=
#' \frac{\mu^2}{\mu+1}
#' \left(
#' 1+
#' \frac{\mu^{\sigma-2}x^{\sigma-1}}
#' {\Gamma(\sigma)}
#' \right)
#' e^{-\mu x},
#' }
#'
#' for \eqn{x > 0}, \eqn{\mu > 0} and \eqn{\sigma > 0}.
#'
#' Note: in this implementation we changed the original parameters
#' \eqn{\theta} for \eqn{\mu} and \eqn{\alpha} for \eqn{\sigma}.
#' This reparameterization was performed to implement the distribution
#' within the GAMLSS framework.
#'
#' The GL2 distribution is a flexible two-parameter extension of the
#' classical Lindley distribution and is suitable for modeling
#' positive lifetime and survival data.
#'
#' @return
#' \code{dGL2} gives the density, \code{pGL2} gives the distribution
#' function, \code{qGL2} gives the quantile function, and
#' \code{rGL2} generates random deviates.
#'
#' @example examples/examples_dGL2.R
#'
#' @export
dGL2 <- function(x, mu, sigma , log = FALSE) {
  if (any(mu <= 0)) stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0)) stop(paste("sigma must be positive", "\n", ""))
  
  # Ensure same length vector
  ly    <- max(length(x), length(mu), length(sigma))
  xx    <- rep(x, length=ly)
  mu    <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  
  # Temporal change for invalid x's
  xx[x <= 0] <- 0.5
  xx[is.infinite(x)] <- 0.5
  
  # pdf in log-scale
  
  part1 <- 2 * log(mu) - log(mu + 1)
  
  term2 <- (mu^(sigma- 2) * xx^(sigma - 1)) / gamma(sigma)
  part2 <- log1p(term2)
  
  part3 <- -mu * xx
  
  p <- part1 + part2 + part3
  
  # Assign values for invalid x's
  p[x <= 0] <- -Inf
  p[is.infinite(x)] <- -Inf
  
  if (log == FALSE)
    p <- exp(p)
  
  return(p)
}
#' @export
#' @importFrom stats pnorm
#' @rdname dGL2
pGL2 <- function(q, mu, sigma, lower.tail=TRUE, log.p=FALSE){
  
  if (any(mu <=0))    stop("parameter mu has to be positive!")
  if (any(sigma <=0)) stop("parameter sigma has to be posiyive!")
  
  # Ensure same length vector
  ly     <- max(length(q), length(mu), length(sigma))
  qq     <- rep(q, length=ly)
  mu     <- rep(mu, length=ly)
  sigma  <- rep(sigma, length=ly)
  
  # Temporal change for invalid x's
  qq[q <=0]     <- 0.5
  qq[q == Inf]  <- 0.5
  
  # The cumulative
  part1 <- (mu+1)*gamma(sigma)
  part2 <- (mu*gamma(sigma))*(1-exp(-mu*qq))
  gamma_inc_sup <- pgamma(mu* qq, shape = sigma, lower.tail = FALSE) * gamma(sigma)
  part3 <- gamma(sigma) - gamma_inc_sup
  part  <- part2 + part3
  cdf   <- part/part1
    
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
#' @rdname dGL2
qGL2 <- function(p, mu, sigma, lower.tail=TRUE, log.p=FALSE){
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
  
  #The quantile
  
  qq <- rep(NA, ly)
  
  for (i in seq_len(ly)) {
    if (pp[i] <= 0 | pp[i] >= 1) {
      qq[i] <- NaN
      next
    }
    qq[i] <- uniroot(
      f     = function(x) pGL2(x, mu = mu[i], sigma = sigma[i]) - pp[i],
      lower = 1e-10,
      upper = 1e6,
      tol   = 1e-8
    )$root
  }
  
  # To deal with invalid p's
  qq[p < 0]  <- NaN
  qq[p > 1]  <- NaN
  qq[p == 1] <- Inf
  qq[p == 0] <- 0
  
  return(qq) 
}
#' @importFrom stats runif
#' @export
#' @rdname dGL2
rGL2 <- function(n, mu, sigma){
  if (any(mu <= 0))     stop("parameter mu has to be positive!")
  if (any(sigma <= 0))  stop("parameter sigma has to be positive!")
  if (any(n <= 0))      stop(paste("n must be a positive integer", "\n", ""))
  
  n <- ceiling(n)
  u <- runif(n=n)
  x <- qGL2(p=u, mu=mu, sigma=sigma)
  return(x)
}
#' @importFrom stats runif
#' @export
#' @rdname dGL2
hGL2 <- function(x, mu = 0.5, sigma = 0.5)
{
  if(any(mu <= 0))
    stop("parameter mu has to be positive!")
  
  if(any(sigma <= 0))
    stop("parameter sigma has to be positive!")
  
  dGL2(x, mu, sigma) /
    (1 - pGL2(x, mu, sigma))
}
