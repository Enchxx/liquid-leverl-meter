`timescale 1ns / 1ps

module sensors_input_module(
    input clk_100MHz,
    input reset,
    input [7:0] sensors_input,
    output reg [7:0] stored_data,
    output reg input_error
    );
    
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
        stored_data <= 8'd0;
        input_error <= 1'b0;
        end else begin
            input_error <= 1'b0;
            case(sensors_input)
                8'b0000_0000: stored_data <= 8'b0000_0000;
                8'b0000_0001: stored_data <= 8'b0000_1100;
                8'b0000_0011: stored_data <= 8'b0001_1001;
                8'b0000_0111: stored_data <= 8'b0010_0110;
                8'b0000_1111: stored_data <= 8'b0011_0010;
                8'b0001_1111: stored_data <= 8'b0011_1111;
                8'b0011_1111: stored_data <= 8'b0100_1011;
                8'b0111_1111: stored_data <= 8'b0101_1000;
                8'b1111_1111: stored_data <= 8'b0110_0100;
                default: begin
                    stored_data <= 8'b0000_0000;
                    input_error <= 1'b1;
                end
            endcase
        end
    end
    
endmodule
