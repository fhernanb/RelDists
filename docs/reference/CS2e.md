# The Cosine Sine Exponential family

The Cosine Sine Exponential family

## Usage

``` r
CS2e(mu.link = "log", sigma.link = "log", nu.link = "log")
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

Returns a gamlss.family object which can be used to fit a CS2e
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Cosine Sine Exponential distribution with parameters `mu`, `sigma`
and `nu` has density given by

\\f(x)=\frac{\pi \sigma \mu \exp(\frac{-x} {\nu})}{2 \nu
\[(\mu\sin(\frac{\pi}{2} \exp(\frac{-x} {\nu})) +
\sigma\cos(\frac{\pi}{2} \exp(\frac{-x} {\nu}))\]^2}, \\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \> 0\\ and \\\nu \> 0\\.

## References

Chesneau, C., Bakouch, H. S., & Hussain, T. (2019). A new class of
probability distributions via cosine and sine functions with
applications. Communications in Statistics-Simulation and Computation,
48(8), 2287-2300.

## See also

[dCS2e](http://fhernanb.github.io/RelDists/reference/dCS2e.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu 
y <- rCS2e(n=100, mu = 0.1, sigma =1, nu=0.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family='CS2e',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>  0.07959399 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>   0.9818056 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>   0.4858994 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.45, max=0.55)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(0.2 - x1)
sigma <- exp(0.8 - x2)
nu <- 0.5
x <- rCS2e(n=n, mu, sigma, nu)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1,family=CS2e,
              control=gamlss.control(n.cyc=50000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>   -1.403342    1.345065 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    2.254965   -4.530517 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>   0.5787574 
```
