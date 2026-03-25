# The Generalized Gompertz family

The Generalized Gompertz family

## Usage

``` r
GGD(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a GGD
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Generalized Gompertz Distribution with parameters `mu`, `sigma` and
`nu` has density given by

\\f(x)= \nu \mu \exp(-\frac{\mu}{\sigma}(\exp(\sigma x - 1))) (1 -
\exp(-\frac{\mu}{\sigma}(\exp(\sigma x - 1))))^{(\nu - 1)} ,\\

for \\x \geq 0\\, \\\mu \> 0\\, \\\sigma \geq 0\\ and \\\nu \> 0\\

## References

\#' El-Gohary, A., Alshamrani, A., & Al-Otaibi, A. N. (2013). The
generalized Gompertz distribution. Applied mathematical modelling,
37(1-2), 13-24.

## See also

[dGGD](http://fhernanb.github.io/RelDists/reference/dGGD.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
#Example 1
# Generating some random values with
# known mu, sigma, nu and tau
y <- rGGD(n=1000, mu=1, sigma=0.3, nu=1.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family='GGD',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu 
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>   0.9749114 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>   0.3144968 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>    1.452729 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(0.5 - x1)
sigma <- exp(-1 - x2)
nu <- 1.5
x <- rGGD(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, family=GGD,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    1.460665   -2.735945 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>   -6.274569    9.130668 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>    1.741431 
```
