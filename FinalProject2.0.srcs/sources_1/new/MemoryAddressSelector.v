`timescale 1ns / 1ps

module MemoryAddressSelector(Ld, Sel, PC_Addr, D_Addr, Addr);
    input Ld;
    input Sel;
    input wire [7:0] PC_Addr, D_Addr;
    output reg [7:0] Addr;
    
    
    always @(*) begin
        if(Ld == 1) begin
            case(Sel)
                1'b0: Addr <= PC_Addr;
                1'b1: Addr <= D_Addr;
            endcase
        end
    end
    
    
endmodule
