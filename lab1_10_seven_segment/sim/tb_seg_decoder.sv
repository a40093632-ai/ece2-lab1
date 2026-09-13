`timescale 1ns/1ps

module tb_seg_decoder;

    reg [3:0] bcd;
    wire [7:0] seg_data;

    reg [7:0] digits [0:15];

    integer n;
    integer checked;

    seg_decoder dut (
        .bcd(bcd),
        .seg_data(seg_data)
    );

    initial begin
        digits[0]  = 8'hFC;
        digits[1]  = 8'h60;
        digits[2]  = 8'hDA;
        digits[3]  = 8'hF2;
        digits[4]  = 8'h66;
        digits[5]  = 8'hB6;
        digits[6]  = 8'hBE;
        digits[7]  = 8'hE0;
        digits[8]  = 8'hFE;
        digits[9]  = 8'hF6;
        digits[10] = 8'hEE;
        digits[11] = 8'h3E;
        digits[12] = 8'h9C;
        digits[13] = 8'h7A;
        digits[14] = 8'h9E;
        digits[15] = 8'h8E;

        $dumpfile("wave.vcd");
        $dumpvars(0, tb_seg_decoder);

        checked = 0;

        for (n = 0; n < 16; n = n + 1) begin
            bcd = n[3:0];

            #10;

            if (seg_data !== digits[n]) begin
                $fatal(
                    1,
                    "FAIL seg_decoder bcd=%h expected=%h actual=%h",
                    bcd,
                    digits[n],
                    seg_data
                );
            end

            checked = checked + 1;
        end

        if (checked != 16)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS seg_decoder cases=%0d", checked);
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule
