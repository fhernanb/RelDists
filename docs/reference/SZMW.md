# The Sarhan and Zaindin's Modified Weibull family

The Sarhan and Zaindin's Modified Weibull distribution

## Usage

``` r
SZMW(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a SZMW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Sarhan and Zaindin's Modified Weibull distribution with parameters
`mu`, `sigma` and `nu` has density given by

\\f(x)=(\mu + \sigma \nu x^{\nu - 1}) \exp(- \mu x - \sigma x^\nu),\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \> 0\\ and \\\nu \> 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Sarhan, A. M., & Zaindin, M. (2009). Modified Weibull distribution.
APPS. Applied Sciences, 11, 123-136.

## See also

[dSZMW](http://fhernanb.github.io/RelDists/reference/dSZMW.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rSZMW(n=100, mu = 1, sigma = 1, nu = 1.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family='SZMW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>    1.157218 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>   0.6491916 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>    2.317524 

# Example 2
# Generating random values under some model
n     <- 200
x1    <- runif(n)
x2    <- runif(n)
mu    <- exp(-1.6 * x1)
sigma <- exp(0.9 - 1 * x2)
nu    <- 1.5
x     <- rSZMW(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, mu.fo=~x1, sigma.fo=~x2, nu.fo=~1, family=SZMW,
              control=gamlss.control(n.cyc=50000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>   0.4087507  -0.9729186 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>   0.7313018  -1.8532639 
coef(mod, what='nu')
#> (Intercept) 
#>   0.5665461 
```
