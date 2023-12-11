`timescale 1ns / 1ps

module RegisterFile(
    input [15:0] data_in,
    input [3:0] wr_addr,
    input [3:0] rp_addr,
    input [3:0] rq_addr,
    input wr,
    input rp_rd,
    input rq_rd,
    output reg [15:0] rp_out,
    output reg [15:0] rq_out);
    
    reg [15:0] Registers [15:0];
    
    always@(*) begin
        if(rp_rd == 1 && rq_rd == 1) begin
            rp_out <= Registers[rp_addr];
            rq_out <= Registers[rq_addr];
        end
        if(rp_rd == 1) begin
            rp_out <= Registers[rp_addr];
            rq_out <= 16'b0000_0000_0000_0000;
        end
        else if(wr == 1) begin
            Registers[wr_addr] <= data_in;
        end
    end
endmodule
