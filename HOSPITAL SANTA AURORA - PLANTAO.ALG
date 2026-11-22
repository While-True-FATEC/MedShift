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

   nome_medico: vetor[1..25] de caractere
   especialidade_medico: vetor[1..25] de inteiro
   disp_medico: vetor[1..25] de inteiro
   disp_registro: vetor[1..50] de inteiro

   id_disponibilidade: vetor[1..50] de inteiro
   qtd_disp: inteiro

   semana: vetor[1..50] de inteiro
   diasemana: inteiro

   // VETORES DE QUANTIDADES POR TURNO
   // POSICAO 1 = MANHA
   // POSICAO 2 = TARDE
   // POSICAO 3 = NOITE

   qtd_pediatras: vetor[1..3] de inteiro
   qtd_clinicos: vetor[1..3] de inteiro
   qtd_cirurgioes: vetor[1..3] de inteiro

   cadastrado: vetor[1..3] de inteiro

   trabalha_turno, plantao_valido: logico
   tem_manha, tem_tarde, tem_noite: logico
   tem_pediatra,tem_clinico,tem_cirurgiao: logico
   opcao_alteracao, especialidade_antiga, disponibilidade_antiga: inteiro
   especialidades_faltando: caractere

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

   para i de 1 ate 3 faca

      qtd_pediatras[i] <- 0
      qtd_clinicos[i] <- 0
      qtd_cirurgioes[i] <- 0

      cadastrado[i] <- 0

   fimpara

   para i de 1 ate 25 faca

      nome_medico[i] <- ""
      especialidade_medico[i] <- 0
      disp_medico[i] <- 0

   fimpara

   para i de 1 ate 50 faca

      id_disponibilidade[i] <- 0
      semana[i] <- 0
      disp_registro[i] <- 0
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
               escreval("Qual o dia da semana deseja cadastrar esse médico:")
               escreval("1 - Segunda-Feira")
               escreval("2 - Ter�a-Feira")
               escreval("3 - Quarta-Feira")
               escreval("4 - Quinta-Feira")
               escreval("5 - Sexta-Feira")
               escreva("Escolha uma op��o: ")
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
                     escreval("Dia da Semana: Terça-Feira")
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
         escreval("2 - Ter�a-Feira")
         escreval("3 - Quarta-Feira")
         escreval("4 - Quinta-Feira")
         escreval("5 - Sexta-Feira")
         escreva("Escolha uma op��o: ")
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
            escreval("Dia da Semana: Terça-Feira")
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

         //RELATÓRIO DO TURNO DA MANHÃ

         Se qtd_cad_pediatra = 0 entao
            plantao_valido <- falso
            escreval("Nenhum Pediatra cadastrado/disponivel no turno da manhã!")
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
            escreval("Nenhum Clínico Geral cadastrado/disponivel no turno da manhã!")
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
            escreval("Nenhum Cirurgião cadastrado/disponivel no turno da manhã!")
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
               escreval("Nenhum Cirurgião disponivel no turno da manha!")
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
            escreval("Nenhum Clínico Geral cadastrado/disponivel no turno da tarde!")
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
            escreval("Nenhum Cirurgião cadastrado/disponivel no turno da tarde!")
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
               escreval("Nenhum Cirurgião disponivel no turno da tarde!")
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
            escreval("Nenhum Clínico Geral cadastrado/disponivel no turno da noite!")
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
            escreval("Nenhum Cirurgião cadastrado/disponivel no turno da noite!")
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
               escreval("Nenhum Cirurgião disponivel no turno da noite!")
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
            escreval("Motivo: Nenhum médico foi cadastrado.")
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
            escreval("Aqui est�o todos os m�dicos cadastrados no sistema")
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

            escreval("Qual id voc� deseja atribuir a outro dia: ")
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


               escreval("O m�dico ", nome_medico[idbusca], " est� escalado para os seguintes turnos:")
               escreval(" ")

               para i de 1 ate qtd_disp faca

                  se id_disponibilidade[i] = idbusca entao

                     se semana[i] = 1 entao
                        escreva("Segunda-Feira: ")

                        se (disp_registro[i] = 1) entao
                           escreval("Manh�")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manh� e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manh� e Noite")
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
                        escreva("Ter�a-Feira: ")

                        se (disp_registro[i] = 1) entao
                           escreval("Manh�")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manh� e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manh� e Noite")
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
                           escreval("Manh�")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manh� e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manh� e Noite")
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
                           escreval("Manh�")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manh� e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manh� e Noite")
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
                           escreval("Manh�")
                        senao
                           se (disp_registro[i] = 2) entao
                              escreval("Tarde")
                           senao
                              se (disp_registro[i] = 3) entao
                                 escreval("Noite")
                              senao
                                 se (disp_registro[i] = 4) entao
                                    escreval("Manh� e Tarde")
                                 senao
                                    se (disp_registro[i] = 5) entao
                                       escreval("Manh� e Noite")
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

               escreval("Em qual outro dia voc� deseja escal�-lo: ")

               escreval(" ")
               escreval("1 - Segunda-Feira")
               escreval("2 - Ter�a-Feira")
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
                  escreva("Escolha uma op��o: ")
                  leia(disponibilidade)

                  enquanto (disponibilidade < 1) ou (disponibilidade > 6) faca

                     escreval("Disponibilidade invalida!")
                     escreva("Digite um valor de 1 a 6: ")
                     leia(disponibilidade)

                  fimenquanto

                  qtd_disp <- qtd_disp + 1
                  id_disponibilidade[qtd_disp] <- idbusca
                  semana[qtd_disp] <- diasemana
                  disp_registro[qtd_disp] <- disponibilidade

                  // NOME DO MEDICO

                  limpatela
                  
                  escreval("M�dico atribu�do com sucesso!")

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

                  // CODIGO 7 REPRESENTA OS TRES TURNOS
                  se tem_manha e tem_tarde e tem_noite entao
                     disp_medico[idbusca] <- 7
                  senao
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
                        se disp_medico[i] = 7 entao
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


      caso 0

         limpatela

         escreval("----------------------------------------")
         escreval("           RELAT�RIO FINAL DA SEMANA")
         escreval("----------------------------------------")

         diasemana <- 1

         se diasemana = 1 entao

            escreval(" ")
            escreval("                         -------------")
            escreval("                         SEGUNDA-FEIRA")
            escreval("                         -------------")


            escreval(" ")
            escreval("  TURNO DA MANH�")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Pediatra disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Clínico Geral cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Clinico Geral disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da tarde!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da tarde!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da tarde!")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da noite!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da noite!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da noite!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 3) ou (disp_registro[i] = 5) ou (disp_registro[i] = 6) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 3) Entao
                              Escreval(" | Turno: Noite")
                           Senao
                              Se (disp_registro[i] = 5) Entao
                                 Escreval(" | Turno: Manh� e Noite")
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
            escreval("                         TER�A-FEIRA")
            escreval("                         -----------")

            escreval(" ")
            escreval("  TURNO DA MANH�")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Pediatra dispon�vel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cl�nico Geral disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("         ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da tarde!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da tarde!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da tarde!")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da noite!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da noite!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da noite!")
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
            escreval("  TURNO DA MANH�")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Pediatra dispon�vel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cl�nico Geral disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("         ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da tarde!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da tarde!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da tarde!")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da noite!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da noite!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da noite!")
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
            escreval("  TURNO DA MANH�")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Pediatra dispon�vel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cl�nico Geral disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("         ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da tarde!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da tarde!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da tarde!")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da noite!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da noite!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da noite!")
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
            escreval("  TURNO DA MANH�")
            escreval(" ")

            Se qtd_cad_pediatra = 0 entao
               plantao_valido <- falso
               escreval("     Nenhum Pediatra cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Pediatra dispon�vel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 1) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_pediatra, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])


                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cl�nico Geral disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 2) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("         ", esp_clinico_geral, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da manh�!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da manh�!")
               senao
                  para i de 1 ate qtd_disp faca
                     se (especialidade_medico[id_disponibilidade[i]] = 3) e (semana[i] = diasemana) entao
                        se (disp_registro[i] = 1) ou (disp_registro[i] = 4) ou (disp_registro[i] = 5) entao
                           escreva("     ", esp_cirurgiao, " | ID: ", id_disponibilidade[i], " | NOME: ", nome_medico[id_disponibilidade[i]])

                           Se (disp_registro[i] = 1) Entao
                              Escreval(" | Turno: Manh�")
                           Senao
                              Se (disp_registro[i] = 4) Entao
                                 Escreval(" | Turno: Manh� e Tarde")
                              Senao
                                 Se (disp_registro[i] = 5) Entao
                                    Escreval(" | Turno: Manh� e Noite")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da tarde!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da tarde!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da tarde!")
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
               escreval("     Nenhum Cl�nico Geral cadastrado/disponivel no turno da noite!")
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
               escreval("     Nenhum Cirurgi�o cadastrado/disponivel no turno da noite!")
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
                  escreval("     Nenhum Cirurgi�o disponivel no turno da noite!")
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
   escreval("Op��o inv�lida!")
fimescolha

fimenquanto

fimalgoritmo