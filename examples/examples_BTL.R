# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rBTL(n=300, mu=0.75, sigma=1.3, nu=0.5)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, nu.fo =~1, family=BTL,
               control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod1, what="mu"))
exp(coef(mod1, what="sigma"))
exp(coef(mod1, what="nu"))

# Example 2
# Generating random values under some model
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  x3 <- runif(n)
  mu <- exp(1.5 - 2.0 * x1)   
  sigma <- exp(2.5 - 0.5 * x2) 
  nu <- exp(-2.0 + 4.5 * x3)
  y <- rBTL(n, mu, sigma, nu)
  data.frame(y=y, x1=x1, x2=x2, x3=x3)
}

dat <- gendat(n=2000)

mod2 <- gamlss(y~x1, sigma.fo=~x2, nu.fo=~x3, family=BTL, data=dat,
               control=gamlss.control(n.cyc=3000, trace=FALSE))

summary(mod2)
coef(mod2, what="mu")
coef(mod2, what="sigma")
coef(mod2, what="nu")

# Example 3
# Fatigue life (T) measures in cycles (×10-3) of n 101
# aluminum coupons (specimens) of type 6061-T6.
# Taken from Leiva et al. (2006) page 37.
# https://journal.r-project.org/articles/RN-2006-033/RN-2006-033.pdf

y <- c(0.0251, 0.0886, 0.0891, 0.2501, 0.3113, 0.3451, 
       0.4763, 0.5650, 0.5671, 0.6566, 0.6748, 0.6751, 
       0.6753, 0.7696, 0.8375, 0.8391, 0.8425, 0.8645, 
       0.8851, 0.9113, 0.9120, 0.9836, 1.0483, 1.0596, 
       1.0773, 1.1733, 1.2570, 1.2766, 1.2985, 1.3211, 
       1.3503, 1.3551, 1.4595, 1.4880, 1.5728, 1.5733, 
       1.7083, 1.7263, 1.7460, 1.7630, 1.7746, 1.8275, 
       1.8375, 1.8503, 1.8808, 1.8878, 1.8881, 1.9316, 
       1.9558, 2.0048, 2.0408, 2.0903, 2.1093, 2.1330, 
       2.2100, 2.2460, 2.2878, 2.3203, 2.3470, 2.3513, 
       2.4951, 2.5260, 2.9911, 3.0256, 3.2678, 3.4045, 
       3.4846, 3.7433, 3.7455, 3.9143, 4.8073, 5.4005, 
       5.4435, 5.5295, 6.5541, 9.0960)

mod3 <- gamlss(y~1, family=BTL, 
               control=gamlss.control(n.cyc=500, trace=FALSE))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod3, what="mu"))
exp(coef(mod3, what="sigma"))
exp(coef(mod3, what="nu"))
