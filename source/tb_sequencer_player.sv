`timescale 1ns/10ps

`default_nettype none



module tb_sequencer();

reg CLK, N_RST;

// reg [7:0]KEY;

reg SEQUENCER_ON, TOGGLE;
reg [2:0]BEAT;

wire [3:0] NOTE_SUSTAIN; //a testbench has no inputs or outputs, the DUT has

reg [1023:0] testname;

localparam time CLK_PERIOD = 100; // 10kHz clock

sequencer_player #(.PLAY_ON(0)) player_1
                         (.toggle(TOGGLE), 
                          .beat(BEAT), 
                          .sequencer_on(SEQUENCER_ON), .clk(CLK), .n_rst(N_RST),
                          .note_sustain(NOTE_SUSTAIN));

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
    SEQUENCER_ON = 1;
    N_RST = 1'b1; 
    BEAT = 3;

    @(negedge CLK);

    SEQUENCER_ON = 1;

    #(CLK_PERIOD * 3);

    @(negedge CLK);

    TOGGLE = 1;

    @(negedge CLK);

    TOGGLE = 0;

    @(negedge CLK);

    TOGGLE = 1;

    @(negedge CLK);

    TOGGLE = 0;

    @(posedge CLK);

    BEAT = 0;

    @(posedge CLK);

    BEAT = 1;

    @(posedge CLK);

    BEAT = 2;

    @(posedge CLK);

    BEAT = 3;

    @(posedge CLK);

    BEAT = 4;

    @(posedge CLK);

    BEAT = 5;

    @(posedge CLK);

    BEAT = 6;

    @(posedge CLK);

    BEAT = 7;

    @(posedge CLK);

    BEAT = 0;

    @(posedge CLK);

    BEAT = 1;

    #(CLK_PERIOD * 1);



    $finish;

end

endmodule