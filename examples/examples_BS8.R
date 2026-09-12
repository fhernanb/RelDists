# Example 1
# Generating some random values with
# known mu and sigma

set.seed(12345)
y <- rBS8(n=10, mu=1.1, sigma=10)

# Fitting the model using default link function
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS8,
               control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))

# Fitting again the model using our own link function.
# As mu > 1, we can use
#     link function:    g(mu) = log(mu - 1)
# inv link function: g-1(eta) = exp(eta) + 1

# The following function "log_1_to_inf" is defined with the informatio
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
                family=BS8(mu.link = log_1_to_inf()),
                control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod99, what="mu")) + 1
exp(coef(mod99, what="sigma"))


# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS8
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.6 - 2.4 * x1) + 1  # Aprox 2.45 with link function log(mu - 1)
  sigma <- exp(1.6 + 1.5 * x2)   # Aprox 10 with link function log(sigma)
  y <- rBS8(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(1234)
dat <- gendat(n=400)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS8(mu.link = log_1_to_inf()), 
               data=dat,
               control=gamlss.control(n.cyc=100))

summary(mod2)

}