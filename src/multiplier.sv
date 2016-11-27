`timescale 1ns/1ps
module multiplier(  input logic START,
                    input logic n_reset,
                    output logic[15:0] AQ,
                    output logic READY);
                    
    logic hwClock;
    logic clk;
    logic carry;
    logic RESET;
    logic SHIFT;
    logic ADD;
    logic DECREMENT;
    logic[7:0] multiplicand;
    logic[7:0] multiplier;
    logic[7:0] sum;
    logic[16:0] register;
    logic[3:0] count;
    
    initial
    begin
        $dumpfile("multiplier_tb.vcd");
        $dumpvars(0, hwClock, clk, carry, RESET, SHIFT, ADD, DECREMENT, multiplicand, multiplier, sum, register, count);
    end
    
    //Comment out if synthesising!
    initial
    begin
        clk = 0;
        forever #1 clk = ~clk;
    end
    
    // For conformance with specification
    assign AQ = register[15:0];
    
    //// Internal Oscillator 3.33MHz. Comment out if simulating!
    // defparam OSCH_inst.NOM_FREQ = "3.33";
    // OSCH OSCH_inst
        // ( 
        // .STDBY(1'b0),       // 0=Enabled, 1=Disabled also Disabled with Bandgap=OFF
        // .OSC(hwClock),
        // .SEDSTDBY()             // this signal is not required if not using SED
        // );
        
    assign multiplicand = 8'b11001011;
    assign multiplier = 8'b00010011;
    
    // slowClock sc(.*);
    adder a(.a(register[15:8]), .m(multiplicand), .carry(carry), .sum(sum));
    regs r(.*);
    counter c(.*);
    sequencer s(.*);
    
endmodule
