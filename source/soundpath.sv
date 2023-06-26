// ************************************************************************************************
// Soundpath module
//   inputs: sample_now <- from sample clk divider to activate seqdiv
//           mode <- off, sqare, saw, triangle
//           divisor <- value from LUT to calculate period
//           clk
//           n_rst <- expects a ACTIVE LOW rst Signals
//   output: sample <- 8 bit sample to be give to wave_comb and pwm
//           done <- signals when value is ready to be read
//
//   Use: This is an integration module that groups together the oscilator, seqential divider, and
//        waveshaper as they are always used together in a path.
// ************************************************************************************************

module soundpath(input logic clk, n_rst, sample_now,
                 input logic [1:0] mode,
                 input logic [18:0] divisor,
                 output logic [7:0] sample,
                 output logic done
);

  logic [7:0] Q; //quotient value before it is shaped by the waveshaper
  logic [18:0] count; //counting up value from oscilator, serves as dividend
  

  oscilator osc (.clk(clk),
                   .nrst(n_rst),
                   .max(divisor),
                   .count(count));

  seqdiv sdiv (.clk(clk),
               .RST(n_rst),
               .sample(sample_now),
               .count(count),
               .dsor(divisor),
               .done(done),
               .Q_out(Q));

  waveshaper waveshape (.Q(Q),
                        .mode({1'b0, mode}),
                        .count(count),
                        .divisor(divisor),
                        .sample(sample));

endmodule