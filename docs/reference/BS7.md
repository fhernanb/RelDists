# The Birnbaum-Saunders family - Santos-Neto et al. (2012) (P5 Based on the variance)

The function `BS7()` defines the Birnbaum-Saunders distribution, a
two-parameter distribution, for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
BS7(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter (representing the variance).

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter (representing the shape).

## Value

Returns a `gamlss.family` object which can be used to fit a BS7
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Birnbaum-Saunders distribution with parameters `mu` and `sigma`
(where `mu` represents the true variance \\\sigma^2\\ and `sigma`
represents the shape parameter \\\alpha\\) has density given by

\\f(x\|\mu,\sigma) = \frac{1}{\sqrt{2\pi}} \exp\left( -\frac{1}{2\mu^2}
\left\[ \frac{\mu\sqrt{4+5\mu^2}}{2\sqrt{\sigma}x^{-1}} +
\frac{2\sqrt{\sigma}\\x\mu\\^{-1}}{\sqrt{4+5\mu^2}} - 2 \right\] \right)
\times \left\[
\frac{\\x\mu\\^{-1/2}\\4+5\mu^2\\^{1/4}}{2^{3/2}\sigma^{1/4}} +
\frac{\sigma^{1/4}}{\\x\mu\\^{3/2}\sqrt{2}\\4+5\mu^2\\^{1/4}} \right\]\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \frac{\[2+\mu^2\]\sqrt{\sigma}}{\mu\sqrt{4+5\mu^2}}\\ and
\\Var(X) = \sigma\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[dBS7](http://fhernanb.github.io/RelDists/reference/dBS7.md).

## Author

David Villegas Ceballos, <david.villegas1@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
set.seed(12345)
y <- rBS7(n=100, mu=0.2, sigma=10)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS7, 
               control=gamlss.control(n.cyc=1000))
#> GAMLSS-RS iteration 1: Global Deviance = 523.2187 
#> GAMLSS-RS iteration 2: Global Deviance = 523.2067 
#> GAMLSS-RS iteration 3: Global Deviance = 523.1963 
#> GAMLSS-RS iteration 4: Global Deviance = 523.1875 
#> GAMLSS-RS iteration 5: Global Deviance = 523.1799 
#> GAMLSS-RS iteration 6: Global Deviance = 523.1734 
#> GAMLSS-RS iteration 7: Global Deviance = 523.1679 
#> GAMLSS-RS iteration 8: Global Deviance = 523.1631 
#> GAMLSS-RS iteration 9: Global Deviance = 523.159 
#> GAMLSS-RS iteration 10: Global Deviance = 523.1555 
#> GAMLSS-RS iteration 11: Global Deviance = 523.1525 
#> GAMLSS-RS iteration 12: Global Deviance = 523.1499 
#> GAMLSS-RS iteration 13: Global Deviance = 523.1477 
#> GAMLSS-RS iteration 14: Global Deviance = 523.146 
#> GAMLSS-RS iteration 15: Global Deviance = 523.1445 
#> GAMLSS-RS iteration 16: Global Deviance = 523.1433 
#> GAMLSS-RS iteration 17: Global Deviance = 523.1421 
#> GAMLSS-RS iteration 18: Global Deviance = 523.1412 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>    0.214036 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    11.56968 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS7
if (FALSE) { # \dontrun{
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(0.6 - 4.4 * x1)      # Aprox 0.2
  sigma <- exp(1.6 + 1.5 * x2)   # Aprox 10
  y <- rBS7(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=200)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS7, data=dat,
               control=gamlss.control(n.cyc=1000))

summary(mod2)
} # }
```
