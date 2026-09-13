#' The Birnbaum-Saunders distribution - Santos-Neto et al. (2012) (P7 based on the mean and a bounded variance)
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
#' @seealso \link{BS9}.
#' 
#' @details 
#' The Birnbaum-Saunders with parameters \code{mu} and \code{sigma}
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
#' @return 
#' \code{dBS9} gives the density, \code{pBS9} gives the distribution 
#' function, \code{qBS9} gives the quantile function, \code{rBS9}
#' generates random deviates and \code{hBS9} gives the hazard function.
#' 
#' @example examples/examples_dBS9.R
#' 
#' @export
dBS9 <- function(x, mu=0.5, sigma=10, log=FALSE) {
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 0 | sigma <= 1
  mu[invalid_param_values]    <- 2 # Temporal change
  sigma[invalid_param_values] <- 2 # Temporal change
  
  # Changing from BS to BS9 (original)
  new_mu     <- mu/sigma #Beta
  new_sigma  <- sqrt(2*(sigma-1)) #Alfa
  
  res <- dBS(x=x, mu=new_mu, sigma=new_sigma, log=log)
  
  res[invalid_param_values] <- 0
  
  return(res)
}
#' @export
#' @importFrom stats pnorm
#' @rdname dBS9
pBS9 <- function(q, mu=1, sigma=2, lower.tail=TRUE, log.p=FALSE) { 
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 0 | sigma <= 1
  mu[invalid_param_values]    <- 2 # Temporal change
  sigma[invalid_param_values] <- 2 # Temporal change
  
  # Changing from BS to BS9 (original)
  new_mu     <- mu/sigma #Beta
  new_sigma  <- sqrt(2*(sigma-1)) #Alfa
  
  cdf <- pBS(q=q, mu=new_mu, sigma=new_sigma, lower.tail=lower.tail, log.p=log.p)
  
  cdf[invalid_param_values] <- 0
  
  return(cdf)
}
#' @importFrom stats uniroot qnorm
#' @export
#' @rdname dBS9
qBS9 <- function(p, mu=1, sigma=2, lower.tail = TRUE, log.p = FALSE) {
  
  # Temporal change for invalid mu or sigma values
  invalid_param_values <- mu <= 0 | sigma <= 1
  mu[invalid_param_values]    <- 2 # Temporal change
  sigma[invalid_param_values] <- 2 # Temporal change
  
  # Changing from BS to BS9 (original)
  new_mu     <- mu/sigma #Beta
  new_sigma  <- sqrt(2*(sigma-1)) #Alfa
  
  if (log.p==TRUE) p <- log(p)
  if (lower.tail==FALSE) p <- 1-p
  if (any(p < 0)|any(p > 1)) stop(paste("p must be between 0 and 1", "\n", ""))
  
  q <- qBS(p=p, mu=new_mu, sigma=new_sigma, lower.tail=lower.tail, log.p=log.p)
  
  q[invalid_param_values] <- 0
  
  return(q)
}
#' @importFrom stats runif
#' @export
#' @rdname dBS9
rBS9 <- function(n, mu=1, sigma=2) {
  
  if (any(n <= 0)) stop(paste("n must be a positive integer", "\n", ""))
  
  # Changing from BS to BS9 (original)
  new_mu     <- mu/sigma #Beta
  new_sigma  <- sqrt(2*(sigma-1)) #Alfa
  
  r <- rBS(n=n, mu=new_mu, sigma=new_sigma)
  r
}
#' @export
#' @rdname dBS9
hBS9 <- function(x, mu, sigma) {
  h <- dBS9(x, mu, sigma) / pBS9(x, mu, sigma, lower.tail=FALSE)
  h
}
