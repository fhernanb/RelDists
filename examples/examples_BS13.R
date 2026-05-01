# Example 1
# Generating some random values with
# known mu and sigma
set.seed(123456)
y <- rBS13(n=500, mu=5, sigma=30)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS13,
               control=gamlss.control(n.cyc=300, trace=TRUE))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS13
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.1 + 1.1 * x1)      # Aprox 5
  sigma <- exp(2.2 + 2.4 * x2)   # Aprox 30
  y <- rBS13(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=200)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS13, data=dat,
               control=gamlss.control(n.cyc=500, trace=TRUE))

summary(mod2)

