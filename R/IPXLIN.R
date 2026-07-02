#' IPXLIN
#' 
#' Esta funcion sirve para obtener la suma de dos numeros reales.
#' 
#' @param x A number.
#' @param y A number.
#' @return The sum of \code{x} and \code{y}.
#' @examples
#' mean(c(4, 6, 8, 9, 2))
#' @export
IPXLIN <- function(x, y) {
  res <- x + y
  class(res) <- 'sumita'
  res
}
