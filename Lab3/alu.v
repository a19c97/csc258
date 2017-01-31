//SW[7:0] data inputs
//KEY[2:0] function inputs
//LEDR[7:0] output display - binary
//HEX0, HEX2 output display - 7-seg

module alu(LEDR, SW, KEY, HEX0, HEX2);
     input [7:0] SW;
     input [2:0] KEY;
     output [7:0] LEDR;
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

     redOr o4(
          .a(A),
          .b(B),
          .o(out4)
     );

     concat o5(
          .a(A),
          .b(B),
          .o(out5)
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

//A + B using the verilog +
module vadder(a, b, s);
    input [3:0]a;
    input [3:0]b;
    output [7:0] s;
    assign s[4:0] = a + b;
    assign s[7:5] = 3'b000;
endmodule;

//A xor B in the lower four bits, A or B in the upper four bits
module op3(a, b, o);
    input [3:0] a;
    input [3:0] b;
    output [7:0] o;
    assign o[3:0] = a | b;
    assign o[7:4] = a ^ b;
endmodule;

//reductive or either A or B
module redOr(a, b, o);
    input a;
    input b;
    output o;
    assign o = (| a) | (| b);
endmodule;

//A left most four bits, B right most four bits
module concat(a, b, o);
    input a;
    input b;
    output o;
    assign o = {a, b};
endmodule;
