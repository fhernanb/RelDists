#' The Birnbaum-Saunders family - Santos-Neto et al. (2012) (P7 based on the mean and a bounded variance)
#' 
#' @author David Villegas Ceballos, \email{david.villegas1@@udea.edu.co}
#' 
#' @description 
#' The function \code{BS9()} defines the Birnbaum-Saunders distribution, 
#' a two-parameter distribution, for a \code{gamlss.family} object 
#' to be used in GAMLSS fitting using the function \code{gamlss()}.
#' 
#' @param mu.link defines the mu.link, with "log" link as the default 
#' for the mu parameter (representing the variance).
#' @param sigma.link defines the sigma.link, with "log" link as the default 
#' for the sigma parameter (representing the shape).
#' 
#' @references
#' Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012). 
#' On new parameterizations of the Birnbaum-Saunders distribution. 
#' Pakistan Journal of Statistics, 28(1), 1-26.
#' 
#' @seealso \link{dBS9}.
#' 
#' @details 
#' The Birnbaum-Saunders distribution with parameters \code{mu} and \code{sigma} 
#' (where \code{mu} represents the true variance \eqn{\sigma^2} and \code{sigma} represents the shape parameter \eqn{\alpha}) 
#' has density given by
#' 
#' \deqn{
#' f(x \mid \mu,\sigma) =
#' \frac{
#' \exp\left(\frac{1}{2(\sigma-1)}\right)
#' (x\sigma+\mu)
#' }{
#' 4\sqrt{\pi\sigma(\sigma-1)\mu}\,x^{3/2}
#' }
#' \exp\left[
#' -\frac{1}{4(\sigma-1)}
#' \left(
#' \frac{x\sigma}{\mu}+
#' \frac{\mu}{x\sigma}
#' \right)
#' \right]
#' }{
#' }
#' 
#' for \eqn{x>0}, \eqn{\mu>0} and \eqn{\sigma>1}. In this parameterization, 
#' \eqn{E(X) = \mu} and 
#' \eqn{Var(X) = \frac{\mu^2(\sigma-1)(5\sigma-3)}{\sigma^2}}.
#' 
#' @returns Returns a \code{gamlss.family} object which can be used to fit a 
#' BS9 distribution in the \code{gamlss()} function.
#' 
#' @example examples/examples_BS9.R
#' 
#' @importFrom gamlss rqres.plot
#' @export
BS9 <- function(mu.link = "log", sigma.link = "log") {
  mstats <- checklink("mu.link", "BS9", substitute(mu.link),
                      c("log", "inverse", "identity", "own"))
  dstats <- checklink("sigma.link", "BS9", substitute(sigma.link),
                      c("log", "logit", "probit", "own"))
  structure(
    list(family = c("BS9", "Birnbaum-Saunders - Eight parameterization"),
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
         
         # First derivates
         
         dldm = function(y, mu, sigma) {
           dm   <- gamlss::numeric.deriv(dBS9(y, mu, sigma, log=TRUE),
                                         theta="mu",
                                         delta=0.00001)
           dldm <- as.vector(attr(dm, "gradient"))
           dldm
         },
         
         dldd = function(y, mu, sigma) {
           dd   <- gamlss::numeric.deriv(dBS9(y, mu, sigma, log=TRUE),
                                         theta="sigma",
                                         delta=0.00001)
           dldd <- as.vector(attr(dd, "gradient"))
           dldd
         },
         
         # Second derivates
         
         d2ldm2 = function(y, mu, sigma) {
           dm   <- gamlss::numeric.deriv(dBS9(y, mu, sigma, log=TRUE),
                                         theta="mu",
                                         delta=0.00001)
           dldm <- as.vector(attr(dm, "gradient"))
           d2ldm2 <- - dldm * dldm
           d2ldm2 <- ifelse(d2ldm2 < -1e-15, d2ldm2, -1e-15)
           d2ldm2
         },
         
         d2ldmdd = function(y, mu, sigma) {
           dm   <- gamlss::numeric.deriv(dBS9(y, mu, sigma, log=TRUE),
                                         theta="mu",
                                         delta=0.00001)
           dldm <- as.vector(attr(dm, "gradient"))
           dd   <- gamlss::numeric.deriv(dBS9(y, mu, sigma, log=TRUE),
                                         theta="sigma",
                                         delta=0.00001)
           dldd <- as.vector(attr(dd, "gradient"))
           
           d2ldmdd <- - dldm * dldd
           d2ldmdd <- ifelse(d2ldmdd < -1e-15, d2ldmdd, -1e-15)
           d2ldmdd
         },
         
         d2ldd2  = function(y, mu, sigma) {
           dd   <- gamlss::numeric.deriv(dBS9(y, mu, sigma, log=TRUE),
                                         theta="sigma",
                                         delta=0.00001)
           dldd <- as.vector(attr(dd, "gradient"))
           d2ldd2 <- - dldd * dldd
           d2ldd2 <- ifelse(d2ldd2 < -1e-15, d2ldd2, -1e-15)
           d2ldd2
         },
         
         
         G.dev.incr = function(y,mu,sigma,...) -2*dBS9(y,mu,sigma,log=TRUE),
         rqres = expression(rqres(pfun="pBS9", type="Continuous",y=y,mu=mu,sigma=sigma)),
         
         mu.initial = expression({mu <- rep(mean(y), length(y)) }),
         sigma.initial = expression({sigma <- rep(ifelse((4*mean(y)^2+sqrt(mean(y)^2*(mean(y)^2+3*var(y))))/(5*mean(y)^2-var(y)) <= 1, 2, (4*mean(y)^2+sqrt(mean(y)^2*(mean(y)^2+3*var(y))))/(5*mean(y)^2-var(y))), length(y))}),
         
         mu.valid = function(mu) all(mu > 0) ,
         sigma.valid = function(sigma) all(sigma > 1),
         y.valid = function(y) all(y > 0)
    ),
    class = c("gamlss.family","family"))
}

