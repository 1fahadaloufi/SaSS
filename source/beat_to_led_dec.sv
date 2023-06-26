/************************************************************************************************************/
// Inputs:
//    beat -> current beat the sycnroniser is on (0-7)
//    sequencer_on -> A 1 or 0 value which denotes that the chip is in sequencer mode if 1 and piano mode if 0
//
// Outputs:
//    to_led -> Signal depicting which light should be on in the fpga
/*************************************************************************************************************/

module beat_to_led_dec (input logic [2:0]beat, input logic sequencer_on, output logic [7:0]to_led);

    always_comb begin

        if(sequencer_on) begin
            case(beat)
            3'd0: to_led = 8'b00000001;
            3'd1: to_led = 8'b00000010;
            3'd2: to_led = 8'b00000100;
            3'd3: to_led = 8'b00001000;
            3'd4: to_led = 8'b00010000;
            3'd5: to_led = 8'b00100000;
            3'd6: to_led = 8'b01000000;
            3'd7: to_led = 8'b10000000;
            endcase
        end
        else
            to_led = 8'b0;

    end

endmodule