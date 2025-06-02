`timescale 1ns / 1ps

module debouncer(
    input clk_100MHz,
    input clk_1kHz,
    input reset,
    input reset_button,
    input saveH_button,
    input saveL_button,
    output reg reset_button_out,
    output reg saveH_button_out,
    output reg saveL_button_out
    );
    
    reg prev_reset;
    reg prev_saveH;
    reg prev_saveL;

    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            reset_button_out <= 0;
            saveH_button_out <= 0;
            saveL_button_out <= 0;
            prev_reset <= 0;
            prev_saveH <= 0;
            prev_saveL <= 0;
        end else if (clk_1kHz) begin
            reset_button_out <= reset_button & ~prev_reset;
            saveH_button_out <= saveH_button & ~prev_saveH;
            saveL_button_out <= saveL_button & ~prev_saveL;
            prev_reset <= reset_button;
            prev_saveH <= saveH_button;
            prev_saveL <= saveL_button;
         end
    end
endmodule