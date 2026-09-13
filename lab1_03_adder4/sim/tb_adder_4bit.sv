`timescale 1ns/1ps

module tb_adder_4bit;

    reg [3:0] a;
    reg [3:0] b;

    wire [3:0] s;
    wire cout;

    reg [4:0] expected;
    integer n;
    integer checked;

    adder_4bit dut (
        .a(a),
        .b(b),
        .s(s),
        .cout(cout)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_adder_4bit);

        checked = 0;

        for (n = 0; n < 256; n = n + 1) begin
            a = n / 16;
            b = n % 16;

            expected = {1'b0, a} + {1'b0, b};

            #10;

            if ({cout, s} !== expected) begin
                $fatal(
                    1,
                    "FAIL adder_4bit a=%0d b=%0d expected=%0d actual=%0d",
                    a,
                    b,
                    expected,
                    {cout, s}
                );
            end

            checked = checked + 1;
        end

        if (checked != 256)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS adder_4bit cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
