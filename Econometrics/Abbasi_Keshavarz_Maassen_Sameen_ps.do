* 1.
cls
clear
use rd_expenditure_spain_1

regress rdi_exp n_workers sales firm_age

spikeplot rdi_exp
spikeplot sales
spikeplot firm_age
spikeplot n_workers
 
* Standardized residuals
regress rdi_exp n_workers sales firm_age
predict rsta, rstandard
predict stdp, stdp

* Studentized residuals
predict rstu, rstudent

* leverage
* regress rdi_exp n_workers sales firm_age
* predict lev, leverage

* Cook's distance

predict d, cooksd

list rdi_exp n_workers sales firm_age d if d>1

gen obs=_n

tw (connected d obs) (scatter d obs if d>1, mcolor(green) msymbol(triangle) mlabel(obs))

* dffit

predict dfit, dfits

list rdi_exp n_workers sales firm_age dfit if abs(dfit)>2*sqrt(3/4000)

* dfbeta

dfbeta

list rdi_exp n_workers sales firm_age _dfbeta_1 if abs(_dfbeta_1)>2/sqrt(4000)

*list rdi_exp n_workers sales firm_age _dfbeta_2 if abs(_dfbeta_2)>2/sqrt(51)
*list rdi_exp n_workers sales firm_age _dfbeta_3 if abs(_dfbeta_3)>2/sqrt(51)

* correlation matrix between regressors
corr n_workers sales firm_age

* VIF greater than 10 - 1/VIF lower than 0.1

regress rdi_exp n_workers sales firm_age

vif 

gen log_rdi_exp = log(rdi_exp)
 
* 2.
regress log_rdi_exp n_workers sales firm_age

* This is ramsey test and it does not test the existance of omitted variable
ovtest 

predict yhat, xb
gen yhat2=yhat^2
gen yhat3=yhat^3
gen yhat4=yhat^4

regress log_rdi_exp n_workers sales firm_age yhat2 yhat3 yhat4

test yhat2=yhat3=yhat4=0

* 3.
cls
clear
use rd_expenditure_spain_1

gen lrdi_exp = log(rdi_exp)
gen ln_workers = log(n_workers)
gen lsales = log(sales)


regress lrdi_exp ln_workers lsales firm_age

*3.2.
test ln_workers = 3*lsales
* or
test ln_workers - 3*lsales = 0

* 3.3.
regress lrdi_exp ln_workers lsales firm_age
predict rsta, rstandard
predict stdp, stdp

* Studentized residuals
predict rstu, rstudent

* leverage
* regress rdi_exp n_workers sales firm_age
* predict lev, leverage

* Cook's distance

predict d, cooksd

list rdi_exp lrdi_exp ln_workers lsales firm_age d if d>1

gen obs=_n

tw (connected d obs) (scatter d obs if d>1, mcolor(green) msymbol(triangle) mlabel(obs))

* dffit

predict dfit, dfits

list lrdi_exp ln_workers lsales firm_age dfit if abs(dfit)>2*sqrt(3/4000)

* dfbeta

dfbeta

list lrdi_exp ln_workers lsales firm_age _dfbeta_1 if abs(_dfbeta_1)>2/sqrt(4000)

* 4.
cls
clear
use rd_expenditure_spain_1

gen lrdi_exp = log(rdi_exp)
gen ln_workers = log(n_workers)
gen lsales = log(sales)
gen firm_age_2 = firm_age^2

regress lrdi_exp ln_workers lsales firm_age firm_age_2

* 4.1
* JUST TO SEE THE MULTICOLINIEARITY THAT WE SAID IS OK
* correlation matrix between regressors
corr firm_age firm_age_2

* VIF greater than 10 - 1/VIF lower than 0.1

regress lrdi_exp ln_workers lsales firm_age firm_age_2

vif 

gen lfirm_age = log(firm_age)
regress lrdi_exp ln_workers lsales lfirm_age

vif

* 5. 
cls
clear
use rd_expenditure_spain_1

gen lrdi_exp = log(rdi_exp)
gen lsales = log(sales)
gen firm_age_2 = firm_age^2
gen nworkers_notrd = n_workers - rdi_nworkers
gen lnworkers_notrd = log(nworkers_notrd)
gen lrdi_nworkers = log(rdi_nworkers)

regress lrdi_exp lnworkers_notrd lrdi_nworkers lsales firm_age firm_age_2

*5.3.
test lnworkers_notrd = lrdi_nworkers = 0

* 6.
regress lrdi_exp lnworkers_notrd lrdi_nworkers lsales firm_age firm_age_2 inter_mkt i.firm_type

* 6.5.
regress lrdi_exp lnworkers_notrd lrdi_nworkers lsales firm_age firm_age_2 inter_mkt ib3.firm_type

* 7.
gen interaction = inter_mkt*lsales
regress lrdi_exp lnworkers_notrd lrdi_nworkers lsales firm_age firm_age_2 inter_mkt interaction i.firm_type


* 8.
regress lrdi_exp lnworkers_notrd lrdi_nworkers lsales firm_age firm_age_2 inter_mkt interaction i.firm_type

predict res, residuals

scatter res lsales
scatter res firm_age
scatter res lnworkers_notrd
scatter res lrdi_nworkers
scatter res inter_mkt

hettest

estat imtest, white

xi: regress lrdi_exp lnworkers_notrd lrdi_nworkers lsales firm_age firm_age_2 inter_mkt interaction i.firm_type, vce(robust)