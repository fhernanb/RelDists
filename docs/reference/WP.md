# The Weibull Poisson family

The Weibull Poisson family

## Usage

``` r
WP(mu.link = "log", sigma.link = "log", nu.link = "log")
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

## Value

Returns a gamlss.family object which can be used to fit a WP
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Weibull Poisson distribution with parameters `mu`, `sigma` and `nu`
has density given by

\\f(x) = \frac{\mu \sigma \nu e^{-\nu}} {1-e^{-\nu}} x^{\mu-1}
\exp({-\sigma x^{\mu}+\nu \exp({-\sigma} x^{\mu}) }),\\

for \\x \> 0\\.

## References

Lu, Wanbo, and Daimin Shi. "A new compounding life distribution: the
Weibull–Poisson distribution." Journal of applied statistics 39.1
(2012): 21-38.

## See also

[dWP](http://fhernanb.github.io/RelDists/reference/dWP.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rWP(n=3000, mu=1.5, sigma=0.5, nu=0.5)

# Fitting the model
require(gamlss)

mod1 <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family=WP,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>    1.530922 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>   0.4717282 
exp(coef(mod1, what="nu"))
#> (Intercept) 
#>   0.6564898 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ WP
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(-1.3 + 3.1 * x1)
  sigma <- exp(0.9 - 3.2 * x2)
  nu <- 0.5
  y <- rWP(n=n, mu, sigma, nu)
  data.frame(y=y, x1=x1, x2)
}

set.seed(1234)
dat <- gendat(n=100)

# Fitting the model
mod2 <- NULL
mod2 <- gamlss(y~x1, sigma.fo=~x2, nu.fo=~1, 
               family=WP, data=dat,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod2, what="mu")
#> (Intercept)          x1 
#>   -1.125264    3.013640 
coef(mod2, what="sigma")
#> (Intercept)          x2 
#>   0.9625944  -3.7192040 
exp(coef(mod2, what="nu"))
#> (Intercept) 
#>   0.9819208 
```
