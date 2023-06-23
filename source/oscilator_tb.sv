

`timescale 1ns/10ps

`default_nettype none



module oscilator_tb();

reg CLK, N_RST;

reg [18:0]MAX;

wire [18:0]COUNT; //a testbench has no inputs or outputs, the DUT has.

reg [1023:0] testname;

localparam time CLK_PERIOD = 100; // 10kHz clock

oscilator osc(.clk(CLK), .nrst(N_RST), .max(MAX), .count(COUNT)); //create instance of your module and map its inputs and outputs to the tb 

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

    MAX = 19'd146237; 

    #(CLK_PERIOD * 200000);
    
    

     

    

    

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