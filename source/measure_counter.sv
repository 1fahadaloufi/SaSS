module measure_counter (input logic play, beat_pulse, clk, n_rst, output logic [2:0]beat);

    logic [2:0]next_beat;

    always_ff @(posedge clk, negedge n_rst) begin
        if(n_rst)
        beat <= next_beat;
        else
        beat <= 0;
    end

    always_comb begin
        if(beat_pulse & play) begin
            if(beat == 7)
            next_beat = 0;
            else
            next_beat = beat + 1;
        end
        else
        next_beat = beat;

    end

endmodule