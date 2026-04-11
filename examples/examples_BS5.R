# Example 1
# Generating some random values with
# known mu and sigma
set.seed(123)
y <- rBS5(n=50, mu=1, sigma=25)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS5)

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS5
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.5 - 3 * x1)        # Aprox 1
  sigma <- exp(2.4 + 1.7 * x2)   # Aprox 25
  y <- rBS5(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

dat <- gendat(n=100)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS5, data=dat)

summary(mod2)
