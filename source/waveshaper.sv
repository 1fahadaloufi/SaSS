module waveshaper(
    input logic [7:0] Q,
    input logic [2:0] mode,
    input logic [18:0] count, divisor,
    output logic [7:0] sample
);
    logic [8:0] b_sample;

    always_comb begin
        case(mode)
            0: b_sample = 0;                                //off
            1: b_sample = (count > divisor >> 1) ? 255 : 0; //square
            2: b_sample = {1'b0, Q};                        //saw
            3: begin                                        //triangle
                if(count < divisor >> 1)                    // |
                    b_sample = {1'b0, Q} << 1;              // |
                else                                        // |
                    b_sample = 510 - ({1'b0, Q} << 1);      //\ /
               end
        endcase
        sample = b_sample[7:0];
    end
endmodule