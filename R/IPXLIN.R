#' The Inverse Power XLindley family - Hassan et al. (2025)
#'
#' @description
#' The Inverse Power XLindley family
#'
#' @param mu.link defines the mu.link, with "logit" link as the default for the mu parameter.
#' @param sigma.link defines the sigma.link, with "log" link as the default for the sigma parameter.
#'
#' @seealso \link{dIPXLIN}
#'
#' @details
#' The Inverse Power XLindley distribution with parameters \code{mu},
#' and \code{sigma} has density given by
#'
#' \eqn{f(x|\mu,\sigma) = \frac{\sigma \mu^2}{(1+\mu)^2} x^{-2\sigma-1} \left(1 + (2+\mu) x^\sigma\right) e^{-\mu x^{-\sigma}}}
#' 
#' for \eqn{x>0}, \eqn{\mu>0} and \eqn{\sigma>0}. In this parameterization, 
#' \eqn{\mu} is the scale parameter and \eqn{\sigma} is the shape parameter.
#'
#' @returns
#' Returns a gamlss.family object which can be used to fit a
#' IPXLIN distribution in the \code{gamlss()} function.
#'
#' @example examples/examples_IPXLIN.R
#'
#' @references
#' Hassan, A. S., Alsadat, N., Chesneau, C., Elgarhy, M., Kayid, M., 
#' Nasiru, S., & Gemeay, A. M. (2025). Inverse power XLindley 
#' distribution with statistical inference and applications to 
#' engineering data. Scientific Reports, 15, 4385.
#'
#' @importFrom gamlss rqres.plot
#' @export
IPXLIN <- function (mu.link="log", sigma.link="log"){
  mstats <- checklink("mu.link", "Inverse Power XLindley",
                      substitute(mu.link), c("log", "own"))
  dstats <- checklink("sigma.link", "Inverse Power XLindley",
                      substitute(sigma.link), c("log", "own"))
  
  structure(list(family=c("IPXLIN", "Inverse Power XLindley"),
                 parameters=list(mu=TRUE, sigma=TRUE),
                 nopar=2,
                 type="Continuous",
                 
                 mu.link    = as.character(substitute(mu.link)),
                 sigma.link = as.character(substitute(sigma.link)),
                 
                 mu.linkfun    = mstats$linkfun,
                 sigma.linkfun = dstats$linkfun,
                 
                 mu.linkinv    = mstats$linkinv,
                 sigma.linkinv = dstats$linkinv,
                 
                 mu.dr    = mstats$mu.eta,
                 sigma.dr = dstats$mu.eta,
                 
                 # First derivates
                 dldm = function(y, mu, sigma) {
                   dm   <- gamlss::numeric.deriv(dIPXLIN(y, mu, sigma, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   dldm
                 },
                 
                 dldd = function(y, mu, sigma) {
                   dd   <- gamlss::numeric.deriv(dIPXLIN(y, mu, sigma, log=TRUE),
                                                 theta="sigma",
                                                 delta=0.00001)
                   dldd <- as.vector(attr(dd, "gradient"))
                   dldd
                 },
                 
                 # Second derivates
                 
                 d2ldm2 = function(y, mu, sigma) {
                   dm   <- gamlss::numeric.deriv(dIPXLIN(y, mu, sigma, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   d2ldm2 <- - dldm * dldm
                   d2ldm2 <- ifelse(d2ldm2 < -1e-15, d2ldm2, -1e-15)
                   d2ldm2
                 },
                 
                 d2ldd2  = function(y, mu, sigma) {
                   dd   <- gamlss::numeric.deriv(dIPXLIN(y, mu, sigma, log=TRUE),
                                                 theta="sigma",
                                                 delta=0.00001)
                   dldd <- as.vector(attr(dd, "gradient"))
                   d2ldd2 <- - dldd * dldd
                   d2ldd2 <- ifelse(d2ldd2 < -1e-15, d2ldd2, -1e-15)
                   d2ldd2
                 },
                 
                 d2ldmdd = function(y, mu, sigma) {
                   dm   <- gamlss::numeric.deriv(dIPXLIN(y, mu, sigma, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   dd   <- gamlss::numeric.deriv(dIPXLIN(y, mu, sigma, log=TRUE),
                                                 theta="sigma",
                                                 delta=0.00001)
                   dldd <- as.vector(attr(dd, "gradient"))
                   
                   d2ldmdd <- - dldm * dldd
                   d2ldmdd <- ifelse(d2ldmdd < -1e-15, d2ldmdd, -1e-15)
                   d2ldmdd
                 },
                 
                 G.dev.incr = function(y, mu, sigma, ...) -2*dIPXLIN(y, mu, sigma, log=TRUE),
                 rqres      = expression(rqres(pfun="pIPXLIN", type="Continuous", y=y, mu=mu, sigma=sigma)),
                 
                 mu.initial    = expression(mu    <- rep(1.0, length(y))),
                 sigma.initial = expression(sigma <- rep(1.0, length(y))),
                 
                 mu.valid    = function(mu)    all(mu > 0),
                 sigma.valid = function(sigma) all(sigma > 0),
                 
                 y.valid = function(y) all(y > 0)
                 
  ),
  class=c("gamlss.family", "family"))
}
