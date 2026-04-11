# The Flexible Weibull Extension family

The function `FWE()` defines the Flexible Weibull distribution, a two
parameter distribution, for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
FWE(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a FWE
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Flexible Weibull extension with parameters `mu` and `sigma` has
density given by

\\f(x) = (\mu + \sigma/x^2) exp(\mu x - \sigma/x) exp(-exp(\mu
x-\sigma/x))\\

for \\x\>0\\.

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
y <- rFWE(n=100, mu=0.75, sigma=1.3)

# Fitting the model
require(gamlss)
mod <- gamlss(y~1, sigma.fo=~1, family='FWE',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>   0.8259024 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>    1.293655 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n)
x2 <- runif(n)
mu <- exp(1.21 - 3 * x1)
sigma <- exp(1.26 - 2 * x2)
x <- rFWE(n=n, mu, sigma)

mod <- gamlss(x~x1, sigma.fo=~x2, family=FWE, 
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    1.243045   -2.921220 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.399095   -2.026717 
```
