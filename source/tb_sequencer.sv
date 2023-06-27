`timescale 1ns/1ns

`default_nettype none



module tb_sequencer();

reg CLK, N_RST;

reg [7:0]KEY;

reg SEQUENCER_ON, PLAY, TEMPO_SEL;

wire [3:0] NOTE_SUSTAIN; //a testbench has no inputs or outputs, the DUT has

reg [1023:0] testname;

localparam time CLK_PERIOD = 100; // 10kHz clock

sequencer dfg (.keys({TEMPO_SEL, KEY, SEQUENCER_ON, PLAY}), .clk(CLK), .n_rst(N_RST), .note_sustain(NOTE_SUSTAIN), .to_led(), .sequencer_on());

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
    N_RST = 1'b0;

    @(negedge CLK);
    KEY = 0;
    SEQUENCER_ON = 0;
    N_RST = 1'b1; 
    PLAY = 0;
    TEMPO_SEL = 0;

    @(negedge CLK);

    SEQUENCER_ON = 1;

    #(CLK_PERIOD * 30);

    @(negedge CLK);

    KEY[0] = 1;

    #(CLK_PERIOD * 30);

    @(negedge CLK);

    KEY[0] = 0;

    #(CLK_PERIOD * 30);

    @(negedge CLK);

    KEY[0] = 1;

    #(CLK_PERIOD * 30);

    @(negedge CLK); 

    KEY[0] = 0;

    #(CLK_PERIOD * 30);

     @(negedge CLK);

    KEY[1] = 1;

    #(CLK_PERIOD * 30);

    @(negedge CLK);

    KEY[1] = 0;

    #(CLK_PERIOD * 30);

    @(negedge CLK);

    KEY[6] = 1;

    #(CLK_PERIOD * 30);

    @(negedge CLK); 

    KEY[6] = 0;
    
    #(CLK_PERIOD * 30);

    @(negedge CLK);

    PLAY = 1;

    #(CLK_PERIOD * 30);

    @(negedge CLK);

    PLAY = 0;

    #(CLK_PERIOD * 10000000);

    $finish;

end

endmodule