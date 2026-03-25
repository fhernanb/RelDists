# The Log-Weibull family

The Log-Weibull distribution

## Usage

``` r
LW(mu.link = "identity", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a LW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Log-Weibull Distribution with parameters `mu` and `sigma` has
density given by

\\f(y)=(1/\sigma) e^{((y - \mu)/\sigma)} exp\\-e^{((y -
\mu)/\sigma)}\\,\\

for \\-\infty \< y \< \infty\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Gumbel, E. J. (1958). Statistics of extremes. Columbia university press.

## See also

[dLW](http://fhernanb.github.io/RelDists/reference/dLW.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma 
y <- rLW(n=100, mu=0, sigma=1.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, family= 'LW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu and sigma
# using the inverse link function
coef(mod, 'mu')
#> (Intercept) 
#>  -0.1011533 
exp(coef(mod, 'sigma'))
#> (Intercept) 
#>    1.641673 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- 1.5 - 3 * x1
sigma <- exp(1.4 - 2 * x2)
x <- rLW(n=n, mu, sigma)

mod <- gamlss(x~x1, sigma.fo=~x2, family=LW,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    1.523550   -3.362458 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.200269   -1.559729 
```
