/*
Prática IV - Modulo da simulacao
Alunos: Alexandre Roque e Vitor Santana.
Disciplina: Arquitetura e Organização de Computadores II.
Professora: Daniela Cristina Cascini Kupsch.
*/

module simula;
	reg clock, RunFirst;
	integer i;

	Snooping toplevel(RunFirst, clock);

	wire Next = toplevel.Next;
	wire Tstep_Q = toplevel.P0.Tstep_Q;

	wire 	[1:0] EstadoP0 [3:0];
	wire 	[4:0]  tagsP0  [3:0];
	wire 	[6:0] DadosP0  [3:0];

	wire 	[1:0] EstadoP1 [3:0];
	wire 	[4:0]  tagsP1  [3:0];
	wire 	[6:0] DadosP1  [3:0];

	wire 	[1:0] EstadoP3 [3:0];
	wire 	[4:0]  tagsP3  [3:0];
	wire 	[6:0] DadosP3  [3:0];


	assign EstadoP0[0] = toplevel.P0.Estado[0];
	assign EstadoP0[1] = toplevel.P0.Estado[1];
	assign EstadoP0[2] = toplevel.P0.Estado[2];
	assign EstadoP0[3] = toplevel.P0.Estado[3];

	assign EstadoP1[0] = toplevel.P1.Estado[0];
	assign EstadoP1[1] = toplevel.P1.Estado[1];
	assign EstadoP1[2] = toplevel.P1.Estado[2];
	assign EstadoP1[3] = toplevel.P1.Estado[3];

	assign EstadoP3[0] = toplevel.P3.Estado[0];
	assign EstadoP3[1] = toplevel.P3.Estado[1];
	assign EstadoP3[2] = toplevel.P3.Estado[2];
	assign EstadoP3[3] = toplevel.P3.Estado[3];

	assign tagsP0[0] =	toplevel.P0.tags[0];
	assign tagsP0[1] =	toplevel.P0.tags[1];
	assign tagsP0[2] =	toplevel.P0.tags[2];
	assign tagsP0[3] =	toplevel.P0.tags[3];

	assign tagsP1[0] =	toplevel.P1.tags[0];
	assign tagsP1[1] =	toplevel.P1.tags[1];
	assign tagsP1[2] =	toplevel.P1.tags[2];
	assign tagsP1[3] =	toplevel.P1.tags[3];

	assign tagsP3[0] =	toplevel.P3.tags[0];
	assign tagsP3[1] =	toplevel.P3.tags[1];
	assign tagsP3[2] =	toplevel.P3.tags[2];
	assign tagsP3[3] =	toplevel.P3.tags[3];

	assign DadosP0[0] = toplevel.P0.Dados[0];
	assign DadosP0[1] = toplevel.P0.Dados[1];
	assign DadosP0[2] = toplevel.P0.Dados[2];
	assign DadosP0[3] = toplevel.P0.Dados[0];

	assign DadosP1[0] = toplevel.P1.Dados[0];
	assign DadosP1[1] = toplevel.P1.Dados[1];
	assign DadosP1[2] = toplevel.P1.Dados[2];
	assign DadosP1[3] = toplevel.P1.Dados[0];

	assign DadosP3[0] = toplevel.P3.Dados[0];
	assign DadosP3[1] = toplevel.P3.Dados[1];
	assign DadosP3[2] = toplevel.P3.Dados[2];
	assign DadosP3[3] = toplevel.P3.Dados[0];
	
	wire LeituraEscritaMemoria = toplevel.LeituraEscritaMemoria;


	initial
		begin
			toplevel.P0.Estado[0] = 2'b00;
			toplevel.P0.Estado[1] = 2'b01;
			toplevel.P0.Estado[2] = 2'b10;
			toplevel.P0.Estado[3] = 2'b00;

			toplevel.P0.tags[0] = 0;
			toplevel.P0.tags[1] = 8;
			toplevel.P0.tags[2] = 10;
			toplevel.P0.tags[3] = 18;

			toplevel.P0.Dados[0] = 10;
			toplevel.P0.Dados[1] = 8;
			toplevel.P0.Dados[2] = 30;
			toplevel.P0.Dados[3] = 10;


			toplevel.P1.Estado[0] = 2'b00;
			toplevel.P1.Estado[1] = 2'b10;
			toplevel.P1.Estado[2] = 2'b00;
			toplevel.P1.Estado[3] = 2'b01;

			toplevel.P1.tags[0] = 0;
			toplevel.P1.tags[1] = 28;
			toplevel.P1.tags[2] = 10;
			toplevel.P1.tags[3] = 18;

			toplevel.P1.Dados[0] = 10;
			toplevel.P1.Dados[1] = 68;
			toplevel.P1.Dados[2] = 10;
			toplevel.P1.Dados[3] = 19;


			toplevel.P3.Estado[0] = 2'b01;
			toplevel.P3.Estado[1] = 2'b01;
			toplevel.P3.Estado[2] = 2'b00;
			toplevel.P3.Estado[3] = 2'b00;

			toplevel.P3.tags[0] = 20;
			toplevel.P3.tags[1] = 8;
			toplevel.P3.tags[2] = 10;
			toplevel.P3.tags[3] = 18;

			toplevel.P3.Dados[0] = 20;
			toplevel.P3.Dados[1] = 08;
			toplevel.P3.Dados[2] = 10;
			toplevel.P3.Dados[3] = 10;



			RunFirst = 0;
			#1;
			clock = 0;
			RunFirst = 1;
			#1;
			RunFirst = 0;

			#1400;
			$finish;
	end

	initial
			begin
				forever
					begin
				#20;
				clock = ~clock;
			end //begin
		end //initial

	always@(posedge Next or posedge toplevel.auxWriteBackOuvinte) begin
		$display("");
		$display("+++++++++++++++++++++++++++++++++++++++++++++++++");
		$display("Intrucao: %d", toplevel.endereco);

		$display("P0");
		$display("Coherency state	Address tag	 Data");
		for(i=0; i<4; i=i+1) begin
			case(toplevel.P0.Estado[i])
				2'b00: $write("I"); 2'b01:	$write("S");2'b10: $write("M"); default : $write("X");
			endcase
			$write("                    ");
			$write("%d", toplevel.P0.tags[i]);
			$write("              ");
			$write("%d", toplevel.P0.Dados[i]);
			$write("\n");
		end
		$display("");

		$display("P1");
		$display("Coherency state	Address tag	 Data");
		for(i=0; i<4; i=i+1) begin
			case(toplevel.P1.Estado[i])
				2'b00: $write("I"); 2'b01:	$write("S");2'b10: $write("M"); default : $write("X");
			endcase
			$write("                    ");
			$write("%d", toplevel.P1.tags[i]);
			$write("              ");
			$write("%d", toplevel.P1.Dados[i]);
			$write("\n");
		end
		$display("");

		$display("P3");
		$display("Coherency state	Address tag	 Data");
		for(i=0; i<4; i=i+1) begin
			case(toplevel.P3.Estado[i])
				2'b00: $write("I"); 2'b01:	$write("S");2'b10: $write("M"); default : $write("X");
			endcase
			$write("                    ");
			$write("%d", toplevel.P3.tags[i]);
			$write("              ");
			$write("%d", toplevel.P3.Dados[i]);
			$write("\n");
		end
		/*
		$display("");
		$display("Tstep P0:%d  P1:%d P3:%d", toplevel.P0.Tstep_Q, toplevel.P1.Tstep_Q, toplevel.P3.Tstep_Q);
		$display("tag P0:%d  P1:%d P3:%d", toplevel.P0.tag, toplevel.P1.tag, toplevel.P3.tag);
		$display("EscritaLeitura P0:%d  P1:%d P3:%d", toplevel.P0.EscritaLeitura, toplevel.P1.EscritaLeitura, toplevel.P3.EscritaLeitura);
		$display("ProcessadorAtual P0:%d, P1:%d, P3:%d", toplevel.P0.ProcessadorAtual, toplevel.P1.ProcessadorAtual, toplevel.P3.ProcessadorAtual);
		*/
		/*
		$display("Testes");

		$display("Clear P0:%d  P1:%d P3:%d", toplevel.P0.Clear, toplevel.P1.Clear, toplevel.P3.Clear);
		$display("tag P0:%d  P1:%d P3:%d", toplevel.P0.tag, toplevel.P1.tag, toplevel.P3.tag);
		$display("DadoEscrito P0:%d  P1:%d P3:%d", toplevel.P0.DadoEscrito, toplevel.P1.DadoEscrito, toplevel.P3.DadoEscrito);
		$display("EscritaLeitura P0:%d  P1:%d P3:%d", toplevel.P0.EscritaLeitura, toplevel.P1.EscritaLeitura, toplevel.P3.EscritaLeitura);
		$display("ProcessadorAtual P0:%d, P1:%d, P3:%d", toplevel.P0.ProcessadorAtual, toplevel.P1.ProcessadorAtual, toplevel.P3.ProcessadorAtual);
		$display("Done P0:%d, P1:%d, P3:%d", toplevel.P0.Done, toplevel.P1.Done, toplevel.P3.Done);
		$display("ExisteTag P0:%d, P1:%d, P3:%d", toplevel.P0.ExisteTag, toplevel.P1.ExisteTag, toplevel.P3.ExisteTag);
		$display("HitMissAtual P0:%d, P1:%d, P3:%d", toplevel.P0.HitMissAtual, toplevel.P1.HitMissAtual, toplevel.P3.HitMissAtual);
		$display("EstadoAtual P0:%d, P1:%d, P3:%d", toplevel.P0.EstadoAtual, toplevel.P1.EstadoAtual, toplevel.P3.EstadoAtual);
		$write("estadoResultante: ");
		case(toplevel.P0.estadoResultante)
			2'b00: $write("I"); 2'b01:	$write("S");2'b10: $write("M"); default : $write("X");
		endcase
		*/
		$write("\n");
		$write("saidaBus: ");
		case(toplevel.saidaBus)
			2'b01:$write(" read miss");
			2'b10:$write(" write miss");
			2'b11:$write(" invalidade");
		endcase
		$write("\n");
		/*
		$write("valorRetorno P0: %d, P1:%d, P3:%d", toplevel.P0.valorRetorno, toplevel.P1.valorRetorno, toplevel.P3.valorRetorno);
		$write("\n");
		*/
		/*
		$write("saidaBusP0: %d", toplevel.P0.saidaBus);
		case(toplevel.P0.saidaBus)
			2'b01:$write(" read miss");
			2'b10:$write(" write miss");
			2'b11:$write(" invalidade");
		endcase
		$write("\n");
		$write("saidaBusP1: %d", toplevel.P1.saidaBus);
		case(toplevel.P1.saidaBus)
			2'b01:$write(" read miss");
			2'b10:$write(" write miss");
			2'b11:$write(" invalidade");
		endcase
		$write("\n");
		$write("saidaBusP3: %d", toplevel.P3.saidaBus);
		case(toplevel.P3.saidaBus)
			2'b01:$write(" read miss");
			2'b10:$write(" write miss");
			2'b11:$write(" invalidade");
		endcase
		$write("\n");
		*/
		/*
		$display("RunMaquinaDeEstados P0:%d, P1:%d, P3:%d", toplevel.P0.RunMaquinaDeEstados, toplevel.P1.RunMaquinaDeEstados, toplevel.P3.RunMaquinaDeEstados);
		$display("posicaoTag: %d", toplevel.P0.posicaoTag);
		$display("posicaoTagMapeamento: %d", toplevel.P0.posicaoTagMapeamento);
		*/
		$display("Valor Lido P0:%d  P1:%d P3:%d", toplevel.P0.valorRetorno, toplevel.P1.valorRetorno, toplevel.P3.valorRetorno);

		//$display("Valor: %d, Tag: %d e Sinal: %d", toplevel.P0.valorParaMemoria, toplevel.P0.tagParaMemoria, toplevel.P0.LeituraEscritaMemoria);

		if(toplevel.P0.writeback || toplevel.P0.auxWriteBackOuvinte) begin
			if(toplevel.P0.writeback) begin
				$display("Writeback Principal: Tag:%d e Valor:%d", toplevel.P0.tagParaMemoria, toplevel.P0.valorParaMemoria);
			end
			else if(toplevel.P0.auxWriteBackOuvinte )begin
				$display("WritebackOuvinte: Tag:%d e Valor:%d", toplevel.P0.tagParaMemoria, toplevel.P0.valorParaMemoria);
			end
		end

		if(toplevel.P1.writeback || toplevel.P1.auxWriteBackOuvinte) begin
			if(toplevel.P1.writeback) begin
				$display("Writeback Principal: Tag:%d e Valor:%d", toplevel.P1.tagParaMemoria, toplevel.P1.valorParaMemoria);
			end
			else if(toplevel.P1.auxWriteBackOuvinte) begin
				$display("WritebackOuvinte: Tag:%d e Valor:%d", toplevel.P1.tagParaMemoria, toplevel.P1.valorParaMemoria);
			end
		end
		
		if(toplevel.P3.writeback || toplevel.P3.auxWriteBackOuvinte) begin
			if(toplevel.P3.writeback) begin
				$display("Writeback Principal: Tag:%d e Valor:%d", toplevel.P3.tagParaMemoria, toplevel.P3.valorParaMemoria);
			end
			else if(toplevel.P3.auxWriteBackOuvinte) begin
				$display("WritebackOuvinte: Tag:%d e Valor:%d", toplevel.P3.tagParaMemoria, toplevel.P3.valorParaMemoria);
			end
		end

		
		/*

		$display("BuscaCache P0:%d, P1:%d, P3:%d ", toplevel.P0.buscaCache, toplevel.P1.buscaCache, toplevel.P3.buscaCache);
		$display("inputBusca P0:%d, P1:%d, P3:%d ", toplevel.P0.inputBusca, toplevel.P1.inputBusca, toplevel.P3.inputBusca);
		$display("resultadoBusca P0:%d, P1:%d, P3:%d ", toplevel.P0.resultadoBusca, toplevel.P1.resultadoBusca, toplevel.P3.resultadoBusca);
		$display("resultadoRecebidoBusca P0:%d, P1:%d, P3:%d ", toplevel.P0.resultadoRecebidoBusca, toplevel.P1.resultadoRecebidoBusca, toplevel.P3.resultadoRecebidoBusca);
		$display("resultadoBusca toplevel:%d ", toplevel.resultadoBusca);
		*/
		
		/*
		$display("Memoria: ");
		$display("TagParaMemoria P0:%d, P1:%d, P3:%d ", toplevel.P0.tagParaMemoria, toplevel.P1.tagParaMemoria, toplevel.P3.tagParaMemoria);
		$display("Sinal P0:%d, P1:%d, P3:%d ", toplevel.P0.LeituraEscritaMemoria, toplevel.P1.LeituraEscritaMemoria, toplevel.P3.LeituraEscritaMemoria);
		$display("ValorParaMemoria: %d", toplevel.P0.valorParaMemoria, toplevel.P1.valorParaMemoria, toplevel.P3.valorParaMemoria);
		$display("Saida: %d", toplevel.saidaMemoria);
		$display("Entrada: %d", toplevel.valorParaMemoria);
		$display("valorRecebido P0:%d, P1:%d, P3:%d", toplevel.P0.valorRecebidoDaMemoria, toplevel.P1.valorRecebidoDaMemoria, toplevel.P3.valorRecebidoDaMemoria);
		$display("Tag: %d", toplevel.tagParaMemoria);
		*/
		$display("    STATEMENT :: time is %0t",$time);
		$display("+++++++++++++++++++++++++++++++++++++++++++++++++");
		$display("");

	end

endmodule
