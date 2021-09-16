/*
Prática IV - Modulo do topLevel do Snooping
Alunos: Alexandre Roque e Vitor Santana.
Disciplina: Arquitetura e Organização de Computadores II.
Professora: Daniela Cristina Cascini Kupsch.
*/

module Snooping(RunFirst, clock);
	input clock;
	input RunFirst;
	wire [7:0] endereco;
	wire [15:0] instr;
	wire DoneP0, DoneP1, DoneP3;
	wire Next = DoneP0 | DoneP1 | DoneP3 | RunFirst ;
	wire [6:0] valorRetornoP0, valorRetornoP1, valorRetornoP3;
	wire [1:0] saidaBusP0, saidaBusP1, saidaBusP3;
	wire [1:0] saidaBus = saidaBusP0 | saidaBusP1 | saidaBusP3;
	wire writebackP0, writebackP1, writebackP3;
	
	wire auxWriteBackOuvinteP0, auxWriteBackOuvinteP1, auxWriteBackOuvinteP3;
	wire auxWriteBackOuvinte = auxWriteBackOuvinteP0 | auxWriteBackOuvinteP1 | auxWriteBackOuvinteP3; 
	
	wire [6:0] saidaMemoria;
	
	wire [6:0] valorParaMemoriaP0;
	wire LeituraEscritaMemoriaP0;
	wire [4:0] tagParaMemoriaP0;
	
	wire [6:0] valorParaMemoriaP1;
	wire LeituraEscritaMemoriaP1;
	wire [4:0] tagParaMemoriaP1;
	
	wire [6:0] valorParaMemoriaP3;
	wire LeituraEscritaMemoriaP3;
	wire [4:0] tagParaMemoriaP3;
	
	wire achouBuscaP0, achouBuscaP1, achouBuscaP3;
	wire achouBusca = achouBuscaP0 | achouBuscaP1 | achouBuscaP3;
	
	wire [6:0] valorParaMemoria = valorParaMemoriaP0 | valorParaMemoriaP1 | valorParaMemoriaP3;
	wire LeituraEscritaMemoria = LeituraEscritaMemoriaP0 | LeituraEscritaMemoriaP1 | LeituraEscritaMemoriaP3 | writebackP0 | writebackP1 | writebackP3;
	wire [4:0] tagParaMemoria = tagParaMemoriaP1 | tagParaMemoriaP0 | tagParaMemoriaP3;
	
	wire reset = Next;
	wire inputBusca;
	
	wire [6:0] resultadoBuscaP0, resultadoBuscaP1, resultadoBuscaP3;
	wire [6:0] resultadoBusca = resultadoBuscaP0 | resultadoBuscaP1 | resultadoBuscaP3;
	
	wire buscaCacheP0, buscaCacheP1, buscaCacheP3;
	wire buscaCache = buscaCacheP0 | buscaCacheP1 | buscaCacheP3;
	
	counter Counter(clock, Next, endereco);
	
	MemInst MemIntrucoes(endereco, instr);
	
	memRam Mem(tagParaMemoria, clock, valorParaMemoria, LeituraEscritaMemoria, saidaMemoria);
	
	cache P0 (2'b00, 1'b1, instr, DoneP0, clock, reset, valorRetornoP0, saidaBusP0, writebackP0, valorParaMemoriaP0, LeituraEscritaMemoriaP0, tagParaMemoriaP0, buscaCacheP0, buscaCache, resultadoBuscaP0, resultadoBusca, saidaMemoria, saidaBus, achouBuscaP0, achouBusca, auxWriteBackOuvinteP0);

	cache P1 (2'b01, 1'b1, instr, DoneP1, clock, reset, valorRetornoP1, saidaBusP1, writebackP1, valorParaMemoriaP1, LeituraEscritaMemoriaP1, tagParaMemoriaP1, buscaCacheP1, buscaCache, resultadoBuscaP1, resultadoBusca, saidaMemoria, saidaBus, achouBuscaP1, achouBusca, auxWriteBackOuvinteP1);

	cache P3 (2'b11, 1'b1, instr, DoneP3, clock, reset, valorRetornoP3, saidaBusP3, writebackP3, valorParaMemoriaP3, LeituraEscritaMemoriaP3, tagParaMemoriaP3, buscaCacheP3, buscaCache, resultadoBuscaP3, resultadoBusca, saidaMemoria, saidaBus, achouBuscaP3, achouBusca, auxWriteBackOuvinteP3);

	//module cache(tagProcessador, Run, inst, Done, clock, reset, valorRetorno, saidaBus, writeback, valorParaMemoria, LeituraEscritaMemoria, tagParaMemoria, buscaCache, inputBusca, resultadoBusca, resultadoRecebidoBusca,valorRecebidoDaMemoria);

	
	
endmodule
