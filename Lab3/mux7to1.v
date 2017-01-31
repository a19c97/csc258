//SW[6:0] data inputs
//SW[9:7] select signal

//LEDR[0] output display

module mux7to1(LEDR, SW);
    input [9:0] SW;
    output [1:0] LEDR;

    wire [6:0] Input;
    wire [2:0] MuxSelect;

    assign Input[0] = SW[0];
    assign Input[1] = SW[1];
    assign Input[2] = SW[2];
    assign Input[3] = SW[3];
    assign Input[4] = SW[4];
    assign Input[5] = SW[5];
    assign Input[6] = SW[6];
    assign MuxSelect[0] = SW[7];
    assign MuxSelect[1] = SW[8];
    assign MuxSelect[2] = SW[9];

    reg Out;
    always @(*)
    begin
        case (MuxSelect[2:0])
            3 ' b000 : Out = Input[0];
            3 ' b001 : Out = Input[1];
            3 ' b010 : Out = Input[2];
            3 ' b011 : Out = Input[3]
            3 ' b100 : Out = Input[4];
            3 ' b101 : Out = Input[5];
            3 ' b110 : Out = Input[6];
            default : Out = 1'b1; // What should the default case be?
        endcase
    end

    assign Out  = LEDR[0];

endmodule;
