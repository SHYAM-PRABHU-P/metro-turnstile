# 🚇 Metro Turnstile Controller (FSM Design)

## Overview
This project implements a Metro Turnstile Controller using a Finite State Machine (FSM) in Verilog.  
The system validates user input and controls gate access based on predefined conditions.

## Working Principle
- System starts in IDLE state  
- When V = 1, it moves to ACCESS_CHECK  
- If 4 ≤ A_C ≤ 11 → Access granted  
- Else → Return to IDLE  
- In GRANT state:
  - Gate opens (open = 1)  
  - Remains open for 15 clock cycles  
  - Then closes and returns to IDLE  

## FSM States
- IDLE → Waiting for validation  
- ACCESS_CHECK → Checking access condition  
- GRANT → Gate open state  

## Modules
- metro_turnstile.v → Main design file  

## Tools Used
- Verilog HDL  
- Xilinx Vivado  

## Inputs & Outputs

### Inputs
- clk → Clock signal  
- rst → Active-low reset  
- V → Validation signal  
- A_C[3:0] → Access control value  

### Outputs
- open → Gate control signal  
- state_out[1:0] → Current FSM state  

## Output
- open = 1 → Gate opens  
- open = 0 → Gate remains closed  
- Gate stays open for 15 clock cycles after valid access  

## How to Run
1. Open project in Vivado  
2. Add the design file and testbench  
3. Run Behavioral Simulation  
4. Observe waveform output  

## Applications
- Metro ticketing systems  
- Access control systems  
- Automated gates  
