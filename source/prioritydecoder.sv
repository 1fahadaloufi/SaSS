// This program represents the combinational logic block 
//which decodes the pressed note key into a 4-bit value.

module pri_dec (
  input logic [13:0] synced_i,
  output logic [3:0] note_1, note_2,
  output logic multi
);

assign {note_1} =
                synced_i[13] == 1 ? 4'b1101 :
                synced_i[12] == 1 ? 4'b1100 :
                synced_i[11] == 1 ? 4'b1011 :
                synced_i[10] == 1 ? 4'b1010 :
                synced_i[9] == 1 ? 4'b1001 :
                synced_i[8] == 1 ? 4'b1000 :
                synced_i[7] == 1 ? 4'b0111 :
                synced_i[6] == 1 ? 4'b0110 :
                synced_i[5] == 1 ? 4'b0101 :
                synced_i[4] == 1 ? 4'b0100 :
                synced_i[3] == 1 ? 4'b0011 :
                synced_i[2] == 1 ? 4'b0010 :
                synced_i[1] == 1 ? 4'b0001 :
                synced_i[0] == 1 ? 4'b0000 :
                4'b0000;

assign {note_2} =
                synced_i[0] == 1 ? 4'b0000 :
                synced_i[1] == 1 ? 4'b0001 :
                synced_i[2] == 1 ? 4'b0010 :
                synced_i[3] == 1 ? 4'b0011 :
                synced_i[4] == 1 ? 4'b0100 :
                synced_i[5] == 1 ? 4'b0101 :
                synced_i[6] == 1 ? 4'b0110 :
                synced_i[7] == 1 ? 4'b0111 :
                synced_i[8] == 1 ? 4'b1000 :
                synced_i[9] == 1 ? 4'b1001 :
                synced_i[10] == 1 ? 4'b1010 :
                synced_i[11] == 1 ? 4'b1011 :
                synced_i[12] == 1 ? 4'b1100 :
                synced_i[13] == 1 ? 4'b1101 :
                4'b0000;

assign multi = !(^synced_i | (~|synced_i));

endmodule