* We can look to see if there are significant high correlations showing multicolinearity
pwcorr *, sig star(0.05)

* we can make the factors and eigenvalues seeing how much factors have eigen>1, then we can use those factors
factortest p03_1-p03_16

* we can set the eigenvalues treshold on lower than 1 as well:
factor p03_1-p03_16, pcf mineigen(0.8)

rotate, varimax horst blanks(.7) 

predict international_d identity reference weakness business