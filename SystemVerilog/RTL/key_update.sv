// Design Name: Key Update Procedure for Present Cipher           //
// Module Name: key_update                                        //
// Language:    SystemVerilog                                     //


module key_update(data_o,data_i,round_counter);

//- Module IOs ----------------------------------------------------------------

output wire[79 : 0] data_o; // 80-bit output (will be the updated value of current key)
input  wire[79 : 0] data_i; // 80-bit input 
input  wire[4  : 0] round_counter;

//- Variables, Registers and Parameters ---------------------------------------

wire [79:0] s1,s2,s3; // intermediate signals                                  

//- Instantiations ------------------------------------------------------------

sbox key_update_sbox(.data_o(s2[79:76]),.data_i(s1[79:76])); // four left-most bits are determined by the sbox output

//- Continuous Assignments------------------------------------------------------

assign s1 = {data_i[18:0],data_i[79:19]};
assign s2[75:0] = s1[75:0]; // four left-most bits are determined by the sbox output
assign s3 = {s2[79:20],(s2[19:15])^(round_counter),s2[14:0]};   
assign data_o = s3;

//-----------------------------------------------------------------------------
endmodule
