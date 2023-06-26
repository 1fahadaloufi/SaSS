module sequencer_encoder (input logic [9:0]keys, input logic clk, n_rst, output logic [7:0]toggle, output logic sequencer_on, play);

    // First 8 keys (9:2) are used for toggles 7:0, key 1 is for sequencer_on, and key 0 is for play

    logic [9:0]inter_keys, keys_sync, keys_edge_det, keys_pos_edge; // Intermiediate signal for keys in syncronyser
    logic next_play, next_sequencer_on;

// Syncroniser
  
    always_ff @(posedge clk, negedge n_rst) begin 
        if(n_rst) begin
        keys_sync <= inter_keys;
        inter_keys <= keys;
        end
        else begin
        keys_sync <= 0;
        inter_keys <= 0;
        end
    end

// Edge detector
    always_ff @(posedge clk, negedge n_rst) begin 
        if(n_rst)
        keys_edge_det <= keys_sync;
        else
        keys_edge_det <= 0;
    end

    assign keys_pos_edge = (keys_sync & ~keys_edge_det); // Edge detected key signals
    assign toggle = keys_pos_edge[9:2];

// Key value sustainer
    always_ff @(posedge clk, negedge n_rst) begin 
        if(n_rst) begin
            sequencer_on <= next_sequencer_on;
            play <= next_play;
        end
        else begin
            sequencer_on <= 0;
            play <= 0;
        end
    end

    always_comb begin

        case(sequencer_on)
        0: next_sequencer_on = keys_pos_edge[1] ? 1 : 0;
        1: next_sequencer_on = keys_pos_edge[1] ? 0 : 1;
        endcase

        case(play)
        0: next_play = keys_pos_edge[0] ? 1 : 0;
        1: next_play = keys_pos_edge[0] ? 0 : 1;
        endcase
        
    end

    

endmodule