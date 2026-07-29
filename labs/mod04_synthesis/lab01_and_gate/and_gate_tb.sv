module and_gate_tb();

logic w_a, w_b, w_y;

and_gate uu_and_gate (
  .a(w_a),
  .b(w_b),
  .y(w_y)
  );

initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0, and_gate_tb);
end

initial begin
  $display(" A B | Y");
  $display("-----+---");

  for(byte i=0; i<4; i++) begin
    w_a = i[0]; w_b = i[1];
    #10
    $display(" %1b %1b | %1b", w_a, w_b, w_y);
  end

  $finish();
end

endmodule
