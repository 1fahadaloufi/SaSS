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

waveform_comb u1 (.multi(pb[3]), .done1(pb[2]), .done2(pb[1]), .clk(hwclk), .n_rst(pb[10]), .sample1(8'd134), .sample2(8'd32), .ready(green), .comb_waveform(right));

endmodule