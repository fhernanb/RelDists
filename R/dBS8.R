#' The Birnbaum-Saunders distribution - Santos-Neto et al. (2012) (P6 Based on the variance 2)
#' 
#' @author David Villegas Ceballos, \email{david.villegas1@@udea.edu.co}
#' 
#' @description
#' Density, distribution function, quantile function, 
#' random generation and hazard function for the 
#' Birnbaum-Saunders distribution with 
#' parameters \code{mu} and \code{sigma}.
#' 
#' @param x,q vector of quantiles.
#' @param p vector of probabilities.
#' @param n number of observations. 
#' @param mu parameter representing the shape (\code{mu > 0}).
#' @param sigma parameter representing the variance (\code{sigma > 0}).    
#' @param log,log.p logical; if TRUE, probabilities p are given as log(p).  
#' @param lower.tail logical; if TRUE (default), probabilities are 
#' P[X <= x], otherwise, P[X > x].
#' 
#' @references
#' Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012). 
#' On new parameterizations of the Birnbaum-Saunders distribution. 
#' Pakistan Journal of Statistics, 28(1), 1-26.
#' 
#' @seealso \link{BS8}.
#' 
#' @details 
#' The Birnbaum-Saunders with parameters \code{mu} and \code{sigma}
#' has density given by
#' 
#' \eqn{f(x|\mu,\sigma) = 
#' \frac{\sqrt{\mu}}
#'      {2\sqrt{2\pi\sigma}}
#' \left[
#' \left\{
#' \frac{1}{2x}
#' \sqrt{\frac{5\sigma}{\mu(\mu-1)}}
#' \right\}^{1/2}
#' +
#' \left\{
#' \frac{1}{2x}
#' \sqrt{\frac{5\sigma}{\mu(\mu-1)}}
#' \right\}^{3/2}
#' \right]
#' \exp\left(
#' -\frac{5}{8(\mu-1)}
#' \left[
#' \frac{2x\sqrt{\mu(\mu-1)}}{\sqrt{5\sigma}}
#' +
#' \frac{\sqrt{5\sigma}}
#'      {2+\sqrt{\mu(\mu-1)}}
#' -2
#' \right]
#' \right)
#' }
#' 
#' for \eqn{x>0}, \eqn{\mu>0} and \eqn{\sigma>0}. In this parameterization, 
#' \eqn{E(X) = \frac{[2\mu+3]\sqrt{\sigma}}{\sqrt{20\mu(\mu-1)}}} and 
#' \eqn{Var(X) = \sigma}.
#' 
#' @return 
#' \code{dBS8} gives the density, \code{pBS8} gives the distribution 
#' function, \code{qBS8} gives the quantile function, \code{rBS8}
#' generates random deviates and \code{hBS8} gives the hazard function.
#' 
#' @example examples/examples_dBS8.R
#' 
#' @export
dBS8 <- function(x, mu=0.5, sigma=10, log=FALSE) {
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 1 | sigma <= 0
  mu[invalid_param_values]    <- 2 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  
  # Changing from BS to BS8 (original)
  new_mu     <- sqrt(5*sigma)/(2*sqrt(mu*mu*(mu-1))) #Beta
  new_sigma  <- 2*sqrt(mu-1)/sqrt(5) #Alfa
  
  res <- dBS(x=x, mu=new_mu, sigma=new_sigma, log=log)
  
  res[invalid_param_values] <- 0
  
  return(res)
}
#' @export
#' @importFrom stats pnorm
#' @rdname dBS8
pBS8 <- function(q, mu=1, sigma=0.5, lower.tail=TRUE, log.p=FALSE) { 
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 1 | sigma <= 0
  mu[invalid_param_values]    <- 2 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  
  # Changing from BS to BS8 (original)
  new_mu     <- sqrt(5*sigma)/(2*sqrt(mu*(mu-1))) #Beta
  new_sigma  <- 2*sqrt(mu-1)/sqrt(5) #Alfa
  
  cdf <- pBS(q=q, mu=new_mu, sigma=new_sigma, lower.tail=lower.tail, log.p=log.p)
  
  cdf[invalid_param_values] <- 0
  
  return(cdf)
}
#' @importFrom stats uniroot qnorm
#' @export
#' @rdname dBS8
qBS8 <- function(p, mu=1, sigma=0.5, lower.tail = TRUE, log.p = FALSE) {
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 1 | sigma <= 0
  mu[invalid_param_values]    <- 2 # Temporal change
  sigma[invalid_param_values] <- 1 # Temporal change
  
  # Changing from BS to BS8 (original)
  new_mu     <- sqrt(5*sigma)/(2*sqrt(mu*(mu-1))) #Beta
  new_sigma  <- 2*sqrt(mu-1)/sqrt(5) #Alfa
  
  if (log.p==TRUE) p <- log(p)
  if (lower.tail==FALSE) p <- 1-p
  if (any(p < 0)|any(p > 1)) stop(paste("p must be between 0 and 1", "\n", ""))
  
  q <- qBS(p=p, mu=new_mu, sigma=new_sigma, lower.tail=lower.tail, log.p=log.p)
  
  q[invalid_param_values] <- 0
  
  return(q)
}
#' @importFrom stats runif
#' @export
#' @rdname dBS8
rBS8 <- function(n, mu=1, sigma=0.5) {
  if (any(n <= 0)) stop(paste("n must be a positive integer", "\n", ""))
  
  # Changing from BS to BS8 (original)
  new_mu     <- sqrt(5*sigma)/(2*sqrt(mu*(mu-1))) #Beta
  new_sigma  <- 2*sqrt(mu-1)/sqrt(5) #Alfa
  
  r <- rBS(n=n, mu=new_mu, sigma=new_sigma)
  r
}
#' @export
#' @rdname dBS8
hBS8 <- function(x, mu, sigma) {
  h <- dBS8(x, mu, sigma) / pBS8(x, mu, sigma, lower.tail=FALSE)
  h
}
