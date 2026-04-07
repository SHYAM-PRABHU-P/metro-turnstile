`timescale 1ns / 1ps

module metro_turnstile_tb();
    reg clk=1;
    reg rst;
    reg V;
    reg [3:0]A_C;
    wire open;
    wire [1:0]state_out;
    
    metro_turnstile uut(.clk(clk),.rst(rst),.V(V),.A_C(A_C),.open(open),.state_out(state_out));
    
    always begin
        clk=~clk;#0.5;
    end
    
    initial begin
        $monitor($time,"VALIDATE=$0b,ACCESS CODE=%0d,CURRENT STATE=&0d,DOOR OPENS:%0d",V,A_C,state_out,open);
        
        rst=0;V=0;#1;
        rst=1;
        @(posedge clk);
        V=0;A_C=0;
        @(posedge clk);
        V=1;A_C=0;
        @(posedge clk);
        V=1;A_C=9;
        @(posedge clk);
        V=1;A_C=9;
        #40;
        
    end 
endmodule
