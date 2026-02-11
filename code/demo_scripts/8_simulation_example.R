# Problem: estimating the SE of the proportion of hatchery fish that returned
# to Deep Creek.  The proportion is estimated from the number of hatchery fish
# that were caught netting, observed through a video weir, and estimated from
# sonar. The sonar counts are estimated with error, and then extrapolated using
# netting data to estimate the number of hatchery fish.

# P_h = (H_below + H_video + (p_n * N_sonar)) /
#       (H_below + N_video + N_sonar)
#
# Note:  p_n AND N_sonar are estimated with error!
#
# So it becomes a big gnarly delta-method calculation that includes a covariance
# term because (p_n * N_sonar)) and (H_below + N_video + N_sonar) are not
# independent.



# Treat these variables as known with no uncertainty
N_video <- 1000
H_below <- 100
H_video <- 300



# Simulate p_n and N_sonar stochastically, and carry these through estimation

# number of replicates for simulation
nsim <- 100000

# simulate p_n as calculated from a Binomial sample
p_n <- rbinom(n=nsim, size=100, p=0.3)/100

# simulate N_sonar
SE_N_sonar <- 300  # this will be used later
N_sonar <- rnorm(n=nsim, mean=3000, sd=SE_N_sonar)

# carry these through calculation!
# we get a vector of estimated hatchery proportions
H_sonar <- p_n * N_sonar
P_h <- (H_below + H_video + (p_n * N_sonar)) /
  (H_below + N_video + N_sonar) # same formula as above



# Side quest: comparing two versions of Goodman's formula
# SE_H_sonar will be used in the variance formula later on

# result is two vectors of estimated SE's
SE_p_n <- sqrt(p_n*(1-p_n)/100) # ignoring FPC for now
SE_H_sonar_1 <- sqrt(((N_sonar^2)*(SE_p_n^2)) +
                       (p_n^2)*(SE_N_sonar^2))   # without the subtraction in Goodman
SE_H_sonar_2 <- sqrt(((N_sonar^2)*(SE_p_n^2)) +
                       (p_n^2)*(SE_N_sonar^2) -
                       (SE_p_n^2)*(SE_N_sonar^2)) # with the subtraction

# comparing two versions of Goodman
par(mfrow=c(1,2))
hist(SE_H_sonar_1)    # distribution of SE_H_sonar_1
abline(v=sd(H_sonar), lwd=3) # vertical line at "true" standard error
hist(SE_H_sonar_2)    # distribution of SE_H_sonar_2
abline(v=sd(H_sonar), lwd=3) # vertical line at "true" standard error

mean(SE_H_sonar_1)  # without the subtraction in Goodman
mean(SE_H_sonar_2)  # with the subtraction
sd(H_sonar)  # actually the first version seems closer!



# Now the PUNCHLINE: using three competing formulas to estimate the SE of the
# hatchery proportion.  For each one, we get a vector of simulated replicates.
# We can COMPARE these distributions to the "actual" SD of the estimator,
# obtained by simulation!

# delta method thing without covariance
SE_P_h_1 <- abs(P_h) * sqrt((SE_H_sonar_1/(H_below + H_video + (p_n*N_sonar)))^2 +
                              (SE_N_sonar/(H_below + N_video + N_sonar))^2)

# trying covariance one way
SE_P_h_2 <- abs(P_h) * sqrt((SE_H_sonar_1/(H_below + H_video + (p_n*N_sonar)))^2 +
                              (SE_N_sonar/(H_below + N_video + N_sonar))^2 -
                              2*(p_n*(SE_N_sonar^2)) /
                              ((H_below + H_video + (p_n*N_sonar))*(H_below + N_video + N_sonar)))

# trying covariance another way
SE_P_h_3 <- abs(P_h) * sqrt((SE_H_sonar_1/(H_below + H_video + (p_n*N_sonar)))^2 +
                              (SE_N_sonar/(H_below + N_video + N_sonar))^2 -
                              2*(SE_H_sonar_1^2) /
                              ((H_below + H_video + (p_n*N_sonar))*(H_below + N_video + N_sonar)))
par(mfrow=c(2,2))
hist(SE_P_h_1)    # distribution of estimator
abline(v=sd(P_h), lwd=3) # vertical line at "true" standard error
hist(SE_P_h_2)
abline(v=sd(P_h), lwd=3)
hist(SE_P_h_3)
abline(v=sd(P_h), lwd=3)

boxplot(SE_P_h_1,SE_P_h_2,SE_P_h_3)
abline(h=sd(P_h), lwd=3)

mean(SE_P_h_1)
mean(SE_P_h_2)
mean(SE_P_h_3)   # this one seems to be closest ....?
sd(P_h)

# here comes the full derived formula!
SE_P_h_derived <- abs(P_h) * sqrt((sqrt((N_sonar^2)*(SE_p_n^2) +
                                          ((p_n^2)*(SE_N_sonar^2)) -
                                          (SE_p_n^2)*(SE_N_sonar^2))/(H_below + H_video + (p_n*N_sonar)))^2 +
                                    ((SE_N_sonar)/(H_below + N_video + N_sonar))^2 -
                                    ((2*p_n*(SE_N_sonar^2))/((H_below + N_video + N_sonar) * (H_below + H_video + (p_n*N_sonar)))))
hist(SE_P_h_derived)
abline(v=sd(P_h), lwd=3)
mean(SE_P_h_derived)
sd(P_h)
