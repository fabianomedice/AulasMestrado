
#==============================================================================
#  Primeiro Projeto - M�todos Estat�sticos Avan�ados em Epidemiologia
#==============================================================================
#
#  Descri��o do Estudo: A dosagem da hemoglobina glicosilada (HbA) � uma
#  ferramenta importante para o acompanhamento de gestantes com diabetes.
#  Sabe-se que o risco de defeitos cong�nitos aumenta quando a m�e possui diabetes.
#  Entretanto, acredita-se que com um acompanhamento adequado, a
#  gestante aumenta o risco de ter um beb� saud�vel.
#
#===============================================================================
#
# PS: Para come�ar a entender o c�digo, tudo o que criamos e mexemos digitalmente
#	se chama vari�vel. Ent�o n�o confundir com as vari�veis do problema estat�stico.
#	Se for alguma v�riavel dos dados estat�sticos, estar� avisado.
#	As fun��es que chamamos aqui s�o os comandos da linguagem de programa��o R.
#
#-------------------------------------------------------------------------------
#  Limpeza de vari�veis
#-------------------------------------------------------------------------------

 rm(list=ls(all=TRUE)) # limpar todas as vari�veis do R

# Ou seja, qualquer v�riavel criada ser� apagada. Isto serve para termos certeza que
# n�o haver� nada criado com algum nome do programa
#
# PS: Na d�vida, crie uma vari�vel (exemplo: ex01), chame ela, use o comando e veja o que acontece

#-------------------------------------------------------------------------------
#  Leitura dos Dados do Experimento
#-------------------------------------------------------------------------------

# Cria��o de vari�vel chamada "Dados", o qual conter� todo o banco de dado
# O banco de dados para o Primeiro Projeto se chama "dados_projeto1.txt", que nem no site do professor
# Para a importa��o dos dados funcionar, o script e os dados devem estar na mesma pasta do seu computador
# O "R" deve estar no mesmo diretorio que ambos
#
# PS: Chamamos de Leitura ou Read sempre que trazemos algo para o espa�o virtual do programa e
#	chamamos de Escrita ou Write sempre que escrevemos algo para fora do programa

 Dados <- read.table("dados_projeto1.txt", head=T) # ler o banco de dados do diret�rio de trabalho

# Para conferir se os dados entraram no nosso espa�o virtual do programa R, chamamos a vari�vel "Dados" criada

 Dados

# Para saber quantas linhas e colunas os dados tem, usamos a fun��o "dim()" 
#
# PS: A primeira informa��o � o n�mero de linhas e a segunda o de colunas.
#	Esse comando ajuda para saber se todos os dados foram, porque assim voc� s� tem que olhar a �ltima linha
#	e coluna

 dim(Dados)

#-------------------------------------------------------------------------------
#  Inspecionando os dados e suas componentes
#-------------------------------------------------------------------------------
 
# Todo objeto (ou vari�vel) tem uma classe (ou tipo de dados)
# A fun��o "class()" nos informa qual classe que esse objeto possu�
# "data.frame" quando for uma tabela (matrix) de dados
# "numeric" quando for valores n�mericos n�o inteiros (com valores depois da v�rgula. Exemplo: 0,2 ou 1,2)
# "integer" quando for valores n�mericos inteiros (apenas valores que n�o possu� v�rgula. Exemplo: 1 ou 10)
# "character" quando for considerado uma escrita (ou letras)
# (� apenas um amontuado de letras sem qualquer significado)
# "factor" quando for considerado uma vari�vel nominal 
# (uma vari�vel que n�o pode ser contada e nem colocada em alguma ordem) 
# Exemplo: Cor de olho, Tipo de cabelo. Ela n�o � s� uma letra. Ela � uma palavra que tem algum significado
#
# PS: Essas 5 s�o as que eu consegui achar. Se tiver outras, eu n�o sei quais s�o.

# A fun��o "is.data.frame()" pergunta e a vari�vel l� dentro � "data.frame" ou n�o, respondendo TRUE ou FALSE

 is.data.frame(Dados)

# A fun��o "names()" nos d� os valores dos nomes de cada coluna da vari�vel chamada

 names(Dados)

# Ao chamar sua vari�vel (no nosso trabalho, "Dados") ela ir� chamar todos os valores dentro dela (no nosso
# trabalho, as duas colunas)
# Ent�o, ao cham�-la com um "$" seguido de um nome da sua coluna, ir� apenas aparecer os dados daquela coluna
# PS: No nosso trabalho, as colunas se chamam "Hba" e "Grupo", que s�o nossas vari�veis estat�sticas

 Dados$Hba
 Dados$Grupo

