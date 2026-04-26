`timescale 1ns / 1ps

module testbench_4_stage_pipeline;
reg clk;
reg rst;
wire [31:0] aluout;

pipelined_4stage uut(
    .clk(clk),
    .rst(rst),
    .aluout(aluout)
);

always #10 clk = ~clk;
initial begin
    clk = 0;
    rst = 1;
    #50;
    rst = 0;
    #500;
    $finish;
end

endmodule