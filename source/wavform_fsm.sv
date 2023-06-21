

module waveform_fsm (input logic mode_key, clk, n_rst, output logic [1:0]mode);

logic [1:0]next_state; // Declaring intermediate variable for flip-flop
typedef enum logic [1:0]{OFF, SQUARE, SAW, TRI} wave_types; // Giving names to states, OFF is 0, SQUARE is 1, SAW is 2, and TRI is 3

    always_ff @ (posedge clk, negedge n_rst) begin
        if(n_rst)
            mode <= next_state;
        else
            mode <= 2'd0; // Mode set to OFF on reset
    end

    always_comb begin // When mode_key is pressed if cycles modes in the order: OFF -> SQUARE -> SAW -> TRI -> OFF -> ...

        case(mode)
        OFF: next_state = mode_key ? SQUARE : OFF; 
        SQUARE: next_state = mode_key ? SAW : SQUARE;
        SAW: next_state = mode_key ? TRI : SAW;
        TRI: next_state = mode_key ? OFF : TRI;
        endcase

    end


endmodule