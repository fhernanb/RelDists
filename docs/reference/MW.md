# The Modified Weibull family

\#' The Modified Weibull distribution

## Usage

``` r
MW(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a MW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Modified Weibull distribution with parameters `mu`, `sigma` and `nu`
has density given by

\\f(x) = \mu (\sigma + \nu x) x^{\sigma - 1} \exp(\nu x) \exp(-\mu
x^{\sigma} \exp(\nu x)),\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \geq 0\\ and \\\nu \geq 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Lai, C. D., Xie, M., & Murthy, D. N. P. (2003). A modified Weibull
distribution. IEEE Transactions on reliability, 52(1), 33-37.

## See also

[dMW](http://fhernanb.github.io/RelDists/reference/dMW.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rMW(n=100, mu = 2, sigma = 1.5, nu = 0.2)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family= 'MW',
               control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>    1.935706 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>    1.512932 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>   0.2942034 

# Example 2
# Generating random values under some model
n     <- 200
x1    <- rpois(n, lambda=2)
x2    <- runif(n)
mu    <- exp(3 -1 * x1)
sigma <- exp(2 - 2 * x2)
nu    <- 0.2
x     <- rMW(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, mu.fo=~x1, sigma.fo=~x2, nu.fo=~1, family=MW,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>   3.0337995  -0.9488072 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    2.096852   -2.077852 
coef(mod, what='nu')
#> (Intercept) 
#>   -2.612791 
```
