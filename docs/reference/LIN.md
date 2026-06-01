# The Lindley family

The function `LIN()` defines the Lindley distribution with only one
parameter for a `gamlss.family` object to be used in GAMLSS fitting
using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
LIN(mu.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a LIN
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Lindley with parameter `mu` has density given by

\\f(x) = \frac{\mu^2}{\mu+1} (1+x) \exp(-\mu x),\\

for x \> 0 and \\\mu \> 0\\.

## References

Lindley, D. V. (1958). Fiducial distributions and Bayes' theorem.
Journal of the Royal Statistical Society. Series B (Methodological),
102-107.

## Author

Freddy Hernandez <fhernanb@unal.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rLIN(n=200, mu=2)

# Fitting the model
require(gamlss)
mod <- gamlss(y ~ 1, family="LIN")
#> GAMLSS-RS iteration 1: Global Deviance = 271.5334 

# Extracting the fitted values for mu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>    1.850502 

# Example 2
# Generating random values under some model
n <- 100
x1 <- runif(n=n)
x2 <- runif(n=n)
eta <- 1 + 3 * x1 - 2 * x2
mu <- exp(eta)
y <- rLIN(n=n, mu=mu)

mod <- gamlss(y ~ x1 + x2, family=LIN)
#> GAMLSS-RS iteration 1: Global Deviance = -74.6135 
#> GAMLSS-RS iteration 2: Global Deviance = -74.6135 

coef(mod, what='mu')
#> (Intercept)          x1          x2 
#>    1.119287    2.698049   -2.044628 
```
