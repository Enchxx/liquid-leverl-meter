`timescale 1ns / 1ps

module clock_manager(
    input clk_100MHz,
    input reset,
    output clk_1kHz,
    output clk_1Hz
    );
    
    reg [16:0] Q1;
    reg [26:0] Q2;
    
    always @(posedge clk_100MHz or posedge reset) begin
        if(reset) begin
            Q1 = 17'd0;
            Q2 = 27'd0;
        end else begin
        if(Q1 != 17'd99999)
            Q1 <= Q1 + 1;
        else
            Q1 <= 17'd0;
        if (Q2 != 27'd99999999)
            Q2 <= Q2 + 1;
        else
            Q2 <= 27'd0;
        end
    end
    
    assign clk_1kHz = (Q1 == 17'd99999) ? 1'b1 : 1'b0;
    assign clk_1Hz = (Q2 == 27'd99999999) ? 1'b1 : 1'b0;
    
endmodule
