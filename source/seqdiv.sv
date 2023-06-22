// ************************************************************************************************
// Sequential Divider module
//   inputs: count <- 19 bit value from oscilator should be smaller than dsor as it is * 256
//           dsor <- 19 bit value from frequence table
//           sample <- expects a pulse from sample counter to tell to sample every 255 ticks
//           clk
//           RST <- expects a ACTIVE LOW rst Signals
//   output: Q_out <- 8 bit quotient fed to waveshaper
//           done <- signals when value is ready to be read
// ************************************************************************************************



module seqdiv 
//#(parameter BIT_WIDTH = 4;)
(
  input logic [18:0] count, dsor, //BIT_WIDTH - 1
  input logic sample, clk, RST,
  output logic [7:0] Q_out, //BIT_WIDTH
  output logic done
);
  logic [27:0] part1_A, part1_Q, next_Q, Q, next_M, M, next_A, A; //BIT_WIDTH
  logic [5:0] next_C, C;
  logic start, next_start, dived, next_dived;

  always_comb begin
    
    if(sample) begin
      next_A = 0;
      next_M = {1'b0, 8'b0, dsor};
      next_Q = {1'b0,count, 8'b0};
      next_C = 0;
      part1_A = 0;
      part1_Q = 0;
      done = 0;

      next_start = 1;
      next_dived = 0;

      Q_out = 0;
    end
    else if(C < (28) & start) begin //BIT_WIDTH + 1
      {part1_A, part1_Q} = {A, Q} << 1;
      next_M = M;
      if(part1_A[27]) begin
        next_A = part1_A + M;
      end
      else begin
        next_A = part1_A - M;
      end
      
      if(next_A[27]) begin
        next_Q = part1_Q;
      end
      else begin
        next_Q = part1_Q + 1;
      end
      next_C = C + 1;
      done = 0;

      next_start = 1;

      next_dived = 1; 

      Q_out = 0;
    end
    else if (dived) begin
      done = 1; 
      next_Q = Q;
      part1_Q = 0;
      next_M = M;
      next_A = A;
      part1_A = 0;
      next_C = C;

      next_start = 0;
      next_dived = 1;

      Q_out = Q[7:0];
    end
    else begin
      done = 0; 
      next_Q = Q;
      part1_Q = 0;
      next_M = M;
      next_A = A;
      part1_A = 0;
      next_C = C;

      next_start = 0;
      next_dived = 0;

      Q_out = Q[7:0];
    end
  end
  
  always_ff @(posedge clk, negedge RST) begin
    if(!RST) begin
      C <= 0;
      Q <= 0;
      M <= 0;
      A <= 0;

      start <= 0;
      dived <= 0;
    end
    else begin
      Q <= next_Q;
      M <= next_M;
      C <= next_C;
      A <= next_A;

      start <= next_start;
      dived <= next_dived;
    end
  end
endmodule



