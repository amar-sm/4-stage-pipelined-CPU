`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2026 18:50:30
// Design Name: 
// Module Name: pipelined_4stage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "define.v"

module pipelined_4stage(clk, rst, aluout);

input clk, rst;
output [`DSIZE-1:0] aluout;

//IF
wire [`ISIZE-1:0] pc_cur, pc_next, inst_mem;

//ID
wire [`ISIZE-1:0] inst_id;
wire [5:0] op;
wire [4:0] rs, rt, rd;
wire [15:0] imm16;
wire [31:0] imm_ext;
wire wen, alusrc, regDST;
wire [2:0] aluop;
wire [`ASIZE-1:0] waddr_sel;
wire [`DSIZE-1:0] rdata1, rdata2;

//EX
wire [`DSIZE-1:0] ex_r1, ex_r2, ex_imm;
wire [`ASIZE-1:0] ex_waddr;
wire ex_wen, ex_alusrc;
wire [2:0] ex_aluop;
wire [`DSIZE-1:0] alu_b, alu_res;

//WB stage wires
wire [`DSIZE-1:0] wb_res;
wire [`ASIZE-1:0] wb_addr;
wire wb_wen;

//delay
wire [`ASIZE-1:0] waddr_d;
wire [`DSIZE-1:0] wdata_d;

assign pc_next = pc_cur + 1;
PC1 PC0(clk, rst, pc_next, pc_cur);

memory IM(
    clk,
    rst,
    1'b0,
    pc_cur,
    32'b0,
    1'b0,
    inst_mem
);

assign op = inst_id[31:26];
assign rs= inst_id[25:21];
assign rt= inst_id[20:16];
assign rd= inst_id[15:11];
assign imm16= inst_id[15:0];

assign imm_ext= {16'b0, imm16};
assign waddr_sel = regDST ? rd : rt;

//pipeline IF/ID+ID/EX
ID_EXE_stage PIPE(
    clk, rst,
    inst_mem, inst_id,
    rdata1, rdata2, imm_ext, waddr_sel,
    wen, alusrc, aluop,
    ex_r1, ex_r2, ex_imm, ex_waddr,
    ex_wen, ex_alusrc, ex_aluop
);

control CTRL(op, wen, alusrc, regDST, aluop);

//regfile(WB stage write)
regfile RF(
    clk, rst,
    wb_wen,
    rs, rt,
    waddr_d,
    wdata_d,
    rdata1,
    rdata2
);

assign alu_b = ex_alusrc ? ex_imm : ex_r2;
alu ALU0(
    ex_r1,
    alu_b,
    ex_aluop,
    alu_res
);

assign aluout = alu_res;

//EX to WB register
EXE_WB_stage EXWB(
    clk,
    rst,
    alu_res,
    ex_waddr,
    ex_wen,
    wb_res,
    wb_addr,
    wb_wen
);

//delay before wb
delay_reg DR(
    clk,
    rst,
    wb_res,
    wb_addr,
    wdata_d,
    waddr_d
);

endmodule
