# Parameterized Single-Port Synchronous RAM (Verilog)

## Overview
Designed and implemented a parameterized single-port synchronous RAM using Verilog HDL. 
The memory supports configurable data width and address width, making it reusable for various digital design applications.

## Key Features
- Parameterized DATA_WIDTH and ADDR_WIDTH
- Synchronous read and write operations
- Single clock design
- Synthesizable RTL implementation
- Verified using testbench in ModelSim

## Design Parameters
- DATA_WIDTH  : Width of each memory word
- ADDR_WIDTH  : Number of address bits
- Memory Depth = 2^ADDR_WIDTH

## Project Structure
rtl/memory.v        - RTL design  
tb/memory_tb.v      - Testbench  
sim/run.do          - Simulation script  

## Tools Used
- Verilog HDL
- ModelSim
