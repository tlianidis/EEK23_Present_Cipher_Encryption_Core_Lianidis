// Design Name: Test Bench for Present Encryptor Core             //
// Module Name: present_encryptor_top_tb                          //
// Language:    SystemVerilog                                     //

`timescale 1ps / 1ps

//- Test Bench ----------------------------------------------------------------
module present_encryptor_top_tb;

//- Variables, Registers and Parameters ---------------------------------------

wire [63:0] data_o;   // ciphertext will appear here
logic [79:0] data_i;  // plaintext and key must be fed here
logic data_load;      // when '1', first 64 bits of data_i will be loaded into state register
logic key_load;       // when '1', data_i will be loaded into key register
logic clk_i;         // clock signal

//- Instantiations ------------------------------------------------------------

present_encryptor_top DUT (.*);

//- Assertions ----------------------------------------------------------------

assert property(@(posedge clk_i) key_load |-> !data_load) $display("Key_load is 1 and data_load is 0. That is correct.");
else $error("Both key_load and data_load are 1. That is an error.");

assert property(@(posedge clk_i) data_load |-> !key_load) $display("Data_load is 1 and key_load is 0. That is correct.");
else $error("Both key_load and data_load are 1. That is an error.");

assert property(@(posedge clk_i) data_load |=> !data_load) $display("Data_load is 1 and on the next clock cycle is 0. That is correct.");
else $error("Data_load is 1 and on the next clock cycle it is still 1. That is an error.");

assert property(@(posedge clk_i) key_load |=> !key_load) $display("Key_load is 1 and on the next clock cycle is 0. That is correct.");
else $error("Key_load is 1 and on the next clock cycle it is still 1. That is an error.");


//- Behavioral Modelling -----------------------------------------------------



initial
begin
    
    $monitor($realtime," ps %h %h %h %h %h", data_o, data_i, data_load, key_load, clk_i);
  
    #0   data_i = 80'h00000000_00000000_0000 ; key_load = 1; clk_i = 1'b0; data_load =0; //Loading the key and clk_i initialization
    #10  data_i = 64'h00000000_00000000      ; key_load = 0; data_load = 1;              //Loading the plaintext
    #10  data_load = 0;                                                                   //Starting normal operation of the circuit
    #315
          data_i = 80'hFFFFFFFF_FFFFFFFF_FFFF ; key_load = 1;                             // Loading the key
    #10  data_i = 64'h00000000_00000000      ; key_load = 0; data_load = 1;              // Loading the plaintext
    #10  data_load = 0;                                                                 //Starting normal operation of the circuit
    #315
          data_i = 80'h00000000_00000000_0000 ; key_load = 1;                            // Loading the key
    #10  data_i = 64'hFFFFFFFF_FFFFFFFF      ; key_load = 0; data_load = 1;             // Loading the plaintext
    #10  data_load = 0;                                                                   //Starting normal operation of the circuit
    #315
         data_i = 80'hFFFFFFFF_FFFFFFFF_FFFF ; key_load = 1;                          // Loading the key
    #10  data_i = 64'hFFFFFFFF_FFFFFFFF      ; key_load = 0; data_load = 1;           // Loading the plaintext
    #10  data_load = 0;                                                               //Starting normal operation of the circuit
    #315
         data_i = 80'h15643925_ABCD45F1_EA12 ; key_load = 1;                              // Loading the key
    #10  data_i = 64'hABCD4561_AB239845      ; key_load = 0; data_load = 1;             // Loading the plaintext
    #10  data_load = 0;                                                                   //Starting normal operation of the circuit
    #315
         data_i = 80'h8814356B_B1239856_BCBB ; key_load = 1;                           // Loading the key
    #10  data_i = 64'hBACDEF12_66578321      ; key_load = 0; data_load = 1;             // Loading the plaintext
    #10  data_load = 0;                                                                 //Starting normal operation of the circuit
    #315
         data_i = 80'h9993BAAE_44432567_AB45 ; key_load = 1;                           // Loading the key
    #10  data_i = 64'hCDA91243_34561298      ; key_load = 0; data_load = 1;           // Loading the plaintext
    #10  data_load = 0;                                                                //Starting normal operation of the circuit
    #315 
         data_i = 80'h554678AB_ABDC3894_8742 ; key_load = 1;                          // Loading the key
    #10  data_i = 64'hDBCA5523_F945FAB2      ; key_load = 0; data_load = 1;          // Loading the plaintext
    #10  data_load = 0;                                                               //Starting normal operation of the circuit
    #315 $finish;                                                                         //Finish simulation
end

always                  // Generation of clk_i at 100 GHz
    #5 clk_i = ~clk_i;

//-----------------------------------------------------------------------------
endmodule