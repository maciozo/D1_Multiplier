module counter_tb;

    logic clk;
    logic n_reset;
    logic DECREMENT;
    logic RESET;
    logic[2:0] count;
    
    counter r(.*);
    
    initial
    begin
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, clk, n_reset, DECREMENT, RESET, count);
    end
    
    initial
    begin
        #1 clk <= 0;
        forever #5 clk <= ~clk;
    end
    
    initial
    begin
        n_reset = 0;
        DECREMENT = 0;
        RESET = 0;
        
        
        #5;
        n_reset = 1;
        RESET = 1;
        if (count != 3'b000)
        begin
            $display("Count not resetting = %b", count);
            // $fatal;
        end
        
        
        #10;
        RESET = 0;
        if (count != 4)
        begin
            $display("count not initialising = %b", count);
            // $fatal;
        end
        
        
        #10;
        DECREMENT = 1;
        if (count != 4)
        begin
            $display("count not holding = %b", count);
            // $fatal;
        end
        
        
        #10;
        DECREMENT = 0;
        if (count != 3)
        begin
            $display("count not decrementing = %b", count);
            // $fatal;
        end
        
        
        #10;
        DECREMENT = 1;
        if (count != 3)
        begin
            $display("count not holding = %b", count);
            // $fatal;
        end
        
        
        #10;
        DECREMENT = 0;
        if (count != 2)
        begin
            $display("count not decrementing = %b", count);
            // $fatal;
        end
        
        
        #10;
        RESET = 1;
        if (count != 2)
        begin
            $display("count not holding = %b", count);
            // $fatal;
        end
        
        #10;
        if (count != 4)
        begin
            $display("count not initialising = %b", count);
            // $fatal;
        end
        
        $display("Test successful!");
        $finish;
    end
endmodule