`timescale 1ns/10ps

`default_nettype none



module std_rate_clk_div_tb();

reg CLK, N_RST;

wire COUNT; //a testbench has no inputs or outputs, the DUT has

reg [1023:0] testname;

localparam time CLK_PERIOD = 100; // 10kHz clock

std_rate_clk_div u2 (.clk(CLK), .nrst(N_RST), .pulse(COUNT));

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
     
    N_RST = 1'b1; 

    #(CLK_PERIOD * 1000);



end

endmodule