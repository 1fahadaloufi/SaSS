
`timescale 1ns/10ps

`default_nettype none



module pwm_tb();

reg CLK, N_RST;

reg [7:0]MAX;

reg READY;

wire PWM_O; //a testbench has no inputs or outputs, the DUT has

reg [1023:0] testname;

localparam time CLK_PERIOD = 100; // 10kHz clock

pwm pwm(.clk(CLK), .n_rst(N_RST), .comb_waveform(MAX), .pwm_o(PWM_O), .ready(READY)); //create instance of your module and map its inputs and outputs to the tb 

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

    READY = 1;

    MAX = 8'd130; 

    @(negedge CLK);

    READY = 0;

    @(negedge CLK);

    MAX = 8'd100;

    #(CLK_PERIOD * 254);



    @(negedge CLK);

    MAX = 8'd26; 

    #(CLK_PERIOD * 256);
    
    
@(negedge CLK);

    MAX = 8'd255; 

@(posedge CLK);

    READY = 1;

@(posedge CLK);

    READY = 0;

    #(CLK_PERIOD * 280);
     

    

    

//     testname="random test1 with N_RST high";

//     @(negedge CLK); 

//     ASYNC_IN = 1'b0; N_RST = 1'b1;

//     @(posedge CLK);     

// ​

    

//     testname="random test2 with N_RST high";

//     @(negedge CLK); 

//     ASYNC_IN = 1'b1; N_RST = 1'b1;

//     @(posedge CLK); 

    

//     testname="random test3 with N_RST high";

//     @(negedge CLK); 

//     ASYNC_IN = 1'b0; N_RST = 1'b1;

//     @(posedge CLK); 

    

//    testname="random test4 with N_RST high";

//    @(negedge CLK); 

//     ASYNC_IN = 1'b1; N_RST = 1'b1;

//     @(posedge CLK); 

    

//     testname="random test5 with N_RST high";

//     @(negedge CLK); 

//     ASYNC_IN = 1'b1; N_RST = 1'b1;

//     @(posedge CLK); 

    

// ​

//     testname="random test6 with N_RST high";

//     @(negedge CLK); 

//     ASYNC_IN = 1'b0; N_RST = 1'b1;

//     @(posedge CLK); 

    

//    testname="random test7 with N_RST high";

//    @(negedge CLK);

//     ASYNC_IN = 1'b1; N_RST = 1'b1;

//     @(posedge CLK); 

// ​

    

    $finish; 

// add your test cases here

end

endmodule