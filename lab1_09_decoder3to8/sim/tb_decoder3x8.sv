`timescale 1ns/1ps

module tb_decoder3x8;

    reg a;
    reg b;
    reg c;

    wire [7:0] o;

    reg [7:0] expected;
    integer n;
    integer checked;

    decoder3x8 dut (
        .a(a),
        .b(b),
        .c(c),
        .o(o)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_decoder3x8);

        checked = 0;

        for (n = 0; n < 8; n = n + 1) begin
            {a, b, c} = n[2:0];
            expected = 8'b00000001 << n;

            #10;

            if (o !== expected) begin
                $fatal(
                    1,
                    "FAIL decoder3x8 input=%b expected=%b actual=%b",
                    {a, b, c},
                    expected,
                    o
                );
            end

            checked = checked + 1;
        end

        if (checked != 8)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS decoder3x8 cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
