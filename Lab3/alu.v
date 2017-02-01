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
     wire [3:0] out0_sum;
     wire out0_carry;
     wire [7:0] out1;
     wire [3:0] out1_sum;
     wire out1_carry;
     wire [7:0] out2;
     wire [7:0] out3;
     wire [7:0] out4;
     wire [7:0] out5;

     assign A[0] = SW[4];
     assign A[1] = SW[5];
     assign A[2] = SW[6];
     assign A[3] = SW[7];
     assign B[0] = SW[0];
     assign B[1] = SW[1];
     assign B[2] = SW[2];
     assign B[3] = SW[3];
 	
     assign fin[0] = KEY[0];
     assign fin[1] = KEY[1];
     assign fin[2] = KEY[2];
     
     assign out0[3:0] = out0_sum;
     assign out0[4] = out0_carry;
     assign out1[3:0] = out1_sum;
     assign out1[4] = out1_carry;
     
     ripple r0(
     	.a(A),
	.b(4'b0000),
	.cin(1),
	.s(out0_sum),
	.cout(out0_carry)
     );
     
     ripple r1(
     	.a(A),
	.b(B),
	.cin(0),
	.s(out1_sum),
	.cout(out1_carry)
     );
     
     vadder o2(
          .a(A),
          .b(B),
          .s(out2)
     );
     
     op3 o3(
          .a(A),
          .b(B),
          .o(out3)
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
    	 case(fin[2:0])
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
     
     //display A on HEX0
     seg0 s0a(
        .c0(A[0]),
        .c1(A[1]),
        .c2(A[2]),
        .c3(A[3]),
        .seg0(HEX0[0])
        );
     seg1 s1a(
        .c0(A[0]),
        .c1(A[1]),
        .c2(A[2]),
        .c3(A[3]),
        .seg1(HEX0[1])
        );
     seg2 s2a(
        .c0(A[0]),
        .c1(A[1]),
        .c2(A[2]),
        .c3(A[3]),
        .seg2(HEX0[2])
        );
     seg3 s3a(
        .c0(A[0]),
        .c1(A[1]),
        .c2(A[2]),
        .c3(A[3]),
        .seg3(HEX0[3])
        );
     seg4 s4a(
        .c0(A[0]),
        .c1(A[1]),
        .c2(A[2]),
        .c3(A[3]),
        .seg4(HEX0[4])
        );
    seg5 s5a(
        .c0(A[0]),
        .c1(A[1]),
        .c2(A[2]),
        .c3(A[3]),
        .seg5(HEX0[5])
        );
    seg6 s6a(
        .c0(A[0]),
        .c1(A[1]),
        .c2(A[2]),
        .c3(A[3]),
        .seg6(HEX0[6])
        );

     //display B on HEX2
     seg0 s0b(
        .c0(B[0]),
        .c1(B[1]),
        .c2(B[2]),
        .c3(B[3]),
        .seg0(HEX2[0])
        );
     seg1 s1b(
        .c0(B[0]),
        .c1(B[1]),
        .c2(B[2]),
        .c3(B[3]),
        .seg1(HEX2[1])
        );
     seg2 s2b(
        .c0(B[0]),
        .c1(B[1]),
        .c2(B[2]),
        .c3(B[3]),
        .seg2(HEX2[2])
        );
     seg3 s3b(
        .c0(B[0]),
        .c1(B[1]),
        .c2(B[2]),
        .c3(B[3]),
        .seg3(HEX2[3])
        );
     seg4 s4b(
        .c0(B[0]),
        .c1(B[1]),
        .c2(B[2]),
        .c3(B[3]),
        .seg4(HEX2[4])
        );
     seg5 s5b(
        .c0(B[0]),
        .c1(B[1]),
        .c2(B[2]),
        .c3(B[3]),
        .seg5(HEX2[5])
        );
     seg6 s6b(
        .c0(B[0]),
        .c1(B[1]),
        .c2(B[2]),
        .c3(B[3]),
        .seg6(HEX2[6])
        );
     
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
    input [3:0]a;
    input [3:0]b;
    output [7:0]o;
    assign o = (| a) | (| b);
endmodule;

//A left most four bits, B right most four bits
module concat(a, b, o);
    input [3:0]a;
    input [3:0]b;
    output [7:0]o;
    assign o = {a, b};
endmodule;

module ripple(a, b, cin, s, cout);
    input [3:0] a;
    input [3:0] b;
    input cin;
    output [3:0] s;
    output cout;
    wire w1, w2, w3;

    fullAdder fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .cout(w1),
        .s(s[0])
        );

    fullAdder fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(w1),
        .cout(w2),
        .s(s[1])
        );

    fullAdder fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(w2),
        .cout(w3),
        .s(s[2])
        );

    fullAdder fa3(
        .a(a[3]),
        .b(b[3]),
        .cin(w3),
        .cout(cout),
        .s(s[3])
        );

endmodule;

module fullAdder(a, b, cin, cout, s);
    input a;
    input b;
    input cin;
    output cout, s;
    assign s = (~b&~a&cin) | (~b&a&~cin) | (b&a&cin) | (b&~a&~cin);
    assign cout = (b & a) | (a & cin) | (b & cin);

endmodule;

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
