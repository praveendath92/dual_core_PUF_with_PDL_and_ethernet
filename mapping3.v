module mapping #(
	parameter IN_WIDTH = 128,
	parameter OUT_WIDTH = 16
)(
	input wire clk,
	input wire reset,
	input wire trigger,
	input wire [IN_WIDTH-1:0] dataIn,
	input wire [15:0] opA,
	input wire [15:0] opB,
	output reg done,
	output reg [OUT_WIDTH-1:0] dataOut
	//input wire flag
	);
	
	wire [15:0] response;
	reg startPUF;
	reg PUFreset;
	reg [4:0] countWait;
	integer ind;
	reg [15:0] sum;
	
	//FSM States
	localparam IDLE = 0;
	localparam COMPUTE = 1;
	
	//State Register
	reg mp_state;
	
	reg [IN_WIDTH-1:0] buffer;
	
	always @ (posedge clk) begin
		if (reset) begin
			done <= 0;
			dataOut <= 0;
			mp_state <= IDLE;
			startPUF <= 0;
			countWait <= 0;
			PUFreset <=1;
		end
		
		else begin
			case(mp_state)
				IDLE: begin
					done <= 0;
					sum <= 0;
					PUFreset <= 0;
					countWait <=0;
					startPUF <=0;
					if(trigger == 1)
						//PUFreset <= 0;
						mp_state <= COMPUTE;
						buffer <= dataIn;
				end
				
				COMPUTE: begin
					//for (ind = 0; ind <128; ind = ind + 1) begin
					//	sum <= sum + buffer[ind];
					//end	
					startPUF <=1;
					countWait <= countWait + 1;
					if (countWait == 15) begin //wait for 10 clock cycles
						startPUF<=0;
						//Computation code here.
						/*dataOut <= (buffer[15:0] + buffer[31:16]
									+ buffer[47:32] + buffer[63:48]
									+ buffer[79:64] + buffer[95:80] 
									+ buffer[111:96] + buffer[127:112]);*/
					
						dataOut <= response;
						//dataOut <= sum;
						done <= 1;
						mp_state <= IDLE;
						PUFreset <=1;
					end
				end
			endcase
		end
	end

pufMapping pufCore (
	.CHALLENGE(buffer),
	.RESPONSE(response),
	.trigger(startPUF),
	.reset(PUFreset),
	.a(opA),
	.b(opB)
);
	
endmodule
