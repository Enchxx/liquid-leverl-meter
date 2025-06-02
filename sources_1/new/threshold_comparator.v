`timescale 1ns / 1ps

module threshold_comparator(
    input clk_100MHz,
    input reset,
    input [7:0] sensor_data,
    input [7:0] high_threshold,
    input [7:0] low_threshold,
    output reg [3:0] data_h,
    output reg [3:0] data_t,
    output reg [3:0] data_u,
    output reg GOET,
    output reg LOET
    );
    
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            data_h <= 4'd0;
            data_t <= 4'd0;
            data_u <= 4'd0;
            GOET <= 1'd0;
            LOET <= 1'd0;
        end else begin
            if (sensor_data >= high_threshold) begin
                GOET <= 1'b1;
                LOET <= 1'b0;
            end else if (sensor_data <= low_threshold) begin
                GOET <= 1'b0;
                LOET <= 1'b1;
            end else begin
                GOET <= 1'b0;
                LOET <= 1'b0;
            end
            data_h <= sensor_data / 100;
            data_t <= (sensor_data % 100) / 10;
            data_u <= sensor_data % 10;
        end
    end 
endmodule