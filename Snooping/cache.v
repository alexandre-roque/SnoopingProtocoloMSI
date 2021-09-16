/*
Prática IV - Modulo das caches
Alunos: Alexandre Roque e Vitor Santana.
Disciplina: Arquitetura e Organização de Computadores II.
Professora: Daniela Cristina Cascini Kupsch.
*/

module cache(tagProcessador, Run, inst, Done, clock, reset, valorRetorno, saidaBus, writeback, valorParaMemoria, LeituraEscritaMemoria, tagParaMemoria, buscaCache, inputBusca, resultadoBusca, resultadoRecebidoBusca,valorRecebidoDaMemoria, entradaBus, achouBusca, achouBuscaInput, auxWriteBackOuvinte);
	input [1:0] tagProcessador;
	input [15:0] inst;
	input Run, clock, reset;
	
	input inputBusca;
	output reg buscaCache;
	
	output reg [6:0] resultadoBusca;
	output reg achouBusca;
	input achouBuscaInput;
	
	input [6:0] resultadoRecebidoBusca;
	
	input [6:0] valorRecebidoDaMemoria;
	
	output reg Done;
	output reg [6:0] valorRetorno;
	output [1:0] saidaBus;
	input [1:0] entradaBus;
	
	output writeback;
	
	output reg [4:0] tagParaMemoria;
	output reg [6:0] valorParaMemoria;
	output reg LeituraEscritaMemoria;
	
	output reg auxWriteBackOuvinte;
	
	
	wire [1:0] estadoResultante;
	
	reg 	[4:0] tag;
	reg	EscritaLeitura;
	reg 	[1:0] ProcessadorAtual;
	reg 	HitMissAtual;
	
	reg 	[4:0]  tags  [3:0];
	reg 	[1:0] Estado [3:0];
	reg 	[6:0] Dados  [3:0];
	
	reg [4:0] TagAtual;
	reg ExisteTag;
	reg [1:0] EstadoAtual;
	reg [6:0] DadoEscrito;
	integer posicaoTag;
	integer posicaoTagOuvinte;
	reg existeTagOuvinte;
	
	
	reg RunMaquinaDeEstados;
	reg RunMaquinaDeEstadosOuvinte;
	
	reg [1:0] estadoOuvinte;
	wire [1:0] estadoResultanteOuvinte;
	
	wire abortaAcessoMemoria;
	wire writebackOuvinte;
	
	reg [4:0] TagMapeamento;
	integer posicaoTagMapeamento;
	
	wire [2:0] Tstep_Q;
	wire Clear = Done || reset;
	
	upcount Tstep (Clear, clock, Tstep_Q);
	
	integer i;
	
	
	always@(Tstep_Q or inst) begin	
		ProcessadorAtual = inst[15:13];
		tag = inst[11:7];
		EscritaLeitura = inst[12];
		DadoEscrito = inst[6:0];
		RunMaquinaDeEstados = 0;
		valorParaMemoria = 7'b0000000;
		LeituraEscritaMemoria = 0;
		tagParaMemoria = 4'b0000;
		achouBusca = 0;
		auxWriteBackOuvinte = 0;
		
		if(tagProcessador == ProcessadorAtual) begin
			case(Tstep_Q) 
				3'b000: begin		// Passo 0
					Done = 0;
					ExisteTag = 0;
					TagAtual = 4'bxxxx;
					valorRetorno = 7'bxxxxxxx;
					HitMissAtual = 0;
					EstadoAtual =  2'bxx;
					buscaCache = 0;
				
					for(i =0; i <= 3; i=i+1) begin		// Confere se tem Tag
						if(tag == tags[i]) begin
							ExisteTag = 1;
							TagAtual = tags[i];
							EstadoAtual = Estado[i];
							posicaoTag = i;
						end
					end // for
				
					if(ExisteTag == 0) begin		// Faz o mapeamento
						if(tag == 0) begin
							TagMapeamento = 20;
							posicaoTagMapeamento = 0;
						end
						else if(tag == 8) begin
							TagMapeamento = 28;
							posicaoTagMapeamento = 1;
						end
						else if(tag == 10) begin
							TagMapeamento = 30;
							posicaoTagMapeamento = 2;
						end
						
						if(tag == 20) begin
							TagMapeamento = 0;
							posicaoTagMapeamento = 0;
						end
						else if(tag == 28) begin
							TagMapeamento = 8;
							posicaoTagMapeamento = 1;
						end
						else if(tag == 30) begin
							TagMapeamento = 10;
							posicaoTagMapeamento = 2;
						end
						EstadoAtual = Estado[posicaoTagMapeamento];
						TagAtual = TagMapeamento;
						posicaoTag = posicaoTagMapeamento;
					end
				
					case(EstadoAtual)						// Confere se é hit ou miss
						2'b01, 2'b10:
							if(ExisteTag)
								HitMissAtual = 1;
					endcase				
					
					if(HitMissAtual == 0) begin
						buscaCache = 1;
					end
					
					RunMaquinaDeEstados = 1;
					
				end // Passo 0
				
				3'b001: begin
					
					if(writeback) begin
						valorParaMemoria = Dados[posicaoTag];
						LeituraEscritaMemoria = 1;
						tagParaMemoria = tags[posicaoTag];
					end
					
					Estado[posicaoTag] = estadoResultante;
					if(HitMissAtual == 1) begin		
						if(EscritaLeitura) begin
							Dados[posicaoTag] = DadoEscrito;
							Done = 1;
						end
						else begin
							valorRetorno = Dados[posicaoTag];
							Done = 1;
						end
					end
					else if(HitMissAtual == 0) begin
						tags[posicaoTag] = tag;
						if(EscritaLeitura) begin
							Dados[posicaoTag] = DadoEscrito;
							Done = 1;
						end
					end
					
				
				end
				
				3'b010: begin
					
					if(achouBuscaInput) begin
						Dados[posicaoTag] = resultadoRecebidoBusca;
						valorRetorno = Dados[posicaoTag];
						Done = 1;
					end
					else begin
						LeituraEscritaMemoria = 0;
						tagParaMemoria = tag;
					end
					
					
				end
				
				3'b100: begin
					Dados[posicaoTag] = valorRecebidoDaMemoria;
					valorRetorno = Dados[posicaoTag];
					Done = 1;
				end
				
				default begin end
			endcase
		end
	
		else begin												// tagProcessador
			case(Tstep_Q) 
				3'b000: begin
					existeTagOuvinte = 0;
					resultadoBusca = 0;
					LeituraEscritaMemoria = 0;
					
					for(i =0; i <= 3; i=i+1) begin		// Confere se tem Tag
						if(tag == tags[i]) begin
							existeTagOuvinte = 1;
							estadoOuvinte = Estado[i];
							posicaoTagOuvinte = i;
							if(estadoOuvinte == 2'b10) begin	// Writeback ouvinte feito antes para não fazer ao mesmo tempo
								auxWriteBackOuvinte = 1;
								valorParaMemoria = Dados[posicaoTagOuvinte];
								LeituraEscritaMemoria = 1;
								tagParaMemoria = tags[posicaoTagOuvinte];					
							end
						end
					end // for
					RunMaquinaDeEstadosOuvinte = 1;
				end
			
			
				3'b001: begin
					/*
					if(writebackOuvinte) begin	
						auxWriteBackOuvinte = 1;
						valorParaMemoria = Dados[posicaoTagOuvinte];
						LeituraEscritaMemoria = 1;
						tagParaMemoria = tags[posicaoTagOuvinte];					
					end
					*/
				
				
					if(inputBusca && abortaAcessoMemoria) begin
						achouBusca = 1;
						resultadoBusca = Dados[posicaoTagOuvinte];				
					end
				
					if(existeTagOuvinte) begin
						Estado[posicaoTagOuvinte] = estadoResultanteOuvinte;
					end		
					
				end			
			
			
			default begin end
			endcase
		end
		
	end
	
	MaquinaDeEstados maquina(EstadoAtual, estadoResultante, EscritaLeitura, HitMissAtual, saidaBus, writeback, RunMaquinaDeEstados);

	MaquinaDeEstadosOuvinte maquinaOuvinte(estadoOuvinte, estadoResultanteOuvinte, entradaBus, writebackOuvinte, abortaAcessoMemoria, RunMaquinaDeEstadosOuvinte);
	
	
endmodule
