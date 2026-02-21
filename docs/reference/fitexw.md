# Auxiliar function for the Ex-Wald distribution

This function generates starting values.

## Usage

``` r
fitexw(rt, p = 0.5, start = exwstpt(rt, p), scaleit = TRUE)
```

## Arguments

- rt:

  a vector with the random sample.

- p:

  a value for p.

- start:

  an optional start vector.

- scaleit:

  logical value to scale.

## Value

returns a vector with cumulative probabilities.
