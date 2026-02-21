# The Generalized Inverse Weibull family

The Generalized Inverse Weibull family

## Usage

``` r
GIW(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a GIW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Generalized Inverse Weibull distribution with parameters `mu`,
`sigma` and `nu` has density given by

\\f(x) = \nu \sigma \mu^{\sigma} x^{-(\sigma + 1)} exp \\-\nu
(\frac{\mu}{x})^{\sigma}\\,\\

for x \> 0.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

De Gusmao, F. R., Ortega, E. M., & Cordeiro, G. M. (2011). The
generalized inverse Weibull distribution. Statistical Papers, 52,
591-619.

## See also

[dGIW](http://fhernanb.github.io/RelDists/reference/dGIW.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rGIW(n=200, mu=3, sigma=5, nu=0.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family='GIW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>     2.80729 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>     4.88011 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>   0.6596687 

# Example 2
# Generating random values under some model
n <- 500
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(-1.02 + 3 * x1)
sigma <- exp(1.69 - 2 * x2)
nu <- 0.5
x <- rGIW(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, family=GIW,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>  -0.8411041   2.3834851 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.838394   -2.284789 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>   0.6668348 
```
