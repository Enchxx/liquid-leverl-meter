`timescale 1ns / 1ps

module top_tb;

    // Inputs
    reg clk_100MHz;
    reg reset_button;
    reg saveH_button;
    reg saveL_button;
    reg [7:0] sensors_input;
    reg [7:0] setup_input;
    
    // Outputs
    wire [7:0] cathodes;
    wire [7:0] anodes;
    wire [2:0] LED;
    
    // Instantiate the Unit Under Test (UUT)
    top top (
        .clk_100MHz(clk_100MHz),
        .reset_button(reset_button),
        .saveH_button(saveH_button),
        .saveL_button(saveL_button),
        .sensors_input(sensors_input),
        .setup_input(setup_input),
        .cathodes(cathodes),
        .anodes(anodes),
        .LED1(LED1),
        .LED2(LED2)
    );
    
    // Clock generation (100 MHz)
    initial begin
        clk_100MHz = 0;
        forever #5 clk_100MHz = ~clk_100MHz; // 10ns period = 100MHz
    end
    
    // Test procedure
    initial begin
        // Initialize Inputs
        reset_button = 0; // Przyciski aktywne w stanie wysokim, więc inicjalizacja na 0
        saveH_button = 0;
        saveL_button = 0;
        sensors_input = 8'b00000000;
        setup_input = 8'b00000000;
        
        // Reset the system (hold reset for 100ns)
        reset_button = 1; // Aktywny stan wysoki
        #100;
        reset_button = 0;
        #100;
        
        // Test 1: Normal operation with valid inputs
        $display("Test 1: Normal operation with valid inputs");
        sensors_input = 8'b00001111; // Level 4
        setup_input = 8'b00000000;   // No setup
        #20_000_000; // 20ms - czas na 5 pełnych cykli wyświetlacza (4ms każdy) i 2 cykle LED
        
        // Test 2: Change liquid level
        $display("Test 2: Change liquid level");
        sensors_input = 8'b00111111; // Level 6
        #16_000_000; // 16ms - czas na 4 pełne cykle wyświetlacza
        
        // Test 3: Save high threshold
        $display("Test 3: Save high threshold");
        setup_input = 8'b01010101;   // Setup value for high threshold
        #4_000_000; // 4ms - czas na pełny cykl wyświetlacza
        saveH_button = 1; // Aktywny stan wysoki
        #100_000_000; // 100ms - przycisk wciśnięty
        saveH_button = 0;
        #20_000_000; // 20ms - czas na aktualizację
        
        // Test 4: Save low threshold
        $display("Test 4: Save low threshold");
        setup_input = 8'b00010001;   // Setup value for low threshold
        #4_000_000;
        saveL_button = 1; // Aktywny stan wysoki
        #100_000_000;
        saveL_button = 0;
        #20_000_000;
        
        // Test 5: Invalid sensor input
        $display("Test 5: Invalid sensor input");
        sensors_input = 8'b00110011; // Invalid pattern
        #20_000_000;
        
        // Test 6: Invalid setup input
        $display("Test 6: Invalid setup input");
        setup_input = 8'b00001100;   // Invalid pattern
        #20_000_000;
        
        // Test 7: Reset test
        $display("Test 7: Reset test");
        reset_button = 1; // Aktywny stan wysoki
        #100_000_000;
        reset_button = 0;
        #20_000_000;
        
        // Test 8: Edge cases
        $display("Test 8: Edge cases");
        sensors_input = 8'b11111111; // Full
        #20_000_000;
        sensors_input = 8'b00000001; // Almost empty
        #20_000_000;
        sensors_input = 8'b00000000; // Completely empty (invalid)
        #20_000_000;
        
        $display("All tests completed");
        $finish;
    end
    
    // Monitor to display important signals
    initial begin
        $monitor("Time = %t ns | Sensors = %b | Setup = %b | Cathodes = %b | Anodes = %b | LED1 = %b | LED2 = %b",
            $time, sensors_input, setup_input, cathodes, anodes, LED1, LED2);
    end
    
endmodule