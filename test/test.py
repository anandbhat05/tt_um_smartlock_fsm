# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1

    # Apply sequence 1-0-1-1
    sequence = [1, 0, 1, 1]

    for bit in sequence:
        dut.ui_in.value = bit
        await ClockCycles(dut.clk, 1)

    # Check unlock (assuming bit0 is unlock)
    assert (dut.uo_out.value & 1) == 1, "Unlock failed"
