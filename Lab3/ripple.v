//SW[8:0] data inputs

//LEDR[0] output display

module ripple(LEDR, SW);
    input [8:0] SW;
    output [1:0] LEDR;
    wire w1, w2, w3;

    fullAdder fa0(
        .a(SW[0]),
        .b(SW[4]),
        .c1(SW[8]),
        .c0(w1),
        .s(LEDR[0])
        );

    fullAdder fa1(
        .a(SW[1]),
        .b(SW[5]),
        .c1(w1),
        .c0(w2),
        .s(LEDR[1])
        );

    fullAdder fa2(
        .a(SW[2]),
        .b(SW[6]),
        .c1(w2),
        .c0(w3),
        .s(LEDR[2])
        );

    fullAdder fa3(
        .a(SW[3]),
        .b(SW[7]),
        .c1(w3),
        .c0(LEDR[4]),
        .s(LEDR[3])
        );

endmodule

module fullAdder(a, b, c1, c0, s);
    input a;
    input b;
    input c1;
    output c0;
    output s;

    assign c0 = (b & a) | (a & c1) | (b & c1);
    assign s = (~b&~a&s) | (~b&a&~s) | (b&a&s) | (b&~a&~s);
endmodule
