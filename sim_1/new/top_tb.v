`timescale 1ns / 1ps

module top_tb;
    reg clk_100MHz;
    reg reset_button;
    reg [7:0] sensors_input; 
    reg [7:0] setup_input;
    reg saveH_button;
    reg saveL_button;
    wire [7:0] cathodes;
    wire [3:0] anodes;
    wire [2:0] LED;
    
    
    top top (
    .clk_100MHz (clk_100MHz),
    .saveH_button (saveH_button),
    .saveL_button (saveL_button),
    .sensors_input (sensors_input),
    .setup_input (setup_input),
    .reset_button (reset_button),
    .cathodes (cathodes),
    .anodes (anodes),
    .LED (LED)
    );
    
    initial begin
        clk_100MHz = 1'b0; 
        reset_button = 1'b0;
        saveH_button = 1'b0;
        saveL_button = 1'b0;
        sensors_input = 8'b0000_0000;
        setup_input = 8'b0000_0000;
        
        #10000000 setup_input = 8'b0111_1111;
        #100000 saveH_button = 1'b1;
        #100000 saveH_button = 1'b0;
        
        #10000000 setup_input = 8'b0000_1111;
        #100000 saveL_button = 1'b1;
        #100000 saveL_button = 1'b0;
        
        #10000000 sensors_input = 8'b1111_1111;
        
        #50000000 sensors_input = 8'b0001_11011;
        
        #100000000
        
        #50000000 sensors_input = 8'b0100_0111;
        
        #50000000 sensors_input = 8'b0000_0111;
        
        

        #5000000 reset_button = 1'b1;
        #10000 reset_button = 1'b0;
        
        //#10000 $stop;
    end
    
    always #5 clk_100MHz = ~clk_100MHz; // 100MHz
    
    initial begin
    $monitor("Czas: %0t ns | Sens: %b | Save: %b%b | 7SEG: %b (AN=%b) | LED: %b| reset_button: %b",
             $time, sensors_input, saveH_button, saveL_button, cathodes, anodes, LED, reset_button);
    end
    
endmodule
