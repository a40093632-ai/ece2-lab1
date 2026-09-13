`timescale 1ns/1ps

module tb_demux_1x8;

    reg i;
    reg [2:0] s;

    wire [7:0] o;

    reg [7:0] expected;
    integer n;
    integer checked;

    demux_1x8 dut (
        .i(i),
        .s(s),
        .o(o)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_demux_1x8);

        checked = 0;

        for (n = 0; n < 16; n = n + 1) begin
            i = n / 8;
            s = n % 8;

            expected = i
                ? (8'b10000000 >> s)
                : 8'b00000000;

            #10;

            if (o !== expected) begin
                $fatal(
                    1,
                    "FAIL demux_1x8 i=%b s=%b expected=%b actual=%b",
                    i,
                    s,
                    expected,
                    o
                );
            end

            checked = checked + 1;
        end

        if (checked != 16)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS demux_1x8 cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
