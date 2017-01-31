//SW[8:0] data inputs

//LEDR[0] output display

module ripple(LEDR, SW);
    input [8:0] SW;
    output [4:0] LEDR;
    wire w1, w2, w3;

    fullAdder fa0(
        .a(SW[0]),
        .b(SW[4]),
        .cin(SW[8]),
        .cout(w1),
        .s(LEDR[0])
        );

    fullAdder fa1(
        .a(SW[1]),
        .b(SW[5]),
        .cin(w1),
        .cout(w2),
        .s(LEDR[1])
        );

    fullAdder fa2(
        .a(SW[2]),
        .b(SW[6]),
        .cin(w2),
        .cout(w3),
        .s(LEDR[2])
        );

    fullAdder fa3(
        .a(SW[3]),
        .b(SW[7]),
        .cin(w3),
        .cout(LEDR[4]),
        .s(LEDR[3])
        );

endmodule

module fullAdder(a, b, cin, cout, s);
    input a;
    input b;
    input cin;
    output cout, s;

    assign cout = (b & a) | (a & cin) | (b & cin);
    assign s = (~b&~a&s) | (~b&a&~s) | (b&a&s) | (b&~a&~s);
endmodule
