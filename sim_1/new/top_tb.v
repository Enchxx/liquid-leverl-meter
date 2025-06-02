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
    wire [2:0] LED1;
    wire [2:0] LED2;
    wire led_pwm;

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
        .LED2(LED2),
        .led_pwm(led_pwm)
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
        sensors_input = 8'b00000001;
        setup_input = 8'b00000000;

        // Reset the system (hold reset for 100ns)
        reset_button = 1; // Aktywny stan wysoki
        #100;
        reset_button = 0;
        #100;
        
        #100
        setup_input = 8'b00000111;
        #100
        saveL_button = 1;
        #100
        saveL_button = 0;
        #1000
        sensors_input = 8'b00000001;
        #10000
        sensors_input = 8'b00010001;
        #10000
        sensors_input = 8'b11111111;

        $display("All tests completed");
        $finish;
    end

    // Monitor to display important signals
    initial begin
        $monitor("Time = %t ns | Sensors = %b | Setup = %b | Cathodes = %b | Anodes = %b | LED1 = %b | LED2 = %b",
            $time, sensors_input, setup_input, cathodes, anodes, LED1, LED2);
    end

endmodule