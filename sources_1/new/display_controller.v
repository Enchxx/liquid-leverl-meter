`timescale 1ns / 1ps

module display_controller(
    input  clk_100MHz,
    input  clk_1kHz,
    input  clk_1Hz,
    input  reset,
    input  input_error,
    input  GOET,
    input  LOET,
    input  [3:0] data_h,
    input  [3:0] data_t,
    input  [3:0] data_u,
    output reg [3:0] anodes,
    output reg [7:0] cathodes,
    output reg [2:0] LED
    );
    
    reg [1:0] Q;
    
    wire [7:0] data_h_mux;
    wire [7:0] data_t_mux;
    wire [7:0] data_u_mux;
    wire [7:0] data_a_mux;
    
    wire blank_htt;
    
    bcd_to_7seg bcd_to_7seg_h (
    .clk_100MHz (clk_100MHz),
    .reset (reset),
    .input_data (data_h),
    .blank (1'b1),
    .output_data (data_h_mux),
    .blank_out (blank_htt)
    );
            
    bcd_to_7seg bcd_to_7seg_t (
    .clk_100MHz (clk_100MHz),
    .reset (reset),
    .input_data (data_t),
    .blank (blank_htt),
    .output_data (data_t_mux)
    );
    
    bcd_to_7seg bcd_to_7seg_u (
    .clk_100MHz (clk_100MHz),
    .reset (reset),
    .input_data (data_u),
    .blank (1'b0),
    .output_data (data_u_mux)
    );
    
    alarm_to_7seg alarm_to_7seg (
    .clk_100MHz (clk_100MHz),
    .reset (reset),
    .input_data (data_u),
    .output_data (data_a_mux)
    );
    
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            Q <= 2'd0;
            anodes <= 4'd15;
            cathodes <= 8'd255;
            LED <= 2'd0;
        end else begin
            if (clk_1kHz) begin
                if (Q != 2'd3)
                    Q <= Q + 1;
                else
                    Q <= 2'd0;
            end
            
            case(Q)
                2'b00: anodes <= 4'b0111;
                2'b01: anodes <= 4'b1011;
                2'b10: anodes <= 4'b1101;
                2'b11: anodes <= 4'b1110;
                default: anodes <= 4'b1111;
            endcase

            case(Q)
                2'b00: cathodes <= data_h_mux;
                2'b01: cathodes <= data_t_mux;
                2'b10: cathodes <= data_u_mux;
                2'b11: cathodes <= data_a_mux;
                default: cathodes <= 8'b1111_1111;
            endcase 
            
            case({input_error,GOET,LOET})
                3'b000: LED <= {1'b0,1'b0,1'b1};
                3'b001: LED <= {clk_1Hz,1'b0,clk_1Hz};
                3'b010: LED <= {clk_1Hz,1'b0,1'b0};
                3'b1xx: LED <= {1'b1,1'b0,1'b0};
                default: LED <= {1'b0,1'b0,1'b0};
            endcase
        end
    end
    
endmodule
