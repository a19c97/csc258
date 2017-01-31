//SW[8:0] data inputs

//LEDR[0] output display

module ripple(LEDR, SW);
    input [8:0] SW;
    output [4:0] LEDR;
    wire w1, w2, w3;
    wire [3:0] s;

    assign LEDR[0] = s[0];
    assign LEDR[1] = s[1];
    assign LEDR[2] = s[2];
    assign LEDR[3] = s[3];

    fullAdder fa0(
        .a(SW[0]),
        .b(SW[4]),
        .cin(SW[8]),
        .cout(w1),
        .s(s[0])
        );

    fullAdder fa1(
        .a(SW[1]),
        .b(SW[5]),
        .cin(w1),
        .cout(w2),
        .s(s[1])
        );

    fullAdder fa2(
        .a(SW[2]),
        .b(SW[6]),
        .cin(w2),
        .cout(w3),
        .s(s[2])
        );

    fullAdder fa3(
        .a(SW[3]),
        .b(SW[7]),
        .cin(w3),
        .cout(LEDR[4]),
        .s(s[3])
        );

endmodule

module fullAdder(a, b, cin, cout, s);
    input a;
    input b;
    input cin;
    output cout, s;
    assign s = (~b&~a&cin) | (~b&a&~cin) | (b&a&cin) | (b&~a&~cin);
    assign cout = (b & a) | (a & cin) | (b & cin);

endmodule
