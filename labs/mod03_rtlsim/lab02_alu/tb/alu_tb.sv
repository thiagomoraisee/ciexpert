import alu_pkg::*;

module alu_tb();

   parameter unsigned WIDTH = 'd8;

   logic [WIDTH-1:0] w_a, w_b;
   logic [WIDTH-1:0] w_result;
   logic [2:0] w_op;

   alu #(
      .WIDTH(WIDTH)
   ) uu_alu (
      .a     (w_a     ),
      .b     (w_b     ),
      .op    (w_op    ),
      .result(w_result)
   );

   initial begin
      $fsdbDumpfile("waves.fsdb");
      $fsdbDumpvars(0, alu_tb);
   end

   initial begin
      $display("================");
      $display("     RTLSim     ");
      $display("================");
      w_a = 0; w_b = 0; w_op = 3'b000;
      #10
      for(int i=0; i<6; i++) begin
         $display("---== %s ==---", op_names[i]);
         w_op  = i;
         for (int j=0; j<5; j++) begin
            w_a  = $urandom()%16;
            w_b  = $urandom()%16;
            #10
            $display(" %2d %2s %2d = %2d", w_a, op_symbols[i], w_b, w_result);
         end
      end
      #25
      $finish();
   end

endmodule
