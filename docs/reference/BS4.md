# The Birnbaum-Saunders family - Second parameterization (Ahmed et al., 2008)

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

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

Ahmed, S. E., et al. (2008). Inference in an applied accelerated life
test model based on the Birnbaum-Saunders distribution. Journal of
Statistical Computation and Simulation, 78(9), 809-823.

## See also

[dBS4](http://fhernanb.github.io/RelDists/reference/dBS4.md).

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
y <- rBS4(n=50, mu=2, sigma=0.2)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS4)
#> GAMLSS-RS iteration 1: Global Deviance = 395.6641 
#> GAMLSS-RS iteration 2: Global Deviance = -55.8409 
#> GAMLSS-RS iteration 3: Global Deviance = -59.0774 
#> GAMLSS-RS iteration 4: Global Deviance = -59.0818 
#> GAMLSS-RS iteration 5: Global Deviance = -59.0822 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>     1.77518 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>   0.2094059 

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
# The response variable is the ratio between the average
# rent per acre planted with alfalfa and the corresponding 
# average rent for other agricultural uses. The density of
# dairy cows (X2, number per square mile) is the explanatory variable. 
library(alr4)
data("landrent")

landrent$ratio <- landrent$Y / landrent$X1

with(landrent, plot(x=X2, y=ratio))


mod3 <- gamlss(ratio~X2, sigma.fo=~X2, 
               data=landrent, family=BS4)
#> GAMLSS-RS iteration 1: Global Deviance = 1395.121 
#> GAMLSS-RS iteration 2: Global Deviance = -14.2602 
#> GAMLSS-RS iteration 3: Global Deviance = -18.2044 
#> GAMLSS-RS iteration 4: Global Deviance = -20.8799 
#> GAMLSS-RS iteration 5: Global Deviance = -22.7862 
#> GAMLSS-RS iteration 6: Global Deviance = -24.1204 
#> GAMLSS-RS iteration 7: Global Deviance = -25.1446 
#> GAMLSS-RS iteration 8: Global Deviance = -25.8749 
#> GAMLSS-RS iteration 9: Global Deviance = -26.4526 
#> GAMLSS-RS iteration 10: Global Deviance = -26.8795 
#> GAMLSS-RS iteration 11: Global Deviance = -27.1737 
#> GAMLSS-RS iteration 12: Global Deviance = -27.4248 
#> GAMLSS-RS iteration 13: Global Deviance = -27.614 
#> GAMLSS-RS iteration 14: Global Deviance = -27.7493 
#> GAMLSS-RS iteration 15: Global Deviance = -27.858 
#> GAMLSS-RS iteration 16: Global Deviance = -27.945 
#> GAMLSS-RS iteration 17: Global Deviance = -28.0197 
#> GAMLSS-RS iteration 18: Global Deviance = -28.0776 
#> GAMLSS-RS iteration 19: Global Deviance = -28.1229 
#> GAMLSS-RS iteration 20: Global Deviance = -28.1585 
#> Warning: Algorithm RS has not yet converged

summary(mod3)
#> ******************************************************************
#> Family:  c("BS4", "Birnbaum-Saunders - Fourth parameterization") 
#> 
#> Call:  gamlss(formula = ratio ~ X2, sigma.formula = ~X2, family = BS4,  
#>     data = landrent) 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.920946   0.165953  11.575   <2e-16 ***
#> X2          -0.016821   0.007065  -2.381   0.0203 *  
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.628314   0.150971  10.786 6.03e-16 ***
#> X2          -0.004896   0.005928  -0.826    0.412    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  67 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  63 
#>                       at cycle:  20 
#>  
#> Global Deviance:     -28.15848 
#>             AIC:     -20.15848 
#>             SBC:     -11.33971 
#> ******************************************************************
logLik(mod3)
#> 'log Lik.' 14.07924 (df=4)
```
