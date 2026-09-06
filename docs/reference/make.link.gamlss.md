# Create a Link for GAMLSS families

The function `make.link.gamlss()` is used with `gamlss.family`
distributions in package gamlss().Given a link, it returns a link
function, an inverse link function, the derivative dpar/deta where 'par'
is the appropriate distribution parameter and a function for checking
the domain. It differs from the usual `make.link` of
[`glm()`](https://rdrr.io/r/stats/glm.html) by having extra links as the
`logshifto1`, and the `own`. For the use of the `own` link see the
example bellow. `show.link` provides a way in which the user can
identify the link functions available for each gamlss distribution. If
your required link function is not available for any of the gamlss
distributions you can add it in.

## Usage

``` r
make.link.gamlss(link)
```

## Arguments

- link:

  character or numeric; one of `"logit"`, `"probit"`, `"cloglog"`,
  `"identity"`, `"log"`, `"sqrt"`, `"1/mu^2"`, `"inverse"`,
  `"logshifted"`, `"logitshifted"`, or number, say lambda resulting in
  power link \\\mu^\lambda\\.

## Value

For the `make.link.gamlss` a list with components

linkfun: Link function `function(parameter)`

linkinv: Inverse link function `function(eta)`

mu.eta: Derivative `function(eta)` dparameter/deta

valideta: `function(eta)` TRUE if all of eta is in the domain of
`linkinv`.

For the `show.link` a list with components the available links for the
distribution parameters

## Details

The `own` link function is added to allow the user greater flexibility.
In order to used the own link function for any of the parameters of the
distribution the `own` link should appear in the available links for
this parameter. You can check this using the function `show.link`. If
the `own` do not appear in the list you can create a new function for
the distribution in which `own` is added in the list. For example the
first line of the code of the binomial distribution, `BI`, has change
from

"mstats \<- checklink("mu.link", "Binomial", substitute(mu.link),
c("logit", "probit", "cloglog", "log")), in version 1.0-0 of gamlss, to

"mstats \<- checklink("mu.link", "Binomial", substitute(mu.link),
c("logit", "probit", "cloglog", "log", "own"))

in version 1.0-1. Given that the parameter has `own` as an option the
user needs also to define the following four new functions in order to
used an `own` link.

i\) own.linkfun

ii\) own.linkinv

iii\) own.mu.eta and

iv\) own.valideta.

An example is given below.

Only one parameter of the distribution at a time is allowed to have its
`own` link, (unless the same four `own` functions above are suitable for
more that one parameter of the distribution).

Note that from gamlss version 1.9-0 the user can introduce its own link
function by define an appropriate function, (see the example below).

## Note

For the links involving parameters as in `logshifted` and `logitshifted`
the parameters can be passed in the definition of the distribution by
calling the ` checklink` function, for example in the definition of the
`tau` parameter in BCPE distribution the following call is made:
`tstats <- checklink("tau.link", "Box Cox Power Exponential", substitute(tau.link), c("logshifted", "log", "identity"), par.link = c(1)) `

This function is the same `make.link.gamlss` fuction from gamlss.dist
package.
