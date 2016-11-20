module multiplier(  input logic START,
                    input logic n_reset,
                    output logic[7:0] AQ);
                    
    logic hwClock;
    logic clk;
    logic carry;
    logic READY;
    logic RESET;
    logic SHIFT;
    logic ADD;
    logic DECREMENT;
    logic[3:0] multiplicand;
    logic[3:0] multiplier;
    logic[3:0] sum;
    logic[8:0] register;
    logic[2:0] count;
    
    //// Internal Oscillator 3.33MHz
    defparam OSCH_inst.NOM_FREQ = "3.33";
    OSCH OSCH_inst
        ( 
        .STDBY(1'b0),       // 0=Enabled, 1=Disabled also Disabled with Bandgap=OFF
        .OSC(hwClock),
        .SEDSTDBY()             // this signal is not required if not using SED
        );
        
    assign multiplicand = 4'b0101;
    assign multiplier = 4'0111;
    
    slowClock sc(.*);
    adder a(.a(register[7:4]), .m(multiplier), .carry(carry), .sum(sum));
    regs r(.*);
    counter c(.*);
    sequencer s(.*);
    
    always @(posedge clk, negedge n_reset)
    begin
        if (!n_reset)
        begin
            AQ <= 0;
        end
        else
        begin
            AQ <= register[7:0];
        end
    end
endmodule
