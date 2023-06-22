

module pwm (input logic [7:0]comb_waveform, input logic clk, n_rst, ready, output logic pwm_o);

    logic [7:0]count, next_count; // Delaring local use variables, count stores current count and next_count is for flip-flop
    logic [7:0]current_waveform, next_waveform;

    always_ff @ (posedge clk, negedge n_rst) begin
        if(n_rst) begin
            count <= next_count;
            current_waveform <= next_waveform;
        end
        else begin
            count <= 0; // Count resets to zero if reset
            current_waveform <= 8'd0;
        end
    end

    always_comb begin

        if(ready)
        next_waveform = comb_waveform;
        else 
        next_waveform = current_waveform;

        next_count = (count == 8'd255) ? 8'd0 : (count + 1); // If the count = 255 it wraps to zero, if not it adds 1

        if(count < current_waveform)
            pwm_o = 1; // PWM 1 when its count is less than inputted value from waveform combiner
        else
            pwm_o = 0; // PWM 0 when its count is greater than or equal to inputted value from waveform combiner

    end

endmodule