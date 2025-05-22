`timescale 1ns / 1ps

module top(
    input clk_100MHz,
    input reset_button,
    input saveH_button,
    input saveL_button,
    input [7:0] sensors_input,
    input [7:0] setup_input,
    output [7:0] cathodes, // abcdefg_dp
    output [7:0] anodes, // AN7 AN6 AN5 AN4 AN3 AN2 AN1 AN0
    output [2:0] LED1, //RGB
    output [2:0] LED2 //RGB
    );
    
    wire clk_1kHz;
    wire clk_1Hz;
    wire reset;
    wire input_error;
    wire GOET;
    wire LOET;
    wire [7:0] high_threshold;
    wire [7:0] low_threshold;
    wire [7:0] sensor_data;
    wire [3:0] data_h;
    wire [3:0] data_t;
    wire [3:0] data_u;
    wire saveH_button_out;
    wire saveL_button_out;

    debouncer debouncer (
    .clk_100MHz (clk_100MHz),
    .clk_1kHz (clk_1kHz),
    .reset (reset),
    .reset_button (reset_button),
    .saveH_button (saveH_button),
    .saveL_button (saveL_button),
    .reset_button_out (reset),  
    .saveH_button_out (saveH_button_out),
    .saveL_button_out (saveL_button_out)
    );

    clock_manager clock_manager (
    .clk_100MHz (clk_100MHz),
    .reset (reset),
    .clk_1kHz (clk_1kHz),
    .clk_1Hz (clk_1Hz)
    );
    
    sensors_input_module sensors_input_module (
    .clk_100MHz (clk_100MHz),
    .reset (reset),
    .sensors_input (sensors_input),
    .data (sensor_data),
    .input_error (input_error)
    );
    
    threshold_comparator threshold_comparator (
    .clk_100MHz (clk_100MHz),
    .reset (reset),
    .sensor_data (sensor_data),
    .high_threshold (high_threshold),
    .low_threshold (low_threshold),
    .data_h (data_h),
    .data_t (data_t),
    .data_u (data_u),
    .GOET (GOET),
    .LOET (LOET)
    );
    
    threshold_programmer threshold_programmer (
    .clk_100MHz (clk_100MHz),
    .reset (reset),
    .saveH_button (saveH_button_out),
    .saveL_button (saveL_button_out),
    .setup_input (setup_input),
    .high_threshold (high_threshold),
    .low_threshold (low_threshold)
    );

    display_controller display_controller (
    .clk_100MHz (clk_100MHz),
    .clk_1kHz (clk_1kHz),
    .clk_1Hz (clk_1Hz),
    .reset (reset),
    .input_error (input_error),
    .GOET (GOET),
    .LOET (LOET),
    .data_h (data_h),
    .data_t (data_t),
    .data_u (data_u),
    .anodes (anodes),
    .cathodes (cathodes),
    .LED1 (LED1),
    .LED2 (LED2)
    );
    
endmodule
