`default_nettype none

`timescale 1ns/10ps

module seqdiv_tb();

localparam CLK_PERIOD = 83.33; // 12 Mhz

logic tb_checking_outputs = 1'b0; 
integer tb_test_num;
logic[1024:0] tb_test_case; 


// TB Signals

//logic[4:0] tb_time_o; 
//logic [2:0] tb_mode; 
logic tb_clk, tb_Rst_i; 
//logic tb_button_i; 


logic tb_sample;
logic [18:0] tb_dividend;
logic [18:0]tb_divisor;
logic [7:0] tb_Q;
logic tb_done;

task single_button_press;
begin
    @(negedge tb_clk);
    tb_sample = 1'b1; 
    @(negedge tb_clk);
    tb_sample = 1'b0; 
    @(posedge tb_clk); 
end
endtask

// task check_mode;
// input logic[2:0] expected_mode; 
// input string string_mode; 
// begin
//     @(negedge tb_clk); 
//     tb_checking_outputs = 1'b1; 
//     if(tb_mode == expected_mode)
//         $display("Correct Mode: %s.", string_mode);
//     else
//         $error("Incorrect mode. Expected %s.", string_mode); 
    
//     #(1);
//     tb_checking_outputs = 1'b0;  
// end
// endtask

task reset_dut;
    @(negedge tb_clk);
    tb_Rst_i = 1'b0; 
    @(negedge tb_clk); 
    tb_Rst_i = 1'b1; 
endtask



// task check_time_o;
// input logic[4:0] exp_time_o; 
// begin
//     @(negedge tb_clk); 

//     tb_checking_outputs = 1'b1; 

//     if(tb_time_o == exp_time_o)
//         $display("Correct time_o: %0d.", exp_time_o);
//     else
//         $error("Incorrect mode. Expected %0d. Actual: %0d", exp_time_o, tb_time_o); 
    
//     #(1);
//     tb_checking_outputs = 1'b0;  
// end
// endtask


always begin
    tb_clk = 1'b0; 
    #(CLK_PERIOD / 2);
    tb_clk = 1'b1; 
    #(CLK_PERIOD / 2); 
end


 seqdiv DUT(.clk(tb_clk),
               .RST(tb_Rst_i),
               .sample(tb_sample),
               .count(tb_dividend),
               .dsor(tb_divisor),
               .Q_out(tb_Q),
               .done(tb_done)); 

initial begin

    $dumpfile("dump.vcd");
    $dumpvars; 

    tb_Rst_i = 1'b1; 
    tb_dividend = 19'd137260; 
    tb_divisor = 19'd152890; 
    //tb_test_case = "Initializing"; 

    reset_dut;
    single_button_press;
    #(CLK_PERIOD * 35);

    tb_dividend = 19'd37560;  
    tb_divisor = 19'd302791; 
    //tb_test_case = "Initializing"; 

    //reset_dut;
    single_button_press;
    #(CLK_PERIOD * 35);


    

    $finish; 
end

endmodule 