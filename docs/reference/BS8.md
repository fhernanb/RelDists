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
y <- rBS8(n=100, mu=2, sigma=10)

# Fitting the model using default link function
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS8,
               control=gamlss.control(n.cyc=1000))
#> GAMLSS-RS iteration 1: Global Deviance = 444.115 
#> GAMLSS-RS iteration 2: Global Deviance = 443.9331 
#> GAMLSS-RS iteration 3: Global Deviance = 443.8642 
#> GAMLSS-RS iteration 4: Global Deviance = 443.8386 
#> GAMLSS-RS iteration 5: Global Deviance = 443.8286 
#> GAMLSS-RS iteration 6: Global Deviance = 443.8247 
#> GAMLSS-RS iteration 7: Global Deviance = 443.8234 
#> GAMLSS-RS iteration 8: Global Deviance = 443.8227 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>    2.154669 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    12.18536 

# Fitting the model using a own link function

# 1. Extract the built-in "logshiftto1" link structure
if (FALSE) { # \dontrun{
require(gamlss.dist)
logshift_link <- make.link.gamlss("logshiftto1")

# 2. Assign its components to the 'own' functions gamlss searches for
own.linkfun  <- logshift_link$linkfun
own.linkinv  <- logshift_link$linkinv
own.mu.eta   <- logshift_link$mu.eta
own.valideta <- logshift_link$valideta

mod99 <- gamlss(y~1, sigma.fo=~1, family=BS8(mu.link = "own"),
                control=gamlss.control(n.cyc=1000))

# Extracting the fitted values for mu and sigma
# using the inverse link function
own.linkinv(coef(mod99, what="mu"))
exp(coef(mod00, what="sigma"))
} # }

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS8
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.6 - 1.4 * x1)     # Aprox 2.45 with link log(mu)
  sigma <- exp(1.6 + 1.5 * x2)  # Aprox 10
  y <- rBS8(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(1234)
dat <- gendat(n=400)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS8, data=dat,
               control=gamlss.control(n.cyc=100))
#> GAMLSS-RS iteration 1: Global Deviance = 1605.362 
#> GAMLSS-RS iteration 2: Global Deviance = 1604.067 
#> GAMLSS-RS iteration 3: Global Deviance = 1603.501 
#> GAMLSS-RS iteration 4: Global Deviance = 1603.259 
#> GAMLSS-RS iteration 5: Global Deviance = 1603.156 
#> GAMLSS-RS iteration 6: Global Deviance = 1603.112 
#> GAMLSS-RS iteration 7: Global Deviance = 1603.093 
#> GAMLSS-RS iteration 8: Global Deviance = 1603.084 
#> GAMLSS-RS iteration 9: Global Deviance = 1603.08 
#> GAMLSS-RS iteration 10: Global Deviance = 1603.079 
#> GAMLSS-RS iteration 11: Global Deviance = 1603.078 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("BS8", "Birnbaum-Saunders - Seventh parameterization") 
#> 
#> Call:  
#> gamlss(formula = y ~ x1, sigma.formula = ~x2, family = BS8, data = dat,  
#>     control = gamlss.control(n.cyc = 100)) 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.63427    0.06026   27.12   <2e-16 ***
#> x1          -1.40909    0.07351  -19.17   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   1.7446     0.1540  11.326  < 2e-16 ***
#> x2            1.2384     0.2816   4.398  1.4e-05 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  400 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  396 
#>                       at cycle:  11 
#>  
#> Global Deviance:     1603.078 
#>             AIC:     1611.078 
#>             SBC:     1627.044 
#> ******************************************************************
```
