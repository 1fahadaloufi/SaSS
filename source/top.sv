`default_nettype none

module top 
(
  // I/O ports
  input  logic hwclk, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);
  logic dummy;

  decedge u2(.clk(hwclk), .RST(pb[0]), .button(pb[3]), .syncedge(dummy));
  seqdiv u1 (.clk(hwclk), .RST(pb[0]), .count(19'd137260), .dsor(19'd152890), .sample(dummy), .Q_out({right}), .done(red));
  test u3 (.clk(hwclk), .RST(pb[0]), .start(dummy), .on(left[7]));

endmodule

module decedge(
  input logic clk, RST, button,
  output logic syncedge
);
  logic dummy, Q1, Q2;
  always_comb begin
    syncedge = Q1 & ~Q2;
  end
  
  always_ff @(posedge clk, posedge RST) begin
    if(RST) begin
      dummy <= 0;
      Q1 <= 0;
      Q2 <= 0;
    end
    else begin
      dummy <= button;
      Q1 <= dummy;
      Q2 <= Q1;
    end
  end
endmodule

module test(
  input logic clk, RST, start,
  output logic on
);
  logic act;
  logic [5:0] cnt, next_cnt;
  always_comb begin
    if(start) begin
      act = 1;
    end
    else if (cnt > 0 && cnt < 28) begin
      act = 1;
    end
    else
      act = 0;

    if(cnt > 27)
      on = 1;
    else
      on = 0;

    if(act) begin
      next_cnt = cnt + 1;
    end
    else begin
      next_cnt = 0;
    end
  end

  always @(posedge clk, posedge RST) begin
    if(RST) begin
      cnt <= 0;
    end
    else begin
      cnt <= next_cnt;
    end
  end
endmodule