# The Ex-Wald family

The function `ExWALD()` defines the Ex-wALD distribution,
three-parameter continuous distribution for a `gamlss.family` object to
be used in GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
ExWALD(mu.link = "log", sigma.link = "log", nu.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter.

- nu.link:

  defines the nu.link, with "log" link as the default for the nu
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a Ex-WALD
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Ex-Wald distribution with parameters \\\mu\\, \\\sigma\\ and \\\nu\\
has density given by

\\f(x \|\mu, \sigma, \nu) = \frac{1}{\nu} \exp(\frac{-x}{\nu} +
\sigma(\mu-k)) F_W(x\|k, \sigma) \\ \text{for} \\ k \geq 0\\

\\f(x \|\mu, \sigma, \nu) = \frac{1}{\nu} \exp\left(
\frac{-(\sigma-\mu)^2}{2x} \right) Re \left( w(k^\prime \sqrt{x/2} +
\frac{\sigma i}{\sqrt{2x}}) \right) \\ \text{for} \\ k \< 0\\

where \\k=\sqrt{\mu^2-\frac{2}{\nu}}\\,
\\k^\prime=\sqrt{\frac{2}{\nu}-\mu^2}\\ and \\F_W\\ corresponds to the
cumulative function of the Wald distribution.

More details about those expressions can be found on page 680 from
Heathcote (2004).

## References

Schwarz, W. (2001). The ex-Wald distribution as a descriptive model of
response times. Behavior Research Methods, Instruments, & Computers, 33,
457-469.

Heathcote, A. (2004). Fitting Wald and ex-Wald distributions to response
time data: An example using functions for the S-PLUS package. Behavior
Research Methods, Instruments, & Computers, 36, 678-694.

## See also

[dExWALD](http://fhernanb.github.io/RelDists/reference/dExWALD.md).

## Author

Freddy Hernandez, <fhernanb@unal.edu.co>

## Examples

``` r
# Example 1
# Generating random values with
# known mu, sigma and nu

mu <- 0.20
sigma <- 70
nu <- 115

set.seed(123)
y <- rExWALD(n=100, mu, sigma, nu)

library(gamlss)
mod1 <- gamlss(y~1, family=ExWALD,
               control=gamlss.control(n.cyc=1000, trace=TRUE))
#> GAMLSS-RS iteration 1: Global Deviance = 1258.666 

exp(coef(mod1, what="mu"))
#> (Intercept) 
#>   0.2392296 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>     74.6907 
exp(coef(mod1, what="nu"))
#> (Intercept) 
#>     129.982 

# Example 2
# Generating random values under some model

# \donttest{
# A function to simulate a data set with Y ~ ExWALD
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu    <- exp(-1 + 2.8 * x1) # 1.5 approximately
  sigma <- exp( 1 - 1.2 * x2) # 1.5 approximately
  nu    <- 2
  y <- rExWALD(n=n, mu=mu, sigma=sigma, nu=nu)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(1234)
dat <- gendat(n=200)

# Fitting the model
mod2 <- gamlss(y ~ x1,
               sigma.fo = ~ x2,
               nu.fo = ~ 1,
               family = ExWALD,
               data = dat,
               control = gamlss.control(n.cyc=1000, 
                                        trace=TRUE))
#> GAMLSS-RS iteration 1: Global Deviance = 822.0462 
#> GAMLSS-RS iteration 2: Global Deviance = 819.875 
#> GAMLSS-RS iteration 3: Global Deviance = 818.6914 
#> GAMLSS-RS iteration 4: Global Deviance = 817.9948 
#> GAMLSS-RS iteration 5: Global Deviance = 817.6103 
#> GAMLSS-RS iteration 6: Global Deviance = 817.4151 
#> GAMLSS-RS iteration 7: Global Deviance = 817.3221 
#> GAMLSS-RS iteration 8: Global Deviance = 817.28 
#> GAMLSS-RS iteration 9: Global Deviance = 817.2608 
#> GAMLSS-RS iteration 10: Global Deviance = 817.2515 
#> GAMLSS-RS iteration 11: Global Deviance = 817.2476 
#> GAMLSS-RS iteration 12: Global Deviance = 817.246 
#> GAMLSS-RS iteration 13: Global Deviance = 817.2453 
summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("ExWALD", "Ex-Wald") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, nu.formula = ~1,  
#>     family = ExWALD, data = dat, control = gamlss.control(n.cyc = 1000,  
#>         trace = TRUE)) 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  -0.9079     0.1767  -5.139 6.59e-07 ***
#> x1            2.2407     0.3472   6.453 8.25e-10 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   0.8353     0.1504   5.553 8.95e-08 ***
#> x2           -0.6647     0.2863  -2.322   0.0212 *  
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> ------------------------------------------------------------------
#> Nu link function:  log 
#> Nu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  0.63266    0.09008   7.023 3.36e-11 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  200 
#> Degrees of Freedom for the fit:  5
#>       Residual Deg. of Freedom:  195 
#>                       at cycle:  13 
#>  
#> Global Deviance:     817.2453 
#>             AIC:     827.2453 
#>             SBC:     843.7368 
#> ******************************************************************
# }
```
