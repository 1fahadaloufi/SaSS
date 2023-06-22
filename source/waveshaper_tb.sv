`default_nettype none

`timescale 1ns/10ps

module waveshaper_tb();

localparam CLK_PERIOD = 83.33; // 12 Mhz

logic tb_checking_outputs = 1'b0; 
integer tb_test_num;
logic[1024:0] tb_test_case; 


// TB Signals

//logic[4:0] tb_time_o; 
//logic [2:0] tb_mode; 
logic tb_clk, tb_Rst_i; 
//logic tb_button_i; 


logic [7:0] tb_sample;
logic [2:0] tb_mode;
logic [18:0] tb_count;
logic [18:0] tb_divisor;
logic [7:0] Q_in_tb;

// task single_button_press;
// begin
//     @(negedge tb_clk);
//     tb_sample = 1'b1; 
//     @(negedge tb_clk);
//     tb_sample = 1'b0; 
//     @(posedge tb_clk); 
// end
// endtask


task reset_dut;
    @(negedge tb_clk);
    tb_Rst_i = 1'b0; 
    @(negedge tb_clk); 
    tb_Rst_i = 1'b1; 
endtask


always begin
    tb_clk = 1'b0; 
    #(CLK_PERIOD / 2);
    tb_clk = 1'b1; 
    #(CLK_PERIOD / 2); 
end


 waveshaper DUT(.Q(Q_in_tb),
               .mode(tb_mode),
               .count(tb_count),
               .divisor(tb_divisor),
               .sample(tb_sample)); 

initial begin

    $dumpfile("dump.vcd");
    $dumpvars; 

    //tb_Rst_i = 1'b1; 
    Q_in_tb = 8'd127;

    tb_count = 19'd137260; 
    tb_divisor = 19'd152890; 
    tb_mode = 3'd0;
    
    //reset_dut;

    #(CLK_PERIOD * 7);

    tb_mode = 3'd1;

    #(CLK_PERIOD * 7);

    tb_count = 19'd27560;  
    tb_divisor = 19'd302791; 
    
    #(CLK_PERIOD * 7);

    tb_mode = 3'd2;

    #(CLK_PERIOD * 7);

    tb_mode = 3'd3;

    #(CLK_PERIOD * 7);

    tb_count = 19'd137260; 
    tb_divisor = 19'd152890; 

    #(CLK_PERIOD * 7);

    
    $finish; 
end

endmodule 