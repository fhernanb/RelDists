# FWE distribution

``` r

library(RelDists)
#> Loading required package: survival
#> Loading required package: EstimationTools
#> 
#> ><<<<<<<<<<<<<<<<<<<<<<<<   EstimationTools Version 4.3.1   >>>>>>>>>>>>>>>>>>>>>>>><
#>   Feel free to report bugs in https://github.com/Jaimemosg/EstimationTools/issues
```

## Flexible Weibull extension distribution

This distribution was proposed by Bebbington (2007). The probability
density function \\f(x)\\ and cumulative density function \\F(x)\\ are
given by:

\\f(x) = \left( \mu+ \frac{\sigma}{x^2} \right) e^{\mu x - \sigma / x}
\exp \left( -e^{\mu x - \sigma / x} \right),\\

and

\\F(x) = 1 - \exp\[-e^{\mu x - \sigma / x}\], \quad x \> 0.\\

respectively, where \\\mu \> 0\\, \\\sigma \> 0\\ and \\x \> 0\\.

Next figure shows possible shapes of the \\f(x)\\ and \\F(x)\\ for
several values of the parameters.

![Pdf and cdf for the FWE distribution.
](FWE_distribution_files/figure-html/unnamed-chunk-2-1.png)

Bebbington, M., C. D. Lai, and R. Zitikis. 2007. “A Flexible Weibull
Extension.” *Reliability Engineering & System Safety* 92 (6): 719–26.
