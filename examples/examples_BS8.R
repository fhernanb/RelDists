# Example 1
# Generating some random values with
# known mu and sigma

set.seed(12345)
y <- rBS8(n=100, mu=2, sigma=10)

# 1. Extract the built-in "logshiftto1" link structure
logshift_link <- make.link.gamlss("logshiftto1")

# 2. Assign its components to the 'own' functions gamlss searches for
own.linkfun  <- logshift_link$linkfun
own.linkinv  <- logshift_link$linkinv
own.mu.eta   <- logshift_link$mu.eta
own.valideta <- logshift_link$valideta

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS8(mu.link = "own"),
               control=gamlss.control(n.cyc=100))

mod99 <- gamlss(y~1, sigma.fo=~1, family=BS8,
               control=gamlss.control(n.cyc=100))

# Extracting the fitted values for mu and sigma
# using the inverse link function
own.linkinv(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))

exp(coef(mod99, what="mu"))
exp(coef(mod99, what="sigma"))

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS8
\dontrun{
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.6 - 1.4 * x1)      # Aprox 2.45
  sigma <- exp(1.6 + 1.5 * x2)   # Aprox 10
  y <- rBS8(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=200)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS8(mu.link = "own"), data=dat,
               control=gamlss.control(n.cyc=100))

summary(mod2)
}
