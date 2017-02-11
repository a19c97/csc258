module counter(SW, KEY, HEX0, HEX1);
	
	input [1:0] SW;
	input [0:0] KEY;
	output [6:0] HEX0;
    	output [6:0] HEX1;

	wire Clock, Clear_b, Enable;
	reg [7:0] Q;
	wire [6:0] a;

	assign Clock = KEY[0];
	assign Clear_b = SW[0];
	assign Enable = SW[1];

	toggle q0(
		.t(Enable);
		.clock(Clock);
		.clear_b(Clear_b);
		.q(Q[0]);
	);

	toggle q1(
		.t(a[0]);
		.clock(Clock);
		.clear_b(Clear_b);
		.q(Q[1]);
	);

	toggle q2(
		.t(a[1]);
		.clock(Clock);
		.clear_b(Clear_b);
		.q(Q[2]);
	);

	toggle q3(
		.t(a[2]);
		.clock(Clock);
		.clear_b(Clear_b);
		.q(Q[3]);
	);

	toggle q4(
		.t(a[3]);
		.clock(Clock);
		.clear_b(Clear_b);
		.q(Q[4]);
	);

	toggle q5(
		.t(a[4]);
		.clock(Clock);
		.clear_b(Clear_b);
		.q(Q[5]);
	);

	toggle q6(
		.t(a[5]);
		.clock(Clock);
		.clear_b(Clear_b);
		.q(Q[6]);
	);

	toggle q7(
		.t(a[6]);
		.clock(Clock);
		.clear_b(Clear_b);
		.q(Q[7]);
	);
	
	and_gate a0(
		.x(Enable);
		.y(Q[0]);
		.z(a[0]);	
	);

	and_gate a1(
		.x(a[0]);
		.y(Q[1]);
		.z(a[1]);	
	);

	and_gate a2(
		.x(a[1]);
		.y(Q[2]);
		.z(a[2]);	
	);

	and_gate a3(
		.x(a[2]);
		.y(Q[3]);
		.z(a[3]);	
	);

	and_gate a4(
		.x(a[3]);
		.y(Q[4]);
		.z(a[4]);	
	);

	and_gate a5(
		.x(a[4]);
		.y(Q[5]);
		.z(a[5]);	
	);

	and_gate a6(
		.x(a[5]);
		.y(Q[6]);
		.z(a[6]);	
	);

     	seg0 lower(
        	.c0(Q[0]),
        	.c1(Q[1]),
        	.c2(Q[2]),
        	.c3(Q[3]),
        	.seg0(HEX0[0])
        );
     	seg1 lower(
        	.c0(Q[0]),
        	.c1(Q[1]),
        	.c2(Q[2]),
        	.c3(Q[3]),
        	.seg1(HEX0[1])
        );
     	seg2 lower(
        	.c0(Q[0]),
        	.c1(Q[1]),
        	.c2(Q[2]),
        	.c3(Q[3]),
        	.seg2(HEX0[2])
        );
     	seg3 lower(
        	.c0(Q[0]),
        	.c1(Q[1]),
        	.c2(Q[2]),
        	.c3(Q[3]),
        	.seg3(HEX0[3])
        );
     	seg4 lower(
        	.c0(Q[0]),
        	.c1(Q[1]),
        	.c2(Q[2]),
        	.c3(Q[3]),
        	.seg4(HEX0[4])
        );
     	seg5 lower(
        	.c0(Q[0]),
        	.c1(Q[1]),
        	.c2(Q[2]),
        	.c3(Q[3]),
        	.seg5(HEX0[5])
        );
     	seg6 lower(
        	.c0(Q[0]),
        	.c1(Q[1]),
        	.c2(Q[2]),
        	.c3(Q[3]),
        	.seg6(HEX0[6])
        );

     	seg0 upper(
        	.c0(Q[4]),
        	.c1(Q[5]),
        	.c2(Q[6]),
        	.c3(Q[7]),
        	.seg0(HEX1[0])
        );
     	seg1 upper(
        	.c0(Q[4]),
        	.c1(Q[5]),
        	.c2(Q[6]),
        	.c3(Q[7]),
        	.seg1(HEX1[1])
        );
     	seg1 upper(
        	.c0(Q[4]),
        	.c1(Q[5]),
        	.c2(Q[6]),
        	.c3(Q[7]),
        	.seg1(HEX1[1])
        );
     	seg2 upper(
        	.c0(Q[4]),
        	.c1(Q[5]),
        	.c2(Q[6]),
        	.c3(Q[7]),
        	.seg2(HEX1[2])
        );
     	seg3 upper(
        	.c0(Q[4]),
        	.c1(Q[5]),
        	.c2(Q[6]),
        	.c3(Q[7]),
        	.seg3(HEX1[3])
        );
     	seg4 upper(
        	.c0(Q[4]),
        	.c1(Q[5]),
        	.c2(Q[6]),
        	.c3(Q[7]),
        	.seg4(HEX1[4])
        );
     	seg5 upper(
        	.c0(Q[4]),
        	.c1(Q[5]),
        	.c2(Q[6]),
        	.c3(Q[7]),
        	.seg5(HEX1[5])
        );
     	seg6 upper(
        	.c0(Q[4]),
        	.c1(Q[5]),
        	.c2(Q[6]),
        	.c3(Q[7]),
        	.seg6(HEX1[6])
        );


endmodule

module toggle(t, clock, clear_b, q, not_q);

	input t, clock, clear_b;
	output reg q, not_q;

	assign not_q = ~q;
	
	always @(posedge clock, negedge clear_b)
	begin
		if (clear_b == 1’b0)
			q <= 0;
		if (t == 1’b1)
			q <= ~q;
	end
endmodule

module and_gate(x, y, z);
	
	input x, y;
	output z;

	assign z = x & y;
endmodule

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