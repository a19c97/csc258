module shifter(SW, KEY, LEDR);
	
	output [7:0] LEDR;
	input [9:0] SW;
	input [4:0] KEY;

	wire [7:0] LoadVal;
	wire reset_n, load_n, ShiftRight, ASR, clk;
	wire [7:0] out;
	
	assign out[0] = LEDR[0];	
	assign out[1] = LEDR[1];
	assign out[2] = LEDR[2];
	assign out[3] = LEDR[3];
	assign out[4] = LEDR[4];
	assign out[5] = LEDR[5];
	assign out[6] = LEDR[6];
	assign out[7] = LEDR[7];

	assign LoadVal[0] = SW[0];
	assign LoadVal[1] = SW[1];
	assign LoadVal[2] = SW[2];
	assign LoadVal[3] = SW[3];
	assign LoadVal[4] = SW[4];
	assign LoadVal[5] = SW[5];
	assign LoadVal[6] = SW[6];
	assign LoadVal[7] = SW[7];
	assign reset_n = SW[9];
	assign load_n = KEY[1];
	assign ShiftRight = KEY[2];
	assign ASR = KEY[3];
	assign clk = KEY[0];

	shifter_bit q0(
		.load_val(LoadVal[0]),
		.in(out[1]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(out[0]) //what do we do with this?
	);

	shifter_bit q1(
		.load_val(LoadVal[1]),
		.in(out[2]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(out[1]) 
	);

	shifter_bit q2(
		.load_val(LoadVal[2]),
		.in(out[3]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(out[2])
	);

	shifter_bit q3(
		.load_val(LoadVal[3]),
		.in(out[4]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(out[3])
	);

	shifter_bit q4(
		.load_val(LoadVal[4]),
		.in(out[5]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(out[4])
	);

	shifter_bit q5(
		.load_val(LoadVal[5]),
		.in(out[6]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(out[5])
	);

	shifter_bit q6(
		.load_val(LoadVal[6]),
		.in(out[7]),
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(out[6])
	);
	shifter_bit q7(
		.load_val(LoadVal[7]),
		.in(0),               // what to put here?
		.shift(ShiftRight),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(out[7])
	);
endmodule

module shifter_bit(load_val, in, shift, load_n, clk, reset_n, out);
	input load_val, in, shift, load_n, clk, reset_n;
	output out;
	wire m0, m1;
	
	mux2to1 mux0(
		.x(out),
		.y(in),
		.s(shift),
		.m(m0)
	);
	mux2to1 mux1(
		.x(load_val),
		.y(m0),
		.s(load_n),
		.m(m1)
	);
	pos_d dff(
		.d(m1),
		.clk(clk),
		.reset_n(reset_n),
		.q(out)
	);
endmodule

module pos_d(d, clk, reset_n, q);
	input d, clk, reset_n;
	output q;
	always @(posedge clk)
	begin
		if (reset_n == 1’b0)
			q <= 0;
		else
			q <= d;
	end
endmodule

module mux2to1(x, y, s, m);

	input x; //selected when s is 0

	input y; //selected when s is 1
	input s; //select signal

        output m; //output

	assign m = s & y | ~s & x;

endmodule