
#==============================================================================
#  Primeiro Projeto - Métodos Estatísticos Avançados em Epidemiologia
#==============================================================================
#
#  Descrição do Estudo: A dosagem da hemoglobina glicosilada (HbA) é uma
#  ferramenta importante para o acompanhamento de gestantes com diabetes.
#  Sabe-se que o risco de defeitos congênitos aumenta quando a mãe possui diabetes.
#  Entretanto, acredita-se que com um acompanhamento adequado, a
#  gestante aumenta o risco de ter um bebê saudável.
#
#===============================================================================
#
# PS: Para começar a entender o código, tudo o que criamos e mexemos digitalmente
#	se chama variável. Então não confundir com as variáveis do problema estatístico.
#	Se for alguma váriavel dos dados estatísticos, estará avisado.
#	As funções que chamamos aqui são os comandos da linguagem de programação R.
#
#-------------------------------------------------------------------------------
#  Limpeza de variáveis
#-------------------------------------------------------------------------------

 rm(list=ls(all=TRUE)) # limpar todas as variáveis do R

# Ou seja, qualquer váriavel criada será apagada. Isto serve para termos certeza que
# não haverá nada criado com algum nome do programa
#
# PS: Na dúvida, crie uma variável (exemplo: ex01), chame ela, use o comando e veja o que acontece

#-------------------------------------------------------------------------------
#  Leitura dos Dados do Experimento
#-------------------------------------------------------------------------------

# Criação de variável chamada "Dados", o qual conterá todo o banco de dado
# O banco de dados para o Primeiro Projeto se chama "dados_projeto1.txt", que nem no site do professor
# Para a importação dos dados funcionar, o script e os dados devem estar na mesma pasta do seu computador
# O "R" deve estar no mesmo diretorio que ambos
#
# PS: Chamamos de Leitura ou Read sempre que trazemos algo para o espaço virtual do programa e
#	chamamos de Escrita ou Write sempre que escrevemos algo para fora do programa

 Dados <- read.table("dados_projeto1.txt", head=T) # ler o banco de dados do diretório de trabalho

# Para conferir se os dados entraram no nosso espaço virtual do programa R, chamamos a variável "Dados" criada

 Dados

# Para saber quantas linhas e colunas os dados tem, usamos a função "dim()" 
#
# PS: A primeira informação é o número de linhas e a segunda o de colunas.
#	Esse comando ajuda para saber se todos os dados foram, porque assim você só tem que olhar a última linha
#	e coluna

 dim(Dados)

#-------------------------------------------------------------------------------
#  Inspecionando os dados e suas componentes
#-------------------------------------------------------------------------------
 
# Todo objeto (ou variável) tem uma classe (ou tipo de dados)
# A função "class()" nos informa qual classe que esse objeto possuí
# "data.frame" quando for uma tabela (matrix) de dados
# "numeric" quando for valores númericos não inteiros (com valores depois da vírgula. Exemplo: 0,2 ou 1,2)
# "integer" quando for valores númericos inteiros (apenas valores que não possuí vírgula. Exemplo: 1 ou 10)
# "character" quando for considerado uma escrita (ou letras)
# (é apenas um amontuado de letras sem qualquer significado)
# "factor" quando for considerado uma variável nominal 
# (uma variável que não pode ser contada e nem colocada em alguma ordem) 
# Exemplo: Cor de olho, Tipo de cabelo. Ela não é só uma letra. Ela é uma palavra que tem algum significado
#
# PS: Essas 5 são as que eu consegui achar. Se tiver outras, eu não sei quais são.

# A função "is.data.frame()" pergunta e a variável lá dentro é "data.frame" ou não, respondendo TRUE ou FALSE

 is.data.frame(Dados)

# A função "names()" nos dá os valores dos nomes de cada coluna da variável chamada

 names(Dados)

# Ao chamar sua variável (no nosso trabalho, "Dados") ela irá chamar todos os valores dentro dela (no nosso
# trabalho, as duas colunas)
# Então, ao chamá-la com um "$" seguido de um nome da sua coluna, irá apenas aparecer os dados daquela coluna
# PS: No nosso trabalho, as colunas se chamam "Hba" e "Grupo", que são nossas variáveis estatísticas

 Dados$Hba
 Dados$Grupo

