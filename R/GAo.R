#' The gamma family in its original parameterization
#' 
#' @description 
#' The function \code{GAo()} defines The gamma, 
#' a two parameter distribution, for a \code{gamlss.family} object 
#' to be used in GAMLSS fitting 
#' using the function \code{gamlss()}.
#' 
#' @param mu.link defines the mu.link, with "log" link as the default 
#' for the mu parameter.
#' @param sigma.link defines the sigma.link, with "log" link as the default 
#' for the sigma.
#' 
#' @seealso \link{dGAo}
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
#' @returns Returns a gamlss.family object which can be used to fit a GAo distribution in the \code{gamlss()} function.
#' 
#' @example examples/examples_GAo.R 
#'
#' @references
#' Abramowitz M, Stegun IA (1972). Handbook of Mathematical Functions 
#' with Formulas, Graphs, and Mathematical Tables. Dover Publications, 
#' New York. ISBN 0486612724. Chapter 6: Gamma and Related Functions.
#' 
#' @importFrom gamlss.dist checklink
#' @importFrom gamlss rqres.plot
#' @export
GAo <- function(mu.link = "log", sigma.link = "log"){
  mstats <- checklink("mu.link", "GAo", substitute(mu.link),
                      c("inverse", "log", "identity", "own"))
  dstats <- checklink("sigma.link", "GAo", substitute(sigma.link),
                      c("inverse", "log", "identity", "own"))
  structure(
    list(family = c("GAo", "gamma original"),
         parameters = list(mu=TRUE, sigma=TRUE),
         nopar = 2,
         type = "Continuous",
         mu.link = as.character(substitute(mu.link)),
         sigma.link = as.character(substitute(sigma.link)),
         mu.linkfun = mstats$linkfun,
         sigma.linkfun = dstats$linkfun,
         mu.linkinv = mstats$linkinv,
         sigma.linkinv = dstats$linkinv,
         mu.dr = mstats$mu.eta,
         sigma.dr = dstats$mu.eta,
         
         # First derivatives
         dldm = function(y,sigma,mu) log(y)-log(sigma)-digamma(mu),
         dldd = function(y,sigma,mu) (y-mu*sigma)/sigma^2,
         
         # Second derivatives
         d2ldm2 = function(y,sigma,mu) -trigamma(mu),
         d2ldd2 = function(y,sigma,mu) -mu/sigma^2,
         
         d2ldmdd = function(y,sigma,mu) -1/sigma,
         
         G.dev.incr = function(y,mu,sigma,...) -2*dGAo(y,mu,sigma,log=TRUE),
         rqres = expression(rqres(pfun="pGAo", type="Continuous",y=y,mu=mu,sigma=sigma)),
         
         mu.initial    = expression({mu    <- rep(mean(y)^2/mean((y-mean(y))^2), length(y))}),
         sigma.initial = expression({sigma <- rep(mean((y-mean(y))^2)/mean(y), length(y)) }),
         
         mu.valid = function(mu) all(mu > 0) ,
         sigma.valid = function(sigma) all(sigma > 0),
         y.valid = function(y) all(y > 0)
    ),
    class = c("gamlss.family","family"))
}