#' The Modified Cosine-Weibull distribution (MCWEI) 
#' 
#' @author Juan Andrés Henao Arias, \email{juhenaoar@@unal.edu.co}
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
#' Rui Su, Najla M. Aloraini, Alia A. Alkhathami, Huda M. Alshanbari. 
#' On A new statistical distribution: Its empirical exploration using the reliability
#' and lifespan data in fashion industry. 
#' Alexandria Engineering Journal.
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
dMCWEI <- function(x, mu=2.2, sigma=1.2, nu=0.5, log=TRUE){
  
  if(any(c(mu,sigma)<=0) || nu==0 ){
    print("Error! Parameters are out of range.")
    stop("Parameters are out of range.")
  }
  
  # Checking the length of all vectors
  par_length <- max(length(x), length(mu), length(sigma), length(nu))
  x_rep <- rep(x, length=par_length)
  mu <- rep(mu, length=par_length)
  sigma <- rep(sigma, length=par_length)
  nu <- rep(nu, length=par_length)
  
  # Changing incorrect values of parameters
  x_rep[x<0] <- 0
  x_rep[is.infinite(x)] <- 1
  x_rep[is.na(x)] <- 0
  
  k <- exp(-1*sigma*(x_rep^mu))
  N1 <- pi*nu*mu*sigma*(x_rep^(mu-1))*k*cos(pi*k*0.5)*sin(pi*k*0.5)
  N2 <- exp(nu*(1- (cos(pi*k*0.5))^2))
  D <- exp(nu) - 1
  
  dens <- N1*N2/D
  dens[x_rep < 0] <- 0
  dens[x_rep==-Inf] <- 0
  if(log==TRUE){
    return(log(dens))
  }else{
    return(dens)
  }
  
}
#' @export
#' @importFrom stats pnorm
#' @rdname dMCWEI
pMCWEI <- function(q, mu=2.2, sigma=1.2, nu=0.5, 
                   lower.tail = TRUE, log.p = FALSE){
  
  
  if(any(c(mu,sigma)<=0) || any(nu==0 )){
    print("Error! Parametros fuera de rango.")
    stop("Parametros fuera de rango.")
  }
  
  # Checking all vectors have the same length
  par_length <- max(length(q), length(mu), length(sigma), length(nu))
  q_rep <- rep(q, length=par_length)
  mu <- rep(mu, length=par_length)
  sigma <- rep(sigma, length=par_length)
  nu <- rep(nu, length=par_length)
  
  #modifying incorrect values in parameters
  q_rep[q<0 | q == Inf] <- 0
  
  ang <- (pi)*(exp(-1*sigma*(q_rep^mu)))/2
  N <- exp(nu) - exp(nu*(1-(cos(ang))^2))
  D <- exp(nu) - 1
  
  cdf <- N/D
  if(lower.tail == FALSE){
    cdf <- 1-cdf
  }
  
  if(log.p == TRUE){
    cdf <- log(cdf)
  }
  return(cdf)
}
#' @importFrom stats uniroot qnorm
#' @export
#' @rdname dMCWEI
qMCWEI <- function(p, mu=2.2, sigma=1.2, nu=0.5, 
                   lower.tail = TRUE, log.p = FALSE){
  #Checking correct values in parameters
  if(any(c(mu,sigma)<=0) || nu==0 ){
    print("Error! Parameters are out of range.")
    stop("Parameters are out of range.")
  }
  
  if(log.p == TRUE){
    p <- exp(p)
  }
  if(lower.tail==FALSE){
    p <- 1 - p
  }
  
  #Fixing the length of the vectors
  par_length <- max(length(p), length(mu), length(sigma), length(nu))
  p_rep <- rep(p, length=par_length)
  mu <- rep(mu, length=par_length)
  sigma <- rep(sigma, length=par_length)
  nu <- rep(nu, length=par_length)
  
  #This is an expression given by the authors
  delta_p <- sqrt(1-log(exp(nu) - p_rep*(exp(nu)-1))/nu)
  
  q_p <- (-(log(2*acos(delta_p)/pi))/sigma )^(1/mu)
  
  # Fixing singularities          
  q_p[p<0] <- NaN
  q_p[p>1] <- NaN
  q_p[p==1] <- Inf
  q_p[p==0] <- 0
  
  return(q_p)
  
}
#' @importFrom stats runif
#' @export
#' @rdname dMCWEI
rMCWEI <- function(n, mu=2.2, sigma=1.2, nu = 0.5){
  
  if(any(c(mu, sigma)<=0) || nu==0){
    print("Error! Parameters are out of range.")
    stop("Parameters are out of range.")
  }
  if(any(n<0)){
    stop("n must be a positive integer.")
  }
  
  n <- ceiling(n)
  u <- runif(n=n)
  x <- qMCWEI(p = u, mu = mu, sigma = sigma, nu = nu)
  return(x)
}
#' @export
#' @rdname dMCWEI
hMCWEI <- function(x, mu=2.2, sigma=1.2, nu=0.5){
  
  if(any(x<0) || any(c(mu,sigma)<=0) || nu==0 ){
    print("Error! Parameters are out of range.")
    stop("Parameters out of range.")
  }
  a <- dMCWEI(x, mu=mu, sigma=sigma, nu=nu, log = FALSE)
  b <- 1 - pMCWEI(x,mu=mu ,sigma = sigma , nu = nu, log.p = FALSE)
  a/b
}
