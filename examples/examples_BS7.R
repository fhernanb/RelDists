# Example 1
# Generating some random values with
# known mu and sigma
set.seed(12345)
y <- rBS7(n=100, mu=0.2, sigma=10)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS7, 
               control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS7
\dontrun{
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(0.6 - 4.4 * x1)      # Aprox 0.2
  sigma <- exp(1.6 + 1.5 * x2)   # Aprox 10
  y <- rBS7(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=200)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS7, data=dat,
               control=gamlss.control(n.cyc=1000))

summary(mod2)
}
