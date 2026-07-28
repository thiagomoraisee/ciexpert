package alu_pkg;

   string op_names[6]  = {"NOP", "ADD", "SUB", "MUL", "SHL", "SHR"};
   string op_symbols[6] = {" ", "+", "-", "*", "<<", ">>"};
   typedef enum logic [2:0] {
      NOP = 3'b000,
      ADD = 3'b001,
      SUB = 3'b010,
      MUL = 3'b011,
      SHL = 3'b100,
      SHR = 3'b101
   } op_t;

endpackage
