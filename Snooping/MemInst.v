/*
Prática IV - Modulo da memória de instruções
Alunos: Alexandre Roque e Vitor Santana.
Disciplina: Arquitetura e Organização de Computadores II.
Professora: Daniela Cristina Cascini Kupsch.
*/

module MemInst(endereco, instr);
	input [7:0] endereco;
	output reg [15:0] instr;
	
	reg [15:0] instrucoes [10:0];
	
	initial begin				// IMEDIATO [6:0] // TAG [11:7] // WriteRead [12] // PROCESSADOR [15:13]
		
		// a) P0: read 120
		instrucoes[0] = 16'b0000101000000000;
		// b) P0: write 120 <- - 80 (escreve 80 na posição 120)
		instrucoes[1] = 16'b0001101001010000;
		// c) P3: write 120 <--80
		instrucoes[2] = 16'b0111101001010000;
		// d) P1: read 110
		instrucoes[3] = 16'b0010010100000000;
		// e) P3: write 110 <-- 30
		instrucoes[4] = 16'b0111010100011110;
		// f) P3: read 110
		instrucoes[5] = 16'b0110010100000000;
		// g) P0: write 108 < -- 48
		instrucoes[6] = 16'b0001010000110000;
		// h) P0: write 130 <-- 78
		instrucoes[7] = 16'b0001111101001110;
		// i) P3: write 130 <-- 78
		instrucoes[8] = 16'b0111111101001110;
		
		/*
		P1 read 108
		P1 read 128
		*/
		instrucoes[9] =  16'b0010010000000000;
		
		instrucoes[10] = 16'b0010111000000000;
		
		
		
		/*instrucoes[0] = 16'b0001111000001010;
		
		instrucoes[0] = 16'b0000010000000000;
		
		instrucoes[1] = 16'b0001010000000000;
		
		instrucoes[2] = 16'b0001100100000000;
		
		instrucoes[3] = 16'b0001010100000000;
		
		instrucoes[4] = 16'b0001111000001010;
		*/
		
	end
	
	always@(endereco) begin
		instr = instrucoes[endereco];	
	end

endmodule
