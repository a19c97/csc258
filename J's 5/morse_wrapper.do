vlib work

vlog -timescale 1ns/1ns morse_wrapper.v

vsim morse_wrapper

log {/*}

add wave {/*}


force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

force {KEY[1]} 1
force {CLOCK_50} 1
force {KEY[0]} 0

run 1ns


force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

force {KEY[1]} 1
force {CLOCK_50} 0
force {KEY[0]} 0

run 1ns


force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

force {KEY[1]} 0
force {CLOCK_50} 1
force {KEY[0]} 1

run 1ns


force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

force {KEY[1]} 1
force {CLOCK_50} 0
force {KEY[0]} 1

run 1ns


force {CLOCK_50} 1 0, 0 1 -repeat 2

run 50ns


force {SW[0]} 1
force {SW[1]} 1
force {KEY[1]} 0
force {CLOCK_50} 1

run 1ns


force {KEY[1]} 0
force {CLOCK_50} 0

run 1ns


force {KEY[1]} 0
force {CLOCK_50} 1

run 1ns


force {KEY[1]} 1
force {CLOCK_50} 0

run 1ns


force {CLOCK_50} 1 0, 0 1 -repeat 2

run 200ns
