// Design Name: Present Cipher S-BOX                              //
// Module Name: sbox                                              //
// Language:    SystemVerilog                                     //

//- Module IOs ----------------------------------------------------------------
module sbox (
    output logic [3:0] data_o,
    input [3:0] data_i
    );

//- Procedural Assignments------------------------------------------------------

always_comb                          // This always_comb block implements purely combinational logic
    unique case (data_i)             // Added unique keyword to ensure that there are no overlapping case items
        4'h0 : data_o = 4'hC;
        4'h1 : data_o = 4'h5;
        4'h2 : data_o = 4'h6;
        4'h3 : data_o = 4'hB;
        4'h4 : data_o = 4'h9;
        4'h5 : data_o = 4'h0;
        4'h6 : data_o = 4'hA;
        4'h7 : data_o = 4'hD;
        4'h8 : data_o = 4'h3;
        4'h9 : data_o = 4'hE;
        4'hA : data_o = 4'hF;
        4'hB : data_o = 4'h8;
        4'hC : data_o = 4'h4;
        4'hD : data_o = 4'h7;
        4'hE : data_o = 4'h1;
        4'hF : data_o = 4'h2;
    endcase 

//-----------------------------------------------------------------------------
endmodule
