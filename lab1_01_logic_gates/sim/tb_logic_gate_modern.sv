`timescale 1ns/1ps

module tb_logic_gate_modern;

    reg a;
    reg b;

    wire x;
    wire y;
    wire z;

    reg [2:0] expected;
    integer n;
    integer checked;

    logic_gate dut (
        .a(a),
        .b(b),
        .x(x),
        .y(y),
        .z(z)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_logic_gate_modern);

        checked = 0;

        for (n = 0; n < 4; n = n + 1) begin
            {a, b} = n[1:0];
            expected = {a & b, a | b, a ^ b};

            #10;

            if ({x, y, z} !== expected) begin
                $fatal(
                    1,
                    "FAIL logic_gate input=%b expected=%b actual=%b",
                    {a, b},
                    expected,
                    {x, y, z}
                );
            end

            checked = checked + 1;
        end

        if (checked != 4)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS logic_gate cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
