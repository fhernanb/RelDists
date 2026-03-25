# The Reflected Weibull family

Reflected Weibull distribution

## Usage

``` r
RW(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a RW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Reflected Weibull Distribution with parameters `mu` and `sigma` has
density given by

\\f(y) = \mu\sigma (-y) ^{\sigma - 1} e ^ {-\mu(-y)^\sigma},\\

for y \< 0

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Cohen, A. C. (1973). The reflected Weibull distribution. Technometrics,
15(4), 867-873.

## See also

[dRW](http://fhernanb.github.io/RelDists/reference/dRW.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma 
y <- rRW(n=100, mu=1, sigma=1)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, family= 'RW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod, 'mu'))
#> (Intercept) 
#>    1.108548 
exp(coef(mod, 'sigma'))
#> (Intercept) 
#>    1.028627 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(1.5 - 1.5 * x1)
sigma <- exp(2 - 2 * x2)
x <- rRW(n=n, mu, sigma)

mod <- gamlss(x~x1, sigma.fo=~x2, family=RW,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    1.954567   -2.425330 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    2.166813   -2.234059 
```
