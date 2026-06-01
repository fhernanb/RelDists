# The Kumaraswamy Inverse Weibull family

The Kumaraswamy Inverse Weibull family

## Usage

``` r
KumIW(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a KumIW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Kumaraswamy Inverse Weibull Distribution with parameters `mu`,
`sigma` and `nu` has density given by

\\f(x)= \mu \sigma \nu x^{-\mu - 1} \exp{- \sigma x^{-\mu}} (1 - \exp{-
\sigma x^{-\mu}})^{\nu - 1},\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \> 0\\ and \\\nu \> 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Shahbaz, M. Q., Shahbaz, S., & Butt, N. S. (2012). The Kumaraswamy
Inverse Weibull Distribution. Pakistan journal of statistics and
operation research, 479-489.

## See also

[dKumIW](http://fhernanb.github.io/RelDists/reference/dKumIW.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma, nu and tau
y <- rKumIW(n=100, mu = 1.5, sigma=  1.5, nu = 5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family="KumIW",
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu 
# using the inverse link function
exp(coef(mod, what="mu"))
#> (Intercept) 
#>    1.475102 
exp(coef(mod, what="sigma"))
#> (Intercept) 
#>   0.9123939 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>    2.423832 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(1 - x1)
sigma <- exp(1 - x2)
nu <- 5
x <- rKumIW(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, family=KumIW,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>  -0.2991252   1.1169063 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>   0.9183936  -1.3673258 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>    3.441314 
```
