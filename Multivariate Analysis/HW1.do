count 
corr p07_1-p07_13, cov
mi set mlong
mi register imputed p07_1-p07_13
mi impute mvn p07_1-p07_13, emonly
matrix cov_em = r(Sigma_em)
matrix list cov_em
factormat cov_em, n(53) fact(3) ml

* We can look to see if there are significant high correlations showing multicolinearity
pwcorr p07_1-p07_13, sig star(0.05)

* we can make the factors and eigenvalues seeing how much factors have eigen>1, then we can use those factors
factortest p07_1-p07_13

* we can set the eigenvalues treshold on lower than 1 as well:
factor p07_1-p07_13, pcf
estat kmo
rotate, varimax horst blanks(.7) 

predict behaviour performance management_behaviour

* Anova on Family and non-Family firms

oneway behaviour p04
pwmean behaviour, over(p04) mcompare(tukey) effects
oneway  performance p04
pwmean performance, over(p04) mcompare(tukey) effects
oneway management_behaviour p04
pwmean management_behaviour, over(p04) mcompare(tukey) effects


* discriminant analysis
* priors set to default
xi: discrim lda behaviour performance management_behaviour, group(p04) priors(0.5, 0.5) 

estat grsummarize

estat correlations

estat anova

estat canontest

estat loadings, all

estat structure

estat classfunctions

estat list

estat classtable

estimates

predict DIS_GROUP