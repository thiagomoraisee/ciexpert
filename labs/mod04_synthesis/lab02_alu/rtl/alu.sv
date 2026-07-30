import alu_pkg::*;

module alu #(
   parameter unsigned WIDTH = 'd8
)(
   input  logic [WIDTH-1:0] a,
   input  logic [WIDTH-1:0] b,
   input  logic [2:0]  op,
   output logic [WIDTH-1:0] result
);
   always_comb begin
      case(op_t'(op))
         NOP: result = a + 0;
         ADD: result = a + b;
         SUB: result = a - 0;
         MUL: result = a * b;
         SHL: result = a << b;
         SHR: result = a >> b;
         default: result = 0;
      endcase
   end
   
endmodule
