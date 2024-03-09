// Design Name: Test Bench for Present Encryptor Core             //
// Module Name: present_encryptor_top_tb                          //
// Language:    SystemVerilog                                     //

`timescale 1ps / 1ps

//- Test Bench ----------------------------------------------------------------
module present_encryptor_top_tb;
//- Variables, Registers and Parameters ---------------------------------------
wire [63:0] data_o;
logic  [79:0] data_i;
logic  data_load;
logic  key_load;
logic  clk_i;
//- Instantiations ------------------------------------------------------------
present_encryptor_top UUT (.*);
//- Behavioral Modelling -----------------------------------------------------
initial
begin
    $monitor($realtime,,"ps %h %h %h %h %h ",data_o,data_i,data_load,key_load,clk_i);
    #0   data_i = 80'h00000000_00000000_0000 ; key_load = 1; // Key
    #10  data_i = 64'h00000000_00000000      ; key_load = 0; data_load = 1; // Plaintext
    #10  data_load = 0;
    #330 data_i = 80'hFFFFFFFF_FFFFFFFF_FFFF ; key_load = 1; // Key
    #10  data_i = 64'h00000000_00000000      ; key_load = 0; data_load = 1; // Plaintext
    #10  data_load = 0;
    #330 data_i = 80'h00000000_00000000_0000 ; key_load = 1; // Key
    #10  data_i = 64'hFFFFFFFF_FFFFFFFF      ; key_load = 0; data_load = 1; // Plaintext
    #10  data_load = 0;
    #330 data_i = 80'hFFFFFFFF_FFFFFFFF_FFFF ; key_load = 1; // Key
    #10  data_i = 64'hFFFFFFFF_FFFFFFFF      ; key_load = 0; data_load = 1; // Plaintext
    #10  data_load = 0;
    #330 $finish;
end

initial
begin
    clk_i = 1'b0;
    forever #5 clk_i = ~clk_i;
end
//-----------------------------------------------------------------------------
endmodule