module alu(LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW, KEY);

	output [9:0] LEDR;
	output [6:0] HEX0;
    	output [6:0] HEX1;
    	output [6:0] HEX2;
    	output [6:0] HEX3;
    	output [6:0] HEX4;
    	output [6:0] HEX5;
	input [9:0] SW;
    	input [0:0] KEY;

	reg [7:0] Out;

    	wire [3:0] a;
    	wire [3:0] b;
    	wire [2:0] f;
	wire clock;
	wire reset_n;

	assign clock = KEY[0];
	assign reset_n = SW[9];

    	assign a[0] = SW[0];
   	assign a[1] = SW[1];
   	assign a[2] = SW[2];
  	assign a[3] = SW[3];

	assign b[0] = Out[0];
	assign b[1] = Out[1];
	assign b[2] = Out[2];
	assign b[3] = Out[3];

	assign f[0] = SW[5];
    	assign f[1] = SW[6];
    	assign f[2] = SW[7];

	// Case 0:

	wire [4:0] a_1_adder_out;
	wire [3:0] one;
	assign one[0] = 1;
	assign one[1] = 0;
	assign one[2] = 0;
	assign one[3] = 0;

	rc_adder a_1_adder(
		.out(a_1_adder_out),
		.in_1(a),
		.in_2(one),
        	.in_3(0)
	);

	// Case 1:

	wire [4:0] a_b_adder_out;
	rc_adder a_b_adder(
		.out(a_b_adder_out),
		.in_1(a),
		.in_2(b),
        .in_3(0)
	);

	// Case 2:

	wire [3:0] a_plus_b_out;
	assign a_plus_b_out = a + b;

	// Case 3:

	wire [7:0] a_xor_b_out;
	assign a_xor_b_out[0] = a[0] ^ b[0];
	assign a_xor_b_out[1] = a[1] ^ b[1];
	assign a_xor_b_out[2] = a[2] ^ b[2];
	assign a_xor_b_out[3] = a[3] ^ b[3];
	assign a_xor_b_out[4] = a[0] | b[0];
	assign a_xor_b_out[5] = a[1] | b[1];
	assign a_xor_b_out[6] = a[2] | b[2];
	assign a_xor_b_out[7] = a[3] | b[3];

	// Case 4:

	wire [0:0] red_out;
	assign red_out[0] = (~|a) && (~|b)? 0 : 1;

	// Case 5

	wire [3:0] left_shift_out;
	assign left_shift_out = b << a;

	// Case 6

	wire [3:0] right_shift_out;
	assign right_shift_out = b >> a;

	// Case 7

	wire [3:0] a_times_b_out;
	assign a_times_b_out = a * b;

	wire [2:0] three_zero;
	wire [3:0] four_zero;
	wire [6:0] seven_zero;
	assign three_zero = 3'b000;
	assign four_zero = 4'b0000;
	assign seven_zero = 7'b0000000;

    always @(*)
    begin
        case (f[2:0])
            3'b000:
                Out = {three_zero, a_1_adder_out};
            3'b001:
		Out = {three_zero, a_b_adder_out};
            3'b010:
		Out = {four_zero, a_plus_b_out};
            3'b011:
		Out = a_xor_b_out;
            3'b100:
		Out = {seven_zero, red_out};
            3'b101:
		Out = {four_zero, left_shift_out};
            3'b110:
		Out = {four_zero, right_shift_out};
	    3'b111:
		Out = {four_zero, a_times_b_out};
            default:
		Out = 0;
        endcase
    end

	always @(posedge clock)
	begin
		if (reset_n == 1'b0)
			Out <= 8'b00000000;
	end

    	wire [6:0] hex_0_out;
   	wire [6:0] hex_1_out;
    	wire [6:0] hex_2_out;
    	wire [6:0] hex_3_out;
    	wire [6:0] hex_4_out;
    	wire [6:0] hex_5_out;

    	hex hex_0(
        	.out(hex_0_out),
        	.in(b)
    	);

	hex hex_1(
		.out(hex_1_out),
		.in(four_zero)
	);

	hex hex_2(
		.out(hex_2_out),
		.in(a)
	);

	hex hex_3(
		.out(hex_3_out),
		.in(four_zero)
	);

	hex hex_4(
		.out(hex_4_out),
		.in(Out[3:0])
	);

	hex hex_5(
		.out(hex_5_out),
		.in(Out[7:4])
	);

	assign LEDR[0] = Out[0];
	assign LEDR[1] = Out[1];
	assign LEDR[2] = Out[2];
	assign LEDR[3] = Out[3];
	assign LEDR[4] = Out[4];
	assign LEDR[5] = Out[5];
	assign LEDR[6] = Out[6];
	assign LEDR[7] = Out[7];

    	assign HEX0 = hex_0_out;
    	assign HEX1 = hex_1_out;
    	assign HEX2 = hex_2_out;
    	assign HEX3 = hex_3_out;
   	assign HEX4 = hex_4_out;
    	assign HEX5 = hex_5_out;
endmodule


module rc_adder(out, in_1, in_2, in_3);
    output [4:0] out;
    input [3:0] in_1;
	input [3:0] in_2;
    input in_3;

	wire [3:0] a;
	wire [3:0] b;
	wire c_in;
	wire c_1;
	wire c_2;
	wire c_3;

	wire s_0;
	wire s_1;
	wire s_2;
	wire s_3;
	wire c_out;

	assign a[0] = in_1[0];
	assign a[1] = in_1[1];
	assign a[2] = in_1[2];
	assign a[3] = in_1[3];

	assign b[0] = in_2[0];
	assign b[1] = in_2[1];
	assign b[2] = in_2[2];
	assign b[3] = in_2[3];

	assign c_in = in_3;

	full_adder fa_0(
		.s(s_0),
		.c_o(c_1),
		.a(a[0]),
		.b(b[0]),
		.c_i(c_in)
	);

	full_adder fa_1(
		.s(s_1),
		.c_o(c_2),
		.a(a[1]),
		.b(b[1]),
		.c_i(c_1)
	);

	full_adder fa_2(
		.s(s_2),
		.c_o(c_3),
		.a(a[2]),
		.b(b[2]),
		.c_i(c_2)
	);

	full_adder fa_3(
		.s(s_3),
		.c_o(c_out),
		.a(a[3]),
		.b(b[3]),
		.c_i(c_3)
	);

	assign out[0] = s_0;
	assign out[1] = s_1;
	assign out[2] = s_2;
	assign out[3] = s_3;

	assign out[4] = c_out;

endmodule


module full_adder(s, c_o, a, b, c_i);
    output s;
    output c_o;
    input a;
    input b;
    input c_i;

    wire a_xor_b;

    assign a_xor_b = (a || b) && ~(a && b);

    mux2to1 mux(
        .x(b),
		.y(c_i),
		.s(a_xor_b),
		.m(c_o)
	);

	assign s = (c_i || a_xor_b) && ~(c_i && a_xor_b);

endmodule


module mux2to1(x, y, s, m);
    output m;
    input x;
    input y;
    input s;

    assign m = s & y | ~s & x;

endmodule


module hex(out, in);
	output [6:0] out ;
	input [3:0] in;

	assign out[0] = ~in[3] & in[2] & ~in[1] & ~in[0] |
					 ~in[3] & ~in[2] & ~in[1] & in[0] |
					 in[3] & in[2] & ~in[1] & in[0] |
					 in[3] & ~in[2] & in[1] & in[0];

	assign out[1] = ~in[3] & in[2] & ~in[1] & in[0] |
					 in[3] & in[2] & ~in[1] & ~in[0] |
					 in[3] & in[1] & in[0] |
					 in[2] & in[1] & ~in[0];

	assign out[2] = in[3] & in[2] & ~in[1] & ~in[0] |
					 ~in[3] & ~in[2] & in[1] & ~in[0] |
					 in[3] & in[2] & in[1];

	assign out[3] = ~in[3] & in[2] & ~in[1] & ~in[0] |
					 in[3] & ~in[2] & in[1] & ~in[0] |
					 ~in[2] & ~in[1] & in[0] |
					 in[2] & in[1] & in[0];

	assign out[4] = ~in[3] & in[2] & ~in[1] & ~in[0] |
					 in[3] & ~in[2] & ~in[1] & in[0] |
					 ~in[3] & in[0];

	assign out[5] = ~in[3] & ~in[2] & in[1] & ~in[0] |
					 ~in[3] & in[2] & in[1] & in[0] |
					 in[3] & in[2] & ~in[1] & in[0] |
					 ~in[3] & ~in[2] & in[0];

	assign out[6] = in[3] & in[2] & ~in[1] & ~in[0] |
					 ~in[3] & in[2] & in[1] & in[0] |
					 ~in[3] & ~in[2] & ~in[1];

endmodule
