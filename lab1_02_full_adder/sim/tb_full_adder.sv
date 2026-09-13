`timescale 1ns/1ps

module tb_full_adder;

    reg a;
    reg b;
    reg cin;

    wire s;
    wire cout;

    reg [1:0] expected;
    integer n;
    integer checked;

    full_adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .s(s),
        .cout(cout)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_full_adder);

        checked = 0;

        for (n = 0; n < 8; n = n + 1) begin
            {a, b, cin} = n[2:0];

            expected =
                {1'b0, a}
                + {1'b0, b}
                + {1'b0, cin};

            #10;

            if ({cout, s} !== expected) begin
                $fatal(
                    1,
                    "FAIL full_adder input=%b expected=%b actual=%b",
                    {a, b, cin},
                    expected,
                    {cout, s}
                );
            end

            checked = checked + 1;
        end

        if (checked != 8)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS full_adder cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
