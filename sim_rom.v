//This file was created by a tool wrietten with C.
module sim_rom (
    address,
    clock,
    q);
    input    [10:0]  address;
    input      clock;
    output    [11:0]  q;
    
reg [10:0]    address_latched;
// Instantiate the memory array itself.
reg [11:0]    mem[0:2048-1];
initial begin 
mem[0] = 1219;
mem[1] = 1187;
mem[2] = 3058;
mem[481] = 3075;
mem[482] = 100;
mem[483] = 42;
mem[484] = 107;
mem[485] = 522;
mem[486] = 1603;
mem[487] = 235;
mem[488] = 234;
mem[489] = 650;
mem[490] = 1603;
mem[491] = 651;
mem[492] = 1859;
mem[493] = 3045;
mem[494] = 521;
mem[495] = 1219;
mem[496] = 1443;
mem[497] = 2561;
mem[498] = 100;
mem[499] = 104;
mem[500] = 104;
mem[501] = 3076;
mem[502] = 41;
mem[503] = 3041;
mem[504] = 680;
mem[505] = 3172;
mem[506] = 136;
mem[507] = 1795;
mem[508] = 3061;
mem[509] = 1219;
mem[510] = 1187;
mem[511] = 2560;
mem[512] = 524;
mem[513] = 44;
mem[514] = 684;
mem[515] = 34;
mem[516] = 1219;
mem[517] = 1187;
mem[518] = 3064;
mem[2047] = 2560;
end
// Latch address
always @(posedge clock)
   address_latched <= address;
   
// READ
assign q = mem[address_latched];

endmodule