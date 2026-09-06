# Set the Right Link Function for Specified Parameter and Distribution

This function is used within the distribution family specification of a
GAMLSS model to define the right link for each of the parameters of the
distribution. This function should not be called by the user unless
he/she specify a new distribution family or wishes to change existing
link functions in the parameters.

## Usage

``` r
checklink(which.link = NULL, which.dist = NULL, link = NULL, link.List = NULL)
```

## Arguments

- which.link:

  which parameter link e.g. `which.link="mu.link"`

- which.dist:

  which distribution family e.g. `which.dist="Cole.Green"`

- link:

  a repetition of `which.link` e.g. `link=substitute(mu.link)`

- link.List:

  what link function are required e.g.
  `link.List=c("inverse", "log", "identity")`

## Value

Defines the right link for each parameter.

## Details

This function is the same `checklink` fuction from gamlss.dist package.
