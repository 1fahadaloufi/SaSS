# STARS 2023 Design Final Project


## SaSS: Silicon Allowing Sound Synthesis
* Sydney Cozart
* Elena Lehner
* Connor Mehan
* Alex Rodriguez-Gonzalez​
* TA: Fahad Aloufi

## Synth & Sequencer
This project is an ASIC for a synthesizer that takes in 13 "piano key" inputs and outputs their corresponding sounds. The synthesizer features 3 different waveforms to choose from: square, sawtooth, and triangle. The synthesizer also has an octave mode allowing the user to cycle through 7 possible octaves.

In addition to "piano mode," the ASIC also has a sequencer mode. The sequencer mode has 8 beats whose notes can be edited to form a repeating sound pattern. Within sequencer mode, the tempo can be adjusted between 4 settings.

## Pin Layout
1: C; sequencer note 1

2: C#; sequencer note 2

3: D; sequencer note 3

4: D#; sequencer note 4

5: E; sequencer note 5

6: F; sequencer note 6

7: F#; sequencer note 7

8: G; sequencer note 8

9: G#

10: A

11: A#

12: B

13: C

14: waveform mode

15: octave mode

16: sequencer/piano mode

17: sequencer tempo

18: sequencer play/pause



## Supporting Equipment
List all the required equipment and upload a breadboard with the equipment set up (recommend using tinkercad circuits if possible)

## RTL Diagrams
Only show and describe your top-level RTL that shows the total # of flip flops here. For the rest of your RTLs, link to a "docs" directory within the GitHub page
that shows all component RTLs, state diagrams, and the top level RTL. Please have those as a PDF or a JPEG. 

