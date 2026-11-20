# logLik_MCWEI

This is an auxiliar function to obtain the logLik for MCWEI

## Usage

``` r
logLik_MCWEI(param = c(0, 0, 1), x)
```

## Arguments

- x:

  vector with the data

- logparam:

  vector with the values for mu, sigma and nu

## Examples

``` r
y <- rMCWEI(n=100, mu=1, sigma=1, nu=1)
logLik_MCWEI(param=c(0, 0, 1), x=y)
#> [1] -54.12456
```
