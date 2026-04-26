`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2026 18:45:05
// Design Name: 
// Module Name: EXE_WBstage
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

module EXE_WB_stage(
    input clk,
    input rst,
    input [`DSIZE-1:0] res_in,
    input [`ASIZE-1:0] addr_in,
    input wen_in,

    output reg [`DSIZE-1:0] res_out,
    output reg [`ASIZE-1:0] addr_out,
    output reg wen_out
);

always @(posedge clk) begin
    if (rst) begin
        res_out  <= 0;
        addr_out <= 0;
        wen_out  <= 0;
    end
    else begin
        res_out  <= res_in;
        addr_out <= addr_in;
        wen_out  <= wen_in;
    end
end

endmodule
