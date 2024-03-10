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

//- Behavioral Modelling -----------------------------------------------------

initial
begin
    $monitor($realtime,,"ps %h %h %h %h %h ",data_o,data_i,data_load,key_load,clk_i);
    #0   data_i = 80'h00000000_00000000_0000 ; key_load = 1; clk_i = 1'b0; //Loading the key and clk_i initialization
    #10  data_i = 64'h00000000_00000000      ; key_load = 0; data_load = 1; //Loading the plaintext
    #10  data_load = 0;                                                     //Starting normal operation of the circuit
    #330 data_i = 80'hFFFFFFFF_FFFFFFFF_FFFF ; key_load = 1;                // Loading the key
    #10  data_i = 64'h00000000_00000000      ; key_load = 0; data_load = 1; // Loading the plaintext
    #10  data_load = 0;                                                     //Starting normal operation of the circuit
    #330 data_i = 80'h00000000_00000000_0000 ; key_load = 1;                // Loading the key
    #10  data_i = 64'hFFFFFFFF_FFFFFFFF      ; key_load = 0; data_load = 1; // Loading the plaintext
    #10  data_load = 0;                                                     //Starting normal operation of the circuit
    #330 data_i = 80'hFFFFFFFF_FFFFFFFF_FFFF ; key_load = 1;                // Loading the key
    #10  data_i = 64'hFFFFFFFF_FFFFFFFF      ; key_load = 0; data_load = 1; // Loading the plaintext
    #10  data_load = 0;                                                     //Starting normal operation of the circuit
    #330 $finish;                                                           //Finish simulation
end

always                  // Generation of clk_i at 100 GHz
    #5 clk_i = ~clk_i;

//-----------------------------------------------------------------------------
endmodule