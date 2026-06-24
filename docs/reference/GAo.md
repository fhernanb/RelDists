# The gamma family in its original parameterization

The function `GAo()` defines The gamma, a two parameter distribution,
for a `gamlss.family` object to be used in GAMLSS fitting using the
function [`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
GAo(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a GAo
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The gamma original with parameters `mu` and `sigma` has density given by

\\f(x\|\mu,\sigma) = \frac{x^{\mu-1}e^{-x/\sigma}}{\sigma^\mu
\Gamma(\mu)}\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. The parameter \\\mu\\ is the
shape parameter and \\\sigma\\ is the scale parameter. In this
parameterization \\\mu\\ is the median of \\X\\, \\E(X)=\mu \sigma\\ and
\\Var(X)=\mu \sigma^2\\.

## References

Abramowitz M, Stegun IA (1972). Handbook of Mathematical Functions with
Formulas, Graphs, and Mathematical Tables. Dover Publications, New York.
ISBN 0486612724. Chapter 6: Gamma and Related Functions.

## See also

[dGAo](http://fhernanb.github.io/RelDists/reference/dGAo.md)

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
y <- rGAo(n=100, mu=0.75, sigma=1.3)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=GAo)
#> GAMLSS-RS iteration 1: Global Deviance = 164.6782 
#> GAMLSS-RS iteration 2: Global Deviance = 164.5394 
#> GAMLSS-RS iteration 3: Global Deviance = 164.5074 
#> GAMLSS-RS iteration 4: Global Deviance = 164.4999 
#> GAMLSS-RS iteration 5: Global Deviance = 164.4982 
#> GAMLSS-RS iteration 6: Global Deviance = 164.4978 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>   0.6511692 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    1.382083 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y as GAo
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.45 - 3 * x1)
  sigma <- exp(2 - 1.5 * x2)
  y <- rGAo(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=500)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=GAo, data=dat)
#> GAMLSS-RS iteration 1: Global Deviance = 1978.968 
#> GAMLSS-RS iteration 2: Global Deviance = 1920.325 
#> GAMLSS-RS iteration 3: Global Deviance = 1892.894 
#> GAMLSS-RS iteration 4: Global Deviance = 1879.324 
#> GAMLSS-RS iteration 5: Global Deviance = 1872.392 
#> GAMLSS-RS iteration 6: Global Deviance = 1868.778 
#> GAMLSS-RS iteration 7: Global Deviance = 1866.87 
#> GAMLSS-RS iteration 8: Global Deviance = 1865.852 
#> GAMLSS-RS iteration 9: Global Deviance = 1865.306 
#> GAMLSS-RS iteration 10: Global Deviance = 1865.012 
#> GAMLSS-RS iteration 11: Global Deviance = 1864.853 
#> GAMLSS-RS iteration 12: Global Deviance = 1864.767 
#> GAMLSS-RS iteration 13: Global Deviance = 1864.72 
#> GAMLSS-RS iteration 14: Global Deviance = 1864.695 
#> GAMLSS-RS iteration 15: Global Deviance = 1864.681 
#> GAMLSS-RS iteration 16: Global Deviance = 1864.673 
#> GAMLSS-RS iteration 17: Global Deviance = 1864.669 
#> GAMLSS-RS iteration 18: Global Deviance = 1864.667 
#> GAMLSS-RS iteration 19: Global Deviance = 1864.666 
#> GAMLSS-RS iteration 20: Global Deviance = 1864.665 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("GAo", "gamma original") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, family = GAo, data = dat) 
#> 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.51563    0.05195   29.17   <2e-16 ***
#> x1          -3.05109    0.11392  -26.78   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  2.06855    0.07408   27.93   <2e-16 ***
#> x2          -1.78364    0.13022  -13.70   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  500 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  496 
#>                       at cycle:  20 
#>  
#> Global Deviance:     1864.665 
#>             AIC:     1872.665 
#>             SBC:     1889.523 
#> ******************************************************************
```
