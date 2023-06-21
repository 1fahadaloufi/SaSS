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
  
  freq_div u1(.[3:0]note(note), .[2:0]octave(octave), .[18:0]divider(divider));
endmodule

module freq_div(input logic [3:0]note, input logic [2:0]octave,
                output logic [18:0]divider);
always_comb begin
  case(note):
   4'd0: divider = 19'd305780 >> octave; //C
   4'd1: divider = 19'd288618 >> octave; //C#
   4'd2: divider = 19'd272419 >> octave; //D
   4'd3: divider = 19'd257130 >> octave; //D#
   4'd4: divider = 19'd242698 >> octave; //E
   4'd5: divider = 19'd229077 >> octave; //F
   4'd6: divider = 19'd216219 >> octave; //F#
   4'd7: divider = 19'd204084 >> octave; //G
   4'd8: divider = 19'd192630 >> octave; //G#
   4'd9: divider = 19'd181818 >> octave; //A
   4'd10: divider =19'd171618 >> octave; //A#
   4'd11: divider = 19'd161982 >> octave; //B
   4'd12: divider = 19'd152890 >> octave; //C
  endcase
end
endmodule