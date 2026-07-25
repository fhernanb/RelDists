#' The Modified Cosine-Weibull distribution (MCWEI) 
#' 
#' @author Juan Andres Henao Arias, \email{juhenaoar@@unal.edu.co}
#' 
#' @description
#' Density function, cumulative distribution function, quantile function, 
#' random generation and hazard function for the 
#' Modified Cosine-Weibull distribution with 
#' parameters \code{mu}, \code{sigma} and \code{nu}.
#' 
#' @param x,q vector of quantiles.
#' @param p vector of probabilities.
#' @param n number of observations. 
#' @param mu parameter representing the shape parameter \eqn{\phi} (\code{mu > 0}).    
#' @param sigma parameter representing the scale parameter \eqn{\tau} (\code{sigma > 0}).
#' @param nu parameter representing the additional modified cosine parameter \eqn{\sigma} (\code{nu != 0}).    
#' @param log,log.p logical; if TRUE, probabilities p are given as log(p).  
#' @param lower.tail logical; if TRUE (default), probabilities are 
#' P[X <= x], otherwise, P[X > x].
#' 
#' @references
#' Su, R., Aloraini, N. M., Alkhathami, A. A., Alshanbari, H. M., & Khalifa, 
#' H. A. E. W. (2025). A new statistical distribution: Its empirical 
#' exploration using the reliability and lifespan data in fashion 
#' industry. Alexandria Engineering Journal, 116, 660-671.
#' 
#' @seealso \link{BS}.
#' 
#' @details 
#' The Modified Cosine-Weibull with parameters \code{mu}, \code{sigma} and \code{nu}
#' has density given by
#' 
#' \eqn{  f(x | \mu, \sigma ,\nu) = \frac{\pi \mu \sigma \nu x^{\mu -1} e^{-\sigma x^{\mu}} \cos(\frac{\pi}{2} e^{-\sigma x^{\mu}})\sin(\frac{\pi}{2} e^{-\sigma x^{\mu}})}{e^{\nu} -1} \cdot e^{\nu \left( 1- \cos^2(\frac{\pi}{2} e^{-\sigma x^{\mu}}) \right) }    }
#' 
#' for \eqn{x\ge 0}, \eqn{\mu>0}, \eqn{\sigma>0} and \eqn{\nu \neq 0}.
#' 
#' @return 
#' \code{dMCWEI} gives the density, \code{pMCWEI} gives the cumulative distribution 
#' function, \code{qMCWEI} gives the quantile function, \code{rMCWEI}
#' generates random deviates and \code{hMCWEI} gives the hazard function.
#' 
#' @example examples/examples_dMCWEI.R
#' 
#' @export
dMCWEI <- function(x, mu=2.2, sigma=1.2, nu=0.5, log=TRUE) {
  
  # Ensure same length vector
  ly    <- max(length(x), length(mu), length(sigma), length(nu))
  xx    <- rep(x, length=ly)
  mu    <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  nu    <- rep(nu, length=ly)
  
  # Temporal change for invalid x's
  xx[x <= 0] <- 0.5
  xx[is.infinite(x)] <- 0.5
  
  # Temporal change for invalid, sigma or nu values
  invalid_param_values <- mu <= 0 | sigma <= 0 | nu == 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  nu[invalid_param_values]    <- 1 # Temporal change
  
  # pdf in log-scale
  k <- exp(-1*sigma*(xx^mu))
  p1 <- log(pi)+log(mu)+log(sigma)+log(nu)+(mu-1)*log(xx)-sigma*xx^mu
  p2 <- log(cos(pi*k*0.5)) + log(sin(pi*k*0.5))
  p3 <- nu*(1- (cos(pi*k*0.5))^2) - log(exp(nu) - 1)
  p <- p1 + p2 + p3
  
  # Assign NaN for invalid mu, sigma or nu
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
#' @rdname dMCWEI
pMCWEI <- function(q, mu=2.2, sigma=1.2, nu=0.5, 
                   lower.tail = TRUE, log.p = FALSE) {
  
  # Ensure same length vector
  ly    <- max(length(q), length(mu), length(sigma), length(nu))
  qq    <- rep(q, length=ly)
  mu    <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  nu    <- rep(nu, length=ly)
  
  # Temporal change for invalid x's
  qq[q <= 0] <- 0.5
  qq[q == Inf] <- 0.5
  
  # Temporal change for invalid, sigma or nu values
  invalid_param_values <- mu <= 0 | sigma <= 0 | nu == 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  nu[invalid_param_values]    <- 1 # Temporal change
  
  # The cumulative
  ang <- (pi)*(exp(-1*sigma*(qq^mu)))/2
  N <- exp(nu) - exp(nu*(1-(cos(ang))^2))
  D <- exp(nu) - 1
  cdf <- N/D
  
  # Assign NaN for invalid mu or sigma
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
#' @importFrom stats uniroot qnorm
#' @export
#' @rdname dMCWEI
qMCWEI <- function(p, mu=2.2, sigma=1.2, nu=0.5, 
                   lower.tail = TRUE, log.p = FALSE) {
  
  # To adjust the probability
  if (log.p == TRUE)
    p <- exp(p)
  if (lower.tail == FALSE)
    p <- 1 - p
  
  # Ensure same length vector
  ly <- max(length(p), length(mu), length(sigma), length(nu))
  pp <- rep(p, length=ly)
  mu <- rep(mu, length=ly)
  sigma <- rep(sigma, length=ly)
  nu <- rep(nu, length=ly)
  
  # Temporal change for invalid p's
  pp[p < 0]  <-  0.5
  pp[p > 1]  <-  0.5
  pp[p == 1] <-  0.5
  pp[p == 0] <-  0.5
  
  # Temporal change for invalid, sigma or nu values
  invalid_param_values <- mu <= 0 | sigma <= 0 | nu == 0
  mu[invalid_param_values]    <- 1 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  nu[invalid_param_values]    <- 1 # Temporal change
  
  # This is an expression given by the authors
  delta_p <- sqrt(1-log(exp(nu) - pp*(exp(nu)-1))/nu)
  q <- (-(log(2*acos(delta_p)/pi))/sigma )^(1/mu)
  
  # Assign NaN for invalid mu or sigma
  q[invalid_param_values] <- NaN
  
  if (any(is.nan(q))) {
    warning("NaNs produced")
  }
  
  # To deal with invalid p's
  q[p <  0] <- NaN
  q[p >  1] <- NaN
  q[p == 1] <- Inf
  q[p == 0] <- 0
  
  return(q)
}
#' @importFrom stats runif
#' @export
#' @rdname dMCWEI
rMCWEI <- function(n, mu=2.2, sigma=1.2, nu = 0.5) {
  if (any(n <= 0)) stop(paste("n must be a positive integer", "\n", ""))
  
  n <- ceiling(n)
  u <- runif(n=n)
  x <- qMCWEI(p = u, mu = mu, sigma = sigma, nu = nu)
  return(x)
}
#' @export
#' @rdname dMCWEI
hMCWEI <- function(x, mu=2.2, sigma=1.2, nu=0.5) {
  a <- dMCWEI(x, mu=mu, sigma=sigma, nu=nu, log = FALSE)
  b <- 1 - pMCWEI(x,mu=mu ,sigma = sigma , nu = nu, log.p = FALSE)
  a/b
}
