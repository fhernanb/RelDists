# The Inverse Weibull family

The Inverse Weibull distribution

## Usage

``` r
IW(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a IW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Inverse Weibull distribution with parameters `mu`, `sigma` has
density given by

\\f(x) = \mu \sigma x^{-\sigma-1} \exp(\mu x^{-\sigma})\\

for \\x \> 0\\, \\\mu \> 0\\ and \\\sigma \> 0\\

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Drapella, A. (1993). The complementary Weibull distribution: unknown or
just forgotten?. Quality and reliability engineering international,
9(4), 383-385.

## See also

[dIW](http://fhernanb.github.io/RelDists/reference/dIW.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
y <- rIW(n=100, mu=5, sigma=2.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, mu.fo=~1, sigma.fo=~1, family='IW',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>    4.030121 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>    2.375744 

# Example 2
# Generating random values under some model
n <- 200
x1 <- rpois(n, lambda=2)
x2 <- runif(n)
mu <- exp(2 + -1 * x1)
sigma <- exp(2 - 2 * x2)
x <- rIW(n=n, mu, sigma)

mod <- gamlss(x~x1, mu.fo=~1, sigma.fo=~x2, family=IW,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    2.311472   -1.155356 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.974543   -1.855939 
```
