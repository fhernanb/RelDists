# The Additive Weibull family

The Additive Weibull distribution

## Usage

``` r
AddW(mu.link = "log", sigma.link = "log", nu.link = "log", tau.link = "log")
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

Returns a gamlss.family object which can be used to fit a AddW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

Additive Weibull distribution with parameters `mu`, `sigma`, `nu` and
`tau` has density given by

\\f(x) = (\mu\nu x^{\nu - 1} + \sigma\tau x^{\tau - 1}) \exp({-\mu
x^{\nu} - \sigma x^{\tau} }),\\

for \\x \> 0\\.

## References

Almalki, S. J. (2018). A reduced new modified Weibull distribution.
Communications in Statistics-Theory and Methods, 47(10), 2297-2313.

Xie, M., & Lai, C. D. (1996). Reliability analysis using an additive
Weibull model with bathtub-shaped failure rate function. Reliability
Engineering & System Safety, 52(1), 87-93.

## See also

[dAddW](http://fhernanb.github.io/RelDists/reference/dAddW.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma, nu and tau
# Will not be run this example because high number is cycles
# is needed in order to get good estimates
if (FALSE) { # \dontrun{
y <- rAddW(n=100, mu=1.5, sigma=0.2, nu=3, tau=0.8)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, tau.fo=~1, family='AddW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma, nu and tau
# using the inverse link function
exp(coef(mod, what='mu'))
exp(coef(mod, what='sigma'))
exp(coef(mod, what='nu'))
exp(coef(mod, what='tau'))
} # }

# Example 2
# Generating random values under some model
# Will not be run this example because high number is cycles
# is needed in order to get good estimates
if (FALSE) { # \dontrun{
n <- 200
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(1.67 + -3 * x1)
sigma <- exp(0.69 - 2 * x2)
nu <- 3
tau <- 0.8
x <- rAddW(n=n, mu, sigma, nu, tau)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, tau.fo=~1, family=AddW,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
coef(mod, what="sigma")
exp(coef(mod, what="nu"))
exp(coef(mod, what="tau"))
} # }
```
