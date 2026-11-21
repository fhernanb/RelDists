#' The Modified Cosine-Weibull family.
#'
#' @description
#' The function \code{MCWEI()} defines the Modified Cosine-Weibull (MCWEI) distribution, a three parameter
#' distribution, for a \code{gamlss.family} object to be used in GAMLSS fitting
#' using the function \code{gamlss()}.
#'
#' @param mu.link defines the mu.link, with "log" link as the default for the mu parameter.
#' @param sigma.link defines the sigma.link, with "log" link as the default for the sigma.
#' @param nu.link defines the nu.link, with "inverse" link as the default for the nu.
#'
#' @seealso \link{dMCWEI}
#'
#' @details
#' The Modified Cosine-Weibull with parameters \code{mu}, \code{sigma} and \code{nu}
#' has density given by
#' 
#' \eqn{  f(x | \mu, \sigma ,\nu) = \frac{\pi \mu \sigma \nu x^{\mu -1} e^{-\sigma x^{\mu}} \cos(\frac{\pi}{2} e^{-\sigma x^{\mu}})\sin(\frac{\pi}{2} e^{-\sigma x^{\mu}})}{e^{\nu} -1} \cdot e^{\nu \left( 1- \cos^2(\frac{\pi}{2} e^{-\sigma x^{\mu}}) \right) }    }
#' 
#' for \eqn{x > 0}, \eqn{\mu>0}, \eqn{\sigma>0} and \eqn{\nu \neq 0}.
#' 
#' @returns Returns a gamlss.family object which can be used to fit a MCWEI distribution in the \code{gamlss()} function.
#' 
#' @example examples/examples_MCWEI.R
#' 
#' @references
#' Su, R., Aloraini, N. M., Alkhathami, A. A., Alshanbari, H. M., & Khalifa, 
#' H. A. E. W. (2025). A new statistical distribution: Its empirical 
#' exploration using the reliability and lifespan data in fashion 
#' industry. Alexandria Engineering Journal, 116, 660-671.
#'
#' @importFrom gamlss rqres.plot
#' @importFrom stats dnorm pnorm
#' @export
MCWEI <- function (mu.link="log", sigma.link="log", nu.link="inverse") {
  
  mstats <- checklink("mu.link", "Modified Cosine-Weibull",
                      substitute(mu.link), c("log","identity" ,"own"))
  dstats <- checklink("sigma.link", "Modified Cosine-Weibull",
                      substitute(sigma.link), c("log","identity" ,"own"))
  vstats <- checklink("nu.link", "Modified Cosine-Weibull",
                      substitute(nu.link), c("inverse"))

  structure(list(family=c("MCWEI", "Modified Cosine-Weibull"),
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

                 # First derivatives
                 
                 dldm = function(y, mu, sigma, nu) {
                   dm   <- gamlss::numeric.deriv(dMCWEI(y, mu, sigma, nu, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   dldm
                 },
                 
                 dldd = function(y, mu, sigma, nu) {
                   t1 <- 1/sigma
                   t2 <- -((y^(mu)))
                   t3 <- (pi*exp(-sigma*(y^(mu)))*(y^(mu))*sin((pi*exp(-sigma*(y^(mu))))/2))/(2*cos((pi*exp(-sigma*(y^(mu))))/2))
                   t4 <- (-pi*exp(-sigma*(y^(mu)))*((y^(mu)))*cos((pi*exp(-sigma*(y^(mu))))/2))/(2*sin((pi*exp(-sigma*(y^(mu))))/2))
                   t5 <- -nu*sin((pi*exp(-sigma*(y^(mu))))/2)*cos((pi*exp(-sigma*(y^(mu))))/2)*pi*exp(-sigma*((y^(mu))))*(y^(mu))
                   dldd <- t1+t2+t3+t4+t5
                   return(dldd)
                 },
                 
                 dldv = function(y, mu, sigma, nu) {
                   t1 <- 1/nu
                   t2 <- (sin((pi*exp(-sigma*y^(mu)))/2))^2
                   t3 <- (exp(nu))/(exp(nu)-1)
                   dldv <- t1+t2-t3
                   return(dldv)
                 },
                 
                 # Second derivatives

                 d2ldm2 = function(y, mu, sigma, nu) {
                   dm   <- gamlss::numeric.deriv(dMCWEI(y, mu, sigma, nu, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   
                   d2ldm2 <- -dldm*dldm
                   d2ldm2
                 },
                 
                 d2ldmdd = function(y, mu, sigma, nu) {
                   
                   dm   <- gamlss::numeric.deriv(dMCWEI(y, mu, sigma, nu, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))
                   
                   t1 <- 1/sigma
                   t2 <- -((y^(mu)))
                   t3 <- (pi*exp(-sigma*(y^(mu)))*(y^(mu))*sin((pi*exp(-sigma*(y^(mu))))/2))/(2*cos((pi*exp(-sigma*(y^(mu))))/2))
                   t4 <- (-pi*exp(-sigma*(y^(mu)))*((y^(mu)))*cos((pi*exp(-sigma*(y^(mu))))/2))/(2*sin((pi*exp(-sigma*(y^(mu))))/2))
                   t5 <- -nu*sin((pi*exp(-sigma*(y^(mu))))/2)*cos((pi*exp(-sigma*(y^(mu))))/2)*pi*exp(-sigma*((y^(mu))))*(y^(mu))
                   dldd <- t1+t2+t3+t4+t5

                   
                   d2ldmdd <- - dldm * dldd
                   d2ldmdd
                 },
                 
                 d2ldmdv = function(y, mu, sigma, nu) {
                   
                   dm   <- gamlss::numeric.deriv(dMCWEI(y, mu, sigma, nu, log=TRUE),
                                                 theta="mu",
                                                 delta=0.00001)
                   dldm <- as.vector(attr(dm, "gradient"))

                   t1 <- 1/nu
                   t2 <- (sin((pi*exp(-sigma*y^(mu)))/2))^2
                   t3 <- (exp(nu))/(exp(nu)-1)
                   dldv <- t1+t2-t3

                   
                   d2ldmdv <- - dldm * dldv
                   d2ldmdv
                 },
                 
                 d2ldd2  = function(y, mu, sigma, nu) {
                   t1 <- 1/sigma
                   t2 <- -((y^(mu)))
                   t3 <- (pi*exp(-sigma*(y^(mu)))*(y^(mu))*sin((pi*exp(-sigma*(y^(mu))))/2))/(2*cos((pi*exp(-sigma*(y^(mu))))/2))
                   t4 <- (-pi*exp(-sigma*(y^(mu)))*((y^(mu)))*cos((pi*exp(-sigma*(y^(mu))))/2))/(2*sin((pi*exp(-sigma*(y^(mu))))/2))
                   t5 <- -nu*sin((pi*exp(-sigma*(y^(mu))))/2)*cos((pi*exp(-sigma*(y^(mu))))/2)*pi*exp(-sigma*((y^(mu))))*(y^(mu))
                   dldd <- t1+t2+t3+t4+t5

                   d2ldd2 <- - dldd * dldd
                   d2ldd2
                 },
                 
                 d2ldddv = function(y, mu, sigma, nu) {
                   
                   t1 <- 1/nu
                   t2 <- (sin((pi*exp(-sigma*y^(mu)))/2))^2
                   t3 <- (exp(nu))/(exp(nu)-1)
                   dldv <- t1+t2-t3
                   
                   t1 <- 1/sigma
                   t2 <- -((y^(mu)))
                   t3 <- (pi*exp(-sigma*(y^(mu)))*(y^(mu))*sin((pi*exp(-sigma*(y^(mu))))/2))/(2*cos((pi*exp(-sigma*(y^(mu))))/2))
                   t4 <- (-pi*exp(-sigma*(y^(mu)))*((y^(mu)))*cos((pi*exp(-sigma*(y^(mu))))/2))/(2*sin((pi*exp(-sigma*(y^(mu))))/2))
                   t5 <- -nu*sin((pi*exp(-sigma*(y^(mu))))/2)*cos((pi*exp(-sigma*(y^(mu))))/2)*pi*exp(-sigma*((y^(mu))))*(y^(mu))
                   dldd <- t1+t2+t3+t4+t5
                   
                   d2ldddv <- - dldd * dldv
                   d2ldddv
                 },
                 
                 
                 d2ldv2 = function(y, mu, sigma, nu) {
                   t1 <- 1/nu
                   t2 <- (sin((pi*exp(-sigma*y^(mu)))/2))^2
                   t3 <- (exp(nu))/(exp(nu)-1)
                   dldv <- t1+t2-t3
                    
                   d2ldv2 <- - dldv * dldv
                   d2ldv2
                 },
                 
                 G.dev.incr = function(y, mu, sigma, nu,  ...) -2*dMCWEI(y, mu, sigma, nu,  log=TRUE),
                 rqres      = expression(rqres(pfun="pMCWEI", type="Continuous", y=y, mu=mu, sigma=sigma, nu=nu)),
                 
                 mu.initial    = expression(mu    <- rep(estim_mu_sigma_nu_MCWEI(y)[1], length(y)) ),
                 sigma.initial = expression(sigma <- rep(estim_mu_sigma_nu_MCWEI(y)[2], length(y)) ),
                 nu.initial    = expression(nu    <- rep(estim_mu_sigma_nu_MCWEI(y)[3], length(y)) ),
                 
                 mu.valid    = function(mu)    all(mu > 0),
                 sigma.valid = function(sigma) all(sigma > 0),
                 nu.valid    = function(nu)    all(nu != 0),
                 
                 y.valid = function(y) all(y>=0)
  ),
  class=c("gamlss.family", "family"))
}
#'
#' estim_mu_sigma_nu_MCWEI
#'
#' This function generates initial values for MCWEI distribution.
#'
#' @param y vector with the random sample
#' @examples
#' y <- rMCWEI(n=100, mu=1, sigma=1, nu=1)
#' estim_mu_sigma_nu_MCWEI(y=y)
#' @importFrom stats optim
#' @export
estim_mu_sigma_nu_MCWEI <- function(y) {
  mod <- optim(par=c(0, 0, 1),
               fn=logLik_MCWEI,
               method="Nelder-Mead",
               control=list(fnscale=-1, maxit=100000),
               x=y)
  res <- c(mu_hat    = exp(mod$par[1]),
           sigma_hat = exp(mod$par[2]),
           nu_hat    = 1/mod$par[3]
           )
  names(res) <- c("mu_hat", "sigma_hat", "nu_hat")
  return(res)
}
#'
#' logLik_MCWEI
#'
#' This is an auxiliar function to obtain the logLik for MCWEI
#'
#' @param param vector with the values for mu, sigma and nu
#' @param x vector with the data
#' @examples
#' y <- rMCWEI(n=100, mu=1, sigma=1, nu=1)
#' logLik_MCWEI(param=c(0, 0, 1), x=y)
#' @importFrom stats optim
#' @export
logLik_MCWEI <- function(param=c(0, 0, 1), x) {
  return(sum(dMCWEI(x,
                    mu    = exp(param[1]),
                    sigma = exp(param[2]),
                    nu    = 1/param[3],
                    log=TRUE)))
}