# The four parameter Exponentiated Generalized Gamma family

The four parameter Exponentiated Generalized Gamma distribution

## Usage

``` r
EGG(mu.link = "log", sigma.link = "log", nu.link = "log", tau.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

- nu.link:

  defines the nu.link, with "log" link as the default for the nu
  parameter.

- tau.link:

  defines the tau.link, with "log" link as the default for the tau
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a EGG
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

Four parameter Exponentiated Generalized Gamma distribution with
parameters `mu`, `sigma`, `nu` and `tau` has density given by

\\f(x) = \frac{\nu \sigma}{\mu \Gamma(\tau)}
\left(\frac{x}{\mu}\right)^{\sigma \tau -1} \exp\left\\ - \left(
\frac{x}{\mu} \right)^\sigma \right\\ \left\\ \gamma_1\left( \tau,
\left( \frac{x}{\mu} \right)^\sigma \right) \right\\^{\nu-1} ,\\

for x \> 0.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Cordeiro, G. M., Ortega, E. M., & Silva, G. O. (2011). The exponentiated
generalized gamma distribution with application to lifetime data.
Journal of statistical computation and simulation, 81(7), 827-842.

## See also

[dEGG](http://fhernanb.github.io/RelDists/reference/dEGG.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma, nu and tau
# \donttest{
set.seed(123456)
y <- rEGG(n=100, mu=0.1, sigma=0.8, nu=10, tau=1.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, tau.fo=~1, 
              family=EGG,
              control=gamlss.control(n.cyc=500, trace=FALSE))

# Extracting the fitted values for mu, sigma, nu and tau
# using the inverse link function
exp(coef(mod, what="mu"))
#> (Intercept) 
#>   0.3046327 
exp(coef(mod, what="sigma"))
#> (Intercept) 
#>    1.154273 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>    10.99878 
exp(coef(mod, what="tau"))
#> (Intercept) 
#>   0.4935583 
# }

# Example 2
# Generating random values under some model

# \donttest{
# A function to simulate a data set with Y ~ EGG
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu    <- exp(-0.8 + -3 * x1)
  sigma <- exp(0.77 - 2 * x2)
  nu    <- 10
  tau   <- 1.5
  y <- rEGG(n=n, mu=mu, sigma=sigma, nu=nu, tau)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(12345)
dat <- gendat(n=200)

mod <- gamlss(y~x1, sigma.fo=~x2, nu.fo=~1, tau.fo=~1, 
              family=EGG, data=dat,
              control=gamlss.control(n.cyc=500, trace=FALSE))
#> Warning: Algorithm RS has not yet converged

coef(mod, what="mu")
#> (Intercept)          x1 
#>  -0.7148452  -2.9857824 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    0.942474   -2.101227 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>    6.535813 
exp(coef(mod, what="tau"))
#> (Intercept) 
#>    1.970906 
# }
```
