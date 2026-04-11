# The Extended Exponential Geometric family

The Extended Exponential Geometric family

## Usage

``` r
EEG(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a EEG
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Extended Exponential Geometric distribution with parameters `mu` and
`sigma` has density given by

\\f(x)= \mu \sigma \exp(-\mu x)(1 - (1 - \sigma)\exp(-\mu x))^{-2},\\

for \\x \> 0\\, \\\mu \> 0\\ and \\\sigma \> 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Adamidis, K., Dimitrakopoulou, T., & Loukas, S. (2005). On an extension
of the exponential-geometric distribution. Statistics & probability
letters, 73(3), 259-269.

## See also

[dEEG](http://fhernanb.github.io/RelDists/reference/dEEG.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Generating some random values with
# known mu, sigma, nu and tau
y <- rEEG(n=100, mu = 1, sigma =1.5)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, family=EEG,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma, nu and tau
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>   0.6802456 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>    1.216626 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.1, max=0.2)
x2 <- runif(n, min=0.1, max=0.15)
mu <- exp(0.75 - x1)
sigma <- exp(0.5 - x2)
x <- rEEG(n=n, mu, sigma)

mod <- gamlss(x~x1, sigma.fo=~x2, family=EEG,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>   0.5129634  -1.0662722 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>   0.4416235  -0.7911857 
```
