/************************************************************************************************************/
// Inputs:
//    clk -> 10kHz clock
//    n_rst -> Async negative reset, resets when n_rst is 0
//    tempo_button -> Pulse signal to determine to change tempos
//    beat_pulse -> A pulse which delays the system clock signal down to the desired tempo of the sequencer, tells measure_counter when to count
//
// Outputs:
//    tempo -> 23 bit value which determines the rate at which the measure counter counts
/*************************************************************************************************************/

module tempo_select (input logic tempo_button, clk, n_rst, output logic [21:0]tempo);

    logic [21:0]next_tempo;
    parameter BPM120 = 22'd2499999;
    parameter BPM240 = 22'd1249999;
    parameter BPM480 = 22'd625000;
    parameter BPM320 = 22'd937499;


    always_ff @(posedge clk, negedge n_rst) begin
        if(n_rst)
        tempo <= next_tempo;
        else
        tempo <= BPM240;
    end

    always_comb begin

        case(tempo)
        BPM240: next_tempo = tempo_button ? BPM320 : BPM240; 
        BPM320: next_tempo = tempo_button ? BPM480 : BPM320;
        BPM480: next_tempo = tempo_button ? BPM120 : BPM480;
        BPM120: next_tempo = tempo_button ? BPM240 : BPM120;
        default: next_tempo = BPM240;
        endcase 

    end

endmodule