# The Weibull Geometric family

The Weibull Geometric distribution

## Usage

``` r
WG(mu.link = "log", sigma.link = "log", nu.link = "logit")
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

Returns a gamlss.family object which can be used to fit a WG
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The weibull geometric distribution with parameters `mu`, `sigma` and
`nu` has density given by

\\f(x) = (\sigma \mu^\sigma (1-\nu) x^(\sigma - 1) \exp(-(\mu
x)^\sigma)) (1- \nu \exp(-(\mu x)^\sigma))^{-2},\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \> 0\\ and \\0 \< \nu \< 1\\.

## References

Barreto-Souza, W., de Morais, A. L., & Cordeiro, G. M. (2011). The
Weibull-geometric distribution. Journal of Statistical Computation and
Simulation, 81(5), 645-657.

## See also

[dWG](http://fhernanb.github.io/RelDists/reference/dWG.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rWG(n=100,  mu = 0.9, sigma = 2, nu = 0.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family='WG',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>    1.190599 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>   0.9364273 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>    3.622361 

# Example 2
# Generating random values under some model
n     <- 200
x1    <- runif(n)
x2    <- runif(n)
mu    <- exp(- 0.2 * x1)
sigma <- exp(1.2 - 1 * x2)
nu    <- 0.5
x     <- rWG(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, mu.fo=~x1, sigma.fo=~x2, nu.fo=~1, family=WG,
              control=gamlss.control(n.cyc=50000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>  -0.5958908   0.7582595 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>  -0.1495892   0.5267331 
coef(mod, what='nu')
#> (Intercept) 
#>    1.761155 
```
