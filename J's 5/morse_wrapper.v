module morse_wrapper(SW, KEY, LED, CLOCK_50);
	output [9:0] LED;
	input [9:0] SW;
	input [3:0] KEY;
	input CLOCK_50;
	
	morse main_morse(
		.out(LED[0]),
		.select(SW[2:0]),
		.load_n(KEY[1]),
		.clock(CLOCK_50),
		.reset_n(KEY[0])
	);

endmodule


module morse(out, select, load_n, clock, reset_n);
	output out;
	input [2:0] select;
	input load_n;
	input clock;
	input reset_n;
	
	wire [26:0] rate_divider_out;
	
	rate_divider_2hz rate_divider(
		.enable(1),
		.clock(clock),
		.reset_n(reset_n),
		.Q(rate_divider_out)
	);
	
	wire shift_enable;
	assign shift_enable = (rate_divider_out == 0) ? 1 : 0;
	
	wire [15:0] mux_out;
	
	mux7to1 mux(
		.Out(mux_out),
		.MuxSelect(select)
	);
	
	shift_register shifter(
		.out(out),
		.load_val(mux_out),
		.shift_left(shift_enable),
		.load_n(load_n),
		.clock(clock),
		.reset_n(reset_n)
	);

endmodule


module rate_divider_2hz(enable, clock, reset_n, Q);
	output Q;
	input enable;
	input clock;
	input reset_n;
	
	reg [26:0] Q;
	
	always @(posedge clock, negedge reset_n)
	begin
		if (reset_n == 1'b0)
			//Q <= 27'b101111101011110000011111111; // 99 999 999
			Q <= 27'b000000000000000000000000011;
		else if (enable == 1'b1)
			begin
				if (Q == 0)
					//Q <= 27'b101111101011110000011111111; // 99 999 999
					Q <= 27'b000000000000000000000000011;
				else
					Q <= Q - 1'b1;
			end
	end

endmodule


module mux7to1(Out, MuxSelect);
	output [15:0] Out;
	input [2:0] MuxSelect;
	
	assign Out = (MuxSelect == 0)? 16'b1010100000000000 :
		(MuxSelect == 1)? 16'b1110000000000000 :
		(MuxSelect == 2)? 16'b1010111000000000 :
		(MuxSelect == 3)? 16'b1010101110000000 :
		(MuxSelect == 4)? 16'b1011101110000000 :
		(MuxSelect == 5)? 16'b1110101011100000 :
		(MuxSelect == 6)? 16'b1110101110111000 :
		(MuxSelect == 7)? 16'b1110111010100000 :
		16'b0000000000000000;

endmodule


module shift_register(out, load_val, shift_left, load_n, clock, reset_n);
	output out;
	input [15:0] load_val;
	input shift_left;
	input load_n;
	input clock;
	input reset_n;
	
	wire SB_0_out;
	wire SB_1_out;
	wire SB_2_out;
	wire SB_3_out;
	wire SB_4_out;
	wire SB_5_out;
	wire SB_6_out;
	wire SB_7_out;
	wire SB_8_out;
	wire SB_9_out;
	wire SB_10_out;
	wire SB_11_out;
	wire SB_12_out;
	wire SB_13_out;
	wire SB_14_out;	
	
	shifter_bit shifter_bit_0(
		.out(SB_0_out),
		.load_val(load_val[0]),
		.in(0),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_1(
		.out(SB_1_out),
		.load_val(load_val[1]),
		.in(SB_0_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_2(
		.out(SB_2_out),
		.load_val(load_val[2]),
		.in(SB_1_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_3(
		.out(SB_3_out),
		.load_val(load_val[3]),
		.in(SB_2_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_4(
		.out(SB_4_out),
		.load_val(load_val[4]),
		.in(SB_3_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_5(
		.out(SB_5_out),
		.load_val(load_val[5]),
		.in(SB_4_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_6(
		.out(SB_6_out),
		.load_val(load_val[6]),
		.in(SB_5_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_7(
		.out(SB_7_out),
		.load_val(load_val[7]),
		.in(SB_6_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_8(
		.out(SB_8_out),
		.load_val(load_val[8]),
		.in(SB_7_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_9(
		.out(SB_9_out),
		.load_val(load_val[9]),
		.in(SB_8_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_10(
		.out(SB_10_out),
		.load_val(load_val[10]),
		.in(SB_9_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_11(
		.out(SB_11_out),
		.load_val(load_val[11]),
		.in(SB_10_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_12(
		.out(SB_12_out),
		.load_val(load_val[12]),
		.in(SB_11_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_13(
		.out(SB_13_out),
		.load_val(load_val[13]),
		.in(SB_12_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_14(
		.out(SB_14_out),
		.load_val(load_val[14]),
		.in(SB_13_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
	shifter_bit shifter_bit_15(
		.out(out),
		.load_val(load_val[15]),
		.in(SB_14_out),
		.shift(shift_left),
		.load_n(load_n),
		.clk(clock),
		.reset_n(reset_n)
	);
	
endmodule


module shifter_bit(out, load_val, in, shift, load_n, clk, reset_n);
	output out;
	input load_val;
	input in;
	input shift;
	input load_n;
	input clk;
	input reset_n;
	
	wire M1_out;

	mux2to1 M1(
		.x(out),
		.y(in),
		.s(shift),
		.m(M1_out)
	);

	wire M2_out;

	mux2to1 M2(
		.x(load_val),
		.y(M1_out),
		.s(load_n),
		.m(M2_out)
	);

	flipflop F0(
		.d(M2_out),
		.q(out),
		.clock(clk),
		.reset_n(reset_n)
	);

endmodule


module mux2to1(x, y, s, m);
    output m;
    input x;
    input y;
    input s;

    assign m = s & y | ~s & x;

endmodule


module flipflop(d, q, clock, reset_n);
	output q;
	input d;
	input clock;
	input reset_n;
	
    reg q;

	always @(posedge clock, negedge reset_n)
	
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else
			q <= d;
	end

endmodule
