C sketch 
C        metropolis hasting monte carlo 
C        hamiltonian monte carlo
C not really gonna use it, consider there are 
C MCMCpack and STAN
C rather for fun and jot down thoughts
C
C   arXiv:1808.08490v2  
C   MikeXL/bayes/R/mcmc.r
C
C metropolis hasting, the simplest one 
C target the logged posterior function
C nmc number iterations 
C nbi burnin 
C chain the Markov chain 
C23456789
      subroutine metrop(target, nmc, nbi, chain)
        call random_number(chain(1, :)) 
        do 71 i = 2, nmc
          x = chain(i-1, :)
          call random_num(chain(i, :)
          call random_num(metropolis)
          if exp(target(chain(i, :)) - target(x)) 
      +          > metropolis 
          then 
C accept
          else
C reject 
            chain(i, :) = x
          end 
 71     continue 
      end subroutine metrop
C
C Hamiltonian, put out your sketchbook 
C derivatives 
C
      subroutine ham()
      end subroutine ham
