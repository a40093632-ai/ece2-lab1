`timescale 1ns/1ps

module tb_mux_4x1;

    reg [3:0] i;
    reg [1:0] s;

    wire z;

    reg expected;
    integer n;
    integer checked;

    mux_4x1 dut (
        .i(i),
        .s(s),
        .z(z)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_mux_4x1);

        checked = 0;

        for (n = 0; n < 64; n = n + 1) begin
            i = n / 4;
            s = n % 4;

            expected = i[3-s];

            #10;

            if (z !== expected) begin
                $fatal(
                    1,
                    "FAIL mux_4x1 i=%b s=%b expected=%b actual=%b",
                    i,
                    s,
                    expected,
                    z
                );
            end

            checked = checked + 1;
        end

        if (checked != 64)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS mux_4x1 cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