#-------------------------------------------------------------------------------
#  Parte inserida na programação original
#-------------------------------------------------------------------------------
# Busco dentro da minha variável "Dados" aonde tem os valores "1","2" e "3" na coluna "Grupo" e
# substituo com o nome desses grupos, onde:
# "Grupo" "1" = Gestantes Normais ("N")
# "Grupo" "2" = Gestantes com Tolerância Diminuida ("TD")
# "Grupo" "3" = Gestantes Diabéticas ("D")

# Separo o número de linhas dos meus dados

Numero_Linhas = dim(Dados)
Numero_Linhas = Numero_Linhas[1]

# Ando dentro dos meus dados, 1 a 1, para procurar os grupos e mudar os valores.
# A função "for()" me auxilia nisto, indo de 1 em 1 nos meus dados
# A função "if()" compara duas coisas e, se for verdade, executa os comandos abaixo

 for (i in 1:Numero_Linhas) {
	if (Dados$Grupo[i] == 1) 
		Dados$Grupo[i] = 'N'
	if (Dados$Grupo[i] == 2) 
		Dados$Grupo[i] = 'TD'
	if (Dados$Grupo[i] == 3) 
		Dados$Grupo[i] = 'D'
 }

# Chamo a variável Dados para ver a mudança

 Dados

#-------------------------------------------------------------------------------


# A função "is.factor()" pergunta e a variável lá dentro é "factor" ou não, respondendo TRUE ou FALSE

 is.factor(Dados$Grupo)

# Por ela ser FALSE, ou seja, não ser "factor", temos que mudar, pois a outra função pede
#
# PS: se usar class(Dados$Grupo), dará "integer" na antiga do professor ou "character" na nova que eu criei

# Estamos mudando a classe da coluna "Grupo" para "factor", como se "1", "2" e "3" ganhassem um sentido de
# do grupo número do Grupo e não um número qualquer (como se fosse "Grupo 1", "Grupo 2" e "Grupo 3")
# Como mudei o nome das variáveis, faço as letras "N", "TD" e "D" ganharem o sentido de nome de grupo.

 Dados$Grupo<-factor(Dados$Grupo) # grupo tem que ser factor para a função "summary()" fazer a divisão

# A função "is.numeric()" pergunta e a variável lá dentro é "numeric" ou não, respondendo TRUE ou FALSE

 is.numeric(Dados$Hba) # Hba tem que ser numeric

# Concluímos que o objeto Dados é um data-frame com duas variáveis, sendo uma delas um 
# fator (a variável Grupo) e a outra uma variável numérica (a variável Hba). 

#-------------------------------------------------------------------------------
# Análise descritiva
#-------------------------------------------------------------------------------

# A função "summary()" faz o resumo de todos os dados dentro da variável "Dados"

 summary(Dados)

# a função "tapply()" aplica uma função nos dados "Hba" pela sua divisão "Grupo"

 tapply(Dados$Hba, Dados$Grupo, length) 	#Comprimento
 tapply(Dados$Hba, Dados$Grupo, mean) 	#Média
 tapply(Dados$Hba, Dados$Grupo, median)	#Mediana
 tapply(Dados$Hba, Dados$Grupo, sd)	#Desvio padrão
 tapply(Dados$Hba, Dados$Grupo, max)-tapply(Dados$Hba, Dados$Grupo, min)	#Máx - Min
 tapply(Dados$Hba, Dados$Grupo, summary)	#Tudo resumido por divisão

# Vamos prosseguir com a análise exploratória, obtendo algumas medidas e gráficos. 

 plot(Dados) # gráfico de pontos
# plot(Dados, pch="x", col=2, cex=1.5) # muda a marca, cor e intensidade

 windows() # abre uma nova janela para colocar gráficos
 boxplot(Dados$Hba ~ Dados$Grupo)

