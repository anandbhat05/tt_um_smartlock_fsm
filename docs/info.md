## How it works

This Smart Lock is implemented using a Finite State Machine (FSM).

- Input: `ui_in[0]` → serial bit input
- Output: `uo_out[0]` → unlock signal

The FSM detects the sequence: **1011**

### States:
- S0 → Start
- S1 → detected '1'
- S2 → detected '10'
- S3 → detected '101'
- S4 → detected '1011' → Unlock

---

## How to test

1. Apply reset (`rst_n = 0 → 1`)
2. Send input bits serially on `ui_in[0]`
3. For sequence `1 → 0 → 1 → 1`, output `uo_out[0] = 1`

Example:

| Cycle | Input | Output |
|------ |------ |--------|
| 1     | 1     | 0      |
| 2     | 0     | 0      |
| 3     | 1     | 0      |
| 4     | 1     | 1      |

---

## External hardware

None required.
