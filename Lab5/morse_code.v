module morse_code_wrapper(SW, KEY, LEDR, CLOCK_50);

	input [2:0] SW;
	input [1:0] KEY;
	output [0:0] LEDR;
	input CLOCK_50;
	
	wire [2:0] s;
	assign s[0] = SW[0];
	assign s[1] = SW[1];
	assign s[2] = SW[2];
	wire start;
	assign start = KEY[1];
	wire reset;
	assign reset = KEY[0];
	wire on;
	assign on = LEDR[0];

	morse_code morse_code(
		.s(s),
		.reset(reset),
		.start(start),
		.clock(CLOCK_50),
		.on(on)
	);
	
endmodule

module morse_code(s, reset, start, clock, on);
	
	input s, reset, start, clock;
	wire [2:0] s;
	wire reset, start, clock;
	output on;
	wire on;
	wire [13:0] pattern;
	wire enable;

	select_letter select_letter(
		.s(s),
		.pattern(pattern)
	);

	display_pattern display_pattern(
		.enable(enable),
		.start(start),
		.reset(reset),
		.pattern(pattern),
		.on(on)
	);
	
	rate_divider rate_divider(
		.clock(CLOCK_50),
		.reset(reset),
		.start(start),
		.enable(enable)
	);
	
endmodule

module select_letter(s, pattern);

	input s;
	output pattern;
	wire [2:0] s;
	reg [13:0] pattern;
	
	always @(*)
	begin 
		case (s[2:0])
            	3'b000: assign pattern = 14'b10101000000000;
		3'b001: assign pattern = 14'b11100000000000;
		3'b010: assign pattern = 14'b10101110000000;
		3'b011: assign pattern = 14'b10101011100000;
		3'b100: assign pattern = 14'b10111011100000;
		3'b101: assign pattern = 14'b11101010111000;
		3'b110: assign pattern = 14'b11101011101110;
		3'b111: assign pattern = 14'b11101110101000;
		default: assign pattern = 0;
		endcase
	end

endmodule 

module display_pattern(enable, start, reset, pattern, on);
	
	input enable, start, reset, pattern;
	output on;
	reg on;
	wire [13:0] pattern;
	reg [13:0] p;
	assign pattern = p;

	always @(posedge enable)
	begin
		if (reset == 0)
		begin
			assign on = 0;
			assign p = 0;
		end
		else 
		begin
			assign on = p[13];
			assign p = p << 1;
		end
	end
	
endmodule

module rate_divider(clock, reset, start, enable);
	
	input clock, reset, start;
	output enable;
	wire enable;
	wire upto = 26'b1011111010111100001000000;
	reg [25:0] q;
	assign enable = (q == 0) ? 1 : 0;
	
	always @(posedge clock, negedge reset)
	begin
		if (start == 0)
			q <= 0;
		else
		begin 
			if (q == (upto - 1))
			begin
				q <= 0;
			end
			else
				q <= q + 1'b1;
		end
	end
	
endmodule
