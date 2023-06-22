module sync_edge_det(
    input logic clk, n_rst, async_in,
    output logic edge_det
); 

logic q1; 
logic q2; 
logic q3; 

always_ff @(posedge clk, negedge n_rst) begin
    if(n_rst == 1'b0) begin
        q1 <= 0; 
        q2 <= 0; 
        q3 <= 0; 
    end
    else begin
        q1 <= async_in; 
        q2 <= q1; 
        q3 <= q2; 
    end
end


assign edge_det = q2 & ~q3; 

endmodule 