`timescale 1ns / 1ps

module alarm_to_7seg(
    input reset,
    input [2:0] input_data,
    output reg [7:0] output_data
    );
    
    always @(*) begin
        if(reset) begin
            output_data <= 8'b1111_1111;
        end else begin
            case(input_data)
                3'b001: output_data = 8'b1110_0011; //L
                3'b000: output_data = 8'b1100_0101; //O
                3'b010: output_data = 8'b1001_0001; //H
                3'b100: output_data = 8'b0110_0001; // E
                3'b110: output_data = 8'b0110_0001; // E
                3'b101: output_data = 8'b0110_0001; // E
                default: output_data = 8'b1111_1111; // off
            endcase
        end
    end
endmodule