#' The Generalized Lindley Type II family
#'
#' @author Sofia Cadavid Rueda, \email{socadavidr@@unal.edu.co}
#'
#' @description
#' The Generalized Lindley Type II (GL2) family for fitting
#' positive continuous lifetime data within the GAMLSS framework.
#'
#' @param mu.link defines the mu.link, with "log" link as the default
#' for the mu parameter (mu > 0).
#' @param sigma.link defines the sigma.link, with "log" link as the default
#' for the sigma parameter (sigma > 0).
#'
#' @seealso \link{dGL2}
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
#' they are re-parameterized as
#'
#' \eqn{\mu=\theta}
#'
#' and
#'
#' \eqn{\sigma=\alpha}.
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
#' The GL2 distribution has been proposed for modeling lifetime
#' and survival data and has shown greater flexibility than the
#' classical Lindley and Exponential distributions in several
#' applications.
#'
#' @returns Returns a gamlss.family object which can be used to fit a
#' GL2 distribution in the \code{gamlss()} function.
#'
#' @example examples/examples_GL2.R
#'
#' @references
#' Ekhosuehi, N., Opone, F., & Odobaire, F. (2018).
#' A New Generalized Two Parameter Lindley Distribution.
#' Journal of the Nigerian Statistical Association, 30, 547-566.
#'
#' @importFrom gamlss.dist checklink
#' @importFrom gamlss rqres.plot
#' @export
GL2 <- function(mu.link="log", sigma.link="log") {
  
  mstats <- checklink("mu.link", "GL2",
                      substitute(mu.link),
                      c("log", "inverse", "own"))
  
  dstats <- checklink("sigma.link", "GL2",
                      substitute(sigma.link),
                      c("log", "inverse", "own"))
  
  structure(list(
    
    family     = c("GL2", "New Generalized Two Parameter Lindley"),
    parameters = list(mu=TRUE, sigma=TRUE),
    nopar      = 2,
    type       = "Continuous",
    
    mu.link    = as.character(substitute(mu.link)),
    sigma.link = as.character(substitute(sigma.link)),
    
    mu.linkfun    = mstats$linkfun,
    sigma.linkfun = dstats$linkfun,
    
    mu.linkinv    = mstats$linkinv,
    sigma.linkinv = dstats$linkinv,
    
    mu.dr    = mstats$mu.eta,
    sigma.dr = dstats$mu.eta,
    
    # Primera derivada respecto a mu
    dldm = function(y, mu, sigma) {
      h <- 1e-6
      
      (dGL2(y, mu+h, sigma, log=TRUE) -
          dGL2(y, mu, sigma, log=TRUE))/h
    },
    
    # Primera derivada respecto a sigma
    dldd = function(y, mu, sigma) {
      h <- 1e-6
      
      (dGL2(y, mu, sigma+h, log=TRUE) -
          dGL2(y, mu, sigma, log=TRUE))/h
    },
    
    # Segunda derivada respecto a mu
    d2ldm2 = function(y, mu, sigma) {
      
      h <- 1e-6
      
      dldm <- (dGL2(y, mu+h, sigma, log=TRUE) -
                 dGL2(y, mu, sigma, log=TRUE))/h
      
      -dldm^2
    },
    
    # Derivada cruzada
    d2ldmdd = function(y, mu, sigma) {
      
      h <- 1e-6
      
      dldm <- (dGL2(y, mu+h, sigma, log=TRUE) -
                 dGL2(y, mu, sigma, log=TRUE))/h
      
      dldd <- (dGL2(y, mu, sigma+h, log=TRUE) -
                 dGL2(y, mu, sigma, log=TRUE))/h
      
      -dldm*dldd
    },
    
    # Segunda derivada respecto a sigma
    d2ldd2 = function(y, mu, sigma) {
      
      h <- 1e-6
      
      dldd <- (dGL2(y, mu, sigma+h, log=TRUE) -
                 dGL2(y, mu, sigma, log=TRUE))/h
      
      -dldd^2
    },
    
    G.dev.incr = function(y, mu, sigma, ...)
      -2*dGL2(y, mu, sigma, log=TRUE),
    
    rqres = expression(
      rqres(pfun="pGL2",
            type="Continuous",
            y=y,
            mu=mu,
            sigma=sigma)
    ),
    
    mu.initial = expression(
      mu <- rep(estim_mu_sigma_GL2(y)[1], length(y))
    ),
    
    sigma.initial = expression(
      sigma <- rep(estim_mu_sigma_GL2(y)[2], length(y))
    ),
    
    mu.valid    = function(mu) all(mu > 0),
    sigma.valid = function(sigma) all(sigma > 0),
    
    y.valid = function(y) all(y > 0)
    
  ), class=c("gamlss.family","family"))
}
#' estim_mu_sigma_GL2
#'
#' This function generates initial values for the GL2 distribution
#'
#' @param y vector with the random sample
#' @examples
#' y <- rGL2(n = 100, mu = 3, sigma = 1.2)
#' estim_mu_sigma_GL2(y = y)
#' @importFrom stats optim
#' @export
estim_mu_sigma_GL2 <- function(y) {
  
  mod <- optim(
    par     = c(0,0),
    fn      = logLik_GL2,
    method  = "Nelder-Mead",
    control = list(fnscale=-1, maxit=100000),
    x       = y
  )
  
  c(
    mu_hat    = exp(mod$par[1]),
    sigma_hat = exp(mod$par[2])
  )
}
#' logLik_GL2
#'
#' Auxiliary function to compute the log-likelihood of the GL2 distribution.
#'
#' @param param Numeric vector containing the values of the parameters
#' @param x Numeric vector containing the observations.
#'
#' @examples
#' y <- rGL2(n = 100, mu = 3, sigma = 1.2)
#' logLik_GL2(param = c(0, 0), x = y)
#'
#' @importFrom stats optim
#' @export
logLik_GL2 <- function(param=c(0,0), x) {
  sum(
    dGL2(
      x,
      mu    = exp(param[1]),
      sigma = exp(param[2]),
      log   = TRUE
    )
  )
}