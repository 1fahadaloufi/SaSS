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

  logic [3:0] note;
  logic sync_mode;
  logic sample_now;
  logic [8:0] sample1, sample2, comb_waveform;
  logic [1:0] mode;
  logic done1, done2, ready, pwm_o;
  logic [2:0] octave;
  logic octave_button;
  logic [3:0] multi;
  logic [3:0] note1,note2, note3, note4, pnote1, pnote2, snote;
  logic seq_on;

  inputandcontroller inputcont (.INPUT_keypad_i(pb[14:0]),
                                .INPUT_clk(hwclk),
                                .INPUT_NRST(~pb[16]),
                                .OUTPUT_octave_input_out(octave_button),
                                .OUTPUT_mode_out(sync_mode),
                                .OUTPUT_multi(multi),
                                .OUTPUT_note_1(note1),
                                .OUTPUT_note_2(note2),
                                .OUTPUT_note_3(note3),
                                .OUTPUT_note_4(note4));

  oct_fsm oct (.octave_in(octave_button),
               .clk(hwclk),
               .nrst(~pb[16]),
               .state(octave));

  sequencer seq (.keys({pb[19], pb[7:0], pb[18], pb[17]}), 
                 .clk(hwclk), 
                 .n_rst(~pb[16]), 
                 .note_sustain(snote), 
                 .to_led(right),
                 .sequencer_on(seq_on));

  assign red = seq_on;

  sequencer_piano_select select1 (.sequencer_on(seq_on),
                                 .piano_note(note1),
                                 .sequencer_note(snote),
                                 .used_note(pnote1));

  sequencer_piano_select select2 (.sequencer_on(seq_on),
                                 .piano_note(note2),
                                 .sequencer_note(0),
                                 .used_note(pnote2));

  soundpath sound1 (.clk(hwclk),
                   .n_rst(~pb[16]),
                   .sample_now(sample_now),
                   .note(pnote1),
                   .octave(octave),
                   .mode(mode),
                   .sample(sample1),
                   .done(done1));

  soundpath sound2 (.clk(hwclk),
                   .n_rst(~pb[16]),
                   .sample_now(sample_now),
                   .note(pnote2),
                   .octave(octave),
                   .mode(mode),
                   .sample(sample2),
                   .done(done2));

  // syncedge sedge (.clk(hwclk),
  //                .n_rst(~pb[16]),
  //                .asyc(pb[19]),
  //                .sync(sync_mode));

  waveform_fsm wave (.mode_key(sync_mode),
                     .clk(hwclk),
                     .n_rst(~pb[16]),
                     .mode(mode));

  std_rate_clk_div rate_clk (.clk(hwclk),
                             .nrst(~pb[16]),
                             .pulse(sample_now));

  waveform_comb wave_comb (.multi(multi[1]),
                           .done1(done1),
                           .done2(done2),
                           .sample1(sample1),
                           .sample2(sample2),
                           .ready(ready),
                           .comb_waveform(comb_waveform));

  pwm pm (.clk(hwclk),
          .n_rst(~pb[16]),
          .ready(ready),
          .comb_waveform(comb_waveform),
          .pwm_o(pwm_o));    

  assign left[7] = pwm_o;      
  assign left[1:0] = mode;

endmodule

// module syncedge (input logic clk, n_rst,
//                  input logic asyc,
//                  output logic sync);
//   logic Q1, Q2, Q3; 

//   always_ff @(posedge clk, negedge n_rst) begin
//     if(~n_rst) begin
//       Q1 <= 0;
//       Q2 <= 0;
//       Q3 <= 0;
//     end
//     else begin
//       Q1 <= asyc;
//       Q2 <= Q1;
//       Q3 <= Q2;
//     end
//   end
//   assign sync = Q2 & ~Q3;
// endmodule