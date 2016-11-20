module slowClock(   input logic hwClock,
                    output logic clk);
                    
    logic[20 - 1:0] count = 0;
    
    always @(posedge hwClock)
    begin
        count <= count + 1;
    end
    
    assign clk = count[20 - 1];
endmodule
