tabulate product

tabulate product1

reg miles age times

#Multicoliniearit check
pwcorr miles age time, sig star(0.05)
# Conclusion: We can't see multicoliniearity
# sig shows the H_0: corr==0


tabulate gender
reg miles age times gender

generate fem= 0
replace fem = 1 if gender==0
replace fem = . if missing(age)

reg miles age times gender i.educatio


