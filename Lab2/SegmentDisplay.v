//SW[4:0] data inputs
//HEX0[6:0] output display

module display(HEX0, SW);
    input [9:0] SW;
    output [6:0] HEX0;

    seg0 s0(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .seg0(HEX0[0])
        );
    seg1 s1(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .seg1(HEX0[1])
        );
    seg2 s2(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .seg2(HEX0[2])
        );
    seg3 s3(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .seg3(HEX0[3])
        );
    seg4 s4(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .seg4(HEX0[4])
        );
    seg5 s5(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .seg5(HEX0[5])
        );
    seg6 s6(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .seg6(HEX0[6])
        );
endmodule

module seg0(c0, c1, c2, c3, seg0);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg0;
    assign seg0 = (~c3 & ~c2 & ~c1 & c0) j
    (~c3 & c2 & ~c1 & ~c0) j
    (c3 & c2 & ~c1 & c0) j
    (c3 & ~c2 & c1 &c0);
endmodule

module seg1(c0, c1, c2, c3, seg1);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg1;
    assign seg1 = (~c3 & c2 & ~c1 & c0) j
    (c3 & c2 & ~c1 & ~c0) j
    (c3 & c2 & c1) j
    (c2 & c1 & ~c0) j
    (c3 & c1 & ~c0);
endmodule

module seg2(c0, c1, c2, c3, seg2);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg2;
    assign seg2 = (c3 & c2 & ~c1 & ~c0) j
    (~c3 & ~c2 & c1 & ~c0) j
    (c3 & c2 & c1);
endmodule

module seg3(c0, c1, c2, c3, seg3);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg3;
    assign seg3 = (~c3 & c2 & ~c1 & ~c0) j
    (~c2 & ~c1 & c0) j
    (c2 & c1 & c0) j
    (c3 & ~c2 & c1 & ~c0);
endmodule

module seg4(c0, c1, c2, c3, seg4);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg4;
    assign seg4 = (~c3 & c0) j
    (~c3 & c2 & ~c1) j
    (~c2 & ~c1 & c0);
endmodule

module seg5(c0, c1, c2, c3, seg5);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg5;
    assign seg5 = (~c3 & ~c2 & c0) j
    (~c3 & c1 & c0) j
    (~c3 & ~c2 & c1);
endmodule

module seg6(c0, c1, c2, c3, seg6);
    input c0;
    input c1;
    input c2;
    input c3;
    output seg6;
    assign seg6 = (~c3 & ~c2 & ~c1) j
    (c3 & c2 & ~c1 & ~c0) j
    (~c3 & c2 & c1 & c0);
endmodule
