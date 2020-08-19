
#==============================================================================
#  Comparação de Médias - Teste F - ANOVA
#==============================================================================
#
#  Descrição do Estudo: Volume Expiratório Forçado VEF - Três Grupos
#                        Livro do Marcelo Pagano Cap. 12
#
#===============================================================================
#
#  Leitura dos Dados
#
 rm(list=ls(all=TRUE)) # limpar a console
 ex01 <- read.table("dados_aula2.txt", head=T) # ler o banco de dados do diretório de trabalho
#
 ex01
 dim(ex01)
# Caso o arquivo esteja em outro diretório deve-se colocar o caminho completo 
# deste diretório no argumento de read.table acima. Por exemplo:
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
# Concluímos que o objeto ex01 é um data-frame com duas variáveis, sendo uma delas um 
# fator (a variável grupo) e a outra uma variável numérica. 
#
# Análise descritiva 
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
# Existe uma indicação inicial que o grupo 2 tem média/mediana superior aos
# outros dois.
# Media ~= mediana indicação de simetria de distribuições e mesmo dp/range é uma
# indicação de homocedasticidade.
#  
# Há um mecanismo no R de "anexar" objetos ao caminho de procura que permite 
# economizar um pouco de digitação. Veja os comandos abaixo e compare com o 
# comando anterior. 
#
  attach(ex01)
#
 tapply(volume, grupo, mean)
#
# Interessante não? Quando "anexamos" um objeto do tipo list ou data.frame 
# no caminho de procura com o comando attach() fazemos com que os componentes 
# deste objeto se tornem imediatamente disponíveis e portanto podemos, por 
# exemplo, digitar somente grupo ao invés de ex01$grupo. 
#
# No entanto, este comando deve ser utilizado com cuidado pois o uso abusivo
# vai colocando objeto em cima de objeto.
#
# Vamos prosseguir com a análise exploratória, obtendo algumas medidas e 
# gráficos. 
#
  plot(ex01) # gráfico de pontos
#  plot(ex01, pch="x", col=2, cex=1.5) # muda a marca, cor e intensidade
  plot(ex01$grupo,ex01$volume)
#
  boxplot(volume ~ grupo) # mesmo gráfico anterior
#
#  Agora vamos fazer a análise de variância. Vamos "desanexar" o objeto com 
#  os dados (embora isto não seja necessário). 
  detach(ex01)
  ex01.av <- aov(volume ~ grupo, data = ex01)
  ex01.av
#
  summary(ex01.av)
  anova(ex01.av)
#
# Portanto o objeto ex01.av guarda os resultados da análise. Vamos 
# inspecionar este  objeto mais cuidadosamente e fazer também uma análise 
# dos resultados e resíduos. 
#
  names(ex01.av)
  class(ex01.av)
  ex01.av$coef # mostra os coeficientes estimados do modelo
#
  ex01.av$res # mostra os resíduos do modelo
  residuals(ex01.av)  # forma alternativa
#
#  O valor-p=0,052 somente é válido se as suposições forem confirmadas.
#
#  Vamos verificar as suposições do modelo/teste F
#   1- homocedasticidade e 2- normalidade
#
#  A homogeneidade dos desvios-padrão pode ser verificada pelo 
#  Teste de Bartlett. Um teste alternativo,o de Levene,
#  (usualmente melhor que o de Bartlett) pode ser realizado no pacote
#  lawstat
#
  bartlett.test(ex01$volume, ex01$grupo)
  require(lawstat)  # pedir o pacote lawstat
  levene.test(ex01$volume, ex01$grupo)
#
#  Ambos testes mostram não haver evidência contra a hipótese de
#  homocedasticidade. Os resíduos também podem ser utilizados para verificar
#  as suposições.
#
  plot(ex01.av) # pressione a tecla enter para mudar o gráfico
#
 par(mfrow=c(2,2)) colocando os quatro gráficos na tela
 plot(ex01.av)
 par(mfrow=c(1,1))
#
# o primeiro (e o terceiro) mostrando faixas de mesma dispersão atestam
# a adequação da homocedasticidade. A linha vermelha nestes gráficos deve
# ser horizontal (em torno do y=) se a suposição de homocedasticidade for
# verdadeira. E o segundo gráfico, mostrando os pontos em torno
# da reta, atestam a adequação da normalidade.
#
# O teste de Shapiro-Wilks verifica a normalidade.
#
 shapiro.test(residuals(ex01.av))
#
# Como as suposições foram atendidads, nós dizemos que existem
# diferença entre os grupos ao nível de 10%. Portanto, necessitamos
# de comparações múltiplas para encontrar quais grupos são diferentes
# e quais são iguais. Vamos utilizar os métodos de Bonferroni e Tukey.
#
 pairwise.t.test(ex01$volume, ex01$grupo, p.adj = "bonf")
 pairwise.t.test(ex01$volume, ex01$grupo, p.adj = "holm") # Método de Holm
#
 ex01.tu <- TukeyHSD(ex01.av)
 plot(ex01.tu)
 ex01.tu
#
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
