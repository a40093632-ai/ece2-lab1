`timescale 1ns/1ps

module tb_compare_4;

    reg [3:0] a;
    reg [3:0] b;

    wire [2:0] o;

    reg [2:0] expected;
    integer n;
    integer checked;

    compare_4 dut (
        .a(a),
        .b(b),
        .o(o)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_compare_4);

        checked = 0;

        for (n = 0; n < 256; n = n + 1) begin
            a = n / 16;
            b = n % 16;

            expected = {
                (a > b),
                (a == b),
                (a < b)
            };

            #10;

            if (o !== expected) begin
                $fatal(
                    1,
                    "FAIL compare_4 a=%0d b=%0d expected=%b actual=%b",
                    a,
                    b,
                    expected,
                    o
                );
            end

            checked = checked + 1;
        end

        if (checked != 256)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS compare_4 cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
