`timescale 1ns / 1ps

module RISC_16bit(
    input clk_i,
    output [7:0] disp_seg_o,
    output [7:0] disp_an_o);
    
    wire pc_clr, pc_ld, pc_inc, ir_ld, d_addr_sel, d_rd, d_wr, rf_s1, rf_s0,
        rf_w_wr, rf_rp_rd, rf_rq_rd, rf_rp_zero, alu_s2, alu_s1, alu_s0,
        d_addr_ld, rf_data_ld;
    wire [7:0] pc_addr, pc_in, d_addr, mem_addr;
    wire [15:0] rf_w_data, r_data, ir_out, rp_data, rq_data, alu_out, rf_data;
    wire [3:0] rf_w_addr, rf_rp_addr, rf_rq_addr;
    //reg clk;
    
    Controller C0(d_addr, d_addr_sel, d_rd, d_wr, rf_w_data, rf_s1, rf_s0, rf_w_addr,
        rf_w_wr, rf_rp_addr, rf_rp_rd, rf_rq_addr, rf_rq_rd, alu_s2, alu_s1, alu_s0,
        d_addr_ld, rf_data_ld, pc_ld, pc_clr, pc_inc, ir_ld, ir_out, rf_rp_zero,
        clk_i);
    InstructionRegister IR0(ir_ld, r_data, ir_out);
    ProgramCounter PC0(pc_ld, pc_clr, pc_inc, pc_in, pc_addr);
    PCAndOffset PCO0(pc_addr, ir_out[7:0], pc_in);
    MemoryAddressSelector MAS0(d_addr_ld, d_addr_sel, pc_addr, d_addr, mem_addr);
    Memory256_16bit MM0(mem_addr, d_rd, d_wr, rp_data, r_data, clk_i, disp_seg_o, disp_an_o);
    RegisterDataSelector RDS0(rf_w_data, r_data, alu_out, rf_s1, rf_s0,
        rf_data_ld, rf_data);
    RegisterFile RF0(rf_data, rf_w_addr, rf_rp_addr, rf_rq_addr, rf_w_wr,
        rf_rp_rd, rf_rq_rd, rp_data, rq_data);
    ALU ALU0(alu_s2, slu_s1, alu_s0, rp_data, rq_data, alu_out);
    ZFlag ZF0(rp_data, rf_rp_zero);
    
endmodule
