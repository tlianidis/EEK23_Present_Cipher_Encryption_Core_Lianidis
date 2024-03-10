// Design Name: Key Update Procedure for Present Cipher           //
// Module Name: key_update                                        //
// Language:    SystemVerilog                                     //

//- Module IOs ----------------------------------------------------------------
module key_update(
    output [79 : 0] data_o,     // 80-bit output (will be the updated value of current key)
    input [79 : 0] data_i,     // 80-bit input
    input [4  : 0] round_counter
    );

//- Variables, Registers and Parameters ---------------------------------------

wire [79:0] s1 = {data_i[18:0],data_i[79:19]};  //s1 is an intermediate signal
                                                // the key register is rotated by 61 bit positions to the left
wire [79:0] s2; // intermediate signal                                  
wire [79:0] s3 =  {s2[79:20],(s2[19:15])^(round_counter),s2[14:0]}; // s3 is an intermediate signal
                                                                    //round_counter value is exclusive-ored with bits [19:15] of s2

//- Instantiations ------------------------------------------------------------

sbox key_update_sbox(.data_o(s2[79:76]),.data_i(s1[79:76])); // four left-most bits are determined by the sbox output

//- Continuous Assignments------------------------------------------------------

assign s2[75:0] = s1[75:0]; // four left-most bits are determined by the sbox output 
assign data_o = s3;         //updated value of current key

//-----------------------------------------------------------------------------
endmodule
