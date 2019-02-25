module fullAdder_VAR #(parameter WIDTH=64) (a, b, c_in, sum, c_out);
	output logic [WIDTH-1:0] sum;
	output logic c_out;
	input logic [WIDTH-1:0] a, b;
	input logic c_in;
	
	initial assert(WIDTH>0);
	
	genvar i;
	generate
		for(i=0; i<WIDTH; i++) begin: eachfullAdder
			fullAdder fullAdder (.a(a[i]), .b(b[i]), .c_in, .sum(sum[i]), .c_out);
		end
	endgenerate
endmodule	