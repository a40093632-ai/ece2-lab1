module adder_4bit(
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [3:0] s,
    output wire       cout
);

    assign {cout, s} = a - b;

endmodule
