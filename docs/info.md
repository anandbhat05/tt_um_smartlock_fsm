<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The Smart Lock is implemented using a Finite State Machine (FSM) that detects a predefined binary password (e.g., 1011). Each input bit moves the system through states. If the correct sequence is entered, the FSM reaches the unlock state and asserts the unlock signal. Any incorrect input resets or redirects the state progression.

## How to test

To test the design, first apply a reset signal to initialize the FSM. Then, provide input bits sequentially (in) on each clock cycle and observe the output. When the correct sequence is entered, the unlock signal should go high. For incorrect sequences, the system should remain locked and reset or transition accordingly. Multiple input combinations and edge cases can be verified using a testbench.

## External hardware

No external hardware required.
