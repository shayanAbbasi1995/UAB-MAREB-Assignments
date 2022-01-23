clear
use baráa.dta
*for prediction purposes, knn works much better
*xi: discrim knn p03_1 - p03_16 p04 i.p05 p06, k(20) group(p02)
tabulate p02

*We want to make sure that 
*xi shows that it's a qualitative variable
xi: discrim lda p03_1 - p03_16 p04 i.p05 p06, group(p02)

*we know that our explatory variables have colinearity (multicoliniearity problem)
*we can do factor analysis and use factors to do discriminative analysis
factor p03_1-p03_16, pcf 
predict international_d identity reference weakness business

xi: discrim lda international_d identity reference weakness business p04 i.p05 p06, group(p02)

*When we have imbalance between categories of the dependent variable, we can change the priors (here the imbalance is not serious):
xi: discrim lda international_d identity reference weakness business p04 i.p05 p06, group(p02) priors(0.5, 0.5)

*We can make a discrimination function in quadratic form using the 'qda', knowing that it will increase the fitting.
xi: discrim qda international_d identity reference weakness business p04 i.p05 p06, group(p02) priors(0.5, 0.5)

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

*you can go to anova in menu bar and add any other tables that you like
