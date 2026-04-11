# The Marshall-Olkin Extended Weibull family

The Marshall-Olkin Extended Weibull family

## Usage

``` r
MOEW(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a MOEW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Marshall-Olkin Extended Weibull distribution with parameters `mu`,
`sigma` and `nu` has density given by

\\f(x) = \frac{\mu \sigma \nu (\nu x)^{\sigma - 1} exp\\{-(\nu x
)^{\sigma}}\\}{\\1-(1-\mu) exp\\{-(\nu x )^{\sigma}}\\ \\^{2}},\\

for x \> 0.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Ghitany, M. E., Al-Hussaini, E. K., & Al-Jarallah, R. A. (2005).
Marshall–Olkin extended Weibull distribution and its application to
censored data. Journal of Applied Statistics, 32(10), 1025-1034.

## See also

[dMOEW](http://fhernanb.github.io/RelDists/reference/dMOEW.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rMOEW(n=400, mu=0.5, sigma=0.7, nu=1)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family='MOEW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))
#> Error in gamlss(y ~ 1, sigma.fo = ~1, nu.fo = ~1, family = "MOEW", control = gamlss.control(n.cyc = 5000,     trace = FALSE)): response variable out of range

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> Error: object 'mod' not found
exp(coef(mod, what='sigma'))
#> Error: object 'mod' not found
exp(coef(mod, what='nu'))
#> Error: object 'mod' not found

# Example 2
# Generating random values under some model
n <- 500
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(-1.20 + 3 * x1)
sigma <- exp(0.84 - 2 * x2)
nu <- 1
x <- rMOEW(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, family=MOEW,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>  -0.4789437   1.4206995 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.019160   -2.371121 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>    0.921518 
```
