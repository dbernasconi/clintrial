#' Compute the n2 and Theta_stop values
#'
#' TESTS FOR THIS FUNCTION HAVE TO BE WRITTEN!
#'
#' @param HR_eff HR threshold for efficacy
#' @param HR_ineff HR threshold for inefficacy
#' @param PoS_go Probability of Success for Go decision
#' @param PoS_nogo Probability of Success for NoGo decision
#'
#' @return A list with the values Theta_eff, Theta_ineff,
#' Go, NoGo, n2, Theta_stop
#' @export
get_n2_theta_stop = function(
  HR_eff = 0.55,
  HR_ineff = 0.9,
  PoS_go = 0.9,
  PoS_nogo = 0.85){

  Theta_eff   <- -log(HR_eff)
  Theta_ineff <- -log(HR_ineff)

  Go   <- qnorm(PoS_go, mean = 0,  sd = 1)
  NoGo <- qnorm(PoS_nogo, mean = 0, sd = 1)

  Theta_stop <- (NoGo * Theta_eff + Go * Theta_ineff)/(Go + NoGo)
  n2         <- ceiling(( Go * 2/( Theta_eff - Theta_stop))^2)

  # Return as a list as this will be used
  # in a data.table, running the computation
  # by row
  return(list(Theta_eff = Theta_eff,
              Theta_ineff = Theta_ineff,
              Go = Go, NoGo = NoGo,
              n2 = n2, Theta_stop = Theta_stop))
}
