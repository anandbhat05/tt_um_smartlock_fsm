module tt_um_smart_lock (
    input  wire [7:0] ui_in,
    output reg  [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire clk,
    input  wire rst_n,
    input  wire ena
);

    assign uio_out = 0;
    assign uio_oe  = 0;

    reg [2:0] state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 0;
            uo_out <= 0;
        end else if (ena) begin
            case (state)
                0: if (ui_in[0]) state <= 1;
                1: if (!ui_in[0]) state <= 2;
                2: begin
                    uo_out[0] <= 1; // unlock
                    state <= 0;
                end
            endcase
        end
    end

endmodule
