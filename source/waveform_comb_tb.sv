
`timescale 1ns/10ps

`default_nettype none



module waveform_comb_tb();

reg CLK, N_RST;

reg [7:0]SAMPLE1, SAMPLE2;

reg MULTI, DONE1, DONE2;

wire READY; //a testbench has no inputs or outputs, the DUT has

wire [7:0]COMB_WAVEFORM;

reg [1023:0] testname;

localparam time CLK_PERIOD = 100; // 10kHz clock

waveform_comb u1 (.multi(MULTI), .done1(DONE1), .done2(DONE2), .clk(CLK), .n_rst(N_RST), .sample1(SAMPLE1), .sample2(SAMPLE2), .ready(READY), .comb_waveform(COMB_WAVEFORM));

always begin // Clock ticking

    CLK = 1'b0; 

    #(CLK_PERIOD / 2); 

    CLK = 1'b1; 

    #(CLK_PERIOD / 2); 

end

initial begin

    $dumpfile ("dump.vcd");

    $dumpvars;
end

initial begin

    testname="first test with N_RST value 0";

    @(posedge CLK);
    MULTI = 0;
    DONE1 = 0;
    DONE2 = 0;
    SAMPLE1 = 0;
    SAMPLE2 = 0;
    N_RST = 1'b0;

    @(negedge CLK);
     
    N_RST = 1'b1; 

    @(negedge CLK);

    SAMPLE1 = 8'd142;

    @(negedge CLK);

    DONE1 = 1;

    #(CLK_PERIOD * 2);

    @(negedge CLK);

    DONE2 = 1; 

    #(CLK_PERIOD);

    DONE2 = 0;
    SAMPLE2 = 8'd243;
    SAMPLE1 = 8'd203;

    #(CLK_PERIOD * 3);

    @(negedge CLK);

    MULTI = 1;

    #(CLK_PERIOD * 2);

    @(negedge CLK);

    DONE2 = 1;

    #(CLK_PERIOD * 3);
     
    $finish; 

// add your test cases here

end

endmodule