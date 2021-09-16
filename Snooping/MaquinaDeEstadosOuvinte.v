/*
Prática IV - Modulo da Maquina de estados do ouvinte
Alunos: Alexandre Roque e Vitor Santana.
Disciplina: Arquitetura e Organização de Computadores II.
Professora: Daniela Cristina Cascini Kupsch.
*/

module MaquinaDeEstadosOuvinte(estado, estadoResultante, bus, writeback, abortaAcessoMemoria, Run);
	input [1:0] estado;
	input [1:0] bus;
	input Run;
	output reg [1:0] estadoResultante;
	output reg writeback, abortaAcessoMemoria;
	/*
		Shared 		(01) 	->	Invalidate 		(11)	-> Invalid 	(00)
		Shared 		(01)	-> Write miss 		(10)	-> Invalid 	(00)
		Shared 		(01)	-> CPU read miss 	(01)	-> Shared  	(01)
		
		Modified 	(10)	->	Read miss		(01)	->	Shared	(01)	WRITEBACK
		Modified 	(10)	->	Write miss		(10)	->	Invalid	(00)	WRITEBACK
	
	*/
	
	always@(Run, estado, bus) begin
		writeback = 0;
		estadoResultante = estado;
		abortaAcessoMemoria = 0;
		case(estado)
			2'b01:
				case(bus)
					2'b11:
						estadoResultante = 2'b00;
					2'b10:
						estadoResultante = 2'b00;
					2'b01:
						estadoResultante = 2'b01;
				default begin end
				endcase
			2'b10:
				case(bus)
					2'b10: begin
						estadoResultante = 2'b00;
						writeback = 1;
						abortaAcessoMemoria = 1;
					end
					2'b01: begin
						estadoResultante = 2'b01;
						writeback = 1;
						abortaAcessoMemoria = 1;
					end
				default begin end
				endcase		
		default begin end
		endcase
	end

endmodule
