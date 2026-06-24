#' The gamma distribution in its original parameterization
#' 
#' @description
#' Density, distribution function, quantile function, 
#' random generation and hazard function for the 
#' gamma original distribution with
#' parameters \code{mu} and \code{sigma}.
#' 
#' @param x,q	vector of quantiles.
#' @param p vector of probabilities.
#' @param n number of observations. 
#' @param mu parameter.    
#' @param sigma parameter.
#' @param log,log.p	logical; if TRUE, probabilities p are given as log(p).	
#' @param lower.tail logical; if TRUE (default), probabilities are 
#' P[X <= x], otherwise, P[X > x].
#' 
#' @references
#' Abramowitz M, Stegun IA (1972). Handbook of Mathematical Functions 
#' with Formulas, Graphs, and Mathematical Tables. Dover Publications, 
#' New York. ISBN 0486612724. Chapter 6: Gamma and Related Functions.
#' 
#' @seealso \link{GAo}.
#' 
#' @details 
#' The gamma original with parameters \code{mu} and \code{sigma}
#' has density given by
#' 
#' \eqn{f(x|\mu,\sigma) = \frac{x^{\mu-1}e^{-x/\sigma}}{\sigma^\mu \Gamma(\mu)}}
#' 
#' for \eqn{x>0}, \eqn{\mu>0} and \eqn{\sigma>0}. 
#' The parameter \eqn{\mu} is the shape parameter and \eqn{\sigma} is 
#' the scale parameter.   
#' In this parameterization \eqn{\mu} is the median of \eqn{X}, 
#' \eqn{E(X)=\mu \sigma} and 
#' \eqn{Var(X)=\mu \sigma^2}. 
#' 
#' @return 
#' \code{dGAo} gives the density, \code{pGAo} gives the distribution 
#' function, \code{qGAo} gives the quantile function, \code{rGAo}
#' generates random deviates and \code{hGAo} gives the hazard function.
#' 
#' @example examples/examples_dGAo.R
#' 
#' @importFrom stats dgamma
#' @export
dGAo <- function(x, mu=1, sigma=1, log=FALSE) {
  dgamma(x=x, shape=mu, scale=sigma, log=log)
}
#' @export
#' @importFrom stats pgamma
#' @rdname dGAo
pGAo <- function(q, mu=1, sigma=1, lower.tail=TRUE, log.p=FALSE) {
  pgamma(q=q, shape=mu, scale=sigma, lower.tail=lower.tail, log.p=log.p)
}
#' @importFrom stats qgamma
#' @export
#' @rdname dGAo
qGAo <- function(p, mu=1, sigma=1, lower.tail = TRUE, log.p = FALSE) {
  qgamma(p=p, shape=mu, scale=sigma, lower.tail=lower.tail, log.p=log.p)
}
#' @importFrom stats rgamma
#' @export
#' @rdname dGAo
rGAo <- function(n, mu=1, sigma=1) {
  rgamma(n=n, shape=mu, scale=sigma)
}
#' @export
#' @rdname dGAo
hGAo <- function(x, mu, sigma) {
  h <- dGAo(x, mu, sigma) / pGAo(x, mu, sigma, lower.tail=FALSE)
  h
}