# Agora vamos fazer a análise de variância.
# A função "aov()" faz a analise da variância ANOVA

 AnaliseAnova <- aov(Hba ~ Grupo, data = Dados)
 AnaliseAnova #chama a variável para ver o que está nela

# Agora ver a analise com as funções "summary()" e "anova()"

 summary(AnaliseAnova)
 anova(AnaliseAnova)

# Portanto o objeto "AnaliseAnova" guarda os resultados da análise. Vamos 
# inspecionar este  objeto mais cuidadosamente e fazer também uma análise 
# dos resultados e resíduos. 

 names(AnaliseAnova)
 class(AnaliseAnova)
 AnaliseAnova$coef # mostra os coeficientes estimados do modelo
 AnaliseAnova$res # mostra os resíduos do modelo
 residuals(AnaliseAnova)  # forma alternativa

# Faz os gráficos da analise ANOVA

 windows() # abre uma nova janela para colocar gráficos
 par(mfrow=c(2,2)) #colocando os quatro gráficos na tela
 plot(AnaliseAnova)
 par(mfrow=c(1,1))

# o primeiro (e o terceiro) mostrando faixas de mesma dispersão atestam
# a adequação da homocedasticidade. A linha vermelha nestes gráficos deve
# ser horizontal (em torno do y=) se a suposição de homocedasticidade for
# verdadeira. E o segundo gráfico, mostrando os pontos em torno
# da reta, atestam a adequação da normalidade.

# Ou seja, ele não está adequado à normalidade e a homocedasticidade
#  O valor-p = 6,08e-06 (ou 0,00000608) não atende 
# Agora é analisar pois o valor p ficou muito pequeno, antes de iniciar os outros testes

#  Vamos verificar as suposições do modelo/teste F
#   1- homocedasticidade e 2- normalidade

# A homogeneidade dos desvios-padrão pode ser verificada pelo 
# Teste de Bartlett. Um teste alternativo,o de Levene,
# (usualmente melhor que o de Bartlett) pode ser realizado no pacote lawstat
# Por ele não estar no R, temos que baixar e instalar o pacote para podermos usar
#

# Fazendo o Teste de Bartlett

 bartlett.test(Dados$Hba, Dados$Grupo)

# Fazendo o Teste de Levene
# Não está funcionando

 require(lawstat)  # pedir o pacote lawstat
 levene.test(Dados$Hba, Dados$Grupo)

# O teste de Shapiro-Wilks verifica a normalidade.

 shapiro.test(residuals(AnaliseAnova))

#-------------------------------------------------------------------------------
# Fim do programa
#-------------------------------------------------------------------------------

# Como as suposições foram atendidads, nós dizemos que existem
# diferença entre os grupos ao nível de 10%. Portanto, necessitamos
# de comparações múltiplas para encontrar quais grupos são diferentes
# e quais são iguais. Vamos utilizar os métodos de Bonferroni e Tukey.

 pairwise.t.test(Dados$Hba, Dados$Grupo, p.adj = "bonf")
 pairwise.t.test(Dados$Hba, Dados$Grupo, p.adj = "holm") # Método de Holm

#

 ex01.tu <- TukeyHSD(AnaliseAnova,conf.level = 0.95)
 plot(ex01.tu)
 ex01.tu

# Concluimos que existe diferença média de 0,4mgHg (IC 95%; 0,004 e 0,809) 
# entre o grupo 2(Rancho Los Amigos) e 0 1 (John Hopkins).
#
#
#======================================================================================
#  TÓPICOS ESPECIAIS: Outros Métodos de Análise
#============================================================================
# 1- Teste Não-Paramétrico de Kruskal-Wallis
#
  kruskal.test(volume ~ grupo, data = ex01) 
==========================================================================
#
#  2-   Teste Não-paramétrico via bootstrap
#       Teste de Permutação (Sem Reposição)
#
# amostra observada: 21 + 16 + 23
 b <- 2000 # número de amostras bootstrap
 n<-21+16+23
 chi.boot<-NULL
#
 for (j in 1:b) { # começo do for do bootstrap
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
