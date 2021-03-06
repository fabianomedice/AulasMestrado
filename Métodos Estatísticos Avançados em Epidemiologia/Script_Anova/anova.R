
#==============================================================================
#  Compara��o de M�dias - Teste F - ANOVA
#==============================================================================
#
#  Descri��o do Estudo: Volume Expirat�rio For�ado VEF - Tr�s Grupos
#                        Livro do Marcelo Pagano Cap. 12
#
#===============================================================================
#
#  Leitura dos Dados
#
 rm(list=ls(all=TRUE)) # limpar a console
 ex01 <- read.table("dados_aula2.txt", head=T) # ler o banco de dados do diret�rio de trabalho
#
 ex01
 dim(ex01)
# Caso o arquivo esteja em outro diret�rio deve-se colocar o caminho completo 
# deste diret�rio no argumento de read.table acima. Por exemplo:
#
# ex01 <- read.table("http://www.est.ufmg.br/~enricoc/pdf/avancados_medicina/
# dados_aula2.txt", head=T) # lendo o banco de dados da internet
#
# Inspecionando os dados e suas componentes. 
#  Todo objeto tem uma classe (data.frame (dados), factor, numeric,etc)
#
 is.data.frame(ex01)
 names(ex01)
 ex01$volume
 ex01$grupo
#
 is.factor(ex01$grupo)
 ex01$grupo<-factor(ex01$grupo) # grupo tem que ser factor
 is.numeric(ex01$volume) # volume tem que ser numeric
#
# Conclu�mos que o objeto ex01 � um data-frame com duas vari�veis, sendo uma delas um 
# fator (a vari�vel grupo) e a outra uma vari�vel num�rica. 
#
# An�lise descritiva 
#
  summary(ex01)
  tapply(ex01$volume, ex01$grupo, length)
  by(ex01$volume, ex01$grupo, length) # forma alternativa
  tapply(ex01$volume, ex01$grupo, mean)
  tapply(ex01$volume, ex01$grupo, median)
  tapply(ex01$volume, ex01$grupo, sd)
  tapply(ex01$volume, ex01$grupo, max)-tapply(ex01$volume, ex01$grupo, min)
  tapply(ex01$volume, ex01$grupo, summary)
  by(ex01$volume, ex01$grupo, summary)  # forma alternativa
#
# Existe uma indica��o inicial que o grupo 2 tem m�dia/mediana superior aos
# outros dois.
# Media ~= mediana indica��o de simetria de distribui��es e mesmo dp/range � uma
# indica��o de homocedasticidade.
#  
# H� um mecanismo no R de "anexar" objetos ao caminho de procura que permite 
# economizar um pouco de digita��o. Veja os comandos abaixo e compare com o 
# comando anterior. 
#
  attach(ex01)
#
 tapply(volume, grupo, mean)
#
# Interessante n�o? Quando "anexamos" um objeto do tipo list ou data.frame 
# no caminho de procura com o comando attach() fazemos com que os componentes 
# deste objeto se tornem imediatamente dispon�veis e portanto podemos, por 
# exemplo, digitar somente grupo ao inv�s de ex01$grupo. 
#
# No entanto, este comando deve ser utilizado com cuidado pois o uso abusivo
# vai colocando objeto em cima de objeto.
#
# Vamos prosseguir com a an�lise explorat�ria, obtendo algumas medidas e 
# gr�ficos. 
#
  plot(ex01) # gr�fico de pontos
#  plot(ex01, pch="x", col=2, cex=1.5) # muda a marca, cor e intensidade
  plot(ex01$grupo,ex01$volume)
#
  boxplot(volume ~ grupo) # mesmo gr�fico anterior
#
#  Agora vamos fazer a an�lise de vari�ncia. Vamos "desanexar" o objeto com 
#  os dados (embora isto n�o seja necess�rio). 
  detach(ex01)
  ex01.av <- aov(volume ~ grupo, data = ex01)
  ex01.av
#
  summary(ex01.av)
  anova(ex01.av)
#
# Portanto o objeto ex01.av guarda os resultados da an�lise. Vamos 
# inspecionar este  objeto mais cuidadosamente e fazer tamb�m uma an�lise 
# dos resultados e res�duos. 
#
  names(ex01.av)
  class(ex01.av)
  ex01.av$coef # mostra os coeficientes estimados do modelo
#
  ex01.av$res # mostra os res�duos do modelo
  residuals(ex01.av)  # forma alternativa
#
#  O valor-p=0,052 somente � v�lido se as suposi��es forem confirmadas.
#
#  Vamos verificar as suposi��es do modelo/teste F
#   1- homocedasticidade e 2- normalidade
#
#  A homogeneidade dos desvios-padr�o pode ser verificada pelo 
#  Teste de Bartlett. Um teste alternativo,o de Levene,
#  (usualmente melhor que o de Bartlett) pode ser realizado no pacote
#  lawstat
#
  bartlett.test(ex01$volume, ex01$grupo)
  require(lawstat)  # pedir o pacote lawstat
  levene.test(ex01$volume, ex01$grupo)
#
#  Ambos testes mostram n�o haver evid�ncia contra a hip�tese de
#  homocedasticidade. Os res�duos tamb�m podem ser utilizados para verificar
#  as suposi��es.
#
  plot(ex01.av) # pressione a tecla enter para mudar o gr�fico
#
 par(mfrow=c(2,2)) colocando os quatro gr�ficos na tela
 plot(ex01.av)
 par(mfrow=c(1,1))
#
# o primeiro (e o terceiro) mostrando faixas de mesma dispers�o atestam
# a adequa��o da homocedasticidade. A linha vermelha nestes gr�ficos deve
# ser horizontal (em torno do y=) se a suposi��o de homocedasticidade for
# verdadeira. E o segundo gr�fico, mostrando os pontos em torno
# da reta, atestam a adequa��o da normalidade.
#
# O teste de Shapiro-Wilks verifica a normalidade.
#
 shapiro.test(residuals(ex01.av))
#
# Como as suposi��es foram atendidads, n�s dizemos que existem
# diferen�a entre os grupos ao n�vel de 10%. Portanto, necessitamos
# de compara��es m�ltiplas para encontrar quais grupos s�o diferentes
# e quais s�o iguais. Vamos utilizar os m�todos de Bonferroni e Tukey.
#
 pairwise.t.test(ex01$volume, ex01$grupo, p.adj = "bonf")
 pairwise.t.test(ex01$volume, ex01$grupo, p.adj = "holm") # M�todo de Holm
#
 ex01.tu <- TukeyHSD(ex01.av)
 plot(ex01.tu)
 ex01.tu
#
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
	i. <- sample(ex01$grupo,replace=F)
	       chi.boot[j] <- anova( aov(ex01$volume ~ factor(i.)))$F[1] 
 } # fim do for do bootstrap
#
# hist(chi.boot)
 boot.p.value<-length(chi.boot[chi.boot>=anova(aov(ex01$volume ~ factor(
 ex01$grupo)))$F[1] ])/b # 
 boot.p.value
#
# fim do for do bootstrap
  x<-seq(0,8,.05)
 hist(chi.boot,freq=F)
 lines(x,df(x,2,57),lty=1)
#===========================================================================
