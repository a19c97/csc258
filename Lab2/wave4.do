vlid work
vlog timescale 1ns/1ns 4to1mux.v
vism 4to1mux
log f/*g
add wave f/*g

#first test case
# s0s1 = 00 -> u
force fSW[0]g 1
force fSW[1]g 0
force fSW[2]g 0
force fSW[3]g 0
force fSW[8]g 0
force fSW[9]g 0
run 10ns

#second test case
# s0s1 = 10 -> v
force fSW[0]g 0
force fSW[1]g 1
force fSW[2]g 0
force fSW[3]g 0
force fSW[8]g 1
force fSW[9]g 0

#third test case
# s0s1 = 01 -> w
force fSW[0]g 0
force fSW[1]g 0
force fSW[2]g 1
force fSW[3]g 0
force fSW[8]g 0
force fSW[9]g 1

#fourth test case
# s0s1 = 11 -> x
force fSW[0]g 0
force fSW[1]g 0
force fSW[2]g 0
force fSW[3]g 1
force fSW[8]g 1
force fSW[9]g 1
