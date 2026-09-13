module compare_4(
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [2:0] o
);

    assign o[2] = (a > b);
    assign o[1] = (a != b);
    assign o[0] = (a < b);

endmodule
