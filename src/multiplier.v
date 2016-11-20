`timescale 1ns/1ps
module multiplier(  input logic START,
                    input logic n_reset,
                    output logic[7:0] AQ,
                    output logic READY);
                    
    logic hwClock;
    logic clk;
    logic carry;
    logic RESET;
    logic SHIFT;
    logic ADD;
    logic DECREMENT;
    logic[3:0] multiplicand;
    logic[3:0] multiplier;
    logic[3:0] sum;
    logic[8:0] register;
    logic[2:0] count;
    
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
    
    initial
    begin
        AQ = 0;
        forever #1ps AQ = register[7:0];
    end
    
    //// Internal Oscillator 3.33MHz. Comment out if simulating!
    // defparam OSCH_inst.NOM_FREQ = "3.33";
    // OSCH OSCH_inst
        // ( 
        // .STDBY(1'b0),       // 0=Enabled, 1=Disabled also Disabled with Bandgap=OFF
        // .OSC(hwClock),
        // .SEDSTDBY()             // this signal is not required if not using SED
        // );
        
    assign multiplicand = 4'b0101;
    assign multiplier = 4'b0111;
    
    // slowClock sc(.*);
    adder a(.a(register[7:4]), .m(multiplicand), .carry(carry), .sum(sum));
    regs r(.*);
    counter c(.*);
    sequencer s(.*);
    
    
endmodule
