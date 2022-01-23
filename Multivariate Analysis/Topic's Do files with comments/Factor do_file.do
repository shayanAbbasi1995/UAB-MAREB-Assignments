# correlation matrix for all variables
pwcorr *, sig star(0.05) 

# Installing Factortest package
findit factortest

# Bartlett test and KMO:

# KMO is good enough
factortest rooms age price size

# KMO is not good anymore
factortest rooms age price size zone

# Let's try to make the factore (principle factor analysis)
factor rooms age price size, pcf
# Sum(Eigenvalue) = 4, Eigen value shows the amount of variation each factor absorbs
# One criteria is that we only choose factors with eigen value higher than 1.
# if we sum squared of Factor1 in the Factor loadings we get the eigenvalues
# The rest is in the pdf
# More info on rotate, run command: rotate, blanck(0.5)

reg price rooms age size

factor rooms age size
predict f1
reg price f1