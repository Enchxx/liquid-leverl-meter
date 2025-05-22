`timescale 1ns / 1ps

module bcd_to_7seg(
    input clk_100MHz,
    input reset,
    input [3:0] input_data,
    input blank,
    output reg [7:0] output_data,
    output reg blank_out
    );
    
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            blank_out = 1'b0;
            output_data <= 8'b1111_1111;
        end else begin
            blank_out = 1'b0;
            case(input_data)
                4'b0000: begin 
                    if(blank) begin
                        output_data = 8'b1111_1111;
                        blank_out = 1'b1;
                    end else begin
                        output_data = 8'b0000_0011; //0
                        blank_out = 1'b1;
                    end
                end
                4'b0001: output_data = 8'b1001_1111; //1
                4'b0010: output_data = 8'b0010_0011; //2
                4'b0011: output_data = 8'b0000_1011; //3
                4'b0100: output_data = 8'b1001_1001; //4
                4'b0101: output_data = 8'b0100_1001; //5
                4'b0110: output_data = 8'b0100_1001; //6
                4'b0111: output_data = 8'b0001_1111; //7
                4'b1000: output_data = 8'b0000_0001; //8
                4'b1001: output_data = 8'b0000_1001; //9
                default: output_data = 8'b1111_1111; // off
            endcase
        end
    end
endmodule
