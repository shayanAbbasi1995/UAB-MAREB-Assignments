twoway (scatter P1 S1)
reg P1 S1

twoway (scatter P2 S2)
reg P2 S2

gen S2_2 = S2^2
reg P2 S2 S2_2 # a better fit

# It's better to use log when we don't know about the model's specification
gen ln_P2 = log(P2)
gen ln_S2 = log(S2)

twoway (scatter ln_P2 ln_S2)
reg ln_P2 ln_S2

