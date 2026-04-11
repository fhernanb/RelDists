# Example 1
# Generating some random values with
# known mu and sigma
set.seed(1234)
y <- rBS6(n=50, mu=1, sigma=0.1)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS6)

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS6
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.5 - 3 * x1)        # Aprox 1
  sigma <- exp(0.5 - 3.5 * x2)   # Aprox 0.1
  y <- rBS6(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

dat <- gendat(n=100)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS6, data=dat)

summary(mod2)
