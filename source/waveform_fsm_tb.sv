`timescale 1ns/10ps

`default_nettype none



module waveform_fsm_tb();

reg CLK, N_RST;

reg [7:0]SAMPLE1, SAMPLE2;

reg MODE_KEY;

wire [1:0]MODE; //a testbench has no inputs or outputs, the DUT has

reg [1023:0] testname;

localparam time CLK_PERIOD = 100; // 10kHz clock

waveform_fsm u1 (.mode_key(MODE_KEY), .clk(CLK), .n_rst(N_RST), .mode(MODE));

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
    MODE_KEY = 0;
    N_RST = 1'b0;

    @(negedge CLK);
     
    N_RST = 1'b1; 

    @(posedge CLK);

    MODE_KEY = 1;

    @(posedge CLK);

    MODE_KEY = 0;

    #(CLK_PERIOD);
    @(posedge CLK);

    MODE_KEY = 1;

    @(posedge CLK);

    MODE_KEY = 0;

    #(CLK_PERIOD);

     @(posedge CLK);

    MODE_KEY = 1;

    @(posedge CLK);

    MODE_KEY = 0;

    #(CLK_PERIOD);

     @(posedge CLK);

    MODE_KEY = 1;

    @(posedge CLK);

    MODE_KEY = 0;

    #(CLK_PERIOD);

     @(posedge CLK);

    MODE_KEY = 1;

    @(posedge CLK);

    MODE_KEY = 0;

    #(CLK_PERIOD);

     @(posedge CLK);

    MODE_KEY = 1;

    @(posedge CLK);

    MODE_KEY = 0;

    #(CLK_PERIOD);

     @(posedge CLK);

    MODE_KEY = 1;

    @(posedge CLK);

    MODE_KEY = 0;

    #(CLK_PERIOD);

     @(posedge CLK);

    MODE_KEY = 1;

    @(posedge CLK);

    MODE_KEY = 0;

    #(CLK_PERIOD);
     
    $finish; 
end

endmodule