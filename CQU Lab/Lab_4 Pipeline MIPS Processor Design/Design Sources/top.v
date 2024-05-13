`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 20:32:48
// Design Name: 
// Module Name: top
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


module top(
	input wire clk,rst,
	output wire[31:0] writedata,dataadr,
	output wire memwrite
    );
	// wire clk;
	wire[31:0] pc,instr,readdata;
    wire stallD, pcsrc;
	
	mips mips(.clk(clk), .rst(rst), .pc(pc), .instr(instr), .memwriteM(memwrite), .aluout(dataadr), .writedata(writedata), .readdata(readdata), .stallD(stallD), .pcsrc(pcsrc));
	inst_mem imem(.clka(clk), .addra(pc), .douta(instr), .rsta(rst|pcsrc), .ena(~stallD));
    data_mem dmem(.clka(clk), .addra(dataadr), .dina(writedata), .douta(readdata), .wea(memwrite));
endmodule