#-------------------------------------------------------------------------------
#  Parte inserida na programa��o original
#-------------------------------------------------------------------------------
# Busco dentro da minha vari�vel "Dados" aonde tem os valores "1","2" e "3" na coluna "Grupo" e
# substituo com o nome desses grupos, onde:
# "Grupo" "1" = Gestantes Normais ("N")
# "Grupo" "2" = Gestantes com Toler�ncia Diminuida ("TD")
# "Grupo" "3" = Gestantes Diab�ticas ("D")

# Separo o n�mero de linhas dos meus dados

Numero_Linhas = dim(Dados)
Numero_Linhas = Numero_Linhas[1]

# Ando dentro dos meus dados, 1 a 1, para procurar os grupos e mudar os valores.
# A fun��o "for()" me auxilia nisto, indo de 1 em 1 nos meus dados
# A fun��o "if()" compara duas coisas e, se for verdade, executa os comandos abaixo

 for (i in 1:Numero_Linhas) {
	if (Dados$Grupo[i] == 1) 
		Dados$Grupo[i] = 'N'
	if (Dados$Grupo[i] == 2) 
		Dados$Grupo[i] = 'TD'
	if (Dados$Grupo[i] == 3) 
		Dados$Grupo[i] = 'D'
 }

# Chamo a vari�vel Dados para ver a mudan�a

 Dados

#-------------------------------------------------------------------------------


# A fun��o "is.factor()" pergunta e a vari�vel l� dentro � "factor" ou n�o, respondendo TRUE ou FALSE

 is.factor(Dados$Grupo)

# Por ela ser FALSE, ou seja, n�o ser "factor", temos que mudar, pois a outra fun��o pede
#
# PS: se usar class(Dados$Grupo), dar� "integer" na antiga do professor ou "character" na nova que eu criei

# Estamos mudando a classe da coluna "Grupo" para "factor", como se "1", "2" e "3" ganhassem um sentido de
# do grupo n�mero do Grupo e n�o um n�mero qualquer (como se fosse "Grupo 1", "Grupo 2" e "Grupo 3")
# Como mudei o nome das vari�veis, fa�o as letras "N", "TD" e "D" ganharem o sentido de nome de grupo.

 Dados$Grupo<-factor(Dados$Grupo) # grupo tem que ser factor para a fun��o "summary()" fazer a divis�o

# A fun��o "is.numeric()" pergunta e a vari�vel l� dentro � "numeric" ou n�o, respondendo TRUE ou FALSE

 is.numeric(Dados$Hba) # Hba tem que ser numeric

# Conclu�mos que o objeto Dados � um data-frame com duas vari�veis, sendo uma delas um 
# fator (a vari�vel Grupo) e a outra uma vari�vel num�rica (a vari�vel Hba). 

#-------------------------------------------------------------------------------
# An�lise descritiva
#-------------------------------------------------------------------------------

# A fun��o "summary()" faz o resumo de todos os dados dentro da vari�vel "Dados"

 summary(Dados)

# a fun��o "tapply()" aplica uma fun��o nos dados "Hba" pela sua divis�o "Grupo"

 tapply(Dados$Hba, Dados$Grupo, length) 	#Comprimento
 tapply(Dados$Hba, Dados$Grupo, mean) 	#M�dia
 tapply(Dados$Hba, Dados$Grupo, median)	#Mediana
 tapply(Dados$Hba, Dados$Grupo, sd)	#Desvio padr�o
 tapply(Dados$Hba, Dados$Grupo, max)-tapply(Dados$Hba, Dados$Grupo, min)	#M�x - Min
 tapply(Dados$Hba, Dados$Grupo, summary)	#Tudo resumido por divis�o

# Vamos prosseguir com a an�lise explorat�ria, obtendo algumas medidas e gr�ficos. 

 plot(Dados) # gr�fico de pontos
# plot(Dados, pch="x", col=2, cex=1.5) # muda a marca, cor e intensidade

 windows() # abre uma nova janela para colocar gr�ficos
 boxplot(Dados$Hba ~ Dados$Grupo)

# Agora vamos fazer a an�lise de vari�ncia.
# A fun��o "aov()" faz a analise da vari�ncia ANOVA

 AnaliseAnova <- aov(Hba ~ Grupo, data = Dados)
 AnaliseAnova #chama a vari�vel para ver o que est� nela

# Agora ver a analise com as fun��es "summary()" e "anova()"

 summary(AnaliseAnova)
 anova(AnaliseAnova)

