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

module tempo_select (input logic tempo_button, clk, n_rst, output logic [22:0]tempo);

    logic [22:0]next_tempo;
    parameter BPM120 = 23'd2499999;
    parameter BPM240 = 23'd1249999;
    parameter BPM75 = 23'd3999999;
    parameter BPM100 = 23'd2999999;

    always_ff @(posedge clk, negedge n_rst) begin
        if(n_rst)
        tempo <= next_tempo;
        else
        tempo <= BPM240;
    end

    always_comb begin

        case(tempo)
        BPM240: next_tempo = tempo_button ? BPM120 : BPM240; 
        BPM120: next_tempo = tempo_button ? BPM100 : BPM120;
        BPM100: next_tempo = tempo_button ? BPM75 : BPM100;
        BPM75: next_tempo = tempo_button ? BPM240 : BPM75;
        default: next_tempo = BPM240;
        endcase 

    end

endmodule