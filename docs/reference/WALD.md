# The Wald family

The function `WALD()` defines the wALD distribution, two-parameter
continuous distribution for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
WALD(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a WALD
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Wald distribution with parameters \\\mu\\ and \\sigma\\ has density
given by

\\\operatorname{f}(x \|\mu, \sigma)=\frac{\sigma}{\sqrt{2 \pi x^3}} \exp
\left\[-\frac{(\sigma-\mu x)^2}{2x}\right \], x\>0 \\

## References

Heathcote, A. (2004). Fitting Wald and ex-Wald distributions to response
time data: An example using functions for the S-PLUS package. Behavior
Research Methods, Instruments, & Computers, 36, 678-694.

## See also

[dWALD](http://fhernanb.github.io/RelDists/reference/dWALD.md).

## Author

Sofia Cuartas García, <scuartasg@unal.edu.co>

## Examples

``` r
# Example 1
# Generating random values with
# known mu and sigma
require(gamlss)
mu <- 1.5
sigma <- 4.0

y <- rWALD(10000, mu, sigma)

mod1 <- gamlss(y~1, sigma.fo=~1,  family="WALD",
               control=gamlss.control(n.cyc=5000, trace=TRUE))
#> GAMLSS-RS iteration 1: Global Deviance = 27615.04 
#> GAMLSS-RS iteration 2: Global Deviance = 27614.47 
#> GAMLSS-RS iteration 3: Global Deviance = 27614.15 
#> GAMLSS-RS iteration 4: Global Deviance = 27613.96 
#> GAMLSS-RS iteration 5: Global Deviance = 27613.86 
#> GAMLSS-RS iteration 6: Global Deviance = 27613.8 
#> GAMLSS-RS iteration 7: Global Deviance = 27613.76 
#> GAMLSS-RS iteration 8: Global Deviance = 27613.74 
#> GAMLSS-RS iteration 9: Global Deviance = 27613.73 
#> GAMLSS-RS iteration 10: Global Deviance = 27613.73 
#> GAMLSS-RS iteration 11: Global Deviance = 27613.72 
#> GAMLSS-RS iteration 12: Global Deviance = 27613.72 
#> GAMLSS-RS iteration 13: Global Deviance = 27613.72 
#> GAMLSS-RS iteration 14: Global Deviance = 27613.72 

exp(coef(mod1, what="mu"))
#> (Intercept) 
#>    1.516884 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>     4.04953 

# Example 2
# Generating random values under some model

# A function to simulate a data set with Y ~ WALD
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(0.75 - 0.69 * x1)   # Approx 1.5
  sigma <- exp(0.5 - 0.64 * x2) # Approx 1.20
  y <- rWALD(n, mu, sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

dat <- gendat(n=200)

mod2 <- gamlss(y~x1, sigma.fo=~x2, family=WALD, data=dat, 
               control=gamlss.control(n.cyc=5000, trace=TRUE))
#> GAMLSS-RS iteration 1: Global Deviance = 170.7837 
#> GAMLSS-RS iteration 2: Global Deviance = 169.0064 
#> GAMLSS-RS iteration 3: Global Deviance = 168.5824 
#> GAMLSS-RS iteration 4: Global Deviance = 168.4765 
#> GAMLSS-RS iteration 5: Global Deviance = 168.45 
#> GAMLSS-RS iteration 6: Global Deviance = 168.4428 
#> GAMLSS-RS iteration 7: Global Deviance = 168.4408 
#> GAMLSS-RS iteration 8: Global Deviance = 168.4402 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("WALD", "Wald") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, family = WALD,  
#>     data = dat, control = gamlss.control(n.cyc = 5000, trace = TRUE)) 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  0.79257    0.08098   9.788  < 2e-16 ***
#> x1          -0.58544    0.16660  -3.514 0.000547 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  0.43786    0.06833   6.408 1.06e-09 ***
#> x2          -0.56247    0.12511  -4.496 1.18e-05 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  200 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  196 
#>                       at cycle:  8 
#>  
#> Global Deviance:     168.4402 
#>             AIC:     176.4402 
#>             SBC:     189.6335 
#> ******************************************************************
```
