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
logic [14:0] tb_piano_keys;
logic tb_tempo_select, tb_seq_power, tb_seq_play;
logic tb_pwm_o, tb_seq_led_on;
logic [7:0] tb_beat_led;

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


 sass_synth DUT (.piano_keys(tb_piano_keys),
                 .hwclk(tb_clk),
                 .n_rst(tb_Rst_i),
                 .tempo_select(tb_tempo_select),
                 .seq_power(tb_seq_power),
                 .seq_play(tb_seq_play),
                 .pwm_o(tb_pwm_o),
                 .seq_led_on(tb_seq_led_on),
                 .beat_led(tb_beat_led));
                

initial begin

    $dumpfile("dump.vcd");
    $dumpvars; 

    tb_Rst_i = 1'b1;
    tb_piano_keys =15'b0;
    tb_tempo_select = 0;
    tb_seq_power = 0;
    tb_seq_play = 0;

    reset_dut();

    #(CLK_PERIOD * 2);

    tb_piano_keys =15'b100000000000000;

    #(CLK_PERIOD * 2);

    tb_piano_keys =15'b000000000000000;

    #(CLK_PERIOD * 2);

    tb_piano_keys =15'b100000000000000;

    #(CLK_PERIOD * 2);

    

    tb_piano_keys =15'b010000000000000;

    #(CLK_PERIOD * 2);

    tb_piano_keys =15'b000000000000000;

    #(CLK_PERIOD * 2);

    tb_piano_keys =15'b010000000000000;

    #(CLK_PERIOD * 2);

    tb_piano_keys =15'b000000000000000;

    #(CLK_PERIOD * 2);

    tb_piano_keys =15'b010000000000000;

    #(CLK_PERIOD * 2);

    tb_piano_keys =15'b000000000000000;

    #(CLK_PERIOD * 2);









    tb_piano_keys =15'b000000000000001;

    #(CLK_PERIOD * 7000);

    tb_piano_keys =15'b000000000010001;

    #(CLK_PERIOD * 7000);

    tb_piano_keys =15'b000000000010101;

    #(CLK_PERIOD * 7000);
    
    $finish; 
end

endmodule 