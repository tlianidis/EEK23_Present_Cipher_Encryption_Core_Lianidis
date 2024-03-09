// Design Name: Substitution Layer for Present Cipher             //
// Module Name: substitution                                      //
// Language:    SystemVerilog                                     //


// Present cipher uses 16 S-Boxes in parallel to process the data
// this module implements those 16 S-Boxes using the sbox module
//- Module IOs ----------------------------------------------------------------
module substitution(
    output wire [63:0] data_o,
    input  wire [63:0 data_i
    ); 

//- Variables, Registers and Parameters ---------------------------------------

genvar j;

//- Instantiations ------------------------------------------------------------

generate
    for (j = 0; j < 16; j = j+1)
    begin : boxes
        sbox substitution_sbox (.data_o(data_o[j*4+3 : j*4]),.data_i(data_i[j*4+3 : j*4]));    
    end
endgenerate

//-----------------------------------------------------------------------------
endmodule
