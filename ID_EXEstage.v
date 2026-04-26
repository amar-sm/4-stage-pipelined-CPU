`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2026 11:17:31
// Design Name: 
// Module Name: ID_EXEstage
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

module ID_EXE_stage(
    input clk, rst,
    input [`ISIZE-1:0] IF_instruction_in,
    output reg [`ISIZE-1:0] ID_instruction_out,

    input [`DSIZE-1:0] ID_rdata1_in,
    input [`DSIZE-1:0] ID_rdata2_in,
    input [`DSIZE-1:0] ID_imm_in,
    input [`ASIZE-1:0] ID_waddr_in,
    input ID_wen_in,
    input ID_alusrc_in,
    input [2:0] ID_aluop_in,

    output reg [`DSIZE-1:0] EXE_rdata1_out,
    output reg [`DSIZE-1:0] EXE_rdata2_out,
    output reg [`DSIZE-1:0] EXE_imm_out,
    output reg [`ASIZE-1:0] EXE_waddr_out,
    output reg EXE_wen_out,
    output reg EXE_alusrc_out,
    output reg [2:0] EXE_aluop_out
);

//IF/ID
always @(posedge clk) begin
    if(rst)
        ID_instruction_out <= 0;
    else
        ID_instruction_out <= IF_instruction_in;
end

//ID/EXE
always @(posedge clk) begin
    if(rst) begin
        EXE_rdata1_out<= 0;
        EXE_rdata2_out<= 0;
        EXE_imm_out <= 0;
        EXE_waddr_out <= 0;
        EXE_wen_out<= 0;
        EXE_alusrc_out<= 0;
        EXE_aluop_out<= 0;
    end
    else begin
        EXE_rdata1_out<= ID_rdata1_in;
        EXE_rdata2_out<= ID_rdata2_in;
        EXE_imm_out <= ID_imm_in;
        EXE_waddr_out<= ID_waddr_in;
        EXE_wen_out <= ID_wen_in;
        EXE_alusrc_out<= ID_alusrc_in;
        EXE_aluop_out<= ID_aluop_in;
    end
end

endmodule
