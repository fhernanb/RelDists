# The Quasi XGamma Poisson family

The Quasi XGamma Poisson family

## Usage

``` r
QXGP(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a QXGP
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Quasi XGamma Poisson distribution with parameters `mu`, `sigma` and
`nu` has density given by

\\f(x)= K(\mu, \sigma, \nu)(\frac {\sigma^{2} x^{2}}{2} + \mu)
exp(\frac{\nu exp(-\sigma x)(1 + \mu + \sigma x + \frac
{\sigma^{2}x^{2}}{2})}{1+\mu} - \sigma x),\\

for \\x \> 0\\, \\\mu\> 0\\, \\\sigma\> 0\\, \\\nu\> 1\\.

where

\\K(\mu, \sigma, \nu) = \frac{\nu \sigma}{(exp(\nu)-1)(1+\mu)}\\

## References

Sen, S., Korkmaz, M. Ç., & Yousof, H. M. (2018). The quasi
XGamma-Poisson distribution: properties and application. Istatistik
Journal of The Turkish Statistical Association, 11(3), 65-76.

## See also

[dQXGP](http://fhernanb.github.io/RelDists/reference/dQXGP.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rQXGP(n=200, mu=4, sigma=2, nu=3)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family='QXGP',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>    259059.3 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>    1.457187 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>    3.056329 

# Example 2
# Generating random values under some model
n <- 2000
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(-2.19 + 3 * x1)
sigma <- exp(1 - 2 * x2)
nu <- 1
x <- rQXGP(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, family=QXGP,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>   -1.600100    3.455053 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.122522   -2.107520 
exp(coef(mod, what="nu"))
#>  (Intercept) 
#> 2.220444e-16 
```
