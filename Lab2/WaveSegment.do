vlib work
vlog -timescale 1ns/1ns SegmentDisplay.v
vsim display
log {/*}
add wave {/*}

#first test case
#display: 0
#segments off: 6
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#second test case
#display: 1
#segments off: 0 3 4 5 6
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
run 10ns

#third test case
#display: 2
#segments off: 2 5
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
run 10ns
