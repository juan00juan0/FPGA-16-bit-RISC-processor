`timescale 1ns / 1ps

module RegisterDataSelector(
    input [15:0] in2,
    input [15:0] in1,
    input [15:0] in0,
    input s1,
    input s0,
    input ld,
    output reg [15:0] data_out);
    
    always @(*) begin
        if(ld == 1) begin
            case({s1,s0})
                2'b00: data_out <= in0;
                2'b01: data_out <= in1;
                2'b10: data_out <= in2;
            endcase
        end
    end
    
endmodule
