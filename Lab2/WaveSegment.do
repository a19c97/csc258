vlib work
vlog -timescale 1ns/1ns SegmentDisplay.v
vsim display
log {/*}
add wave {/*}

#first test case
#display: 1
#segments off: 0 3 4 5 6
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#second test case
#display: 9
#segments off: 4
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1
run 10ns

#third test case
#display: 3
#segments off: 4 5
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#fourth test case
#display: 5
#segments off: 1 4
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 10ns

#fifth test case
#display: A
#segments off: 3
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns

#sixth test case
#display: F
#segments off: 1 2 3
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
run 10ns

#seventh test case
#display: C
#segments off: 1 2 6
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
run 10ns

#eighth test case
#display: B
#segments off: 0 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 10ns
