# The Inverse Power XLindley family - Hassan et al. (2025)

The Inverse Power XLindley family

## Usage

``` r
IPXLIN(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "logit" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a IPXLIN
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Inverse Power XLindley distribution with parameters `mu`, and
`sigma` has density given by

\\f(x\|\mu,\sigma) = \frac{\sigma \mu^2}{(1+\mu)^2} x^{-2\sigma-1}
\left(1 + (2+\mu) x^\sigma\right) e^{-\mu x^{-\sigma}}\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\\mu\\ is the scale parameter and \\\sigma\\ is the shape parameter.

## References

Hassan, A. S., Alsadat, N., Chesneau, C., Elgarhy, M., Kayid, M.,
Nasiru, S., & Gemeay, A. M. (2025). Inverse power XLindley distribution
with statistical inference and applications to engineering data.
Scientific Reports, 15, 4385.

## See also

[dIPXLIN](http://fhernanb.github.io/RelDists/reference/dIPXLIN.md)

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
y <- rIPXLIN(n=500, mu=0.5, sigma=3.5)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=IPXLIN)
#> GAMLSS-RS iteration 1: Global Deviance = 329.6102 
#> GAMLSS-RS iteration 2: Global Deviance = 160.1532 
#> GAMLSS-RS iteration 3: Global Deviance = 127.0792 
#> GAMLSS-RS iteration 4: Global Deviance = 118.9893 
#> GAMLSS-RS iteration 5: Global Deviance = 116.8421 
#> GAMLSS-RS iteration 6: Global Deviance = 116.2472 
#> GAMLSS-RS iteration 7: Global Deviance = 116.0796 
#> GAMLSS-RS iteration 8: Global Deviance = 116.0322 
#> GAMLSS-RS iteration 9: Global Deviance = 116.0184 
#> GAMLSS-RS iteration 10: Global Deviance = 116.0143 
#> GAMLSS-RS iteration 11: Global Deviance = 116.0132 
#> GAMLSS-RS iteration 12: Global Deviance = 116.0128 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>   0.5118845 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    3.367427 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y as BS
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.45 - 3 * x1)
  sigma <- exp(2 - 1.5 * x2)
  y <- rIPXLIN(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=300)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=IPXLIN, data=dat)
#> GAMLSS-RS iteration 1: Global Deviance = 325.1332 
#> GAMLSS-RS iteration 2: Global Deviance = 222.9418 
#> GAMLSS-RS iteration 3: Global Deviance = 202.5761 
#> GAMLSS-RS iteration 4: Global Deviance = 197.7071 
#> GAMLSS-RS iteration 5: Global Deviance = 196.4548 
#> GAMLSS-RS iteration 6: Global Deviance = 196.1195 
#> GAMLSS-RS iteration 7: Global Deviance = 196.0304 
#> GAMLSS-RS iteration 8: Global Deviance = 196.0063 
#> GAMLSS-RS iteration 9: Global Deviance = 195.9992 
#> GAMLSS-RS iteration 10: Global Deviance = 195.9972 
#> GAMLSS-RS iteration 11: Global Deviance = 195.9966 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("IPXLIN", "Inverse Power XLindley") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, family = IPXLIN,  
#>     data = dat) 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   1.5555     0.1108   14.04   <2e-16 ***
#> x1           -3.2734     0.1752  -18.69   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  2.04708    0.05681   36.03   <2e-16 ***
#> x2          -1.60679    0.10691  -15.03   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  300 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  296 
#>                       at cycle:  11 
#>  
#> Global Deviance:     195.9966 
#>             AIC:     203.9966 
#>             SBC:     218.8117 
#> ******************************************************************
```
