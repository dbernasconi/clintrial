#' Compute the probability of Success?
#'
#' Obviously I would need to read the paper again
#' TESTS FOR THIS FUNCTION HAVE TO BE WRITTEN!
#'
#' @param Theta_stop Theta_stop value
#' @param Theta_eff Theta_eff value
#' @param n2 n2 value
#' @param n3 n2 value
#' @param alpha alpha value
#'
#' @return A scalar value that is the probability of
#' Success?
#' @export
get_pos = function(Theta_stop = 0.32,
                   Theta_eff = 0.59,
                     n2 = 89,
                     n3 = 90,
                     alpha = 0.05){

  low   <- 2 * qnorm((1 - alpha/2), mean=0, sd=1)/ sqrt(n3)
  sigma <- matrix(c(4/n2, 4/n3, 4/n3, 4/n3), nrow=2, ncol=2)

  pos   <- pmvnorm(lower =c(Theta_stop, low),
                   upper = c(Inf, Inf),
                   mean  = c(Theta_eff, Theta_eff),
                   sigma = sigma)
  return(pos[1])
}
