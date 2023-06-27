`default_nettype none

`timescale 1ns/10ps

module tb_soundpath();

localparam CLK_PERIOD = 83.33; // 12 Mhz

logic tb_checking_outputs = 1'b0; 
integer tb_test_num;
logic[1024:0] tb_test_case; 


// TB Signals




logic tb_clk;
logic tb_Rst_i;
logic [1:0] tb_mode;
logic [18:0] tb_divisor;
logic [8:0] tb_sample;
logic tb_done;
logic tb_sample_now;
logic tb_pwm;
logic [8:0] tb_pwm_sample;

task reset_dut;
    @(negedge tb_clk);
    tb_Rst_i = 1'b0; 
    @(negedge tb_clk); 
    tb_Rst_i = 1'b1; 
endtask

always begin
    tb_sample_now = 0;
    #(CLK_PERIOD * 255);
    tb_sample_now = 1;
    #(CLK_PERIOD);
end

always begin
    tb_clk = 1'b0; 
    #(CLK_PERIOD / 2);
    tb_clk = 1'b1; 
    #(CLK_PERIOD / 2); 
end


 soundpath DUT1 (.clk(tb_clk),
                 .n_rst(tb_Rst_i),
                 .sample_now(tb_sample_now),
                 .mode(tb_mode),
                 .note(12),
                 .octave(6),
                 .sample(tb_sample),
                 .done(tb_done));
                
//  pwm DUT2(.clk(tb_clk),
//           .n_rst(tb_Rst_i),
//           .comb_waveform(tb_sample),
//           .ready(tb_done),
//           .pwm_o(tb_pwm));

always_ff @(posedge tb_clk, negedge tb_Rst_i) begin
    if(!tb_Rst_i) begin
        tb_pwm_sample <= 0;
    end
    else
        if(tb_done)
            tb_pwm_sample <= tb_sample;
        else
            tb_pwm_sample <= tb_pwm_sample;
end

initial begin

    $dumpfile("dump.vcd");
    $dumpvars; 

    tb_mode = 2'd0;
    tb_Rst_i = 1;
    tb_divisor = 19'd2658;
    
    reset_dut();

    #(CLK_PERIOD);

    // #(CLK_PERIOD * (tb_divisor * 5));

    // tb_mode = 2'd1;
    
    // #(CLK_PERIOD * (tb_divisor * 5));

    // tb_mode = 2'd2;
    
    // #(CLK_PERIOD * (tb_divisor * 5));

    tb_mode = 2'd3;
    
    #(CLK_PERIOD * (tb_divisor * 30));
    
    $finish; 
end

endmodule 