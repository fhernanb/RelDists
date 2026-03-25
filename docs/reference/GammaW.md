# The Gamma Weibull family

The Gamma Weibull family

## Usage

``` r
GammaW(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a GammaW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Gamma Weibull distribution with parameters `mu`, `sigma` and `nu`
has density given by

\\f(x)= \frac{\sigma \mu^{\nu}}{\Gamma (\nu)} x^{\nu \sigma - 1}
\exp(-\mu x^\sigma),\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \> 0\\ and \\\nu \> 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Stacy, E. W. (1962). A generalization of the gamma distribution. The
Annals of mathematical statistics, 1187-1192.

## See also

[dGammaW](http://fhernanb.github.io/RelDists/reference/dGammaW.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rGammaW(n=100, mu = 0.5, sigma = 2, nu=1)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family='GammaW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>   0.7671921 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>    1.484418 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>     1.28498 

# Example 2
# Generating random values under some model
n     <- 200
x1    <- runif(n)
x2    <- runif(n)
mu    <- exp(1.2 -1.6 * x1)
sigma <- exp(1.1 - 1 * x2)
nu    <- 1
y     <- rGammaW(n=n, mu, sigma, nu)

mod <- gamlss(y~x1, mu.fo=~x1, sigma.fo=~x2, nu.fo=~1, family=GammaW,
              control=gamlss.control(n.cyc=50000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    1.367374   -2.450779 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.501875   -1.343351 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>   0.7508533 
```
