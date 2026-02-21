# The Extended Odd Frechet-Nadarajah-Haghighi family

The Extended Odd Frechet-Nadarjad-Hanhighi family

## Usage

``` r
EOFNH(mu.link = "log", sigma.link = "log", nu.link = "log", tau.link = "log")
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

Returns a gamlss.family object which can be used to fit a EOFNH
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Extended Odd Frechet-Nadarajah-Haghighi distribution with parameters
`mu`, `sigma`, `nu` and `tau` has density given by

\\f(x)= \frac{\mu\sigma\nu\tau(1+\nu x)^{\sigma-1}e^{(1-(1+\nu
x)^\sigma)}\[1-(1-e^{(1-(1+\nu
x)^\sigma)})^{\mu}\]^{\tau-1}}{(1-e^{(1-(1+\nu
x)^{\sigma})})^{\mu\tau+1}} e^{-\[(1-e^{(1-(1+\nu
x)^\sigma)})^{-\mu}-1\]^{\tau}},\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \> 0\\, \\\nu \> 0\\ and \\\tau
\> 0\\.

## References

Nasiru, S. (2018). Extended Odd Fréchet‐G Family of Distributions
Journal of Probability and Statistics, 2018(1), 2931326.

## See also

[dEOFNH](http://fhernanb.github.io/RelDists/reference/dEOFNH.md)

## Author

Helber Santiago Padilla, <hspadillar@unal.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma, nu and tau
set.seed(123)
y <- rEOFNH(n=100, mu=1, sigma=2.1, nu=0.8, tau=1)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, tau.fo=~1, family=EOFNH,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma, nu and tau
# using the inverse link function
exp(coef(mod, what="mu"))
#> (Intercept) 
#>   0.9036802 
exp(coef(mod, what="sigma"))
#> (Intercept) 
#>     2.55407 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>   0.5872532 
exp(coef(mod, what="tau"))
#> (Intercept) 
#>    1.075305 

# Example 2
# Generating random values under the model
n <- 100
x1 <- runif(n)
x2 <- runif(n)
mu <- exp(0.5 - 1.2 * x1)
sigma <- 2.1
nu <- 0.8
tau <- 1
y <- rEOFNH(n=n, mu, sigma, nu, tau)

mod <- gamlss(y~x1, sigma.fo=~1, nu.fo=~1, tau.fo=~1, family=EOFNH,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>  0.05375426 -0.99943981 
exp(coef(mod, what="sigma"))
#> (Intercept) 
#>    1.330352 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>   0.9497364 
exp(coef(mod, what="tau"))
#> (Intercept) 
#>    1.382512 
```
