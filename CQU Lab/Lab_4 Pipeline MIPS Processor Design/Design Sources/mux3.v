`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 17:12:57
// Design Name: 
// Module Name: mux3
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


module mux3 #(parameter WIDTH = 32)
(
    input [WIDTH-1:0] option1, option2, option3,
    input [1:0] select,
    output reg [WIDTH-1:0] data
);

    always @ (*) begin
        if (select == 2'b00) begin
            data = option1;
        end
        else if (select == 2'b01) begin
            data = option2;
        end
        else if (select == 2'b10) begin
            data = option3;
        end
        else begin
            data = 0;
        end
    end
endmodule