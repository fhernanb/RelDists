# The Birnbaum-Saunders family - Santos-Neto et al. (2012) (P6 Based on the variance 2)

The function `BS8()` defines the Birnbaum-Saunders distribution, a
two-parameter distribution, for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
BS8(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter (representing the variance).

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter (representing the shape).

## Value

Returns a `gamlss.family` object which can be used to fit a BS8
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Birnbaum-Saunders distribution with parameters `mu` and `sigma`
(where `mu` represents the true variance \\\sigma^2\\ and `sigma`
represents the shape parameter \\\alpha\\) has density given by

\\f(x\|\mu,\sigma) = \frac{\sqrt{\mu}} {2\sqrt{2\pi\sigma}} \left\[
\left\\ \frac{1}{2x} \sqrt{\frac{5\sigma}{\mu(\mu-1)}} \right\\^{1/2} +
\left\\ \frac{1}{2x} \sqrt{\frac{5\sigma}{\mu(\mu-1)}} \right\\^{3/2}
\right\] \exp\left( -\frac{5}{8(\mu-1)} \left\[
\frac{2x\sqrt{\mu(\mu-1)}}{\sqrt{5\sigma}} + \frac{\sqrt{5\sigma}}
{2+\sqrt{\mu(\mu-1)}} -2 \right\] \right) \\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \frac{\[2\mu+3\]\sqrt{\sigma}}{\sqrt{20\mu(\mu-1)}}\\ and
\\Var(X) = \sigma\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[dBS8](http://fhernanb.github.io/RelDists/reference/dBS8.md).

## Author

David Villegas Ceballos, <david.villegas1@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma

set.seed(12345)
y <- rBS8(n=10, mu=1.1, sigma=10)

# Fitting the model using default link function
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS8,
               control=gamlss.control(n.cyc=1000))
#> GAMLSS-RS iteration 1: Global Deviance = 50.8552 
#> GAMLSS-RS iteration 2: Global Deviance = 50.8413 
#> GAMLSS-RS iteration 3: Global Deviance = 50.8295 
#> GAMLSS-RS iteration 4: Global Deviance = 50.8196 
#> GAMLSS-RS iteration 5: Global Deviance = 50.8113 
#> GAMLSS-RS iteration 6: Global Deviance = 50.8044 
#> GAMLSS-RS iteration 7: Global Deviance = 50.7986 
#> GAMLSS-RS iteration 8: Global Deviance = 50.7938 
#> GAMLSS-RS iteration 9: Global Deviance = 50.7899 
#> GAMLSS-RS iteration 10: Global Deviance = 50.7866 
#> GAMLSS-RS iteration 11: Global Deviance = 50.7839 
#> GAMLSS-RS iteration 12: Global Deviance = 50.7817 
#> GAMLSS-RS iteration 13: Global Deviance = 50.7794 
#> GAMLSS-RS iteration 14: Global Deviance = 50.7776 
#> GAMLSS-RS iteration 15: Global Deviance = 50.7762 
#> GAMLSS-RS iteration 16: Global Deviance = 50.7751 
#> GAMLSS-RS iteration 17: Global Deviance = 50.7742 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>    1.080822 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    10.56283 

# Fitting again the model using our own link function.
# As mu > 1, we can use
#     link function:    g(mu) = log(mu - 1)
# inv link function: g-1(eta) = exp(eta) + 1

# The following function "log_1_to_inf" is defined with the informatio
# of the link and inv link functions:

if (FALSE) { # \dontrun{

log_1_to_inf <- function() {
  linkfun <- function(mu) { log(mu - 1) }
  linkinv <- function(eta) { 
    thresh <- log(.Machine$double.xmax)
    eta <- pmin(thresh, pmax(eta, -700))
    1 + exp(eta) 
  }
  mu.eta <- function(eta) { 
    thresh <- log(.Machine$double.xmax)
    eta <- pmin(thresh, pmax(eta, -700))
    pmax(exp(eta), .Machine$double.eps)
  }
  valideta <- function(eta) { TRUE }
  link <- "log_1_to_inf"
  structure(list(linkfun = linkfun, linkinv = linkinv, mu.eta = mu.eta,
                 valideta = valideta, name = link), class = "link-gamlss")
}

mod99 <- gamlss(y~1, sigma.fo=~1, 
                family=BS8(mu.link = log_1_to_inf()),
                control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod99, what="mu")) + 1
exp(coef(mod99, what="sigma"))


# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS8
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.6 - 2.4 * x1) + 1  # Aprox 2.45 with link function log(mu - 1)
  sigma <- exp(1.6 + 1.5 * x2)   # Aprox 10 with link function log(sigma)
  y <- rBS8(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(1234)
dat <- gendat(n=400)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS8(mu.link = log_1_to_inf()), 
               data=dat,
               control=gamlss.control(n.cyc=100))

summary(mod2)

} # }
```
