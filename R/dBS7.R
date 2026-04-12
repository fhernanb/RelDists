#' The Birnbaum-Saunders distribution - Santos-Neto et al. (2012) (P5 Based on the variance)
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
#' @seealso \link{BS7}.
#' 
#' @details 
#' The Birnbaum-Saunders with parameters \code{mu} and \code{sigma}
#' has density given by
#' 
#' \eqn{f(x|\mu,\sigma) = \frac{1}{\sqrt{2\pi}} \exp\left( -\frac{1}{2\mu^2} \left[ \frac{\mu\sqrt{4+5\mu^2}}{2\sqrt{\sigma}x^{-1}} + \frac{2\sqrt{\sigma}\{x\mu\}^{-1}}{\sqrt{4+5\mu^2}} - 2 \right] \right) \times \left[ \frac{\{x\mu\}^{-1/2}\{4+5\mu^2\}^{1/4}}{2^{3/2}\sigma^{1/4}} + \frac{\sigma^{1/4}}{\{x\mu\}^{3/2}\sqrt{2}\{4+5\mu^2\}^{1/4}} \right]}
#' 
#' for \eqn{x>0}, \eqn{\mu>0} and \eqn{\sigma>0}. In this parameterization, 
#' \eqn{E(X) = \frac{[2+\mu^2]\sqrt{\sigma}}{\mu\sqrt{4+5\mu^2}}} and 
#' \eqn{Var(X) = \sigma}.
#' 
#' @return 
#' \code{dBS7} gives the density, \code{pBS7} gives the distribution 
#' function, \code{qBS7} gives the quantile function, \code{rBS7}
#' generates random deviates and \code{hBS7} gives the hazard function.
#' 
#' @example examples/examples_dBS7.R
#' 
#' @export
dBS7 <- function(x, mu=0.5, sigma=10, log=FALSE){ #mu = varianza   y  sigma = alpha
  if (any(mu <= 0)) stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0))  stop(paste("sigma must be positive", "\n", "")) #(based on the variance 1)
  
  # Changing from BS to BS7 (original)
  new_mu     <- (2 * sqrt(sigma))/(mu * sqrt(4 + 5*mu^2)) #Beta
  new_sigma  <-  mu #Alfa
  
  res <- dBS(x=x, mu=new_mu, sigma=new_sigma, log=log)
  return(res)
}
#' @export
#' @importFrom stats pnorm
#' @rdname dBS7
pBS7 <- function(q, mu=1, sigma=0.5, lower.tail=TRUE, log.p=FALSE){
  if (any(mu <= 0))    stop("parameter mu has to be positive!")
  if (any(sigma <= 0))  stop(paste("sigma must be positive", "\n", ""))
  
  # Changing from BS to BS7 (original)
  new_mu     <- (2 * sqrt(sigma))/(mu * sqrt(4 + 5*mu^2)) #Beta
  new_sigma  <-  mu #Alfa
  
  cdf <- pBS(q=q, mu=new_mu, sigma=new_sigma, lower.tail=lower.tail, log.p=log.p)
  
  return(cdf)
}
#' @importFrom stats uniroot qnorm
#' @export
#' @rdname dBS7
qBS7 <- function(p, mu=1, sigma=0.5, lower.tail = TRUE, log.p = FALSE){
  if (any(mu <= 0)) stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0)) 
    stop(paste("sigma must be positive", "\n", ""))
  
  # Changing from BS to BS7 (original)
  new_mu     <- (2 * sqrt(sigma))/(mu * sqrt(4 + 5*mu^2)) #Beta
  new_sigma  <-  mu #Alfa
  
  if (log.p==TRUE) p <- log(p)
  if (lower.tail==FALSE) p <- 1-p
  if (any(p < 0)|any(p > 1)) stop(paste("p must be between 0 and 1", "\n", ""))
  
  q <- qBS(p=p, mu=new_mu, sigma=new_sigma, lower.tail=lower.tail, log.p=log.p)
  return(q)
}
#' @importFrom stats runif
#' @export
#' @rdname dBS7
rBS7 <- function(n, mu=1, sigma=0.5){
  if (any(n <= 0)) stop(paste("n must be a positive integer", "\n", ""))
  if (any(mu <= 0)) stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0))
    stop(paste("sigma must be positive", "\n", ""))
  
  # Changing from BS to BS7 (original)
  new_mu     <- (2 * sqrt(sigma))/(mu * sqrt(4 + 5*mu^2)) #Beta
  new_sigma  <-  mu #Alfa
  
  r <- rBS(n=n, mu=new_mu, sigma=new_sigma)
  r
}
#' @export
#' @rdname dBS7
hBS7 <- function(x, mu, sigma){
  if (any(x < 0)) 
    stop(paste("x must be positive", "\n", ""))
  if (any(mu <= 0 )) 
    stop(paste("mu must be positive", "\n", ""))
  if (any(sigma <= 0))
    stop(paste("sigma must be positive", "\n", ""))
  
  h <- dBS7(x, mu, sigma) / pBS7(x, mu, sigma, lower.tail=FALSE)
  h
}
