# The Birnbaum-Saunders family - Ahmed et al. (2008)

The function `BS4()` defines the Birnbaum-Saunders distribution, a
two-parameter distribution, for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
BS4(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter.

## Value

Returns a `gamlss.family` object which can be used to fit a BS4
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Birnbaum-Saunders distribution with parameters `mu` and `sigma` has
density given by

\\f(x\|\mu,\sigma) = \frac{1}{2\sqrt{2\pi}} \left\[
\frac{\sigma}{x\sqrt{x}} + \frac{\mu}{\sqrt{x}} \right\] \exp\left(
-\frac{1}{2} \left\[ \frac{\sigma}{\sqrt{x}} - \mu\sqrt{x} \right\]^2
\right)\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \frac{\sigma \mu + 1/2}{\mu^2}\\ and \\Var(X) = \frac{\sigma
\mu + 5/4}{\mu^4}\\.

## References

Ahmed, S. E., Budsaba, K., Lisawadi, S., & Volodin, A. (2008).
Parametric estimation for the Birnbaum-Saunders lifetime distribution
based on a new parametrization. Thailand Statistician, 6(2), 213-240.

## See also

[dBS4](http://fhernanb.github.io/RelDists/reference/dBS4.md).

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
set.seed(123)
y <- rBS4(n=50, mu=2, sigma=0.2)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS4)
#> GAMLSS-RS iteration 1: Global Deviance = 862.6606 
#> GAMLSS-RS iteration 2: Global Deviance = -34.9217 
#> GAMLSS-RS iteration 3: Global Deviance = -52.3527 
#> GAMLSS-RS iteration 4: Global Deviance = -52.3944 
#> GAMLSS-RS iteration 5: Global Deviance = -52.3945 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>    1.887116 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>   0.2167196 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS4
if (FALSE) { # \dontrun{
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.45 - 3 * x1)
  sigma <- exp(2 - 1.5 * x2)
  y <- rBS4(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(1234)
dat <- gendat(n=100)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS4, data=dat,
               control=gamlss.control(n.cyc=100))

summary(mod2)
} # }

# Example 3
# Taken from Ahmed et al. (2008) on page 227
# The response variable is the fatigue
# life of 6061-T6 aluminum coupons.
if (FALSE) { # \dontrun{
y <- c(
    70, 90, 96, 97, 99, 100, 103, 104,
    104, 105, 107, 108, 108, 108, 109, 109,
    112, 112, 113, 114, 114, 114, 116, 119,
    120, 120, 120, 121, 121, 123, 124, 124,
    124, 124, 124, 128, 128, 129, 130, 130,
    130, 130, 131, 131, 131, 131, 131, 132,
    132, 132, 133, 134, 134, 134, 134, 134,
    136, 136, 137, 138, 138, 138, 139, 139,
    141, 141, 142, 142, 142, 142, 142, 142,
    144, 144, 145, 146, 148, 148, 149, 151,
    151, 152, 155, 156, 157, 157, 157, 157,
    158, 159, 162, 163, 163, 164, 166, 166,
    168, 170, 174, 196, 212
)
  
mod3 <- gamlss(y~1, family=BS4, 
               control=gamlss.control(n.cyc=3000))
  
summary(mod3)
exp(coef(mod3, what="mu"))
exp(coef(mod3, what="sigma"))

plot(density(y))
curve(dBS4(x, mu=0.5145121, sigma=67.81761),
      add=TRUE, col="tomato", lwd=2)
legend("topright", legend=c("Empirical", "Estimated"), 
       col=c("black", "tomato"), lty=1)
} # }

# Example 4
# Taken from Ahmed et al. (2008) on page 228
# The response variable is the fatigue life in
# hours of 10 bearings of a certain type. 
if (FALSE) { # \dontrun{
y <- c(152.7, 172.0, 172.5, 173.5, 193.0,
       204.7, 216.5, 234.9, 262.6, 422.6)

mod4 <- gamlss(y~1, family=BS4, 
               control=gamlss.control(n.cyc=3000))

summary(mod4)
exp(coef(mod4, what="mu"))
exp(coef(mod4, what="sigma"))
} # }
```
