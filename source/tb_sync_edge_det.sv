`default_nettype none
`timescale 1ns/10ps


module tb_sync_edge_det(); 


// Local Parameters
localparam CLK_PERIOD = 83.33; // 12 MHz clock 
localparam RESET_ACTIVE = 1'b0; 
localparam RESET_INACTIVE = 1'b1; 


// Input/Output signals for your module to be tested
logic tb_clk, tb_n_rst, tb_async_in;
logic tb_edge_det; 

// logic[3:0] a = '1; // => 4'b1111 
// logic [3:0] b = '0; // => 4'b0000; 

// Instantiate the module

sync_edge_det DUT(.clk(tb_clk),
                  .n_rst(tb_n_rst),
                  .async_in(tb_async_in), 
                  .edge_det(tb_edge_det)
                  ); 


// RESET TASK
task reset_dut;
begin
    @(negedge tb_clk); 
    tb_n_rst = RESET_ACTIVE; 
    @(negedge tb_clk); 
    tb_n_rst = RESET_INACTIVE; 
end 
endtask


// Clock Generation Block
always begin
    tb_clk = 1'b0; 
    #(CLK_PERIOD / 2); 
    tb_clk = 1'b1; 
    #(CLK_PERIOD / 2); 
end



// simulation data
initial begin
    $dumpfile("dump.vcd");
    $dumpvars; 
end 

// Simulation
initial begin
    // set initial values for inputs
    tb_async_in = 1'b0; 
    tb_n_rst = RESET_INACTIVE; 


    // Test case 1: Reset the device
    #(CLK_PERIOD); 


    reset_dut(); 


    #(CLK_PERIOD * 10); 




    $finish; 
    $stop; 
    $display("")

end






endmodule 
