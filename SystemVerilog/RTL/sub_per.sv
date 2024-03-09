// Design Name: Substitution & Permutation  for Present Cipher    //
// Module Name: sub_per                                           //
// Language:    SystemVerilog                                     //

// this module cascades the substitution and permutation layers of the cipher and builds a 
// single entity containing both of them
//- Module IOs ----------------------------------------------------------------
module sub_per(
    output [63:0] data_o,
    input [63:0] data_i
    );

//- Variables, Registers and Parameters ---------------------------------------

wire [63:0] s; // intermediate signal

//- Instantiations ------------------------------------------------------------

substitution sub_per_substitution(.data_o(s)   ,.data_i(data_i)); // input of the S-Box is data_i
permutation  sub_per_permutation (.data_o(data_o),.data_i(s)); // output of Permutation layer is data_o

//-----------------------------------------------------------------------------
endmodule
