`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/28 23:31:55
// Design Name: 
// Module Name: datapath
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

module datapath(
    input clk, rst,
    input memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump,
    input [2:0] alucontrol,
    input [31:0] instr,
    input [31:0] readdata,
    output [31:0] pc,
    output [31:0] aluout, writedata
);

// PC实现
wire [31:0] adderPC, branchPC, PCnext_temp;
adder adderPC_inst(.a(pc), .b(32'h4), .y(adderPC));
// PC选择指令
mux2 PC_select(.option1(adderPC), .option2(instr[25:0]), .select(pcsrc), .data(PCnext_temp));
// PC跳转
wire [31:0] PCjump, PCnext;
assign PCjump = {adderPC[31:28], instr[25:0], 2'b00};
mux2 PCnext_inst(.option1(PCnext_temp), .option2(PCjump), .select(jump), .data(PCnext));
// PC模块
pc PC_inst(.clk(clk), .rst(rst), .newPC(PCnext), .pc(pc));
// branch计算模块
wire [31:0] sign_extend;
sign_extend sign_extend_inst(.sign(instr[15:0]), .sign_extend(sign_extend));
adder adderBranch_inst(.a(adderPC), .b(sign_extend<<2), .y(branchPC));
// 寄存器堆
wire [31:0] srcA, res;
wire [4:0] wa3;
regfile regfile_inst(.clk(clk), .we3(regwrite), .ra1(instr[25:21]), .ra2(instr[20:16]), .wa3(wa3), .wd3(res), .rd1(srcA), .rd2(writedata));
mux2 select_dst(.option1({27'b0, instr[20:16]}), .option2({27'b0, instr[15:11]}), .select(regdst), .data(wa3));
// ALU
wire [31:0] srcB;
mux2 select_srcB(.option1(writedata), .option2(sign_extend), .select(alusrc), .data(srcB));
ALU ALU_inst(.num1(srcA), .num2(srcB), .op(alucontrol), .ans(aluout));
mux2 select_res(.option1(readdata), .option2(aluout), .select(memtoreg), .data(res));

endmodule