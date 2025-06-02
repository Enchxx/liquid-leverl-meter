`timescale 1ns / 1ps

module threshold_programmer(
    input clk_100MHz,
    input reset,
    input saveH_button,
    input saveL_button,
    input [7:0] setup_input,
    output reg [7:0] high_threshold,
    output reg [7:0] low_threshold
    );
    
    reg input_error;
    reg [7:0] stored_data;
    
    always @(*) begin
        if (reset) begin
            input_error <= 1'b0;
            stored_data <= 8'd0;
        end else begin
            input_error <= 1'b0;
            case(setup_input)
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
             
     always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            high_threshold <= 8'd100;
            low_threshold <= 8'd0; 
        end else begin
            if (saveH_button & (setup_input > low_threshold) & ~input_error) begin
                high_threshold <= stored_data;
            end else if (saveL_button & (setup_input < high_threshold) & ~input_error) begin
                low_threshold <= stored_data; 
            end
        end 
     end
endmodule