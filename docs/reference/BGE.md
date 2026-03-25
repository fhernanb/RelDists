# The Beta Generalized Exponentiated family

The Beta Generalized Exponentiated family

## Usage

``` r
BGE(mu.link = "log", sigma.link = "log", nu.link = "log", tau.link = "log")
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

Returns a gamlss.family object which can be used to fit a BGE
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Beta Generalized Exponentiated distribution with parameters `mu`,
`sigma`, `nu` and `tau` has density given by

\\f(x)= \frac{\nu \tau}{B(\mu, \sigma)} \exp(-\nu x)(1- \exp(-\nu
x))^{\tau \mu - 1} (1 - (1- \exp(-\nu x))^\tau)^{\sigma -1},\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \> 0\\, \\\nu \> 0\\ and \\\tau
\> 0\\.

## References

Almalki, S. J. (2018). A reduced new modified Weibull distribution.
Communications in Statistics-Theory and Methods, 47(10), 2297-2313.

Barreto-Souza, W., Santos, A. H., & Cordeiro, G. M. (2010). The beta
generalized exponential distribution. Journal of statistical Computation
and Simulation, 80(2), 159-172.

## See also

[dBGE](http://fhernanb.github.io/RelDists/reference/dBGE.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Generating some random values with
# known mu, sigma, nu and tau
y <- rBGE(n=100, mu = 1.5, sigma =1.7, nu=1, tau=1)

# Fitting the model
require(gamlss)
#> Loading required package: gamlss
#> Loading required package: splines
#> Loading required package: gamlss.data
#> 
#> Attaching package: 'gamlss.data'
#> The following object is masked from 'package:datasets':
#> 
#>     sleep
#> Loading required package: gamlss.dist
#> Loading required package: nlme
#> Loading required package: parallel
#>  **********   GAMLSS Version 5.5-0  ********** 
#> For more on GAMLSS look at https://www.gamlss.com/
#> Type gamlssNews() to see new features/changes/bug fixes.

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, tau.fo=~1, family=BGE,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma, nu and tau
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>    1.291091 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>   0.7667065 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>    2.260267 
exp(coef(mod, what='tau'))
#> (Intercept) 
#>    1.240522 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(0.5 - x1)
sigma <- exp(0.8 - x2)
nu <- 1
tau <- 1
x <- rBGE(n=n, mu, sigma, nu, tau)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, tau.fo=~1, family=BGE,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    1.543910   -1.318217 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.441633   -2.497046 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>    1.086642 
exp(coef(mod, what="tau"))
#> (Intercept) 
#>   0.4448615 
```
