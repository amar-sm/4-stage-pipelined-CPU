`include "define.v"

module memory(
    input clk,
    input rst,
    input wen,
    input [`ISIZE-1:0] addr,
    input [`DSIZE-1:0] data_in,
    input fileid,
    output [`DSIZE-1:0] data_out
);
reg [`DSIZE-1:0] mem_array [0:255];

initial begin
    mem_array[0]  = 32'h00000000; //NOP
    mem_array[1]  = 32'h05031000; //SUB $2,$8,$3
    mem_array[2]  = 32'h00000000; 
    mem_array[3]  = 32'h00000000;
    mem_array[4]  = 32'h00430800; //ADD $1,$2,$3
    mem_array[5]  = 32'h00000000;
    mem_array[6]  = 32'h00000000;
    mem_array[7]  = 32'h0901F000;  //AND $30,$8,$1
    mem_array[8]  = 32'h00000000;
    mem_array[9]  = 32'h00000000;
    mem_array[10] = 32'h1502F800; //MUL $31,$8,$2
    mem_array[11] = 32'h00000000;
    mem_array[12] = 32'h00000000;
    mem_array[13] = 32'h03FA5000;  //ADD $10,$31,$26
    mem_array[14] = 32'h00000000;
    mem_array[15] = 32'h00000000;
    mem_array[16] = 32'h18E40001; //ADDI $4,$7,1
    mem_array[17] = 32'h00000000;
    mem_array[18] = 32'h00000000;
end

assign data_out = mem_array[addr];
always @(posedge clk) begin
    if (wen)
        mem_array[addr]<= data_in;
end

endmodule