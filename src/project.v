/*
 * Smart Lock FSM - TinyTapeout Project
 */

`default_nettype none

module tt_um_smart_lock (
    input  wire [7:0] ui_in,    // Inputs
    output wire [7:0] uo_out,   // Outputs
    input  wire [7:0] uio_in,   // Not used
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // Disable bidirectional IOs
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Input mapping
    wire in_bit = ui_in[0];   // Input bit stream

    // FSM States
    reg [2:0] state;

    parameter S0 = 3'd0,
              S1 = 3'd1,
              S2 = 3'd2,
              S3 = 3'd3,
              S4 = 3'd4;  // Unlock state

    // Output register
    reg unlock;

    // FSM Logic (Password = 1011)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state  <= S0;
            unlock <= 1'b0;
        end else begin
            case (state)
                S0: begin
                    unlock <= 0;
                    state  <= (in_bit) ? S1 : S0;
                end

                S1: begin
                    unlock <= 0;
                    state  <= (in_bit) ? S1 : S2;
                end

                S2: begin
                    unlock <= 0;
                    state  <= (in_bit) ? S3 : S0;
                end

                S3: begin
                    if (in_bit) begin
                        state  <= S4;
                        unlock <= 1;  // Correct sequence detected
                    end else begin
                        state  <= S2;
                        unlock <= 0;
                    end
                end

                S4: begin
                    // Stay unlocked for 1 cycle, then reset
                    unlock <= 0;
                    state  <= S0;
                end

                default: begin
                    state  <= S0;
                    unlock <= 0;
                end
            endcase
        end
    end

    // Output mapping
    assign uo_out[0] = unlock;  // Unlock signal
    assign uo_out[7:1] = 7'b0;

    // Prevent unused warnings
    wire _unused = &{ena, uio_in, ui_in[7:1], 1'b0};

endmodule
