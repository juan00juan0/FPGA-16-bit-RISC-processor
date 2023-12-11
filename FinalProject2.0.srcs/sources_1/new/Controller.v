`timescale 1ns / 1ps

module Controller(
    output reg [7:0] mem_addr,
    output reg addr_sel,
    output reg mem_rd,
    output reg mem_wr,
    output reg [15:0] rf_data,
    output reg rf_s1,
    output reg rf_s0,
    output reg [3:0] wr_addr,
    output reg rf_wr,
    output reg [3:0] rp_addr,
    output reg rp_rd,
    output reg [3:0] rq_addr,
    output reg rq_rd,
    output reg alu_s2,
    output reg alu_s1,
    output reg alu_s0,
    output reg mem_addr_ld,
    output reg rf_data_ld,
    output reg pc_ld, pc_clr, pc_inc, ir_ld,
    input [15:0] ir_out,
    input z_flag,
    input clk);
    
    //reg pc_ld, pc_clr, pc_inc, ir_ld;
    //wire [7:0] pc_in;
    //wire [15:0] ir_out;
    
    wire [3:0] opcode, rd, rs, rt;
    wire [7:0] imm, dir;
    
    //reg counter = 0;
    
    //States
    parameter S_rst = 0, S_fet1 = 1, S_fet2 = 2, S_dec = 3,
        S_ex1 = 4, S_mem1 = 5, S_mem2 = 6, S_mem3 = 7,
        S_wb1 = 8;
    
    //Opcodes
    parameter ADD = 0, SUB = 1, AND = 2, OR = 3, XOR = 4, NOT = 5,
        SLA = 6, SRA = 7, LI = 8, LW = 9, SW = 10, BIZ = 11, BNZ = 12,
        JAL = 13, JMP = 14, JR = 15;
    
    reg [3:0] state, next_state;
    assign opcode = ir_out[15:12];
    assign rd = ir_out[11:8];
    assign rs = ir_out[7:4];
    assign rt = ir_out[3:0];
    assign imm = ir_out[7:0];
    assign dir = ir_out[7:0];
    
    initial begin
        state = S_rst;
    end
    
    always @(posedge clk) begin: StateTransition
        state <= next_state;
    end
    
    always @(state, opcode, rs, rd) begin: Output_NextState
        pc_ld = 0; pc_clr = 0; pc_inc = 0; addr_sel = 0;
        ir_ld = 0; mem_rd = 0; mem_wr = 0; rf_s1 = 0; rf_s0 = 0;
        rf_wr = 0; rp_rd = 0; rq_rd = 0; alu_s2 = 0;
        alu_s1 = 0; alu_s0 = 0;
        mem_addr = 0;
        rf_data = 0;
        wr_addr = 0;
        rp_addr = 0;
        rq_addr = 0;
        next_state = state;
        mem_addr_ld = 0;
        rf_data_ld = 0;
        
        case(state)
            S_rst : begin
                    next_state = S_fet1;
                    pc_clr = 1;
                    end
            S_fet1: begin
                    next_state = S_fet2;
                    addr_sel = 0;
                    mem_addr_ld = 1;
                    end
            S_fet2: begin
                    next_state = S_dec;
                    mem_rd = 1;
                    ir_ld = 1;
                    pc_inc = 1;
                    end
            S_dec: case(opcode)
                       ADD, SUB, AND, OR, XOR, NOT, SLA, SRA: begin
                           next_state = S_ex1;
                           rp_addr = rs;
                           rq_addr = rt;
                           rp_rd = 1;
                           rq_rd = 1;
                           end
                       LI: begin
                          next_state = S_wb1;
                          rf_data = {imm[7], imm[7], imm[7], imm[7],
                              imm[7], imm[7], imm[7], imm[7],
                              imm};
                          {rf_s1, rf_s0} = 2'b10;
                          rf_data_ld = 1;
                          end
                       LW: begin
                           next_state = S_mem1;
                           mem_addr = dir;
                           addr_sel = 1;
                           mem_addr_ld = 1;
                           end
                       SW: begin
                           next_state = S_mem3;
                           rp_addr = rt;
                           rp_rd = 1;
                           mem_addr = dir;
                           addr_sel = 1;
                           mem_addr_ld = 1;
                           end
                   endcase 
            S_ex1: begin
                   next_state = S_mem1;
                   {alu_s2, alu_s1, alu_s0} = opcode;
                   rf_s1 = 0;
                   rf_s0 = 0;
                   rf_data_ld = 1;
                   end
            S_mem1: begin
                    next_state = S_mem2;
                    mem_rd = 1;
                    end
            S_mem2: begin
                    next_state = S_wb1;
                    rf_s1 = 0;
                    rf_s0 = 1;
                    rf_data_ld = 1;
                    end
            S_mem3: begin
                    next_state = S_fet1;
                    mem_wr = 1;
                    end
            S_wb1: begin
                   next_state = S_fet1;
                   wr_addr = rd;
                   rf_wr = 1;
                   end
        endcase
    end
endmodule
