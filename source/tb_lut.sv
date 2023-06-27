`default_nettype none
`timescale 1ns/10ps

module tb_lut();

localparam CLK_PERIOD = 83.33; //10Hz clk
freq_div dut(.note(tb_note), .octave(tb_octave), .divider(tb_divider));
logic [3:0]tb_note; logic [2:0]tb_octave; logic [18:0]tb_divider;
logic tb_clk;

always begin
    tb_clk = 1'b0;
    #(CLK_PERIOD / 2);
    tb_clk = 1'b1;
    #(CLK_PERIOD / 2);
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    tb_note = 4'd0;
    tb_octave = 3'd0;
    #(CLK_PERIOD * 5);

    tb_note = 4'd2;
    tb_octave = 3'd2;
    #(CLK_PERIOD * 5);

    tb_note = 4'd5;
    tb_octave = 3'd5;
    #(CLK_PERIOD * 5);

    tb_note = 4'd7;
    tb_octave = 3'd6;
    #(CLK_PERIOD * 5);

    $finish;
end
endmodule
