#' The Beta Transformed Lomax distribution
#'
#' @author Marieth Guillen, \email{mguillen@unal.edu.co}
#'
#' @description
#' The Beta Transformed Lomax family
#'
#' @param mu.link defines the mu.link, with "log" link as the default for the mu parameter.
#' @param sigma.link defines the sigma.link, with "log" link as the default for the sigma parameter.
#' @param nu.link defines the nu.link, with "log" link as the default for the nu parameter.
#'
#' @seealso \link{dBTL}
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
#' @returns
#' Returns a gamlss.family object which can be used to fit a
#' BTL distribution in the \code{gamlss()} function.
#'
#' @example examples/examples_BTL.R
#'
#' @references
#' Kottakkunnan, F. A New Generalization of Lomax Distribution: Estimation and Modelling for Medical Data.
#' J Stat Theory Appl 25, 19 (2026). https://doi.org/10.1007/s44199-026-00171-0
#'
#' @importFrom gamlss rqres.plot
#' @export
BTL <- function (mu.link="log", sigma.link="log", nu.link="log"){
  mstats <- checklink("mu.link", "Beta Transformed Lomax",
                      substitute(mu.link), c("log", "own"))
  dstats <- checklink("sigma.link", "Beta Transformed Lomax",
                      substitute(sigma.link), c("log", "own"))
  vstats <- checklink("nu.link", "Beta Transformed Lomax",
                      substitute(nu.link), c("log", "own"))
  
  structure(list(family=c("BTL", "Beta Transformed Lomax"),
                 parameters=list(mu=TRUE, sigma=TRUE, nu=TRUE),
                 nopar=3,
                 type="Continuous",
                 
                 mu.link    = as.character(substitute(mu.link)),
                 sigma.link = as.character(substitute(sigma.link)),
                 nu.link    = as.character(substitute(nu.link)),
                 
                 mu.linkfun    = mstats$linkfun,
                 sigma.linkfun = dstats$linkfun,
                 nu.linkfun    = vstats$linkfun,
                 
                 mu.linkinv    = mstats$linkinv,
                 sigma.linkinv = dstats$linkinv,
                 nu.linkinv    = vstats$linkinv,
                 
                 mu.dr    = mstats$mu.eta,
                 sigma.dr = dstats$mu.eta,
                 nu.dr    = vstats$mu.eta,
                 
                 # First derivates
                 dldm = function(y, mu, sigma, nu) {
                   dm   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   dldm
                 },
                 dldd = function(y, mu, sigma, nu) {
                   dd   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="sigma",
                                                 delta=0.00001)
                   dldd <- as.vector(attr(dd, "gradient"))
                   dldd
                 },
                 dldv = function(y, mu, sigma, nu) {
                   dv   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="nu",
                                                 delta=0.00001)
                   dldv <- as.vector(attr(dv, "gradient"))
                   dldv
                 },
                 # Second derivates
                 d2ldm2 = function(y, mu, sigma, nu) {
                   dm   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   d2ldm2 <- - dldm * dldm
                   d2ldm2 <- ifelse(d2ldm2 < -1e-15, d2ldm2, -1e-15)
                   d2ldm2
                 },
                 d2ldd2 = function(y, mu, sigma, nu) {
                   dd   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="sigma",
                                                 delta=0.00001)
                   dldd <- as.vector(attr(dd, "gradient"))
                   d2ldd2 <- - dldd * dldd
                   d2ldd2 <- ifelse(d2ldd2 < -1e-15, d2ldd2, -1e-15)
                   d2ldd2
                 },
                 d2ldv2 = function(y, mu, sigma, nu) {
                   dv   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="nu",
                                                 delta=0.00001)
                   dldv <- as.vector(attr(dv, "gradient"))
                   d2ldv2 <- - dldv * dldv
                   d2ldv2 <- ifelse(d2ldv2 < -1e-15, d2ldv2, -1e-15)
                   d2ldv2
                 },
                 d2ldmdd = function(y, mu, sigma, nu) {
                   dm   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   dd   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="sigma",
                                                 delta=0.00001)
                   dldd <- as.vector(attr(dd, "gradient"))
                   d2ldmdd <- - dldm * dldd
                   d2ldmdd <- ifelse(d2ldmdd < -1e-15, d2ldmdd, -1e-15)
                   d2ldmdd
                 },
                 d2ldmdv = function(y, mu, sigma, nu) {
                   dm   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   dv   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="nu",
                                                 delta=0.00001)
                   dldv <- as.vector(attr(dv, "gradient"))
                   d2ldmdv <- - dldm * dldv
                   d2ldmdv <- ifelse(d2ldmdv < -1e-15, d2ldmdv, -1e-15)
                   d2ldmdv
                 },
                 d2ldddv = function(y, mu, sigma, nu) {
                   dd   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="sigma",
                                                 delta=0.00001)
                   dldd <- as.vector(attr(dd, "gradient"))
                   dv   <- gamlss::numeric.deriv(dBTL(y, mu, sigma, nu, log=TRUE),
                                                 theta="nu",
                                                 delta=0.00001)
                   dldv <- as.vector(attr(dv, "gradient"))
                   d2ldddv <- - dldd * dldv
                   d2ldddv <- ifelse(d2ldddv < -1e-15, d2ldddv, -1e-15)
                   d2ldddv
                 },
                 G.dev.incr = function(y, mu, sigma, nu, ...) -2*dBTL(y, mu, sigma, nu, log=TRUE),
                 rqres      = expression(rqres(pfun="pBTL", type="Continuous", y=y, mu=mu, sigma=sigma, nu=nu)),
                 
                 mu.initial    = expression(mu    <- rep(mean(y), length(y))),
                 sigma.initial = expression(sigma <- rep(1, length(y))),
                 nu.initial    = expression(nu    <- rep(1, length(y))),
                 
                 mu.valid    = function(mu)    all(mu > 0),
                 sigma.valid = function(sigma) all(sigma > 0),
                 nu.valid    = function(nu)    all(nu > 0),
                 
                 y.valid     = function(y)     all(y > 0) # Soporte (0, Inf)
  ),
  class=c("gamlss.family", "family"))
}
