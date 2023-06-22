module oscilator (input logic clk, nrst, input logic [18:0] max, output logic [18:0]count);

  logic [18:0]next_count; // Initializing next_count variable for use in flip-flop

  always_ff @(posedge clk, negedge nrst) begin
    if(nrst)
    count <= next_count;
    else
    count <= 1; // Reset sets count to zero
  end

  always_comb begin

    if(count == max) begin
      next_count = 1; // Once the count hits the inputted max (divider) it wraps to 1
    end
    else begin
      next_count = count + 1; // Counting by 1
    end

    end 

endmodule