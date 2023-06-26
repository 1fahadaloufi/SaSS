module sequencer_clk_div (input logic sequencer_on, clk, n_rst, output logic beat_pulse);

    logic [22:0]count, next_count;

    always_ff @(posedge clk, negedge n_rst) begin
        if(n_rst)
        count <= next_count;
        else
        count <= 0;
    end

    always_comb
        if(sequencer_on) begin
            if(count == 4999999) begin
                beat_pulse = 1;
                next_count = 0;
            end
            else begin
                beat_pulse = 0;
                next_count = count + 1;
            end
        end
        else begin
            beat_pulse = 0;
            next_count = 0;
        end

endmodule