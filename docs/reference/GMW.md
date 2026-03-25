# The Generalized Modified Weibull family

The Generalized modified Weibull distribution

## Usage

``` r
GMW(mu.link = "log", sigma.link = "log", nu.link = "sqrt", tau.link = "sqrt")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

- nu.link:

  defines the nu.link, with "sqrt" link as the default for the nu
  parameter.

- tau.link:

  defines the tau.link, with "sqrt" link as the default for the tau
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a GMW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Generalized modified Weibull distribution with parameters `mu`,
`sigma`, `nu` and `tau` has density given by

\\f(x)= \mu \sigma x^{\nu - 1}(\nu + \tau x) \exp(\tau x - \mu x^{\nu}
e^{\tau x}) \[1 - \exp(- \mu x^{\nu} e^{\tau x})\]^{\sigma-1},\\

for x \> 0.

## See also

[dGMW](http://fhernanb.github.io/RelDists/reference/dGMW.md)

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma, nu and tau
y <- rGMW(n=100, mu=2, sigma=0.5, nu=2, tau=1.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, tau.fo=~ 1, family='GMW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>    10.63227 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>    0.160873 
(coef(mod, what='nu'))^2
#> (Intercept) 
#>    5.428389 
(coef(mod, what='tau'))^2
#> (Intercept) 
#>   0.6294218 

# Example 2
# Generating random values under some model
if (FALSE) { # \dontrun{
n <- 1000
x1 <- runif(n)
x2 <- runif(n)
mu <- exp(2 + -3 * x1)
sigma <- exp(3 - 2 * x2)
nu <- 2
tau <- 1.5
x <- rGMW(n=n, mu, sigma, nu, tau)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, tau.fo=~ 1, family="GMW", 
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
coef(mod, what="sigma")
coef(mod, what="nu")^2
coef(mod, what="tau")^2
} # }
```
