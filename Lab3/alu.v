//SW[7:0] data inputs
//KEY[2:0] function inputs
//LEDR[7:0] output display - binary
//HEX0, HEX2 output display - 7-seg

module alu(LEDR, SW, KEY, HEX);
     input [7:0] SW;
     input [2:0] KEY;
     output [6:0] HEX0;
     output [6:0] HEX2;

     wire [2:0] fin;
     wire [3:0] A;
     wire [3:0] B;

     wire [7:0] out0;
     wire [7:0] out1;
     wire [7:0] out2;
     wire [7:0] out3;
     wire [7:0] out4;
     wire [7:0] out5;
     wire [7:0] out6;
     wire [7:0] out7;

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

     vadder o2(
          .a(A),
          .b(B),
          .s(out2)
     );

     reg [7:0] ALUout;
     always @(*)
     begin
    	 case(fin[1:0])
    	    3'b000 : ALUout = out0;
          3'b001 : ALUout = out1;
          3'b010 : ALUout = out2;
          3'b011 : ALUout = out3;
          3'b100 : ALUout = out4;
          3'b101 : ALUout = out5;
    	    default : ALUout = 8'b00000000;
        endcase
     end

     assign LEDR[7:0] = ALUout;
     // assign HEX0
     // assign HEX2
endmodule;

module vadder(a, b, s);
    input a;
    input b;
    output s;
    assign s = a + b;
endmodule;
