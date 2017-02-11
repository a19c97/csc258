module rate_divider_wrapper(SW, HEX0, CLOCK_50);

	input [2:0] SW;
	output [6:0] HEX0;
	input CLOCK_50;
	
	wire [1:0] s;
	wire clock;
	wire reset_n;
	wire [27:0] upto;
	wire [27:0] q;
	wire enable_hex;
	wire [3:0] display_output;

	assign enable_hex = (q == 0) ? 1 : 0;
	
	assign s[0] = SW[0];
	assign s[1] = SW[1];
	assign reset_n = SW[2];
	assign clock = CLOCK_50;
	
	rate_selector selector(
		.s0(s[0]),
		.s1(s[1]),
		.upto(upto)
	);

	rate_divider divider(
		.enable(1),
		.upto(upto),
		.reset_n(reset_n),
		.clock(clock),
		.q(q)
	);

	display_counter(
		.enable(enable_hex),
		.reset_n(reset_n),
		.clock(clock),
		.q(display_output)
	);

     	seg0 s0(
        	.c0(display_output[0]),
        	.c1(display_output[1]),
        	.c2(display_output[2]),
        	.c3(display_output[3]),
        	.seg0(HEX0[0])
        );
     	seg1 s1(
        	.c0(display_output[0]),
        	.c1(display_output[1]),
        	.c2(display_output[2]),
        	.c3(display_output[3]),
        	.seg1(HEX0[1])
        );
     	seg2 s2(
        	.c0(display_output[0]),
        	.c1(display_output[1]),
        	.c2(display_output[2]),
        	.c3(display_output[3]),
        	.seg2(HEX0[2])
        );
     	seg3 s3(
        	.c0(display_output[0]),
        	.c1(display_output[1]),
        	.c2(display_output[2]),
        	.c3(display_output[3]),
        	.seg3(HEX0[3])
        );
     	seg4 s4(
        	.c0(display_output[0]),
        	.c1(display_output[1]),
        	.c2(display_output[2]),
        	.c3(display_output[3]),
        	.seg4(HEX0[4])
        );
     	seg5 s5(
        	.c0(display_output[0]),
        	.c1(display_output[1]),
        	.c2(display_output[2]),
        	.c3(display_output[3]),
        	.seg5(HEX0[5])
        );
     	seg6 s6(
        	.c0(display_output[0]),
        	.c1(display_output[1]),
        	.c2(display_output[2]),
        	.c3(display_output[3]),
        	.seg6(HEX0[6])
        );


endmodule

module rate_selector(s0, s1, upto);

	input s0, s1;
	output d;
	wire [27:0] upto;
	
	always @(*)
	begin
		if (s1 == 0 && s0 == 0)
			assign upto = 1;
		else if (s1 == 0 && s0 == 1)
			assign upto = 28'b0010111110101111000010000000;
		else if (s1 == 1 && s0 == 0)
			assign upto = 28'b0101111101011110000100000000;
		else
			assign upto = 28'b1011111010111100001000000000;
	end

endmodule 

module rate_divider(enable, upto, reset_n, clock, q); //but enable is always on?

	input enable, upto, reset_n, clock;
	wire [27:0] upto;
	output q;
	reg [27:0] q;
	
	always @(posedge clock)
	begin 
		if (reset_n == 1)
			q <= 0;
		else if (enable == 1)
		begin
			if (q == (d - 1))
				q <= 0;
			else
				q <= q + 1'b1;
		end
	end
endmodule

module display_counter(enable, reset_n, clock, q);
//this module counts up to sixteen; should only increment when enable is on
	
	input enable, reset_n, clock;
	output q;
	reg [3:0] q;
	
	always @(posedge clock)
	begin
		if (reset_n == 1)
			q <= 0;
		else if (enable == 1)
			q <= q + 1'b1; //don't need to check max val?
	end
	
endmodule

module seg0(c0, c1, c2, c3, seg0);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg0;
    assign seg0 = (~c3 & ~c2 & ~c1 & c0) | (~c3 & c2 & ~c1 & ~c0)
    | (c3 & c2 & ~c1 & c0) | (c3 & ~c2 & c1 &c0);
endmodule;

module seg1(c0, c1, c2, c3, seg1);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg1;
    assign seg1 = (~c3 & c2 & ~c1 & c0) |
    (c3 & c2 & ~c1 & ~c0) |
    (c3 & c1 & c0) |
    (c2 & c1 & ~c0) |
    (c3 & c2 & c1);
endmodule;

module seg2(c0, c1, c2, c3, seg2);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg2;
    assign seg2 = (c3 & c2 & ~c1 & ~c0) |
    (~c3 & ~c2 & c1 & ~c0) |
    (c3 & c2 & c1);
endmodule;

module seg3(c0, c1, c2, c3, seg3);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg3;
    assign seg3 = (~c3 & c2 & ~c1 & ~c0) |
    (!c3 & ~c2 & ~c1 & c0) |
    (c2 & c1 & c0) |
    (c3 & ~c2 & c1 & ~c0);
endmodule;

module seg4(c0, c1, c2, c3, seg4);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg4;
    assign seg4 = (~c3 & c0) |
    (~c3 & c2 & ~c1) |
    (~c2 & ~c1 & c0);
endmodule;

module seg5(c0, c1, c2, c3, seg5);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg5;
    assign seg5 = (~c3 & ~c2 & c0) |
    (~c3 & c1 & c0) |
    (~c3 & ~c2 & c1);
endmodule;

module seg6(c0, c1, c2, c3, seg6);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg6;
    assign seg6 = (~c3 & ~c2 & ~c1) |
    (c3 & c2 & ~c1 & ~c0) |
    (~c3 & c2 & c1 & c0);
endmodule;