//SW[7:0] data inputs
//KEY[2:0] function inputs
//LEDR[7:0] output display - binary
//HEX0, HEX2 output display - 7-seg

module alu(LEDR, SW);
     input [9:0] SW;
     output [6:0] HEX0;
     output [6:0] HEX2; 

     wire [2:0] fin;
     wire [3:0] A;
     wire [3:0] B;

     assign A[0] = SW[4];
     assign A[1] = SW[5];
     assign A[2] = SW[6];
     assign A[3] = SW[7];
     assign B[0] = SW[0];
     assign B[1] = SW[1];
     assign B[2] = SW[2];
     assign B[3] = SW[3];
     assign fin[0] = SW[8];
     assign fin[0] = SW[9];

     reg [7:0] ALUout;
     always @(*)
	 case(fin[1:0])
	    3'b000 : 
            3'b001 : 
            3'b010 : 
            3'b011 : 
            3'b100 : 
            3'b101 : 
	    default : ALUout = 8'b00000000;
     begin
     end

     assign LEDR[7:0] = ALUout;
     // assign HEX0
     // assign HEX2

endmodule;

