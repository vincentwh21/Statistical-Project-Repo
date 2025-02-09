
# Load necessary libraries
library(stats)

# Define expected returns and covariance matrix
mu <- c(0.08, 0.13)  # Expected returns

Sigma <- matrix(c(0.0144, 0.00005184,
                  0.00005184, 0.04
                  ), nrow = length(mu), byrow = TRUE)  # Covariance matrix


# Define risk-free rate
Rf <- 0.03  # Risk-free rate


# objective function, maximun the sharpe ratio.
sharpe_ratio <- function(x) {
    w <- c(x, 1-sum(x))
    Rp <- sum(w * mu)
    Sigma_p <- sqrt(sum(w %*% Sigma %*% w))
    return((Rp - Rf)/Sigma_p)
}


# Constraints
n <- length(mu)-1  # For example, we want to generate a 5th order identity matrix
I <- diag(n)
C <- matrix(c(rep(-1, n)), nrow = 1)
ui = rbind(-C, C, -I, I, C)
# ui
ci = c(0, -2, rep(-1, 2*n), -1)
# ci
# AX - b > 0, here A=ui, b=ci, each asset's weight should bigger than -1 and smaller than 1, besides there sum should smaller than 1.



# Initial weights
init_w <- c(rep(1/length(mu), length(mu)-1))
# init_w
# Optimization function
# Solve with simulated annealing algorithm
solution <- constrOptim(init_w, sharpe_ratio, ui = ui, ci = ci, method = "SANN")
# solution
weight = c(solution$par, 1-sum(solution$par))
print('weight')
print(weight) # Weights for each asset
RP = sum(weight * mu)
# Expected return of the portfolio

