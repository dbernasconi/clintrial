# Enter the combinations you would like to test
# The computation will be performed for each
# combination of these parameters (+ the
# additional combinations of n3 if more than
# 1 n3 value per combination is created later)
HR_eff    <- c(0.50,0.55,0.65)
HR_ineff  <- c(0.9,1)
PoS_go    <- 0.9
PoS_nogo  <- 0.85
alpha     <- 0.05

# Create a data.table of all combinations
# Might require to remove the lines that
# are impossible? i.e. with combinations
# that don't make sense.
d = CJ(HR_eff, HR_ineff, PoS_go, PoS_nogo, alpha)

# Compute the n2 and Theta_stop values for
# each combination, i.e. each line, in  d.
# Other derived values are also saved in d
cols_created = c("Theta_eff", "Theta_ineff", "Go", "NoGo", "n2", "Theta_stop")
d[, col_created := get_n2_theta_stop(HR_eff = HR_eff, HR_ineff = HR_ineff,
              PoS_go = PoS_go, PoS_nogo = PoS_go), 1:NROW(d)]

# If more n3 needs to be created for each combination
# of parameters, repeat the lines with the different
# n3 values generated. Then remove the lines where the
# n3 are < n2
nmax <- 300
d = d[, .(n3 = n2:nmax), by = names(d)][n2 < n3]

# Compute the POS for each combination
# of parameters, i.e. each line of the
# data.table d, return the output in
# a new column name POS
d[, POS := get_pos(stop = Theta_stop, theta_eff = Theta_eff,
                    n2 =  n2, n3 = n3, alpha = alpha), 1:NROW(d)]




