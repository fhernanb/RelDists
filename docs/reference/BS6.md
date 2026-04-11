# The Birnbaum-Saunders family - Santos-Neto et al. (2012) (P4 Based on the mean)

The function `BS6()` defines the Birnbaum-Saunders distribution, a
two-parameter distribution, for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
BS6(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter.

## Value

Returns a `gamlss.family` object which can be used to fit a BS6
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Birnbaum-Saunders distribution with parameters `mu` and `sigma`
(where `mu` represents the true mean and `sigma` represents the shape
parameter \\\alpha\\) has density given by

\\f(x\|\mu,\sigma) =
\frac{\exp(1/\sigma^2)\sqrt{2+\sigma^2}}{4\sigma\sqrt{\pi\mu}x^{3/2}}
\left\[ x + \frac{2\mu}{2+\sigma^2} \right\] \exp\left(
-\frac{1}{2\sigma^2} \left\[ \frac{\\2+\sigma^2\\x}{2\mu} +
\frac{2\mu}{\\2+\sigma^2\\x} \right\] \right)\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \mu\\ and \\Var(X) = \[\mu\sigma\]^2 \left\[
\frac{4+5\sigma^2}{(2+\sigma^2)^2} \right\]\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[dBS6](http://fhernanb.github.io/RelDists/reference/dBS6.md).

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
set.seed(1234)
y <- rBS6(n=50, mu=1, sigma=0.1)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS6)
#> GAMLSS-RS iteration 1: Global Deviance = -57.2301 
#> GAMLSS-RS iteration 2: Global Deviance = -103.3578 
#> GAMLSS-RS iteration 3: Global Deviance = -103.639 
#> GAMLSS-RS iteration 4: Global Deviance = -103.639 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>   0.9896907 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>  0.08714616 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS6
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.5 - 3 * x1)        # Aprox 1
  sigma <- exp(0.5 - 3.5 * x2)   # Aprox 0.1
  y <- rBS6(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

#set.seed(1234)
dat <- gendat(n=100)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS6, data=dat)
#> GAMLSS-RS iteration 1: Global Deviance = 29.3823 
#> GAMLSS-RS iteration 2: Global Deviance = -4.822 
#> GAMLSS-RS iteration 3: Global Deviance = -4.9634 
#> GAMLSS-RS iteration 4: Global Deviance = -4.9636 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("BS6", "Birnbaum-Saunders - Sixth parameterization") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, family = BS6, data = dat) 
#> 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.49231    0.02682   55.65   <2e-16 ***
#> x1          -3.00274    0.03843  -78.13   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   0.5643     0.1462    3.86 0.000203 ***
#> x2           -3.6412     0.2220  -16.40  < 2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  100 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  96 
#>                       at cycle:  4 
#>  
#> Global Deviance:     -4.963569 
#>             AIC:     3.036431 
#>             SBC:     13.45711 
#> ******************************************************************
```
