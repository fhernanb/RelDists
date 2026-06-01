# The Birnbaum-Saunders family - Santos-Neto et al. (2012) (P3 Based on GLM)

The function `BS5()` defines the Birnbaum-Saunders distribution, a
two-parameter distribution, for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
BS5(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter.

## Value

Returns a `gamlss.family` object which can be used to fit a BS5
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Birnbaum-Saunders distribution with parameters `mu` and `sigma`
(where `sigma` represents the precision parameter \\\delta\\) has
density given by

\\f(x\|\mu,\sigma) =
\frac{\exp(\sigma/2)\sqrt{\sigma+1}}{4\sqrt{\pi\mu}x^{3/2}} \left\[ x +
\frac{\sigma\mu}{\sigma+1} \right\] \exp\left( -\frac{\sigma}{4} \left\[
\frac{x(\sigma+1)}{\sigma\mu} + \frac{\sigma\mu}{x(\sigma+1)} \right\]
\right)\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \mu\\ and \\Var(X) = \mu^2 \left\[
\frac{2\sigma+5}{(\sigma+1)^2} \right\]\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[dBS5](http://fhernanb.github.io/RelDists/reference/dBS5.md).

## Author

David Villegas Ceballos, <david.villegas1@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
set.seed(123)
y <- rBS5(n=50, mu=1, sigma=25)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS5)
#> GAMLSS-RS iteration 1: Global Deviance = 194.6918 
#> GAMLSS-RS iteration 2: Global Deviance = 61.6892 
#> GAMLSS-RS iteration 3: Global Deviance = 12.4636 
#> GAMLSS-RS iteration 4: Global Deviance = 12.4627 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>    1.025871 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    25.43131 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS5
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.5 - 3 * x1)        # Aprox 1
  sigma <- exp(2.4 + 1.7 * x2)   # Aprox 25
  y <- rBS5(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

dat <- gendat(n=100)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS5, data=dat)
#> GAMLSS-RS iteration 1: Global Deviance = 234.6313 
#> GAMLSS-RS iteration 2: Global Deviance = 115.8122 
#> GAMLSS-RS iteration 3: Global Deviance = 36.5612 
#> GAMLSS-RS iteration 4: Global Deviance = 27.2053 
#> GAMLSS-RS iteration 5: Global Deviance = 27.083 
#> GAMLSS-RS iteration 6: Global Deviance = 27.082 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("BS5", "Birnbaum-Saunders - Fifth parameterization") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, family = BS5, data = dat) 
#> 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.52286    0.05541   27.48   <2e-16 ***
#> x1          -3.08990    0.10621  -29.09   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   2.3499     0.3196   7.352 5.96e-11 ***
#> x2            1.5418     0.6240   2.471   0.0152 *  
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  100 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  96 
#>                       at cycle:  6 
#>  
#> Global Deviance:     27.08202 
#>             AIC:     35.08202 
#>             SBC:     45.5027 
#> ******************************************************************
```
