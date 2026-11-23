Algoritmo "Hospital Santa Aurora - Plantao"

Var

   // VARIAVEIS DE CONTROLE

   i, turno: inteiro
   menu, continuar: inteiro
   especialidade, disponibilidade: inteiro
   id_atual, pode_cadastrar, idbusca: inteiro

   // CONTROLE DOS CADASTROS

   qtd_cad_medicos: inteiro
   qtd_cad_clinico, qtd_cad_pediatra, qtd_cad_cirurgiao: inteiro

   escolhe: caractere

   // IDENTIFICACAO DAS ESPECIALIDADES

   esp_pediatra, esp_clinico_geral, esp_cirurgiao: caractere

   // DADOS DOS MEDICOS
   // O INDICE DO VETOR REPRESENTA O ID DO MEDICO

   nome_medico: vetor[1..50] de caractere
   especialidade_medico: vetor[1..50] de inteiro
   disp_medico: vetor[1..50] de inteiro
   disp_registro: vetor[1..50] de inteiro

   id_disponibilidade: vetor[1..50] de inteiro
   qtd_disp: inteiro

   semana: vetor[1..50] de inteiro
   diasemana: inteiro

   // VETORES DE QUANTIDADES POR TURNO
   // POSICAO 1 = MANHA
   // POSICAO 2 = TARDE
   // POSICAO 3 = NOITE

   qtd_pediatras: vetor[1..10] de inteiro
   qtd_clinicos: vetor[1..10] de inteiro
   qtd_cirurgioes: vetor[1..10] de inteiro

   cadastrado: vetor[1..10] de inteiro

   trabalha_turno, plantao_valido: logico
   tem_manha, tem_tarde, tem_noite: logico
   tem_pediatra,tem_clinico,tem_cirurgiao: logico
   opcao_alteracao, especialidade_antiga, disponibilidade_antiga: inteiro
   qtd_plantao_semana, qtd_plantao_novo: inteiro
   dia_anterior: inteiro
   trabalhou_noite_anterior, quer_manha: logico
   especialidades_faltando: caractere

   // R10 E R11 - INDICADORES DE ESCALACAO
   r_carga: vetor[1..25] de inteiro
   r_cobertura: vetor[1..15,1..3] de inteiro
   r_visto: vetor[1..25,1..15] de logico
   r_id, r_dia, r_turno, r_esp, r_indice: inteiro
   r_codigo, r_total, r_maior, r_menor: inteiro
   r_cobertos, r_faltas, r_minimo, r_turno_ok: inteiro
   r_falha_ped, r_falha_cli, r_falha_cir: inteiro
   r_media, r_percentual: real
   r_inclui: logico

   // PRE-CADASTRO DOS MEDICOS (APRESENTACAO)
   j, grupo, dia_ini: inteiro
   nomes_pre: vetor[1..22] de caractere

   // AVISO DE COBERTURA INSUFICIENTE
   qtd_turnos_insuficientes, limite_medicos, repeticao: inteiro
   falhas_ped, falhas_cli, falhas_cir: inteiro
   av_dia, av_turno, av_esp, av_k: inteiro
   av_coberto, av_cobre_turno: logico

