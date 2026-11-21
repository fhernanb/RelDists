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

# Example 3
# The data represent fracture toughness (a measure of resistance to fracture, 
# in MPa * m^1/2)
# Su et al. (2025) page 667

alumina <- c(
  5.50, 5.00, 4.90, 6.40, 5.10, 5.20, 5.20, 5.00, 4.70, 4.00,
  4.50, 4.20, 4.10, 4.56, 5.01, 4.70, 3.13, 3.12, 2.68, 2.77,
  2.70, 2.36, 4.38, 5.73, 4.35, 6.81, 1.91, 2.66, 2.61, 1.68,
  2.04, 2.08, 2.13, 3.80, 3.73, 3.71, 3.28, 3.90, 4.00, 3.80,
  4.10, 3.90, 4.05, 4.00, 3.95, 4.00, 4.50, 4.50, 4.20, 4.55,
  4.65, 4.10, 4.25, 4.30, 4.50, 4.70, 5.15, 4.30, 4.50, 4.90,
  5.00, 5.35, 5.15, 5.25, 5.80, 5.85, 5.90, 5.75, 6.25, 6.05,
  5.90, 3.60, 4.10, 4.50, 5.30, 4.85, 5.30, 5.45, 5.10, 5.30,
  5.20, 5.30, 5.25, 4.75, 4.50, 4.20, 4.00, 4.15, 4.25, 4.30,
  3.75, 3.95, 3.51, 4.13, 5.40, 5.00, 2.10, 4.60, 3.20, 2.50,
  4.10, 3.50, 3.20, 3.30, 4.60, 4.30, 4.30, 4.50, 5.50, 4.60,
  4.90, 4.30, 3.00, 3.40, 3.70, 4.40, 4.90, 4.90, 5.00
)

mod3 <- gamlss(alumina~1, sigma.fo=~1, family=MCWEI,
               control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod3, what="mu"))
exp(coef(mod3, what="sigma"))
1 / coef(mod3, what="nu")

hist(alumina, freq = FALSE)
curve(dMCWEI(x, 
             mu=exp(coef(mod3, what="mu")), 
             sigma=exp(coef(mod3, what="sigma")), 
             nu=1 / coef(mod3, what="nu")),
      add=TRUE, col="red")
curve(dMCWEI(x, 
             mu=2.73329299, 
             sigma=0.01786388, 
             nu=-1.89210407),
      add=TRUE, col="blue") # Using estimated values of Su et al (2025)

plot(ecdf(alumina))
curve(pMCWEI(x, 
             mu=exp(coef(mod3, what="mu")), 
             sigma=exp(coef(mod3, what="sigma")), 
             nu=1 / coef(mod3, what="nu")),
      add=TRUE, col="red")
curve(pMCWEI(x, 
             mu=2.73329299, 
             sigma=0.01786388, 
             nu=-1.89210407),
      add=TRUE, col="blue") # Using estimated values of Su et al (2025)



