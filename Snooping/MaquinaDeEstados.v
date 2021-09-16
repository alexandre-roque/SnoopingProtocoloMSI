/*
Prática IV - Modulo da Maquina de estados
Alunos: Alexandre Roque e Vitor Santana.
Disciplina: Arquitetura e Organização de Computadores II.
Professora: Daniela Cristina Cascini Kupsch.
*/

module MaquinaDeEstados(estado, estadoResultante, EscritaLeitura, HitMiss, bus, writeback, Run);
	input [1:0] estado;						// 00 para Invalido, 01 para Shared, 10 para Modificado
	input EscritaLeitura;					// 0 para leitura e 1 para write
	input HitMiss;								// 1 para Hit e 0 para Miss
	input Run;
	output reg [1:0] estadoResultante;
	output reg [1:0] bus;
	output reg writeback;

/*
	Invalid (00)  	-> CPU read 	   	/ Place read miss on bus  (01)						-> Shared   	(01)
	Invalid (00)  	-> CPU write 	  		/ Place write miss on bus (10)						-> Modified 	(10)
	
	Modified(10) 	-> CPU read miss  	/ Write-back block  										-> Shared 		(01)
	Modified(10) 	-> CPU write miss 	/ Place write miss on bus(10)/Write-back block	-> Modified 	(10)
	Modified(10) 	-> CPU write hit  	/ 														 		-> Modified 	(10)
	Modified(10) 	-> CPU read hit   	/ 														 		-> Modified 	(10)
	
	Shared(01) 	  	-> CPU read hit   	/ 														 		-> Shared 		(01)
	Shared(01) 	  	-> CPU read miss  	/ Place read miss on bus  (01)					 	-> Shared 		(01)
	Shared(01) 	  	-> CPU write hit  	/ Place invalidade on bus (11)						-> Modified  	(10)
	Shared(01) 	  	-> CPU write miss 	/ Place write miss on bus (10)						-> Modified  	(10)
	
*/
	always@(Run,estado,EscritaLeitura, HitMiss) begin
		writeback = 0;
		bus = 2'b00;
		estadoResultante = 2'b11;
		
		case(estado)
			2'b00:
			/*
			Invalid (00)  	-> CPU read 	   	/ Place read miss on bus  (01)						-> Shared   	(01)
			Invalid (00)  	-> CPU write 	  		/ Place write miss on bus (10)						-> Modified 	(10)
			*/
				if(EscritaLeitura) begin
					bus = 2'b10;
					estadoResultante = 2'b10;
				end
				else begin
					bus = 2'b01;
					estadoResultante = 2'b01;
				end
			2'b01: begin                                            // Shared
			/*
			Shared(01)           -> CPU read hit       /                                                     -> Shared         (01)
			Shared(01)           -> CPU read miss      / Place read miss on bus  (01)                        -> Shared         (01)
			Shared(01)           -> CPU write hit      / Place invalidade on bus (11)                        -> Modified      (10)
			Shared(01)           -> CPU write miss     / Place write miss on bus (10)                        -> Modified      (10)
			*/            
				if(!EscritaLeitura && HitMiss) begin        // CPU read hit
					estadoResultante = 2'b01;
				end
				else if(!EscritaLeitura && !HitMiss)begin // CPU read miss
					bus = 2'b01;
					estadoResultante = 2'b01;
				end
				else if(EscritaLeitura && HitMiss)begin     // CPU write hit
					bus = 2'b11;
					estadoResultante = 2'b10;
				end
				else if(EscritaLeitura && !HitMiss)begin // CPU write miss
					bus = 2'b10;
					estadoResultante = 2'b10;
				end            
			end
			2'b10: begin
			/*
			Modified(10)     -> CPU read miss      / Write-back block                                -> Shared         (01)
			Modified(10)     -> CPU write miss     / Place write miss on bus(10)/Write-back block    -> Modified     (10)
			Modified(10)     -> CPU write hit      /                                                 -> Modified     (10)
			Modified(10)     -> CPU read hit       /                                                 -> Modified     (10)
			*/
				 if(!EscritaLeitura && !HitMiss)begin            // CPU read miss
					  bus = 2'b01;
					  writeback = 1;
					  estadoResultante = 2'b01;
				 end
				 else if(EscritaLeitura && !HitMiss)begin         // CPU write miss
					  bus = 2'b10;
					  writeback = 1;
					  estadoResultante = 2'b10;
				 end
				 else if(EscritaLeitura && HitMiss)begin         // CPU write hit
					  estadoResultante = 2'b10;
				 end
				 else if(!EscritaLeitura && HitMiss)begin         // CPU read hit
					  estadoResultante = 2'b10;
				 end
			end
		default begin end
		endcase	
		if(Run == 0) begin
			writeback = 0;
			bus = 2'b00;
			estadoResultante = 2'b11;	
		end
		
		
	end
endmodule
