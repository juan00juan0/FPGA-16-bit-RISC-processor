`timescale 1ns / 1ps

module InstructionRegister(ld, data_in, data_out);
    input wire ld;
    input wire [15:0] data_in;
    output reg [15:0] data_out;
    
    always @(*) begin
        if(ld == 1) begin
            data_out <= data_in;
        end
    end
endmodule
