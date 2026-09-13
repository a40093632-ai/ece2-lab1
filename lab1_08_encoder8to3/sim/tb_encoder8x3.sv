`timescale 1ns/1ps

module tb_encoder8x3;

    reg [7:0] i;
    wire [2:0] a;

    reg [2:0] expected;
    integer n;
    integer checked;

    encoder8x3 dut (
        .i(i),
        .a(a)
    );

    function automatic [2:0] encode_expected(
        input [7:0] value
    );
        begin
            case (value)
                8'b10000000: encode_expected = 3'b000;
                8'b01000000: encode_expected = 3'b001;
                8'b00100000: encode_expected = 3'b010;
                8'b00010000: encode_expected = 3'b011;
                8'b00001000: encode_expected = 3'b100;
                8'b00000100: encode_expected = 3'b101;
                8'b00000010: encode_expected = 3'b110;
                8'b00000001: encode_expected = 3'b111;
                default:     encode_expected = 3'b000;
            endcase
        end
    endfunction

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_encoder8x3);

        checked = 0;

        for (n = 0; n < 256; n = n + 1) begin
            i = n[7:0];
            expected = encode_expected(i);

            #10;

            if (a !== expected) begin
                $fatal(
                    1,
                    "FAIL encoder8x3 i=%b expected=%b actual=%b",
                    i,
                    expected,
                    a
                );
            end

            checked = checked + 1;
        end

        if (checked != 256)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS encoder8x3 cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