# Portanto o objeto "AnaliseAnova" guarda os resultados da an�lise. Vamos 
# inspecionar este  objeto mais cuidadosamente e fazer tamb�m uma an�lise 
# dos resultados e res�duos. 

 names(AnaliseAnova)
 class(AnaliseAnova)
 AnaliseAnova$coef # mostra os coeficientes estimados do modelo
 AnaliseAnova$res # mostra os res�duos do modelo
 residuals(AnaliseAnova)  # forma alternativa

# Faz os gr�ficos da analise ANOVA

 windows() # abre uma nova janela para colocar gr�ficos
 par(mfrow=c(2,2)) #colocando os quatro gr�ficos na tela
 plot(AnaliseAnova)
 par(mfrow=c(1,1))

# o primeiro (e o terceiro) mostrando faixas de mesma dispers�o atestam
# a adequa��o da homocedasticidade. A linha vermelha nestes gr�ficos deve
# ser horizontal (em torno do y=) se a suposi��o de homocedasticidade for
# verdadeira. E o segundo gr�fico, mostrando os pontos em torno
# da reta, atestam a adequa��o da normalidade.

# Ou seja, ele n�o est� adequado � normalidade e a homocedasticidade
#  O valor-p = 6,08e-06 (ou 0,00000608) n�o atende 
# Agora � analisar pois o valor p ficou muito pequeno, antes de iniciar os outros testes

#  Vamos verificar as suposi��es do modelo/teste F
#   1- homocedasticidade e 2- normalidade

# A homogeneidade dos desvios-padr�o pode ser verificada pelo 
# Teste de Bartlett. Um teste alternativo,o de Levene,
# (usualmente melhor que o de Bartlett) pode ser realizado no pacote lawstat
# Por ele n�o estar no R, temos que baixar e instalar o pacote para podermos usar
#

# Fazendo o Teste de Bartlett

 bartlett.test(Dados$Hba, Dados$Grupo)

# Fazendo o Teste de Levene
# N�o est� funcionando

 require(lawstat)  # pedir o pacote lawstat
 levene.test(Dados$Hba, Dados$Grupo)

# O teste de Shapiro-Wilks verifica a normalidade.

 shapiro.test(residuals(AnaliseAnova))

#-------------------------------------------------------------------------------
# Fim do programa
#-------------------------------------------------------------------------------

# Como as suposi��es foram atendidads, n�s dizemos que existem
# diferen�a entre os grupos ao n�vel de 10%. Portanto, necessitamos
# de compara��es m�ltiplas para encontrar quais grupos s�o diferentes
# e quais s�o iguais. Vamos utilizar os m�todos de Bonferroni e Tukey.

 pairwise.t.test(Dados$Hba, Dados$Grupo, p.adj = "bonf")
 pairwise.t.test(Dados$Hba, Dados$Grupo, p.adj = "holm") # M�todo de Holm

#

 ex01.tu <- TukeyHSD(AnaliseAnova,conf.level = 0.95)
 plot(ex01.tu)
 ex01.tu

# Concluimos que existe diferen�a m�dia de 0,4mgHg (IC 95%; 0,004 e 0,809) 
# entre o grupo 2(Rancho Los Amigos) e 0 1 (John Hopkins).
#
#
#======================================================================================
#  T�PICOS ESPECIAIS: Outros M�todos de An�lise
#============================================================================
# 1- Teste N�o-Param�trico de Kruskal-Wallis
#
  kruskal.test(volume ~ grupo, data = ex01) 
==========================================================================
#
#  2-   Teste N�o-param�trico via bootstrap
#       Teste de Permuta��o (Sem Reposi��o)
#
# amostra observada: 21 + 16 + 23
 b <- 2000 # n�mero de amostras bootstrap
 n<-21+16+23
 chi.boot<-NULL
#
 for (j in 1:b) { # come�o do for do bootstrap
        x.boot<-NULL
	i. <- sample(Dados$Grupo,replace=F)
	       chi.boot[j] <- anova( aov(Dados$Hba ~ factor(i.)))$F[1] 
 } # fim do for do bootstrap
#
# hist(chi.boot)
 boot.p.value<-length(chi.boot[chi.boot>=anova(aov(Dados$Hba ~ factor(
 Dados$Grupo)))$F[1] ])/b # 
 boot.p.value
#
# fim do for do bootstrap
  x<-seq(0,8,.05)
 hist(chi.boot,freq=F)
 lines(x,df(x,2,57),lty=1)
#===========================================================================
