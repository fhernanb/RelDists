#' The Inverse Power XLindley distribution - Hassan et al. (2025)
#' 
#' @author Sebastián Ándres Rios Romero, \email{srios.romero@@udea.edu.co}
#' 
#' @description
#' Density, distribution function, quantile function, 
#' random generation and hazard function for the 
#' Inverse Power XLindley distribution with 
#' parameters \code{mu} and \code{sigma}.
#' 
#' @param x,q vector of quantiles.
#' @param p vector of probabilities.
#' @param n number of observations. 
#' @param mu parameter representing \eqn{\eta} (\code{mu > 0}).    
#' @param sigma parameter representing \eqn{\sigma} (\code{sigma > 0}).
#' @param log,log.p logical; if TRUE, probabilities p are given as log(p).  
#' @param lower.tail logical; if TRUE (default), probabilities are 
#' P[X <= x], otherwise, P[X > x].
#' 
#' @references
#' Hassan, A. S., Alsadat, N., Chesneau, C., Elgarhy, M., Kayid, M., 
#' Nasiru, S., & Gemeay, A. M. (2025). Inverse power XLindley 
#' distribution with statistical inference and applications to 
#' engineering data. Scientific Reports, 15, 4385.
#' 
#' @seealso \link{IPXLIN}.
#' 
#' @details 
#' The Inverse Power XLindley with parameters \code{mu} and \code{sigma}
#' has density given by
#' 
#' \eqn{f(x|\mu,\sigma) = \frac{\sigma \mu^2}{(1+\mu)^2} x^{-2\sigma-1} \left(1 + (2+\mu) x^\sigma\right) e^{-\mu x^{-\sigma}}}
#' 
#' for \eqn{x>0}, \eqn{\mu>0} and \eqn{\sigma>0}. In this parameterization, 
#' \eqn{\mu} is the scale parameter and \eqn{\sigma} is the shape parameter.
#' 
#' @return 
#' \code{dIPXLIN} gives the density, \code{pIPXLIN} gives the distribution 
#' function, \code{qIPXLIN} gives the quantile function, \code{rIPXLIN}
#' generates random deviates and \code{hIPXLIN} gives the hazard function.
#' 
#' @example examples/examples_dIPXLIN.R
#' 
#' @export
dIPXLIN <- function(x, mu=1, sigma=1, log=FALSE){ #mu = eta (escala)  y  sigma = forma
  if (any(mu <= 0)) stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0))  stop(paste("sigma must be positive", "\n", ""))
  
  log_dens <- ifelse(
    x <= 0,
    -Inf,
    log(sigma) + 2*log(mu) - 2*log(1+mu) +
      (-2*sigma - 1)*log(x) +
      log(1 + (2+mu)*x^sigma) -
      mu*x^(-sigma)
  )
  
  if (log) return(log_dens)
  res <- exp(log_dens)
  return(res)
}
#' @export
#' @importFrom stats integrate
#' @rdname dIPXLIN
pIPXLIN <- function(q, mu=1, sigma=1, lower.tail=TRUE, log.p=FALSE){
  if (any(mu <= 0))    stop("parameter mu has to be positive!")
  if (any(sigma <= 0))  stop(paste("sigma must be positive", "\n", ""))
  
  v <- mu * q^(-sigma)
  
  cdf <- ifelse(
    q <= 0,
    0,
    exp(-v) * (1 + v / (1 + mu)^2)
  )
  
  if (!lower.tail) cdf <- 1 - cdf
  if (log.p)       cdf <- log(cdf)
  
  return(cdf)
}
#' @importFrom lamW lambertWm1
#' @export
#' @rdname dIPXLIN
qIPXLIN <- function(p, mu=1, sigma=1, lower.tail = TRUE, log.p = FALSE){
  if (any(mu <= 0)) stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0)) 
    stop(paste("sigma must be positive", "\n", ""))
  
  if (log.p==TRUE) p <- exp(p)
  if (lower.tail==FALSE) p <- 1-p
  if (any(p < 0)|any(p > 1)) stop(paste("p must be between 0 and 1", "\n", ""))
  
  arg <- -p * (mu + 1)^2 * exp(-(mu + 1)^2)
  
  w <- lamW::lambertWm1(arg)
  
  q <- ((-(mu + 1)^2 - w) / mu)^(-1/sigma)
  
  q <- ifelse(p <= 0, 0, ifelse(p >= 1, Inf, q))
  
  return(q)
}
#' @importFrom stats runif
#' @export
#' @rdname dIPXLIN
rIPXLIN <- function(n, mu=1, sigma=1){
  if (any(n <= 0)) stop(paste("n must be a positive integer", "\n", ""))
  if (any(mu <= 0)) stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0))
    stop(paste("sigma must be positive", "\n", ""))
  
  u <- runif(n)
  r <- qIPXLIN(p=u, mu=mu, sigma=sigma)
  r
}
#' @export
#' @rdname dIPXLIN
hIPXLIN <- function(x, mu=1, sigma=1){
  if (any(x < 0)) 
    stop(paste("x must be positive", "\n", ""))
  if (any(mu <= 0 )) 
    stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0))
    stop(paste("sigma must be positive", "\n", ""))
  
  h <- dIPXLIN(x, mu, sigma) / pIPXLIN(x, mu, sigma, lower.tail=FALSE)
  h
}