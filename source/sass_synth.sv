module sass_synth (input logic [14:0] piano_keys,
                   input logic n_rst, hwclk,
                   input logic tempo_select, seq_power, seq_play,
                   output logic pwm_o, seq_led_on,
                   output logic [7:0] beat_led,
                   output logic [1:0] mode_out);
logic [3:0] note;
  logic sync_mode;
  logic sample_now;
  logic [8:0] sample1, sample2, sample3, sample4, comb_waveform;
  logic [1:0] mode;
  logic done1, done2, done3, done4, ready;
  logic [2:0] octave;
  logic octave_button;
  logic [3:0] multi;
  logic [3:0] note1, note2, note3, note4, pnote1, pnote2, pnote3, pnote4, snote;
  logic seq_on;

  inputandcontroller inputcont (.INPUT_keypad_i(piano_keys),
                                .INPUT_clk(hwclk),
                                .INPUT_NRST(n_rst),
                                .OUTPUT_octave_input_out(octave_button),
                                .OUTPUT_mode_out(sync_mode),
                                .OUTPUT_multi(multi),
                                .OUTPUT_note_1(note1),
                                .OUTPUT_note_2(note2),
                                .OUTPUT_note_3(note3),
                                .OUTPUT_note_4(note4));

  oct_fsm oct (.octave_in(octave_button),
               .clk(hwclk),
               .nrst(n_rst),
               .state(octave));

  sequencer seq (.keys({tempo_select, piano_keys[7:0], seq_power, seq_play}), 
                 .clk(hwclk), 
                 .n_rst(n_rst), 
                 .note_sustain(snote), 
                 .to_led(beat_led),
                 .sequencer_on(seq_on));

  assign seq_led_on = seq_on;

  sequencer_piano_select select1 (.sequencer_on(seq_on),
                                 .piano_note(note1),
                                 .sequencer_note(snote),
                                 .used_note(pnote1));

  sequencer_piano_select select2 (.sequencer_on(seq_on),
                                 .piano_note(note2),
                                 .sequencer_note(0),
                                 .used_note(pnote2));

  sequencer_piano_select select3 (.sequencer_on(seq_on),
                                 .piano_note(note3),
                                 .sequencer_note(0),
                                 .used_note(pnote3));

  sequencer_piano_select select4 (.sequencer_on(seq_on),
                                 .piano_note(note4),
                                 .sequencer_note(0),
                                 .used_note(pnote4));

  soundpath sound1 (.clk(hwclk),
                   .n_rst(n_rst),
                   .sample_now(sample_now),
                   .note(pnote1),
                   .octave(octave),
                   .mode(mode),
                   .sample(sample1),
                   .done(done1));

  soundpath sound2 (.clk(hwclk),
                   .n_rst(n_rst),
                   .sample_now(sample_now),
                   .note(pnote2),
                   .octave(octave),
                   .mode(mode),
                   .sample(sample2),
                   .done(done2));

  soundpath sound3 (.clk(hwclk),
                   .n_rst(n_rst),
                   .sample_now(sample_now),
                   .note(pnote3),
                   .octave(octave),
                   .mode(mode),
                   .sample(sample3),
                   .done(done3));

  soundpath sound4 (.clk(hwclk),
                   .n_rst(n_rst),
                   .sample_now(sample_now),
                   .note(pnote4),
                   .octave(octave),
                   .mode(mode),
                   .sample(sample4),
                   .done(done4));

  waveform_fsm wave (.mode_key(sync_mode),
                     .clk(hwclk),
                     .n_rst(n_rst),
                     .mode(mode));

  std_rate_clk_div rate_clk (.clk(hwclk),
                             .nrst(n_rst),
                             .pulse(sample_now));

  new_waveform_comb wave_comb (.clk(hwclk),
                               .n_rst(n_rst),
                               .num_signals(multi[2:0]),
                               .done(done1 | done2 | done3 | done4),
                               .sample1(sample1),
                               .sample2(sample2),
                               .sample3(sample3),
                               .sample4(sample4),
                               .seq_on(seq_on),
                               .ready(ready),
                               .comb_waveform(comb_waveform));

  pwm pm (.clk(hwclk),
          .n_rst(n_rst),
          .ready(ready),
          .comb_waveform(comb_waveform),
          .pwm_o(pwm_o));  

    assign mode_out = mode;
endmodule