//SW[4:0] data inputs
//SW[9] select signal
//SW[9] select signal

//LEDR[0] output display

module 4to1mux(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
    wire uov, wox;

    mux2to1 mux1(
        .x(SW[0]),
        .y(SW[1]),
        .s(SW[8]),
        .m(uov)
        );

    mux2to1 mux2(
        .x(SW[2]),
        .y(SW[3]),
        .s(SW[8]),
        .m(wox)
    );

    mux2to1 mux3(
        .x(uov),
        .y(wox),
        .s(SW[9]),
        .m(LEDR[0])
    );
endmodule

module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output

    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule
