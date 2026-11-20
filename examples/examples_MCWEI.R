# Example 1
# Generating some random values with
# known mu, sigma and nu

true_mu <- 2.2
true_sigma <- 1.2
true_nu <- 10

y <- rMCWEI(n=1000, mu=true_mu, sigma=true_sigma, nu=true_nu)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=MCWEI,
               control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))
1 / coef(mod1, what="nu")

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ MCWEI
gendat <- function(n) {
  x1 <- runif(n, min=0.4, max=0.6)
  x2 <- runif(n, min=0.4, max=0.6)
  mu <- exp(1 + 3 * x1)
  sigma <- exp(2 + 1 * x2)
  nu <- 5
  y <- rMCWEI(n=n, mu=mu, sigma=sigma, nu=nu)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(1234)
dat <- gendat(n=100)

mod2 <- gamlss(y~x1, sigma.fo=~x2, nu.fo=~1,
               family=MCWEI, data=dat,
               control=gamlss.control(n.cyc=1000))

summary(mod2)
1 / coef(mod2, what="nu")

