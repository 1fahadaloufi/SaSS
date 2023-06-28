`default_nettype none
module top 
(
  // I/O ports
  input  logic hwclk, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);

  sass_synth sass (.piano_keys(pb[14:0]),
                   .n_rst(~pb[16]),
                   .hwclk(hwclk),
                   .tempo_select(pb[19]),
                   .seq_power(pb[18]),
                   .seq_play(pb[17]),
                   .pwm_o(left[7]),
                   .seq_led_on(red),
                   .beat_led(right),
                   .mode_out(left[1:0]));
  
endmodule