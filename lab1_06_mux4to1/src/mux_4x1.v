module mux_4x1(
    input  wire [3:0] i,
    input  wire [1:0] s,
    output wire       z
);

    assign z = (s == 2'b00) ? i[3] :
               (s == 2'b01) ? i[2] :
               (s == 2'b10) ? i[1] :
                               i[0];

endmodule
