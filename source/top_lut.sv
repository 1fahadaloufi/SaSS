`default_nettype none
module top (
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
  
  //freq_div u1(.[3:0]note(note), .[2:0]octave(octave), .[18:0]divider(divider));
  //newfreq_div u1(.[3:0]note(note), .[2:0]octave(octave), .[18:0]divider(divider));
endmodule
