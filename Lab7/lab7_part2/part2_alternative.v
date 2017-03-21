// Part 2 skeleton

module part2
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input	CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	
	// connecting input and output 
	assign colour = SW[9:7];
	wire go;
	assign go = ~KEY[1];
	wire load;
	assign load = ~KEY[3];
	wire finished_drawing;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
    
    wire ld_x, ld_y;
    
    // Instansiate datapath
	datapath d0(
		.clk(CLOCK_50),
		.resetn(resetn),
		.data_in(SW[6:0]),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.finished_drawing(finished_drawing),
		
		.X(x),
		.Y(y)
	);

    // Instansiate FSM control
    control c0(
    	.clk(CLOCK_50),
    	.reset(resetn),
    	.go(go),
    	.load(load),
    	.finished_drawing(finished_drawing),
    	
    	.ld_x(ld_x),
    	.ld_y(ld_y),
    	.writeEn(writeEn)
    );
    
endmodule

module control(
    input clk,
    input resetn,
    input go,
    input load,
    input finished_drawing,
    
    output reg ld_x, ld_y, incr, writeEn
);
	
	reg [4:0] current_state, next_state; 
	
	localparam 
	S_LOAD_X = 5'd0,
	S_LOAD_X_WAIT = 5'd1,
	S_LOAD_Y = 5'd2,
	S_LOAD_Y_WAIT = 5'd3,
	S_DRAW = 5'd4;
	
    always@(*)
    begin: state_table 
        case (current_state)
            S_LOAD_X: next_state = load ? S_LOAD_X_WAIT : S_LOAD_X; 
            S_LOAD_X_WAIT: next_state = load ? S_LOAD_X_WAIT : S_LOAD_Y;
            S_LOAD_Y: next_state = load ? S_LOAD_Y_WAIT : S_LOAD_Y;
            S_LOAD_Y_WAIT: next_state = go ? S_DRAW : S_LOAD_Y_WAIT;
            S_DRAW: next_state = finished_drawing ? S_LOAD_X : S_DRAW;
            default: next_state = S_LOAD_X;
        endcase
    end // state_table
    
    always @(*)
    begin: enable_signals
    	ld_x = 1'b0;
    	ld_y = 1'b0;
    	incr = 1'b0;
    	writeEn = 1'b0;
    	case (current_state)
    	    S_LOAD_X: begin
                ld_x = 1'b1;
            end
            S_LOAD_Y: begin
                ld_y = 1'b1;
            end
            S_DRAW: begin
            	incr = 1'b1;
            	writeEn = 1'b1;
            end
    	endcase
    end // enable_signals
    
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_LOAD_X;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

module datapath(
	input clk,
	input resetn,
	input [6:0] data_in,
	input ld_x, ld_y, incr,
	
	output reg [7:0] X,
	output reg [6:0] Y,
	output reg finished_drawing
);

	reg [7:0] X_init;
	reg [6:0] Y_init;
	reg [3:0] counter;
	
	// loading inputs
	always @ (posedge clk) begin
        if (!resetn) 
		begin
		X <= 8'd0;
		Y <= 7'd0;
		X_init <= 8'd0;
		Y_init <= 7'd0;
		counter <= 4'd0;
		finished_drawing <= 1'b0;
        end
        else begin
	    finished_drawing <= 1'b0;
            if (ld_x)
	    	begin
                X <= {1'b0, data_in};
                X_init <= {1'b0, data_in};
		end
            if (ld_y)
	    	begin
            	Y <= data_in;
            	Y_init <= data_in;
		end
        end
    end
    
    // incrementing counter
    always @(posedge clk)
    begin: counter_incr
    	if (incr)
    		counter <= counter + 1;
    		if (counter == 0)
    			finished_drawing <= 1'b1;
		else 
			finished_drawing <= 1'b0;
    end // counter_incr
    
	// incrementing X and Y
	always @(*)
	begin: increment
		X <= X_init + counter[1:0];
		Y <= Y_init + counter[3:2];
	end // increment
endmodule
