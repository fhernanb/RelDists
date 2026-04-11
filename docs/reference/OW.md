# The Odd Weibull family

The function `OW()` defines the Odd Weibull distribution, a three
parameter distribution, for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
OW(mu.link = "log", sigma.link = "log", nu.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

- nu.link:

  defines the nu.link, with "log" link as the default for the nu.

## Value

Returns a gamlss.family object which can be used to fit a OW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The odd Weibull with parameters `mu`, `sigma` and `nu` has density given
by

\\f(t) = \left( \frac{\sigma\nu}{t} \right) (\mu t)^\sigma e^{(\mu
t)^\sigma} \left(e^{(\mu t)^{\sigma}}-1\right)^{\nu-1} \left\[ 1 +
\left(e^{(\mu t)^{\sigma}}-1\right)^\nu \right\]^{-2}\\

for \\x\>0\\.

## References

Cooray, K. (2006). Generalization of the Weibull distribution: the odd
Weibull family. Statistical Modelling, 6(3), 265-277.

## Author

Jaime Mosquera Gutiérrez <jmosquerag@unal.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rOW(n=200, mu=0.1, sigma=7, nu = 1.1)

# Fitting the model
require(gamlss)
mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family="OW",
              control=gamlss.control(n.cyc=500, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what="mu"))
#> (Intercept) 
#>  0.09847697 
exp(coef(mod, what="sigma"))
#> (Intercept) 
#>    7.452586 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>     1.01129 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n)
x2 <- runif(n)
x3 <- runif(n)
mu <- exp(1.2 + 2 * x1)
sigma <- 2.12 + 3 * x2
nu <- exp(0.2 - x3)
y <- rOW(n=n, mu, sigma, nu)

mod <- gamlss(y~x1, sigma.fo=~x2, nu.fo=~x3, 
              family=OW(sigma.link="identity"), 
              control=gamlss.control(n.cyc=300, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    1.264500    1.885548 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.773182    3.542576 
coef(mod, what="nu")
#> (Intercept)          x3 
#>   0.2547996  -0.9621959 
```
