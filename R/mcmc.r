
metrop.rwalker.proposal.fun <- function(theta){
  # finding the right scaling factor is more of an art than science
  # or try and error to look for the best fit on acceptance %

  return(theta+rnorm(length(theta))*2.38)   # random walk with scale factor 2.38
}

hamiltonian.proposal.fun <- function(theta){
  #forget it.. it is a good theory
  # H(q, p) = U(q) + K(p) .. the potential and kinetic energy
  # simulate data by the way of the physical system moves than a random walk
  # faster convergence
  # more parameters to worry: epsilon, M, t, L
  # not to mention the change of proposal..
  #   U(q) = -log[pi(q) * L(q|D)]
  # hmc proposal and actual simulation is tight up
  #  condition:
  #     runif(1) < exp(-U(q*)+U(q)-K(p*)+K(p))
  # no to mention the painful gradient (log likelihood function)
  # there are research work being done on the gradient free hamiltonian
  # don't quote on me, it is still an exciting new area
  #
  # good read, I'll leave the work for others :)
  #
  # for now, it does exactly the random walk if hmc = TRUE

  return(theta+rnorm(length(theta))*2.38)
}

# Metroplis Hasting Monte Carlo Simulation
# fun .......... the logged posterior sampling function
# theta.init ... initial parameter(s) value
# nmc .......... number of Markov Chains
# nbi .......... number of burn-ins
# hmc .......... reserved for future Hamiltonian or RWHMC implementation
mcmc <- function(fun, theta.init, nmc, nbi, hmc = FALSE, ...) {

  iterations <- nmc + nbi
  chain <- array(dim = c(iterations, length(theta.init)))
  chain[1, ] <- theta.init

  # choose the proposal function
  if(hmc){
    propose <- hamiltonian.proposal.fun          #hamiltonian
  }else{
    propose <- metrop.rwalker.proposal.fun       #random walk
  }

  for(i in 1:(iterations-1)) {
    proposal <- propose(chain[i, ])
    p <- exp(fun(proposal, ...) - fun(chain[i, ], ...))

    if(runif(1) < p) {
      chain[i+1, ] <- proposal       #accept
    }else{
      chain[i+1, ] <- chain[i, ]     #reject
    }
  }

  return(chain[-(1:nbi), ])
}
