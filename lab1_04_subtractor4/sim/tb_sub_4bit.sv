`timescale 1ns/1ps

module tb_sub_4bit;

    reg [3:0] a;
    reg [3:0] b;

    wire [3:0] d;
    wire bor;

    reg [4:0] expected;
    integer n;
    integer checked;

    sub_4bit dut (
        .a(a),
        .b(b),
        .d(d),
        .bor(bor)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_sub_4bit);

        checked = 0;

        for (n = 0; n < 256; n = n + 1) begin
            a = n / 16;
            b = n % 16;

            expected[4] = (a < b);
            expected[3:0] = a - b;

            #10;

            if ({bor, d} !== expected) begin
                $fatal(
                    1,
                    "FAIL sub_4bit a=%0d b=%0d expected=%b actual=%b",
                    a,
                    b,
                    expected,
                    {bor, d}
                );
            end

            checked = checked + 1;
        end

        if (checked != 256)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS sub_4bit cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
