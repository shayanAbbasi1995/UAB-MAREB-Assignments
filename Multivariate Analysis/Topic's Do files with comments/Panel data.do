* use panelusa50-89
* treating panel data like cross section >> Pooled regression:
regress spend dem* divgov dis1 persinc* aper* popul*

* Considering panel data with random effects
xtreg spend dem* divgov dis1 persinc* aper* popul*, re
* Now we have R-sq within and between groups as well as the overal R2
* If we go to statistic >> Linear model >> linear regression and run cross sectional OLS, and in the by/if/in section we add year in repeated command by groups! we take the regression for each year which is a bad idea when we are looking for the generalization of some variable effect on dependent variable.

* Breusch and Pagan Lagrangian multiplier test for random effects
xttest0


xtreg spend dem* divgov dis1 persinc* aper* popul*, fe
* this is the same as doing:
regress spend dem* divgov dis1 persinc* aper* popul* i.stcode
* Using state code as the state fixed effect


* which is better, FE or RE?
xtreg spend dem* divgov dis1 persinc* aper* popul*, fe
* We save the fixed effect results 
est store fixed
* now estimate the random effect
xtreg spend dem* divgov dis1 persinc* aper* popul*, re
* now the test
hausman fixed
* There is a systematic difference in the estiate coefficient
* So we will choose FE

* Now we can add other fixed effects such as year fixed effect and ...
xtreg spend dem* divgov dis1 persinc* aper* popul* i.stcode i.year

* we can test parameters together
testparm i.year
* in older versions: testparam _IP_Year1951 - _IP_Year1989 (or something like this)


* detecting autocorrelation
xtserial spend dem1 demmaj1 demgov divgov dis1 persinc* aper* popul*, output
* detecting autocorrelation
xtregar spend dem* divgov dis1 persinc* aper* popul*, fe


xtreg spend dem* divgov dis1 persinc* aper* popul*, fe
xttest3

* detecting heteroscedasticity
xtreg spend dem* divgov dis1 persinc* aper* popul*, fe
xttest2
* since xttest2 not working:
xtcsd, pesaran show


  

