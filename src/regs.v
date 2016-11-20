module regs(input logic clk, 
            input logic n_reset,
            input logic ADD,
            input logic SHIFT,
            input logic RESET,
            input logic[3:0] sum,
            input logic[3:0] multiplier,
            input logic carry,
            output logic[8:0] register);

    always @(posedge clk, negedge n_reset)
    begin
    
        if (!n_reset)
        begin
            register <= 9'b0;
        end
        
        else if (RESET)
        begin
            register <= {5'b0, multiplier};
        end
            
        else if (ADD & !SHIFT)
        begin
            register[8:4] <= {carry, sum};
        end
            
        else if (SHIFT & !ADD)
        begin
            register <= {1'b0, register[8:1]};
        end
        
        else
        begin
            register <= register;
        end
            
    end
    
endmodule
