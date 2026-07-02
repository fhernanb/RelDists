# logLik_GL2

Auxiliary function to compute the log-likelihood of the GL2
distribution.

## Usage

``` r
logLik_GL2(param = c(0, 0), x)
```

## Arguments

- param:

  Numeric vector containing the values of the parameters

- x:

  Numeric vector containing the observations.

## Examples

``` r
y <- rGL2(n = 100, mu = 3, sigma = 1.2)
logLik_GL2(param = c(0, 0), x = y)
#> [1] -37.95071
```
