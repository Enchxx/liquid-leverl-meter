## LIQUID LEVEL METER
This project implements a liquid level meter on the Nexys4 DDR FPGA board (Xilinx Artix-7, XC7A100TCSG324-1).
The system measures liquid level, displays it as a percentage on four 7-segment displays (3 digits + status indicator), 
and triggers an alarm LED when programmable thresholds are exceeded.

**Key Features**
  
  ✔ Real-time liquid level measurement (0-100%)
  
  ✔ 4-digit 7-segment display:

  - 3 digits show percentage (0-100%)

  - 1 letter indicates status:
     - L (Low) – Below lower threshold
     - o (OK) – Within safe range
     - H (High) – Above upper threshold
  
  ✔ Programmable thresholds (adjustable via buttons)
  
  ✔ Alarm LED when level is out of range
  
  ✔ Nexys4 DDR-compatible (tested on XC7A100TCSG324-1)

**Hardware Setup**

  - FPGA Board: Nexys4 DDR (Xilinx Artix-7)

  - Sensor: Simulated by switches

  - Display: onm board 4x 7-segment digits (CC)

**Controls:**

  - **Buttons** for threshold and reset adjustment

  - **Switches** for programming thresholds

  - **Alarm:** Onboard LED (red for alert)

**Repository Structure**
```
├── /sources_1/
│   └── /new/
│       ├── top.v
│       ├── sensors_input_module.v
│       ├── threshold_comparator.v
│       ├── threshold_programmer.v
│       ├── debouncer.v
│       ├── clock_manager.v
│       ├── bcd_to_7seg.v
│       ├── alarm_to_7seg.v
│       └── display_controller.v
├── /constrs_1/
│   └── /new/
│       └── liquid-level-meter.xdc
└── /sim_1/
    └── /new/
        └── top_tb.v
```

**How It Works**
  1. Sensor Input: Measures liquid level (analog/digital).

  2. Percentage Calculation: Converts raw data to 0-100%.

  3. Threshold Check: Compares level against user-set limits.

  4. Display Output: Shows XXX% + status (L/o/H).

  5. Alarm Trigger: LED lights up if level is unsafe.

**Tags:** _#FPGA #Verilog #Nexys4 #LiquidLevel #7Segment #Vivado #EmbeddedSystems_
