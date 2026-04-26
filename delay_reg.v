`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2026 11:14:45
// Design Name: 
// Module Name: delay_reg
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

module delay_reg(
    input clk,
    input rst,
    input [`DSIZE-1:0] wdatain,
    input [`ASIZE-1:0] waddrin,
    output reg [`DSIZE-1:0] wdataout,
    output reg [`ASIZE-1:0] waddrout
);

always @(posedge clk) begin
    if(rst) begin
        wdataout <= 0;
        waddrout <= 0;
    end
    else begin
        wdataout <= wdatain;
        waddrout <= waddrin;
    end
end

endmodule
