`timescale 1ns / 1ps

module metro_turnstile(
    input clk,rst,V,
    input [3:0]A_C,
    output reg open,
    output wire [1:0]state_out
    );
    
    parameter [1:0] IDLE=2'b00;
    parameter [1:0] ACCESS_CHECK=2'b01;
    parameter [1:0] GRANT=2'b10;
    
    reg [1:0]state;
    reg [1:0]next_state;
    
    reg [3:0] t;
    
    always @ (*) begin
        next_state=IDLE;
        open=1'b0;
        case(state)
            IDLE            :   begin
                                    if(V==1'b1) begin                      //if (validate=1), then (n_s=ACCESS_CHECK), else (n_s=IDLE) as at line 40
                                        next_state=ACCESS_CHECK;
                                    end     
                                end
            ACCESS_CHECK    :   begin
                                    if((4'd4<=A_C) && (A_C<=4'd11)) begin    //if ( (4<A_C) && (A_C<11) ), then (n_s=GRANT), else (n_s=IDLE) as at line 40
                                        next_state=GRANT;
                                    end
                                    else begin
                                    next_state=IDLE;
                                    end
                                end
            GRANT           :   begin
                                    open=1'b1;                     //if ( time==15(sec) ), then "DOOR_CLOSE" (n_s=IDLE), else "DOOR REMAINS OPEN" (n_s=GRANT)
                                    if(t==4'd15) begin
                                        open=1'b0;
                                        next_state=IDLE;
                                    end
                                    else begin
                                        next_state=GRANT;
                                    end
                                end 
            default         :   begin
                                    next_state=IDLE;
                                    open=1'b0;
                                end
        endcase
    end
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            state<=IDLE;
        end
        else begin
            state<=next_state;
        end
    end
    assign state_out=state;
    
    always @(posedge clk or negedge rst) begin
        if(!rst)
            t<=4'b0;
        else if(state==GRANT) 
            t<=t+1'b1;
        else
            t<=4'b0;       
    end
    
endmodule