Inicio

   // IDENTIFICACAO DAS ESPECIALIDADES

   esp_pediatra <- "Pediatra"
   esp_clinico_geral <- "Clinico Geral"
   esp_cirurgiao <- "Cirurgiao"

   // INICIALIZACAO DOS CONTADORES

   qtd_cad_medicos <- 0
   qtd_cad_clinico <- 0
   qtd_cad_pediatra <- 0
   qtd_cad_cirurgiao <- 0
   qtd_disp <- 0

   // INICIALIZACAO DOS VETORES

   para i de 1 ate 10 faca

      qtd_pediatras[i] <- 0
      qtd_clinicos[i] <- 0
      qtd_cirurgioes[i] <- 0

      cadastrado[i] <- 0

   fimpara

   para i de 25 ate 50 faca

      nome_medico[i] <- ""
      especialidade_medico[i] <- 0
      disp_medico[i] <- 0

   fimpara

   para i de 25 ate 50 faca

      id_disponibilidade[i] <- 0
      semana[i] <- 0
      disp_registro[i] <- 0
      
   fimpara


   // PRE-CADASTRO DOS MEDICOS PARA A APRESENTACAO
   // SEGUNDA A QUINTA: CADASTRO AUTOMATICO
   // SEXTA: CADASTRO DOS MEDICOS PRE-DEFINIDOS
   //
   // GRUPO 1 -> SEGUNDA E TERCA
   // GRUPO 2 -> QUARTA E QUINTA
   //
   // DISPONIBILIDADE 4 -> MANHA E TARDE
   // DISPONIBILIDADE 3 -> NOITE
   //
   // CADA TURNO POSSUI:
   // 1 PEDIATRA
   // 2 CLINICOS
   // 1 CIRURGIAO
   //
   // SEXTA:
   // 2 CLINICOS MANHA E TARDE
   // 2 CLINICOS NOITE
   // 1 PEDIATRA NOITE
   // 1 CIRURGIAO NOITE


   // NOMES DOS MEDICOS

   nomes_pre[1] <- "JOAO"
   nomes_pre[2] <- "ENZO"
   nomes_pre[3] <- "OTTO"
   nomes_pre[4] <- "NINA"

   nomes_pre[5] <- "LARA"
   nomes_pre[6] <- "CAIO"
   nomes_pre[7] <- "NOAH"
   nomes_pre[8] <- "LUCA"

   nomes_pre[9] <- "ANA"
   nomes_pre[10] <- "EVA"
   nomes_pre[11] <- "ARI"
   nomes_pre[12] <- "IAN"

   nomes_pre[13] <- "LEO"
   nomes_pre[14] <- "GIL"
   nomes_pre[15] <- "BEN"
   nomes_pre[16] <- "RUI"

   // SEXTA

   nomes_pre[17] <- "DAVI"
   nomes_pre[18] <- "IAGO"
   nomes_pre[19] <- "NOEL"
   nomes_pre[20] <- "HUGO"
   nomes_pre[21] <- "LUIS"
   nomes_pre[22] <- "ERIC"


   // CADASTRO DE SEGUNDA A QUINTA

   para grupo de 1 ate 2 faca

      dia_ini <- grupo * 2 - 1

      para j de 1 ate 2 faca

         se j = 1 entao
            disponibilidade <- 4
         senao
            disponibilidade <- 3
         fimse

         para especialidade de 1 ate 3 faca

            // DOIS CLINICOS POR TURNO
            // UMA UNIDADE DAS OUTRAS ESPECIALIDADES

            limite_medicos <- 1

            se especialidade = 2 entao
               limite_medicos <- 2
            fimse

            para repeticao de 1 ate limite_medicos faca

               id_atual <- qtd_cad_medicos + 1

               nome_medico[id_atual] <- nomes_pre[id_atual]
               especialidade_medico[id_atual] <- especialidade
               disp_medico[id_atual] <- disponibilidade

               // CONTABILIZAR MEDICOS POR ESPECIALIDADE

               se especialidade = 1 entao
                  qtd_cad_pediatra <- qtd_cad_pediatra + 1
               fimse

               se especialidade = 2 entao
                  qtd_cad_clinico <- qtd_cad_clinico + 1
               fimse

               se especialidade = 3 entao
                  qtd_cad_cirurgiao <- qtd_cad_cirurgiao + 1
               fimse

               qtd_cad_medicos <- qtd_cad_medicos + 1

               // ESCALAR O MEDICO NOS DOIS DIAS DO GRUPO

               para diasemana de dia_ini ate dia_ini + 1 faca

                  qtd_disp <- qtd_disp + 1

                  id_disponibilidade[qtd_disp] <- id_atual
                  semana[qtd_disp] <- diasemana
                  disp_registro[qtd_disp] <- disponibilidade

               fimpara

               // ATUALIZAR QUANTIDADES DOS TURNOS

               para turno de 1 ate 3 faca

                  trabalha_turno <- falso

                  se disponibilidade = turno entao
                     trabalha_turno <- verdadeiro
                  fimse

                  se (disponibilidade = 4) e (turno <= 2) entao
                     trabalha_turno <- verdadeiro
                  fimse

                  se trabalha_turno entao

                     se especialidade = 1 entao
                        qtd_pediatras[turno] <- qtd_pediatras[turno] + 1
                     fimse

                     se especialidade = 2 entao
                        qtd_clinicos[turno] <- qtd_clinicos[turno] + 1
                     fimse

                     se especialidade = 3 entao
                        qtd_cirurgioes[turno] <- qtd_cirurgioes[turno] + 1
                     fimse

                     cadastrado[turno] <- 1

                  fimse

               fimpara

            fimpara

         fimpara

      fimpara

   fimpara


   // CADASTRO AUTOMATICO DE SEXTA-FEIRA

   para i de 17 ate 22 faca

      id_atual <- qtd_cad_medicos + 1

      nome_medico[id_atual] <- nomes_pre[id_atual]

      // DEFINIR ESPECIALIDADE

      se (id_atual >= 17) e (id_atual <= 20) entao
         especialidade <- 2
      senao
         se id_atual = 21 entao
            especialidade <- 1
         senao
            especialidade <- 3
         fimse
      fimse

      // DEFINIR DISPONIBILIDADE

      se (id_atual = 17) ou (id_atual = 18) entao
         disponibilidade <- 4
      senao
         disponibilidade <- 3
      fimse

      especialidade_medico[id_atual] <- especialidade
      disp_medico[id_atual] <- disponibilidade

      // CONTABILIZAR MEDICOS POR ESPECIALIDADE

      se especialidade = 1 entao
         qtd_cad_pediatra <- qtd_cad_pediatra + 1
      fimse

      se especialidade = 2 entao
         qtd_cad_clinico <- qtd_cad_clinico + 1
      fimse

      se especialidade = 3 entao
         qtd_cad_cirurgiao <- qtd_cad_cirurgiao + 1
      fimse

      qtd_cad_medicos <- qtd_cad_medicos + 1

      // REGISTRAR DISPONIBILIDADE NA SEXTA

      qtd_disp <- qtd_disp + 1

      id_disponibilidade[qtd_disp] <- id_atual
      semana[qtd_disp] <- 5
      disp_registro[qtd_disp] <- disponibilidade

      // ATUALIZAR QUANTIDADES DOS TURNOS

      para turno de 1 ate 3 faca

         trabalha_turno <- falso

         se disponibilidade = turno entao
            trabalha_turno <- verdadeiro
         fimse

         se (disponibilidade = 4) e (turno <= 2) entao
            trabalha_turno <- verdadeiro
         fimse

         se trabalha_turno entao

            se especialidade = 1 entao
               qtd_pediatras[turno] <- qtd_pediatras[turno] + 1
            fimse

            se especialidade = 2 entao
               qtd_clinicos[turno] <- qtd_clinicos[turno] + 1
            fimse

            se especialidade = 3 entao
               qtd_cirurgioes[turno] <- qtd_cirurgioes[turno] + 1
            fimse

            cadastrado[turno] <- 1

         fimse

      fimpara

   fimpara


   // APRESENTACAO DO SISTEMA

   limpatela

   escreval("----------------------------------------")
   escreval("       HOSPITAL SANTA AURORA")
   escreval("              MEDSHIFT - WHILETRUE")
   escreval("----------------------------------------")
   escreval("Ola! Seja bem-vindo ao sistema de plantao.")
   escreval(" ")

   continuar <- 1

   // MENU PRINCIPAL

   enquanto (continuar = 1) faca

      escreval(" ")
      escreval("----------------------------------------")
      escreval("             MENU PRINCIPAL")
      escreval("----------------------------------------")

      escreval("1 - Cadastrar um medico")
      escreval("2 - Consultar semana")
      escreval("3 - Procurar ID")
      escreval("4 - Atribuir Semana")
      escreval("5 - Resetar escala")
      escreval("6 - Relatorio semanal")
      escreval("7 - Avisos de cobertura da semana")
      escreval("0 - Finalizar o plantao")
      escreval("----------------------------------------")
      escreva("Escolha uma opcao: ")
      leia(menu)

      escolha menu

      caso 1

         limpatela

         se (qtd_cad_medicos >= 25) entao

            escreval("Limite de medicos cadastrados atingido.")
            escreval("Nao e possivel realizar novos cadastros.")

         senao

            escolhe <- "S"

            enquanto (escolhe = "S") e (qtd_cad_medicos < 25) faca

               limpatela

               escreval("----------------------------------------")
               escreval("           CADASTRO DO MEDICO")
               escreval("----------------------------------------")


               // ESCOLHA DA SEMANA
               escreval(" ")
               escreval("Qual o dia da semana deseja cadastrar esse medico:")
               escreval("1 - Segunda-Feira")
               escreval("2 - Terca-Feira")
               escreval("3 - Quarta-Feira")
               escreval("4 - Quinta-Feira")
               escreval("5 - Sexta-Feira")
               escreva("Escolha uma opcao: ")
               leia(diasemana)

               enquanto (diasemana < 1) ou (diasemana > 5) faca

                  escreval("Dia da Semana invalido!")
                  escreva("Digite entre 1 e 5: ")
                  leia(diasemana)

               fimenquanto


               // ESCOLHA DA ESPECIALIDADE

               limpatela

               escreval("----------------------------------------")
               escreval("           CADASTRO DO MEDICO")
               escreval("----------------------------------------")

               escreval(" ")
               escreval("Especialidade:")
               escreval("1 - Pediatra")
               escreval("2 - Clinico Geral")
               escreval("3 - Cirurgiao")
               escreva("Escolha uma opcao: ")
               leia(especialidade)

               enquanto (especialidade < 1) ou (especialidade > 3) faca

                  escreval("Especialidade invalida!")
                  escreva("Digite 1, 2 ou 3: ")
                  leia(especialidade)

               fimenquanto

               pode_cadastrar <- 1

               // VERIFICAR O LIMITE DA ESPECIALIDADE

               se (especialidade = 1) entao
                  se (qtd_cad_pediatra >= 8) entao
                     escreval("Limite de pediatras atingido.")
                     pode_cadastrar <- 0
                  fimse
               fimse

               se (especialidade = 2) entao
                  se (qtd_cad_clinico >= 9) entao
                     escreval("Limite de clinicos gerais atingido.")
                     pode_cadastrar <- 0
                  fimse
               fimse

               se (especialidade = 3) entao
                  se (qtd_cad_cirurgiao >= 8) entao
                     escreval("Limite de cirurgioes atingido.")
                     pode_cadastrar <- 0
                  fimse
               fimse

               se (pode_cadastrar = 1) entao

                  // ID SEQUENCIAL PARA TODOS OS MEDICOS
                  id_atual <- qtd_cad_medicos + 1

                  // CADASTRO DA DISPONIBILIDADE

                  limpatela

                  escreval("----------------------------------------")
                  escreval("           CADASTRO DO MEDICO")
                  escreval("----------------------------------------")

                  escreval(" ")
                  escreval("Disponibilidade:")
                  escreval("1 - Manha")
                  escreval("2 - Tarde")
                  escreval("3 - Noite")
                  escreval("4 - Manha e Tarde")
                  escreval("5 - Manha e Noite")
                  escreval("6 - Tarde e Noite")
                  escreva("Escolha uma opcao: ")
                  leia(disponibilidade)

                  enquanto (disponibilidade < 1) ou (disponibilidade > 6) faca

                     escreval("Disponibilidade invalida!")
                     escreva("Digite um valor de 1 a 6: ")
                     leia(disponibilidade)

                  fimenquanto

                  qtd_disp <- qtd_disp + 1

                  id_disponibilidade[qtd_disp] <- id_atual
                  semana[qtd_disp] <- diasemana
                  disp_registro[qtd_disp] <- disponibilidade

                  // NOME DO MEDICO

                  limpatela

                  escreval("----------------------------------------")
                  escreval("           CADASTRO DO MEDICO")
                  escreval("----------------------------------------")

                  escreval(" ")
                  escreva("Nome do especialista: ")
                  leia(nome_medico[id_atual])

                  // O NOME DO MEDICO NAO PODE SER VAZIO
                  enquanto nome_medico[id_atual] = "" faca
                     escreval("O nome do medico nao pode ser vazio!")
                     escreva("Nome do especialista: ")
                     leia(nome_medico[id_atual])
                  fimenquanto

                  // GUARDAR OS DADOS DO MEDICO

                  especialidade_medico[id_atual] <- especialidade
                  disp_medico[id_atual] <- disponibilidade

                  // ATUALIZAR O CONTADOR DA ESPECIALIDADE

                  se (especialidade = 1) entao
                     qtd_cad_pediatra <- qtd_cad_pediatra + 1
                  fimse

                  se (especialidade = 2) entao
                     qtd_cad_clinico <- qtd_cad_clinico + 1
                  fimse

                  se (especialidade = 3) entao
                     qtd_cad_cirurgiao <- qtd_cad_cirurgiao + 1
                  fimse

                  qtd_cad_medicos <- qtd_cad_medicos + 1

                  // ATUALIZAR AS QUANTIDADES DOS TURNOS

                  para turno de 1 ate 3 faca

                     trabalha_turno <- falso

                     se (disponibilidade = turno) entao
                        trabalha_turno <- verdadeiro
                     fimse

                     se (disponibilidade = 4) e (turno <= 2) entao
                        trabalha_turno <- verdadeiro
                     fimse

                     se (disponibilidade = 5) e ((turno = 1) ou (turno = 3)) entao
                        trabalha_turno <- verdadeiro
                     fimse

                     se (disponibilidade = 6) e (turno >= 2) entao
                        trabalha_turno <- verdadeiro
                     fimse

                     se (trabalha_turno = verdadeiro) entao

                        se (especialidade = 1) entao
                           qtd_pediatras[turno] <- qtd_pediatras[turno] + 1
                        fimse

                        se (especialidade = 2) entao
                           qtd_clinicos[turno] <- qtd_clinicos[turno] + 1
                        fimse

                        se (especialidade = 3) entao
                           qtd_cirurgioes[turno] <- qtd_cirurgioes[turno] + 1
                        fimse

                        cadastrado[turno] <- 1

                     fimse

                  fimpara

                  // FICHA DO MEDICO

                  limpatela

                  escreval("===========================")
                  escreval("       FICHA DO MEDICO")
                  escreval("===========================")

                  se (diasemana = 1) entao
                     escreval("Dia da Semana: Segunda-Feira")
                  fimse
                  se (diasemana = 2) entao
                     escreval("Dia da Semana: Terca-Feira")
                  fimse
                  se (diasemana = 3) entao
                     escreval("Dia da Semana: Quarta-Feira")
                  fimse
                  se (diasemana = 4) entao
                     escreval("Dia da Semana: Quinta-Feira")
                  fimse
                  se (diasemana = 5) entao
                     escreval("Dia da Semana: Sexta-Feira")
                  fimse

                  se (especialidade = 1) entao
                     escreval("Especialidade: ", esp_pediatra)
                  fimse

                  se (especialidade = 2) entao
                     escreval("Especialidade: ", esp_clinico_geral)
                  fimse

                  se (especialidade = 3) entao
                     escreval("Especialidade: ", esp_cirurgiao)
                  fimse

                  se (disponibilidade = 1) entao
                     escreval("Disponibilidade: Manha")
                  fimse

                  se (disponibilidade = 2) entao
                     escreval("Disponibilidade: Tarde")
                  fimse

                  se (disponibilidade = 3) entao
                     escreval("Disponibilidade: Noite")
                  fimse

                  se (disponibilidade = 4) entao
                     escreval("Disponibilidade: Manha e Tarde")
                  fimse

                  se (disponibilidade = 5) entao
                     escreval("Disponibilidade: Manha e Noite")
                  fimse

                  se (disponibilidade = 6) entao
                     escreval("Disponibilidade: Tarde e Noite")
                  fimse

                  escreval("Nome: ", nome_medico[id_atual])
                  escreval("ID do especialista: ", id_atual)

                  escreval("===========================")
                  escreval("MEDICO CADASTRADO COM SUCESSO!")
                  escreval("===========================")

                  // PERGUNTAR SE DESEJA CADASTRAR OUTRO MEDICO

                  se (qtd_cad_medicos < 25) entao

                     escreval(" ")
                     escreval("Realizar um novo cadastro? [S/N]")
                     leia(escolhe)

                     enquanto (escolhe <> "S") e (escolhe <> "N") faca

                        escreval("Insira S ou N.")
                        leia(escolhe)

                     fimenquanto

                  senao

                     escolhe <- "N"
                     escreval("Limite total de medicos atingido.")

                  fimse

               fimse

            fimenquanto

         fimse

      caso 2

         limpatela

         escreval("----------------------------------------")
         escreval("          CONSULTA DO PLANTAO")
         escreval("----------------------------------------")

         escreval(" ")
         escreval("Qual o dia da semana deseja consultar:")
         escreval("1 - Segunda-Feira")
         escreval("2 - Terca-Feira")
         escreval("3 - Quarta-Feira")
         escreval("4 - Quinta-Feira")
         escreval("5 - Sexta-Feira")
         escreva("Escolha uma opcao: ")
         leia(diasemana)

         enquanto (diasemana < 1) ou (diasemana > 5) faca

            escreval("Dia da Semana invalido!")
            escreva("Digite entre 1 e 5: ")
            leia(diasemana)

         fimenquanto

         limpatela

         escreval("----------------------------------------")
         escreval("          CONSULTA DO PLANTAO")
         escreval("----------------------------------------")

         se (diasemana = 1) entao
            escreval("Dia da Semana: Segunda-Feira")
         fimse
         se (diasemana = 2) entao
            escreval("Dia da Semana: Terca-Feira")
         fimse
         se (diasemana = 3) entao
            escreval("Dia da Semana: Quarta-Feira")
         fimse
         se (diasemana = 4) entao
            escreval("Dia da Semana: Quinta-Feira")
         fimse
         se (diasemana = 5) entao
            escreval("Dia da Semana: Sexta-Feira")
         fimse

         plantao_valido <- verdadeiro

         escreval(" ")
         escreval("TURNO DA MANHA")
         escreval(" ")

         //RELATORIO DO TURNO DA MANHA

         Se qtd_cad_pediatra = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Pediatra cadastrado/disponivel no turno da manha!")
         senao
            tem_pediatra <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) ou (disp_registro[i] = 7) entao
                     tem_pediatra <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_pediatra = falso entao
               plantao_valido <- falso
               escreval("Nenhum Pediatra disponivel no turno da manha!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) ou (disp_registro[i] = 7) entao
                        escreva(esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 1) Entao
                           Escreval(" | Turno: Manha")
                        Senao
                           Se (disp_registro[i] = 4) Entao
                              Escreval(" | Turno: Manha e Tarde")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         Se qtd_cad_clinico = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Clinico Geral cadastrado/disponivel no turno da manha!")
         senao
            tem_clinico <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) ou (disp_registro[i] = 7) entao
                     tem_clinico <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_clinico = falso entao
               plantao_valido <- falso
               escreval("Nenhum Clinico Geral disponivel no turno da manha!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) ou (disp_registro[i] = 7) entao
                        escreva(esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 1) Entao
                           Escreval(" | Turno: Manha")
                        Senao
                           Se (disp_registro[i] = 4) Entao
                              Escreval(" | Turno: Manha e Tarde")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         Se qtd_cad_cirurgiao = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Cirurgiao cadastrado/disponivel no turno da manha!")
         senao
            tem_cirurgiao <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) ou (disp_registro[i] = 7) entao
                     tem_cirurgiao <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_cirurgiao = falso entao
               plantao_valido <- falso
               escreval("Nenhum Cirurgiao disponivel no turno da manha!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) ou (disp_registro[i] = 7) entao
                        escreva(esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 1) Entao
                           Escreval(" | Turno: Manha")
                        Senao
                           Se (disp_registro[i] = 4) Entao
                              Escreval(" | Turno: Manha e Tarde")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         escreval("TURNO DA TARDE")
         escreval(" ")

         //CONSULTA DO TURNO DA TARDE

         Se qtd_cad_pediatra = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Pediatra cadastrado/disponivel no turno da tarde!")
         senao
            tem_pediatra <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                     tem_pediatra <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_pediatra = falso entao
               plantao_valido <- falso
               escreval("Nenhum Pediatra disponivel no turno da tarde!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                        escreva(esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 2) Entao
                           Escreval(" | Turno: Tarde")
                        Senao
                           Se (disp_registro[i] = 4) Entao
                              Escreval(" | Turno: Manha e Tarde")
                           Senao
                              Se (disp_registro[i] = 6) Entao
                                 Escreval(" | Turno: Tarde e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         Se qtd_cad_clinico = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Clinico Geral cadastrado/disponivel no turno da tarde!")
         senao
            tem_clinico <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                     tem_clinico <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_clinico = falso entao
               plantao_valido <- falso
               escreval("Nenhum Clinico Geral disponivel no turno da tarde!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                        escreva(esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 2) Entao
                           Escreval(" | Turno: Tarde")
                        Senao
                           Se (disp_registro[i] = 4) Entao
                              Escreval(" | Turno: Manha e Tarde")
                           Senao
                              Se (disp_registro[i] = 6) Entao
                                 Escreval(" | Turno: Tarde e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         Se qtd_cad_cirurgiao = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Cirurgiao cadastrado/disponivel no turno da tarde!")
         senao
            tem_cirurgiao <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                     tem_cirurgiao <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_cirurgiao = falso entao
               plantao_valido <- falso
               escreval("Nenhum Cirurgiao disponivel no turno da tarde!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                        escreva(esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 2) Entao
                           Escreval(" | Turno: Tarde")
                        Senao
                           Se (disp_registro[i] = 4) Entao
                              Escreval(" | Turno: Manha e Tarde")
                           Senao
                              Se (disp_registro[i] = 6) Entao
                                 Escreval(" | Turno: Tarde e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         escreval("TURNO DA NOITE")
         escreval(" ")

         //CONSULTA DO TURNO DA NOITE

         Se qtd_cad_pediatra = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Pediatra cadastrado/disponivel no turno da noite!")
         senao
            tem_pediatra <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                     tem_pediatra <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_pediatra = falso entao
               plantao_valido <- falso
               escreval("Nenhum Pediatra disponivel no turno da noite!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                        escreva(esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 3) Entao
                           Escreval(" | Turno: Noite")
                        Senao
                           Se (disp_registro[i] = 5) Entao
                              Escreval(" | Turno: Manha e Noite")
                           Senao
                              Se (disp_registro[i] = 6) Entao
                                 Escreval(" | Turno: Tarde e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         Se qtd_cad_clinico = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Clinico Geral cadastrado/disponivel no turno da noite!")
         senao
            tem_clinico <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                     tem_clinico <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_clinico = falso entao
               plantao_valido <- falso
               escreval("Nenhum Clinico Geral disponivel no turno da noite!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                        escreva(esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 3) Entao
                           Escreval(" | Turno: Noite")
                        Senao
                           Se (disp_registro[i] = 5) Entao
                              Escreval(" | Turno: Manha e Noite")
                           Senao
                              Se (disp_registro[i] = 6) Entao
                                 Escreval(" | Turno: Tarde e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         Se qtd_cad_cirurgiao = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Cirurgiao cadastrado/disponivel no turno da noite!")
         senao
            tem_cirurgiao <- falso

            para i de 1 ate qtd_disp faca
               se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                  se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                     tem_cirurgiao <- verdadeiro
                  fimse
               fimse
            fimpara

            se tem_cirurgiao = falso entao
               plantao_valido <- falso
               escreval("Nenhum Cirurgiao disponivel no turno da noite!")
            senao
               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                        escreva(esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])
                        se disp_registro[i] = 7 entao
                           escreval(" | Turno: Manha, Tarde e Noite")
                        fimse

                        Se (disp_registro[i] = 3) Entao
                           Escreval(" | Turno: Noite")
                        Senao
                           Se (disp_registro[i] = 5) Entao
                              Escreval(" | Turno: Manha e Noite")
                           Senao
                              Se (disp_registro[i] = 6) Entao
                                 Escreval(" | Turno: Tarde e Noite")
                              fimse
                           fimse
                        FimSe
                     FimSe
                  fimse
               fimpara
            fimse
         fimse

         escreval(" ")

         escreval("----------------------------------------")

         se qtd_cad_medicos = 0 entao
            escreval("PLANTAO NAO PODE SER PUBLICADO!")
            escreval("Motivo: Nenhum medico foi cadastrado.")
         senao
            se plantao_valido = falso entao
               escreval("PLANTAO NAO PODE SER PUBLICADO!")
               escreval("Motivo: Falta profissional em uma ou mais especialidades/turnos.")
            senao
               escreval("PLANTAO PUBLICADO!")
               escreval("Obrigado por utilizar o Medshift!")
            fimse
         fimse

         escreval("----------------------------------------")

      caso 3

         limpatela

         se (qtd_cad_medicos = 0) entao
            escreval("Nenhum medico foi cadastrado!")
         senao

            escreval("=== IDS DISPONIVEIS PARA PESQUISA ===")

            escreva("Pediatras: ")
            para i de 1 ate qtd_cad_medicos faca
               se especialidade_medico[i] = 1 entao
                  escreva(i, " ")
               fimse
            fimpara

            escreval(" ")

            escreva("Clinicos Gerais: ")
            para i de 1 ate qtd_cad_medicos faca
               se especialidade_medico[i] = 2 entao
                  escreva(i, " ")
               fimse
            fimpara

            escreval(" ")

            escreva("Cirurgioes: ")
            para i de 1 ate qtd_cad_medicos faca
               se especialidade_medico[i] = 3 entao
                  escreva(i, " ")
               fimse
            fimpara

            escreval(" ")
            escreva("Qual ID voce deseja procurar? ")
            leia(idbusca)

            enquanto (idbusca < 1) ou (idbusca > qtd_cad_medicos) faca
               escreval("ID invalido!")
               escreva("Digite outro ID: ")
               leia(idbusca)
            fimenquanto

            enquanto nome_medico[idbusca] = "" faca
               escreval("Medico nao cadastrado!")
               escreva("Digite outro ID: ")
               leia(idbusca)

               enquanto (idbusca < 1) ou (idbusca > qtd_cad_medicos) faca
                  escreval("ID invalido!")
                  escreva("Digite outro ID: ")
                  leia(idbusca)
               fimenquanto
            fimenquanto

            escolhe <- "S"

            enquanto escolhe = "S" faca

               limpatela

               escreval("===========================")
               escreval("      FICHA DO MEDICO")
               escreval("===========================")

               se especialidade_medico[idbusca] = 1 entao
                  escreval("Especialidade: ", esp_pediatra)
               fimse

               se especialidade_medico[idbusca] = 2 entao
                  escreval("Especialidade: ", esp_clinico_geral)
               fimse

               se especialidade_medico[idbusca] = 3 entao
                  escreval("Especialidade: ", esp_cirurgiao)
               fimse

               escreval("Nome: ", nome_medico[idbusca])
               escreval("ID do especialista: ", idbusca)

               se disp_medico[idbusca] = 1 entao
                  escreval("Disponibilidade: Manha")
               senao
                  se disp_medico[idbusca] = 2 entao
                     escreval("Disponibilidade: Tarde")
                  senao
                     se disp_medico[idbusca] = 3 entao
                        escreval("Disponibilidade: Noite")
                     senao
                        se disp_medico[idbusca] = 4 entao
                           escreval("Disponibilidade: Manha e Tarde")
                        senao
                           se disp_medico[idbusca] = 5 entao
                              escreval("Disponibilidade: Manha e Noite")
                           senao
                              se disp_medico[idbusca] = 6 entao
                                 escreval("Disponibilidade: Tarde e Noite")
                              fimse
                              se disp_medico[idbusca] = 7 entao
                                 escreval("Disponibilidade: Manha, Tarde e Noite")
                              fimse
                           fimse
                        fimse
                     fimse
                  fimse
               fimse

               escreval("===========================")
               escreval(" ")

               escreva("Deseja alterar as informacoes deste medico? [S/N] ")
               leia(escolhe)

               enquanto (escolhe <> "S") e (escolhe <> "N") faca
                  escreva("Digite S ou N: ")
                  leia(escolhe)
               fimenquanto

               se escolhe = "S" entao

                  escreval("O que deseja alterar?")
                  escreval("1 - Nome")
                  escreval("2 - Especialidade")
                  escreval("3 - Disponibilidade")
                  escreva("Escolha uma opcao: ")
                  leia(opcao_alteracao)

                  enquanto (opcao_alteracao < 1) ou (opcao_alteracao > 3) faca
                     escreval("Opcao invalida!")
                     escreva("Escolha 1, 2 ou 3: ")
                     leia(opcao_alteracao)
                  fimenquanto

                  // ALTERAR O NOME
                  se opcao_alteracao = 1 entao
                     escreva("Digite o novo nome: ")
                     leia(nome_medico[idbusca])
                     enquanto nome_medico[idbusca] = "" faca
                        escreval("O nome do medico nao pode ser vazio!")
                        escreva("Digite o novo nome: ")
                        leia(nome_medico[idbusca])
                     fimenquanto
                     escreval("Nome alterado com sucesso!")
                  fimse

                  // ALTERAR A ESPECIALIDADE
                  se opcao_alteracao = 2 entao
                     especialidade_antiga <- especialidade_medico[idbusca]
                     escreval("1 - Pediatra")
                     escreval("2 - Clinico Geral")
                     escreval("3 - Cirurgiao")
                     escreva("Digite a nova especialidade: ")
                     leia(especialidade)

                     enquanto (especialidade < 1) ou (especialidade > 3) faca
                        escreval("Especialidade invalida!")
                        escreva("Digite 1, 2 ou 3: ")
                        leia(especialidade)
                     fimenquanto

                     pode_cadastrar <- 1
                     se especialidade <> especialidade_antiga entao
                        se especialidade = 1 entao
                           se qtd_cad_pediatra >= 8 entao
                              escreval("Limite de pediatras atingido!")
                              pode_cadastrar <- 0
                           fimse
                        fimse
                        se especialidade = 2 entao
                           se qtd_cad_clinico >= 9 entao
                              escreval("Limite de clinicos gerais atingido!")
                              pode_cadastrar <- 0
                           fimse
                        fimse
                        se especialidade = 3 entao
                           se qtd_cad_cirurgiao >= 8 entao
                              escreval("Limite de cirurgioes atingido!")
                              pode_cadastrar <- 0
                           fimse
                        fimse
                     fimse

                     se pode_cadastrar = 1 entao
                        se especialidade <> especialidade_antiga entao
                           // DIMINUIR CONTADOR DA ESPECIALIDADE ANTIGA
                           se especialidade_antiga = 1 entao
                              qtd_cad_pediatra <- qtd_cad_pediatra - 1
                           fimse
                           se especialidade_antiga = 2 entao
                              qtd_cad_clinico <- qtd_cad_clinico - 1
                           fimse
                           se especialidade_antiga = 3 entao
                              qtd_cad_cirurgiao <- qtd_cad_cirurgiao - 1
                           fimse

                           // AUMENTAR CONTADOR DA NOVA ESPECIALIDADE
                           se especialidade = 1 entao
                              qtd_cad_pediatra <- qtd_cad_pediatra + 1
                           fimse
                           se especialidade = 2 entao
                              qtd_cad_clinico <- qtd_cad_clinico + 1
                           fimse
                           se especialidade = 3 entao
                              qtd_cad_cirurgiao <- qtd_cad_cirurgiao + 1
                           fimse

                           // ATUALIZAR CONTADORES POR PLANTAO
                           para turno de 1 ate 3 faca
                              trabalha_turno <- falso
                              se disp_medico[idbusca] = turno entao
                                 trabalha_turno <- verdadeiro
                              fimse
                              se (disp_medico[idbusca] = 4) e (turno <= 2) entao
                                 trabalha_turno <- verdadeiro
                              fimse
                              se (disp_medico[idbusca] = 5) e ((turno = 1) ou (turno = 3)) entao
                                 trabalha_turno <- verdadeiro
                              fimse
                              se ((disp_medico[idbusca] = 6) e (turno >= 2)) ou (disp_medico[idbusca] = 7) entao
                                 trabalha_turno <- verdadeiro
                              fimse

                              se trabalha_turno = verdadeiro entao
                                 se especialidade_antiga = 1 entao
                                    qtd_pediatras[turno] <- qtd_pediatras[turno] - 1
                                 fimse
                                 se especialidade_antiga = 2 entao
                                    qtd_clinicos[turno] <- qtd_clinicos[turno] - 1
                                 fimse
                                 se especialidade_antiga = 3 entao
                                    qtd_cirurgioes[turno] <- qtd_cirurgioes[turno] - 1
                                 fimse
                                 se especialidade = 1 entao
                                    qtd_pediatras[turno] <- qtd_pediatras[turno] + 1
                                 fimse
                                 se especialidade = 2 entao
                                    qtd_clinicos[turno] <- qtd_clinicos[turno] + 1
                                 fimse
                                 se especialidade = 3 entao
                                    qtd_cirurgioes[turno] <- qtd_cirurgioes[turno] + 1
                                 fimse
                              fimse
                           fimpara
                           especialidade_medico[idbusca] <- especialidade
                        fimse
                        escreval("Especialidade atualizada com sucesso!")
                     senao
                        escreval("Alteracao cancelada. A especialidade anterior foi mantida.")
                     fimse
                  fimse

                  // ALTERAR A DISPONIBILIDADE
                  se opcao_alteracao = 3 entao
                     disponibilidade_antiga <- disp_medico[idbusca]
                     escreval("1 - Manha")
                     escreval("2 - Tarde")
                     escreval("3 - Noite")
                     escreval("4 - Manha e Tarde")
                     escreval("5 - Manha e Noite")
                     escreval("6 - Tarde e Noite")
                     escreva("Digite a nova disponibilidade: ")
                     leia(disponibilidade)

                     enquanto (disponibilidade < 1) ou (disponibilidade > 6) faca
                        escreval("Disponibilidade invalida!")
                        escreva("Digite um valor de 1 a 6: ")
                        leia(disponibilidade)
                     fimenquanto

                     se disponibilidade <> disponibilidade_antiga entao
                        para turno de 1 ate 3 faca
                           // REMOVER DO TURNO ANTIGO
                           trabalha_turno <- falso
                           se disponibilidade_antiga = turno entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disponibilidade_antiga = 4) e (turno <= 2) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disponibilidade_antiga = 5) e ((turno = 1) ou (turno = 3)) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disponibilidade_antiga = 6) e (turno >= 2) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se disponibilidade_antiga = 7 entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se trabalha_turno = verdadeiro entao
                              se especialidade_medico[idbusca] = 1 entao
                                 qtd_pediatras[turno] <- qtd_pediatras[turno] - 1
                              fimse
                              se especialidade_medico[idbusca] = 2 entao
                                 qtd_clinicos[turno] <- qtd_clinicos[turno] - 1
                              fimse
                              se especialidade_medico[idbusca] = 3 entao
                                 qtd_cirurgioes[turno] <- qtd_cirurgioes[turno] - 1
                              fimse
                           fimse

                           // ADICIONAR AO TURNO NOVO
                           trabalha_turno <- falso
                           se disponibilidade = turno entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disponibilidade = 4) e (turno <= 2) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disponibilidade = 5) e ((turno = 1) ou (turno = 3)) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disponibilidade = 6) e (turno >= 2) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se trabalha_turno = verdadeiro entao
                              se especialidade_medico[idbusca] = 1 entao
                                 qtd_pediatras[turno] <- qtd_pediatras[turno] + 1
                              fimse
                              se especialidade_medico[idbusca] = 2 entao
                                 qtd_clinicos[turno] <- qtd_clinicos[turno] + 1
                              fimse
                              se especialidade_medico[idbusca] = 3 entao
                                 qtd_cirurgioes[turno] <- qtd_cirurgioes[turno] + 1
                              fimse
                           fimse

                           se (qtd_pediatras[turno] + qtd_clinicos[turno] + qtd_cirurgioes[turno]) = 0 entao
                              cadastrado[turno] <- 0
                           senao
                              cadastrado[turno] <- 1
                           fimse
                        fimpara
                        disp_medico[idbusca] <- disponibilidade
                        para i de 1 ate qtd_disp faca
                           se id_disponibilidade[i] = idbusca entao
                              disp_registro[i] <- disponibilidade
                           fimse
                        fimpara
                     fimse
                     escreval("Disponibilidade atualizada com sucesso!")
                  fimse

                  escreval("Informacoes alteradas!")

               fimse

               escreva("Deseja pesquisar outro ID? [S/N] ")
               leia(escolhe)

               enquanto (escolhe <> "S") e (escolhe <> "N") faca
                  escreva("Digite S ou N: ")
                  leia(escolhe)
               fimenquanto

               se escolhe = "S" entao

                  escreval(" ")
                  escreva("Qual ID voce deseja procurar? ")
                  leia(idbusca)
                  enquanto (idbusca < 1) ou (idbusca > qtd_cad_medicos) faca
                     escreval("ID invalido!")
                     escreva("Digite outro ID: ")
                     leia(idbusca)
                  fimenquanto

                  enquanto nome_medico[idbusca] = "" faca
                     escreval("Medico nao cadastrado!")
                     escreva("Digite outro ID: ")
                     leia(idbusca)

                     enquanto (idbusca < 1) ou (idbusca > qtd_cad_medicos) faca
                        escreval("ID invalido!")
                        escreva("Digite outro ID: ")
                        leia(idbusca)
                     fimenquanto
                  fimenquanto

               fimse

            fimenquanto
         fimse

      caso 4

         se (qtd_cad_medicos = 0) entao
            limpatela
            escreval("Nenhum medico foi cadastrado!")
         senao

            limpatela
            escreval("Aqui estao todos os medicos cadastrados no sistema")
            escreval(" ")

            escreva("Pediatras: ")
            para i de 1 ate qtd_cad_medicos faca
               se especialidade_medico[i] = 1 entao
                  escreva(i, " ")
               fimse
            fimpara

            escreval(" ")
            escreval(" ")

            escreva("Clinicos Gerais: ")
            para i de 1 ate qtd_cad_medicos faca
               se especialidade_medico[i] = 2 entao
                  escreva(i, " ")
               fimse
            fimpara

            escreval(" ")
            escreval(" ")

            escreva("Cirurgioes: ")
            para i de 1 ate qtd_cad_medicos faca
               se especialidade_medico[i] = 3 entao
                  escreva(i, " ")
               fimse
            fimpara

            escreval(" ")
            escreval(" ")

            escreval("Qual id voce deseja atribuir a outro dia: ")
            leia(idbusca)

            escreval(" ")
            escreval(" ")

            enquanto (idbusca < 1) ou (idbusca > qtd_cad_medicos) faca
               escreval("ID invalido!")
               escreva("Digite outro ID: ")
               leia(idbusca)
            fimenquanto

            enquanto nome_medico[idbusca] = "" faca
               escreval("Medico nao cadastrado!")
               escreva("Digite outro ID: ")
               leia(idbusca)

               enquanto (idbusca < 1) ou (idbusca > qtd_cad_medicos) faca
                  escreval("ID invalido!")
                  escreva("Digite outro ID: ")
                  leia(idbusca)
               fimenquanto
            fimenquanto

            escolhe <- "S"

            enquanto escolhe = "S" faca

               limpatela

               escreval("===========================")
               escreval("      FICHA DO MEDICO")
               escreval("===========================")

               escreval(" ")

               escreval("ID do especialista: ", idbusca)

               escreval(" ")


               escreval("Nome: ", nome_medico[idbusca])

               escreval(" ")

               se especialidade_medico[idbusca] = 1 entao
                  escreval("Especialidade: ", esp_pediatra)
               fimse

               se especialidade_medico[idbusca] = 2 entao
                  escreval("Especialidade: ", esp_clinico_geral)
               fimse

               se especialidade_medico[idbusca] = 3 entao
                  escreval("Especialidade: ", esp_cirurgiao)
               fimse

               escreval(" ")


               escreval("O medico ", nome_medico[idbusca], " esta escalado para os seguintes turnos:")
               escreval(" ")

               para i de 1 ate qtd_disp faca

                  se id_disponibilidade[i] = idbusca entao

                     se semana[i] = 1 entao
                        escreva("Segunda-Feira: ")

                        se (disp_registro[i] = 1) entao
                           escreval("Manha")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manha e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manha e Noite")
                                    senao
                                       se (disp_registro[i] = 6) entao
                                          escreval("Tarde e Noite")
                                       fimse
                                    fimse
                                 fimse
                              fimse
                           fimse
                        fimse
                     fimse

                     se semana[i] = 2 entao
                        escreva("Terca-Feira: ")

                        se (disp_registro[i] = 1) entao
                           escreval("Manha")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manha e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manha e Noite")
                                    senao
                                       se (disp_registro[i] = 6) entao
                                          escreval("Tarde e Noite")
                                       fimse
                                    fimse
                                 fimse
                              fimse
                           fimse
                        fimse
                     fimse

                     se semana[i] = 3 entao
                        escreva("Quarta-Feira: ")

                        se (disp_registro[i] = 1) entao
                           escreval("Manha")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manha e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manha e Noite")
                                    senao
                                       se (disp_registro[i] = 6) entao
                                          escreval("Tarde e Noite")
                                       fimse
                                    fimse
                                 fimse
                              fimse
                           fimse
                        fimse
                     fimse

                     se semana[i] = 4 entao
                        escreva("Quinta-Feira: ")

                        se (disp_registro[i] = 1) entao
                           escreval("Manha")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manha e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manha e Noite")
                                    senao
                                       se (disp_registro[i] = 6) entao
                                          escreval("Tarde e Noite")
                                       fimse
                                    fimse
                                 fimse
                              fimse
                           fimse
                        fimse
                     fimse

                     se semana[i] = 5 entao
                        escreva("Sexta-Feira: ")

                        se (disp_registro[i] = 1) entao
                           escreval("Manha")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manha e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manha e Noite")
                                    senao
                                       se (disp_registro[i] = 6) entao
                                          escreval("Tarde e Noite")
                                       fimse
                                    fimse
                                 fimse
                              fimse
                           fimse
                        fimse
                     fimse
                  fimse
               fimpara

               escreval(" ")

               escreval("Em qual outro dia voce deseja escala-lo: ")

               escreval(" ")
               escreval("1 - Segunda-Feira")
               escreval("2 - Terca-Feira")
               escreval("3 - Quarta-Feira")
               escreval("4 - Quinta-Feira")
               escreval("5 - Sexta-Feira")
               escreva("Escolha uma opcao: ")
               leia(diasemana)

               enquanto (diasemana < 1) ou (diasemana > 5) faca

                  escreval("Dia da Semana invalido!")
                  escreva("Digite entre 1 e 5: ")
                  leia(diasemana)

               fimenquanto

               pode_cadastrar <- 1

               se (pode_cadastrar = 1) entao

                  // CADASTRO DA DISPONIBILIDADE

                  limpatela

                  escreval("----------------------------------------")
                  escreval("           CADASTRO DO MEDICO")
                  escreval("----------------------------------------")

                  escreval(" ")
                  escreval("Disponibilidade:")
                  escreval("1 - Manha")
                  escreval("2 - Tarde")
                  escreval("3 - Noite")
                  escreval("4 - Manha e Tarde")
                  escreval("5 - Manha e Noite")
                  escreval("6 - Tarde e Noite")
                  escreva("Escolha uma opcao: ")
                  leia(disponibilidade)

                  enquanto (disponibilidade < 1) ou (disponibilidade > 6) faca

                     escreval("Disponibilidade invalida!")
                     escreva("Digite um valor de 1 a 6: ")
                     leia(disponibilidade)

                  fimenquanto

                  // VERIFICAR SE TRABALHOU A NOITE NO DIA ANTERIOR
                  trabalhou_noite_anterior <- falso
                  quer_manha <- falso

                  se (disponibilidade = 1) ou (disponibilidade = 4) ou (disponibilidade = 5) ou (disponibilidade = 7) entao
                     quer_manha <- verdadeiro
                  fimse

                  se diasemana > 1 entao
                     dia_anterior <- diasemana - 1

                     para i de 1 ate qtd_disp faca
                        se (id_disponibilidade[i] = idbusca) e (semana[i] = dia_anterior) entao
                           se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) ou (disp_registro[i] = 7) entao
                              trabalhou_noite_anterior <- verdadeiro
                           fimse
                        fimse
                     fimpara
                  fimse

                  se trabalhou_noite_anterior e quer_manha entao
                     limpatela
                     escreval("ERRO: Este medico trabalhou no turno da noite no dia anterior.")
                     escreval("Ele nao pode ser escalado para trabalhar de manha no dia seguinte.")
                     pode_cadastrar <- 0
                  fimse

                  // CONTAR OS PLANTOES JA ATRIBUIDOS AO MEDICO NA SEMANA
                  qtd_plantao_semana <- 0

                  para i de 1 ate qtd_disp faca
                     se (id_disponibilidade[i] = idbusca) e (semana[i] >= 1) e (semana[i] <= 5) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 2) ou (disp_registro[i] = 3) entao
                           qtd_plantao_semana <- qtd_plantao_semana + 1
                        senao
                           se (disp_registro[i] = 4) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                              qtd_plantao_semana <- qtd_plantao_semana + 2
                           senao
                              se disp_registro[i] = 7 entao
                                 qtd_plantao_semana <- qtd_plantao_semana + 3
                              fimse
                           fimse
                        fimse
                     fimse
                  fimpara

                  // CONTAR QUANTOS PLANTOES A NOVA DISPONIBILIDADE REPRESENTA
                  se (disponibilidade = 1) ou (disponibilidade = 2) ou (disponibilidade = 3) entao
                     qtd_plantao_novo <- 1
                  senao
                     se (disponibilidade = 4) ou (disponibilidade = 5) ou (disponibilidade = 6) entao
                        qtd_plantao_novo <- 2
                     senao
                        qtd_plantao_novo <- 3
                     fimse
                  fimse

                  se (qtd_plantao_semana + qtd_plantao_novo) > 5 entao
                     escreval("ERRO: O medico ultrapassaria o limite de 5 plantoes na semana.")
                     escreval("Plantoes ja cadastrados: ", qtd_plantao_semana)
                     escreval("Plantoes desta nova disponibilidade: ", qtd_plantao_novo)
                     pode_cadastrar <- 0
                  fimse

                  // SO CADASTRAR SE AS DUAS REGRAS FOREM RESPEITADAS
                  se pode_cadastrar = 1 entao

                     qtd_disp <- qtd_disp + 1
                     id_disponibilidade[qtd_disp] <- idbusca
                     semana[qtd_disp] <- diasemana
                     disp_registro[qtd_disp] <- disponibilidade

                     limpatela
                     escreval("Medico atribuido com sucesso!")

                     // REUNIR OS TURNOS DE TODAS AS DISPONIBILIDADES DO MEDICO
                     tem_manha <- falso
                     tem_tarde <- falso
                     tem_noite <- falso

                     para i de 1 ate qtd_disp faca
                        se id_disponibilidade[i] = idbusca entao
                           se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                              tem_manha <- verdadeiro
                           fimse
                           se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                              tem_tarde <- verdadeiro
                           fimse
                           se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                              tem_noite <- verdadeiro
                           fimse
                        fimse
                     fimpara


                     se tem_manha e tem_tarde entao
                        disp_medico[idbusca] <- 4
                     senao
                        se tem_manha e tem_noite entao
                           disp_medico[idbusca] <- 5
                        senao
                           se tem_tarde e tem_noite entao
                              disp_medico[idbusca] <- 6
                           senao
                              se tem_manha entao
                                 disp_medico[idbusca] <- 1
                              senao
                                 se tem_tarde entao
                                    disp_medico[idbusca] <- 2
                                 senao
                                    se tem_noite entao
                                       disp_medico[idbusca] <- 3
                                    fimse
                                 fimse
                              fimse
                           fimse
                        fimse
                     fimse

                     // RECALCULAR AS QUANTIDADES DOS TURNOS

                     // RECALCULAR CONTADORES: CADA MEDICO CONTA UMA VEZ POR TURNO
                     para turno de 1 ate 3 faca
                        qtd_pediatras[turno] <- 0
                        qtd_clinicos[turno] <- 0
                        qtd_cirurgioes[turno] <- 0
                        cadastrado[turno] <- 0
                     fimpara

                     para i de 1 ate qtd_cad_medicos faca
                        para turno de 1 ate 3 faca
                           trabalha_turno <- falso
                           se disp_medico[i] = turno entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disp_medico[i] = 4) e (turno <= 2) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disp_medico[i] = 5) e ((turno = 1) ou (turno = 3)) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se (disp_medico[i] = 6) e (turno >= 2) entao
                              trabalha_turno <- verdadeiro
                           fimse
                           se trabalha_turno entao
                              se especialidade_medico[i] = 1 entao
                                 qtd_pediatras[turno] <- qtd_pediatras[turno] + 1
                              fimse
                              se especialidade_medico[i] = 2 entao
                                 qtd_clinicos[turno] <- qtd_clinicos[turno] + 1
                              fimse
                              se especialidade_medico[i] = 3 entao
                                 qtd_cirurgioes[turno] <- qtd_cirurgioes[turno] + 1
                              fimse
                              cadastrado[turno] <- 1
                           fimse
                        fimpara
                     fimpara
                  fimse
               fimse

               escolhe <- "N"

            fimenquanto
         fimse

      caso 5

         limpatela

         escreval("----------------------------------------")
         escreval("             RESETAR ESCALA")
         escreval("----------------------------------------")

         se qtd_disp = 0 entao
            escreval("Nao ha registros de escala para apagar.")
         senao

            // APAGAR OS REGISTROS DE DISPONIBILIDADE DA SEMANA
            para i de 1 ate 50 faca
               id_disponibilidade[i] <- 0
               semana[i] <- 0
               disp_registro[i] <- 0
            fimpara

            // LIMPAR A DISPONIBILIDADE GERAL DOS MEDICOS,
            // PRESERVANDO SEUS CADASTROS E ESPECIALIDADES
            para i de 1 ate qtd_cad_medicos faca
               disp_medico[i] <- 0
            fimpara

            // ZERAR OS CONTADORES AUXILIARES DOS TURNOS
            para turno de 1 ate 3 faca
               qtd_pediatras[turno] <- 0
               qtd_clinicos[turno] <- 0
               qtd_cirurgioes[turno] <- 0
               cadastrado[turno] <- 0
            fimpara

            qtd_disp <- 0

            escreval("A escala da semana foi apagada com sucesso!")
            escreval("Os medicos cadastrados foram preservados.")

         fimse

         escreval(" ")
         escreval("Retornando ao menu principal...")


      caso 6
         limpatela
         escreval("========================================")
         escreval("     RELATORIO SEMANAL")
         escreval("========================================")

         r_total <- 0
         para r_id de 1 ate 25 faca
            r_carga[r_id] <- 0
            para r_indice de 1 ate 15 faca
               r_visto[r_id,r_indice] <- falso
            fimpara
         fimpara
         para r_indice de 1 ate 15 faca
            para r_esp de 1 ate 3 faca
               r_cobertura[r_indice,r_esp] <- 0
            fimpara
         fimpara

         // Cada registro pode representar um ou dois turnos.
         // r_visto evita contar duas vezes o mesmo medico no mesmo turno.
         para i de 1 ate qtd_disp faca
            r_id <- id_disponibilidade[i]
            r_dia <- semana[i]
            r_codigo <- disp_registro[i]
            se (r_id >= 1) e (r_id <= qtd_cad_medicos) e (r_dia >= 1) e (r_dia <= 5) entao
               para r_turno de 1 ate 3 faca
                  r_inclui <- falso
                  se (r_turno = 1) e ((r_codigo = 1) ou (r_codigo = 4) ou (r_codigo = 5)) entao
                     r_inclui <- verdadeiro
                  fimse
                  se (r_turno = 2) e ((r_codigo = 2) ou (r_codigo = 4) ou (r_codigo = 6)) entao
                     r_inclui <- verdadeiro
                  fimse
                  se (r_turno = 3) e ((r_codigo = 3) ou (r_codigo = 5) ou (r_codigo = 6)) entao
                     r_inclui <- verdadeiro
                  fimse
                  r_indice <- (r_dia - 1) * 3 + r_turno
                  se r_inclui e (nao r_visto[r_id,r_indice]) entao
                     r_visto[r_id,r_indice] <- verdadeiro
                     r_esp <- especialidade_medico[r_id]
                     se (r_esp >= 1) e (r_esp <= 3) entao
                        r_carga[r_id] <- r_carga[r_id] + 1
                        r_cobertura[r_indice,r_esp] <- r_cobertura[r_indice,r_esp] + 1
                        r_total <- r_total + 1
                     fimse
                  fimse
               fimpara
            fimse
         fimpara

         se qtd_cad_medicos = 0 entao
            escreval("Nenhum medico cadastrado. Media indisponivel.")
         senao
            r_media <- r_total / qtd_cad_medicos
            r_maior <- r_carga[1]
            r_menor <- r_carga[1]
            para r_id de 1 ate qtd_cad_medicos faca
               se r_carga[r_id] > r_maior entao
                  r_maior <- r_carga[r_id]
               fimse
               se r_carga[r_id] < r_menor entao
                  r_menor <- r_carga[r_id]
               fimse
            fimpara
            escreval("Total de plantoes: ", r_total)
            escreval("Media da equipe: ", r_media:5:2)
            escreval("Maior carga: ", r_maior)
            escreval("Menor carga: ", r_menor)
            para r_id de 1 ate qtd_cad_medicos faca
               escreva("ID ", r_id, " - ", nome_medico[r_id], ": ", r_carga[r_id], " plantoes")
               se r_carga[r_id] > r_media + 1 entao
                  escreval(" - SOBRECARREGADO")
               senao
                  escreval(" - sem sobrecarga")
               fimse
               se r_carga[r_id] = r_maior entao
                  escreval("  Maior carga (empate possivel)")
               fimse
               se r_carga[r_id] = r_menor entao
                  escreval("  Menor carga (empate possivel)")
               fimse
            fimpara
         fimse

         r_cobertos <- 0
         r_falha_ped <- 0
         r_falha_cli <- 0
         r_falha_cir <- 0
         r_faltas <- 0
         para r_dia de 1 ate 5 faca
            para r_turno de 1 ate 3 faca
               r_indice <- (r_dia - 1) * 3 + r_turno
               r_turno_ok <- 1
               escreval("Dia ", r_dia, " - Turno ", r_turno)
               para r_esp de 1 ate 3 faca
                  r_minimo <- 1
                  se r_esp = 2 entao
                     r_minimo <- 2
                  fimse
                  se r_cobertura[r_indice,r_esp] < r_minimo entao
                     r_turno_ok <- 0
                     r_faltas <- r_faltas + r_minimo - r_cobertura[r_indice,r_esp]
                     escolha r_esp
                     caso 1
                        r_falha_ped <- r_falha_ped + 1
                        escreval("  Faltam ", r_minimo - r_cobertura[r_indice,r_esp], " Pediatra(s)")
                     caso 2
                        r_falha_cli <- r_falha_cli + 1
                        escreval("  Faltam ", r_minimo - r_cobertura[r_indice,r_esp], " Clinico(s) Geral(is)")
                     caso 3
                        r_falha_cir <- r_falha_cir + 1
                        escreval("  Faltam ", r_minimo - r_cobertura[r_indice,r_esp], " Cirurgiao(oes)")
                     fimescolha
                  fimse
               fimpara
               se r_turno_ok = 1 entao
                  r_cobertos <- r_cobertos + 1
                  escreval("  Cobertura completa")
               fimse
            fimpara
         fimpara
         r_percentual <- r_cobertos * 100 / 15
         escreval("Turnos completos: ", r_cobertos, "/15 (", r_percentual:5:2, "%)")
         escreval("Falhas em turnos - Pediatria: ", r_falha_ped)
         escreval("Falhas em turnos - Clinica Geral: ", r_falha_cli)
         escreval("Falhas em turnos - Cirurgia: ", r_falha_cir)
         escreval("Postos sem cobertura: ", r_faltas)
         se r_cobertos = 15 entao
            escreval("SEMANA PLENAMENTE COBERTA")
         senao
            escreval("SEMANA COM COBERTURA INSUFICIENTE")
         fimse

      caso 7

         limpatela

         se qtd_cad_medicos = 0 entao
            escreval("Nenhum medico foi cadastrado!")
         fimse

         // AVISO: TURNOS COM COBERTURA INSUFICIENTE NA SEMANA
         // PERCORRE SEGUNDA A SEXTA, MANHA/TARDE/NOITE, E INFORMA QUAIS
         // ESPECIALIDADES NAO POSSUEM NENHUM MEDICO ESCALADO NO TURNO
         qtd_turnos_insuficientes <- 0
         falhas_ped <- 0
         falhas_cli <- 0
         falhas_cir <- 0

         escreval(" ")
         escreval("----------------------------------------")
         escreval("  AVISO: TURNOS COM COBERTURA INSUFICIENTE")
         escreval("----------------------------------------")

         para av_dia de 1 ate 5 faca
            para av_turno de 1 ate 3 faca

               especialidades_faltando <- ""

               para av_esp de 1 ate 3 faca

                  av_coberto <- falso

                  para av_k de 1 ate qtd_disp faca
                     se (semana[av_k] = av_dia) e (especialidade_medico[id_disponibilidade[av_k]] = av_esp) entao

                        av_cobre_turno <- falso

                        se disp_registro[av_k] = av_turno entao
                           av_cobre_turno <- verdadeiro
                        fimse
                        se (disp_registro[av_k] = 4) e (av_turno <= 2) entao
                           av_cobre_turno <- verdadeiro
                        fimse
                        se (disp_registro[av_k] = 5) e ((av_turno = 1) ou (av_turno = 3)) entao
                           av_cobre_turno <- verdadeiro
                        fimse
                        se (disp_registro[av_k] = 6) e (av_turno >= 2) entao
                           av_cobre_turno <- verdadeiro
                        fimse
                        se disp_registro[av_k] = 7 entao
                           av_cobre_turno <- verdadeiro
                        fimse

                        se av_cobre_turno entao
                           av_coberto <- verdadeiro
                        fimse

                     fimse
                  fimpara

                  // MONTA A LISTA DE ESPECIALIDADES QUE FALTARAM NO TURNO
                  // E CONTABILIZA AS FALHAS POR ESPECIALIDADE
                  se av_coberto = falso entao
                     se especialidades_faltando <> "" entao
                        especialidades_faltando <- especialidades_faltando + ", "
                     fimse
                     se av_esp = 1 entao
                        especialidades_faltando <- especialidades_faltando + esp_pediatra
                        falhas_ped <- falhas_ped + 1
                     fimse
                     se av_esp = 2 entao
                        especialidades_faltando <- especialidades_faltando + esp_clinico_geral
                        falhas_cli <- falhas_cli + 1
                     fimse
                     se av_esp = 3 entao
                        especialidades_faltando <- especialidades_faltando + esp_cirurgiao
                        falhas_cir <- falhas_cir + 1
                     fimse
                  fimse

               fimpara

               se especialidades_faltando <> "" entao

                  qtd_turnos_insuficientes <- qtd_turnos_insuficientes + 1

                  se av_dia = 1 entao
                     escreva("Segunda-Feira")
                  fimse
                  se av_dia = 2 entao
                     escreva("Terca-Feira")
                  fimse
                  se av_dia = 3 entao
                     escreva("Quarta-Feira")
                  fimse
                  se av_dia = 4 entao
                     escreva("Quinta-Feira")
                  fimse
                  se av_dia = 5 entao
                     escreva("Sexta-Feira")
                  fimse

                  se av_turno = 1 entao
                     escreva(" | Manha")
                  fimse
                  se av_turno = 2 entao
                     escreva(" | Tarde")
                  fimse
                  se av_turno = 3 entao
                     escreva(" | Noite")
                  fimse

                  escreval(" | Falta: ", especialidades_faltando)

               fimse

            fimpara
         fimpara

         escreval(" ")

         se qtd_turnos_insuficientes = 0 entao
            escreval("Todos os turnos da semana estao com cobertura completa.")
         senao
            escreval("Total de turnos com cobertura insuficiente: ", qtd_turnos_insuficientes)
            escreval("Falhas por especialidade:")
            escreval("   ", esp_pediatra, ": ", falhas_ped)
            escreval("   ", esp_clinico_geral, ": ", falhas_cli)
            escreval("   ", esp_cirurgiao, ": ", falhas_cir)
         fimse

         escreval("----------------------------------------")


      caso 0

         limpatela

         escreval("----------------------------------------")
         escreval("           RELATORIO FINAL DA SEMANA")
         escreval("----------------------------------------")

         diasemana <- 1

         se diasemana = 1 entao

            escreval(" ")
            escreval("                         -------------")
            escreval("                         SEGUNDA-FEIRA")
            escreval("                         -------------")


            escreval(" ")
            escreval("  TURNO DA MANHA")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manha!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse


            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da manha!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da manha!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA TARDE")
            escreval(" ")

            //CONSULTA DO TURNO DA TARDE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da tarde!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da tarde!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6)  entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da tarde!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA NOITE")
            escreval(" ")

            //CONSULTA DO TURNO DA NOITE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da noite!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da noite!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval(      "Nenhum Clinico Geral disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da noite!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6)  entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse
         fimse


         diasemana <- 2


         se diasemana = 2 entao

            escreval(" ")
            escreval(" ")
            escreval("                         -----------")
            escreval("                         TERCA-FEIRA")
            escreval("                         -----------")

            escreval(" ")
            escreval("  TURNO DA MANHA")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manha!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse


            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da manha!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da manha!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA TARDE")
            escreval(" ")

            //CONSULTA DO TURNO DA TARDE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da tarde!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da tarde!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6)  entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da tarde!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA NOITE")
            escreval(" ")

            //CONSULTA DO TURNO DA NOITE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da noite!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da noite!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval(      "Nenhum Clinico Geral disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da noite!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6)  entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse
         fimse


         diasemana <- 3


         se diasemana = 3 entao

            escreval(" ")
            escreval(" ")
            escreval("                         ------------")
            escreval("                         QUARTA-FEIRA")
            escreval("                         ------------")

            escreval(" ")
            escreval("  TURNO DA MANHA")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manha!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse


            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da manha!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da manha!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA TARDE")
            escreval(" ")

            //CONSULTA DO TURNO DA TARDE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da tarde!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da tarde!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6)  entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da tarde!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA NOITE")
            escreval(" ")

            //CONSULTA DO TURNO DA NOITE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da noite!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da noite!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval(      "Nenhum Clinico Geral disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da noite!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6)  entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse
         fimse

         diasemana <- 4


         se diasemana = 4 entao

            escreval(" ")
            escreval(" ")
            escreval("                         ------------")
            escreval("                         QUINTA-FEIRA")
            escreval("                         ------------")
            escreval(" ")

            escreval(" ")
            escreval("  TURNO DA MANHA")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manha!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse


            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da manha!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da manha!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA TARDE")
            escreval(" ")

            //CONSULTA DO TURNO DA TARDE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da tarde!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da tarde!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6)  entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da tarde!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA NOITE")
            escreval(" ")

            //CONSULTA DO TURNO DA NOITE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da noite!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da noite!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval(      "Nenhum Clinico Geral disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da noite!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6)  entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse
         fimse


         diasemana <- 5


         se diasemana = 5 entao

            escreval(" ")
            escreval(" ")
            escreval("                         -----------")
            escreval("                         SEXTA-FEIRA")
            escreval("                         -----------")

            escreval(" ")
            escreval("  TURNO DA MANHA")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manha!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse


            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da manha!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da manha!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da manha!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manha")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manha e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA TARDE")
            escreval(" ")

            //CONSULTA DO TURNO DA TARDE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da tarde!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da tarde!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6)  entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da tarde!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da tarde!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 2) ou (disp_registro[i] = 4) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 2) Entao
                              Escreval(" | Turno: Tarde")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manha e Tarde")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            escreval("  TURNO DA NOITE")
            escreval(" ")

            //CONSULTA DO TURNO DA NOITE

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da noite!")
            senao
               tem_pediatra <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_pediatra <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_pediatra = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Pediatra disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_clinico = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Clinico Geral cadastrado/disponivel no turno da noite!")
            senao
               tem_clinico <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                        tem_clinico <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_clinico = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Clinico Geral disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse

            escreval(" ")

            Se qtd_cad_cirurgiao = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Cirurgiao cadastrado/disponivel no turno da noite!")
            senao
               tem_cirurgiao <- falso

               para i de 1 ate qtd_disp faca
                  se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                     se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6)  entao
                        tem_cirurgiao <- verdadeiro
                     fimse
                  fimse
               fimpara

               se tem_cirurgiao = falso entao
                  plantao_valido <- falso
                  escreval("     Nenhum Cirurgiao disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manha e Noite")
                              Senao
                                 Se (disp_registro[i] = 6) Entao
                                    Escreval(" | Turno: Tarde e Noite")
                                 fimse
                              fimse
                           FimSe
                        FimSe
                     fimse
                  fimpara
               fimse
            fimse
         fimse

         escreval(" ")
         escreval(" ")
         escreval(" ")

         // AVISO: TURNOS COM COBERTURA INSUFICIENTE NA SEMANA
         // PERCORRE SEGUNDA A SEXTA, MANHA/TARDE/NOITE, E INFORMA QUAIS
         // ESPECIALIDADES NAO POSSUEM NENHUM MEDICO ESCALADO NO TURNO
         qtd_turnos_insuficientes <- 0
         falhas_ped <- 0
         falhas_cli <- 0
         falhas_cir <- 0

         escreval(" ")
         escreval("----------------------------------------")
         escreval("  AVISO: TURNOS COM COBERTURA INSUFICIENTE")
         escreval("----------------------------------------")

         para av_dia de 1 ate 5 faca
            para av_turno de 1 ate 3 faca

               especialidades_faltando <- ""

               para av_esp de 1 ate 3 faca

                  av_coberto <- falso

                  para av_k de 1 ate qtd_disp faca
                     se (semana[av_k] = av_dia) e (especialidade_medico[id_disponibilidade[av_k]] = av_esp) entao

                        av_cobre_turno <- falso

                        se disp_registro[av_k] = av_turno entao
                           av_cobre_turno <- verdadeiro
                        fimse
                        se (disp_registro[av_k] = 4) e (av_turno <= 2) entao
                           av_cobre_turno <- verdadeiro
                        fimse
                        se (disp_registro[av_k] = 5) e ((av_turno = 1) ou (av_turno = 3)) entao
                           av_cobre_turno <- verdadeiro
                        fimse
                        se (disp_registro[av_k] = 6) e (av_turno >= 2) entao
                           av_cobre_turno <- verdadeiro
                        fimse
                        se disp_registro[av_k] = 7 entao
                           av_cobre_turno <- verdadeiro
                        fimse

                        se av_cobre_turno entao
                           av_coberto <- verdadeiro
                        fimse

                     fimse
                  fimpara

                  // MONTA A LISTA DE ESPECIALIDADES QUE FALTARAM NO TURNO
                  // E CONTABILIZA AS FALHAS POR ESPECIALIDADE
                  se av_coberto = falso entao
                     se especialidades_faltando <> "" entao
                        especialidades_faltando <- especialidades_faltando + ", "
                     fimse
                     se av_esp = 1 entao
                        especialidades_faltando <- especialidades_faltando + esp_pediatra
                        falhas_ped <- falhas_ped + 1
                     fimse
                     se av_esp = 2 entao
                        especialidades_faltando <- especialidades_faltando + esp_clinico_geral
                        falhas_cli <- falhas_cli + 1
                     fimse
                     se av_esp = 3 entao
                        especialidades_faltando <- especialidades_faltando + esp_cirurgiao
                        falhas_cir <- falhas_cir + 1
                     fimse
                  fimse

               fimpara

               se especialidades_faltando <> "" entao

                  qtd_turnos_insuficientes <- qtd_turnos_insuficientes + 1

                  se av_dia = 1 entao
                     escreva("Segunda-Feira")
                  fimse
                  se av_dia = 2 entao
                     escreva("Terca-Feira")
                  fimse
                  se av_dia = 3 entao
                     escreva("Quarta-Feira")
                  fimse
                  se av_dia = 4 entao
                     escreva("Quinta-Feira")
                  fimse
                  se av_dia = 5 entao
                     escreva("Sexta-Feira")
                  fimse

                  se av_turno = 1 entao
                     escreva(" | Manha")
                  fimse
                  se av_turno = 2 entao
                     escreva(" | Tarde")
                  fimse
                  se av_turno = 3 entao
                     escreva(" | Noite")
                  fimse

                  escreval(" | Falta: ", especialidades_faltando)

               fimse

            fimpara
         fimpara

         escreval(" ")

         se qtd_turnos_insuficientes = 0 entao
            escreval("Todos os turnos da semana estao com cobertura completa.")
         senao
            escreval("Total de turnos com cobertura insuficiente: ", qtd_turnos_insuficientes)
            escreval("Falhas por especialidade:")
            escreval("   ", esp_pediatra, ": ", falhas_ped)
            escreval("   ", esp_clinico_geral, ": ", falhas_cli)
            escreval("   ", esp_cirurgiao, ": ", falhas_cir)
         fimse

         escreval("----------------------------------------")


         escreval(" ")

         escreval("----------------------------------------")

         se qtd_cad_medicos = 0 entao
            escreval("  PLANTAO NAO PODE SER PUBLICADO!")
            escreval("  Motivo: nenhum medico foi cadastrado.")
         senao
            se plantao_valido = falso entao
               escreval("  PLANTAO NAO PODE SER PUBLICADO!")
               escreval("  Motivo: Falta profissional em uma ou mais especialidades/turnos.")
            senao
               escreval("  PLANTAO PUBLICADO!")
               escreval("  Obrigado por utilizar o Medshift!")
            fimse
         fimse

         escreval("----------------------------------------")
fimalgoritmo
outrocaso
   limpatela
   escreval("Opcao invalida!")
fimescolha

fimenquanto

fimalgoritmo