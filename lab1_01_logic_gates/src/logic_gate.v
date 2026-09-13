module logic_gate(
    input  wire a,
    input  wire b,
    output wire x,
    output wire y,
    output wire z
);

    assign x = a & b;
    assign y = a | b;
    assign z = a ^ b;

endmodule
