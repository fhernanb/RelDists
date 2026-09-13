# Example 1
# Generating some random values with
# known mu and sigma

set.seed(12345)
y <- rBS9(n=300, mu=2, sigma=2.1)

# Fitting the model using default link function
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS9,
               control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))

# Fitting again the model using our own link function.
# As sigma > 1, we can use
# inv link function:    g-1(eta) = exp(eta) + 1
#     link function:    g(sigma) = log(sigma - 1)

# The following function "log_1_to_inf" is defined with the information
# of the link and inv link functions:

\dontrun{

log_1_to_inf <- function() {
  linkfun <- function(mu) { log(mu - 1) }
  linkinv <- function(eta) { 
    thresh <- log(.Machine$double.xmax)
    eta <- pmin(thresh, pmax(eta, -700))
    1 + exp(eta) 
  }
  mu.eta <- function(eta) { 
    thresh <- log(.Machine$double.xmax)
    eta <- pmin(thresh, pmax(eta, -700))
    pmax(exp(eta), .Machine$double.eps)
  }
  valideta <- function(eta) { TRUE }
  link <- "log_1_to_inf"
  structure(list(linkfun = linkfun, linkinv = linkinv, mu.eta = mu.eta,
                 valideta = valideta, name = link), class = "link-gamlss")
}

mod99 <- gamlss(y~1, sigma.fo=~1, 
                family=BS9(sigma.link = log_1_to_inf()),
                control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod99, what="mu"))
exp(coef(mod99, what="sigma")) + 1

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS9
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.6 - 2.4 * x1)          # Aprox 1.5 with link function log(mu)
  sigma <- exp(1.6 + 1.5 * x2) + 1   # Aprox 11.5 with link function log(sigma - 1)
  y <- rBS9(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(1234)
dat <- gendat(n=500)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS9(sigma.link = log_1_to_inf()), 
               data=dat,
               control=gamlss.control(n.cyc=100))

summary(mod2)

}

