#install.packages("ggpubr") #Rodar apenas uma vez

rm(list=ls(all=TRUE)) # limpar todas as variáveis do R

#------------------------------------------------------------------------------------------------------------------
#Preparação dos dados
#------------------------------------------------------------------------------------------------------------------
#Leitura das amostras obtidas
Turma2016 = as.data.frame(read.csv("imc_20162.CSV"))
Turma2017 = as.data.frame(read.csv("CS01_20172.CSV", sep=";"))

#Retirando os Alunos que não são do PPGEE da turma 2016
Turma2016Filtrada = Turma2016[!(apply(Turma2016, 1, function(y) any(y == "ENGSIS"))),] #retira todos as linhas com ENGSIS

#Calculando o IMC dos dados
IMC2016 = rep(0,nrow(Turma2016Filtrada))#criando um vetor zerado
IMC2017 = rep(0,nrow(Turma2017))#criando um vetor zerado

for (i in 1:nrow(Turma2016Filtrada)){
  IMC2016[i] = round(as.numeric(Turma2016Filtrada[i,5])/(as.numeric(Turma2016Filtrada[i,4])^2), digits = 2) #Peso/(Altura^2)
}
for (i in 1:nrow(Turma2017)){
  IMC2017[i] = round(as.numeric(Turma2017[i,1])/(as.numeric(Turma2017[i,2])^2), digits = 2) #Peso/(Altura^2)
}

IMC = IMC2016
Turma2016Filtrada=cbind(Turma2016Filtrada,IMC) #adicionando a coluna nova do IMC
IMC = IMC2017
Turma2017=cbind(Turma2017,IMC) #adicionando a coluna nova do IMC

#------------------------------------------------------------------------------------------------------------------
#Analise dos dados
#------------------------------------------------------------------------------------------------------------------
#Visualização dos dados
boxplot(Turma2016Filtrada[,6])
#Possui um outlier

boxplot(Turma2017[,5])

#------------------------------------------------------------------------------------------------------------------
#Testando normalidade
#------------------------------------------------------------------------------------------------------------------
#Teste de normalidade de Shapiro-Wilk 
library(ggpubr)

shapiro.test(Turma2016Filtrada[,6])
ggqqplot(Turma2016Filtrada[,6])
#####Tem um outlier que faz o teste puxar para não normalidade

shapiro.test(Turma2017[,5])
ggqqplot(Turma2017[,5])
#####Normal

#Histograma das amostras
hist(Turma2016Filtrada[,6],main = "Histograma do ICM da Turma 2016")
hist(Turma2017[,5],main = "Histograma do ICM da Turma 2017")

#Grafico de Disperção Sexo x IMC
plot(Turma2017[,3],Turma2017[,5], xlab = "Sexo", ylab = "IMC")
plot(Turma2016Filtrada[,3],Turma2016Filtrada[,6], xlab = "Sexo", ylab = "IMC")
#####Assim, há uma diferença entre a parcela dos homens e mulheres de cada sala e serão divididos

#Separando por sexo
F2016 = Turma2016Filtrada[!(apply(Turma2016Filtrada, 1, function(y) any(y == "M"))),] #retira todos as linhas com M
M2016 = Turma2016Filtrada[!(apply(Turma2016Filtrada, 1, function(y) any(y == "F"))),] #retira todos as linhas com F
F2017 = Turma2017[!(apply(Turma2017, 1, function(y) any(y == "M"))),] #retira todos as linhas com M
M2017 = Turma2017[!(apply(Turma2017, 1, function(y) any(y == "F"))),] #retira todos as linhas com F

#------------------------------------------------------------------------------------------------------------------
#Testando normalidade dos grupos separados
#------------------------------------------------------------------------------------------------------------------
#Teste de normalidade de Shapiro-Wilk 
library(ggpubr)

shapiro.test(F2016[,6])
ggqqplot(F2016[,6])
#####Normal

shapiro.test(M2016[,6])
ggqqplot(M2016[,6])
#####Normal mas o outlier puxa bem o teste pra não normalidade

shapiro.test(F2017[,5])
ggqqplot(F2017[,5])
#####Não é normal, mas por ter poucos dados, o teste é muito sensivel

shapiro.test(M2017[,5])
ggqqplot(M2017[,5])
#####Normal

#------------------------------------------------------------------------------------------------------------------
#Comparando as salas
#------------------------------------------------------------------------------------------------------------------
power.t.test(n = 4, delta = 1, sd = 1, sig.level = 0.01, type = "two.sample")
##### Por ser apenas 4 variaveis, apenas temos 6% de não ter o erro do tipo II
power.t.test(n = 4, delta = 1, sd = 1, sig.level = 0.05, type = "two.sample")
##### Por ser apenas 4 variaveis, apenas temos 22% de não ter o erro do tipo II

power.t.test(n = 7, delta = 1, sd = 1, sig.level = 0.01, type = "two.sample")
##### Por ser apenas 7 variaveis, apenas temos 17% de não ter o erro do tipo II
power.t.test(n = 7, delta = 1, sd = 1, sig.level = 0.05, type = "two.sample")
##### Por ser apenas 7 variaveis, apenas temos 40% de não ter o erro do tipo II

power.t.test(n = 21, delta = 1, sd = 1, sig.level = 0.01, type = "two.sample")
##### Com 21 variaveis, temos 70% de não ter o erro do tipo II para o teste dos homens
power.t.test(n = 21, delta = 1, sd = 1, sig.level = 0.05, type = "two.sample")
##### Com 21 variaveis, temos 88% de não ter o erro do tipo II para o teste dos homens

#Aplicação do teste t nas amostras obtidas, considerando hipótese alternativa central
#Considerando que as médias do ICM das mulheres são iguais (diferença = 0)
t.test(F2016[,6], F2017[,5], alternative = "two.sided", mu = 0, conf.level = 0.95)
##### Em média, as mulheres de ambas as salas tem o mesmo ICM

#Aplicação do teste t nas amostras obtidas, considerando hipótese alternativa central
#Considerando que as médias do ICM dos homens são iguais (diferença = 0)
t.test(M2016[,6], M2017[,5], alternative = "two.sided", mu = 0, conf.level = 0.95)
##### Em média, os homems de ambas as sala tem o mesmo ICM

#------------------------------------------------------------------------------------------------------------------
#Analise dos resultados
#------------------------------------------------------------------------------------------------------------------
# Por ter pouca observação na amostra das mulheres de cada turma, não se tem uma grande potência do teste t, não 
#obtendo assim grande confiança nos dados. Assim, escolheu-se um nível de confiancia de 95% entre 95% e 99% por ter 
#uma potencia de 22% para as 4 observações em relação a potencia de 6% para o para o nível de confiancia de 99%.
#Assim, de acordo com o teste t, tem-se que a diferença entre as médias de ICM das mulheres de cada turma é 
#0 [-0.1310754,5.4046469] para a significancia de 95%. Mesmo que a amostra de mulheres da turma de 2017 não seja
#normal, por apenas ter 4 observações, qualquer pequena variação faz com que a sensibilidade do teste aponte para
#a não normalidade. Assim, como mostra a figura do Quantile-Quantile plot, há apenas um ponto afastado da curva que 
#leva a amostra a não ser normal.
# Em relação a média de IMC dos homens, de acordo com o teste t, tem-se que a diferença de cada turma é 
#0 [-1.788951  3.089904] para a significancia de 95% com uma potencia de 88%. 

#------------------------------------------------------------------------------------------------------------------
#Conclusão
#------------------------------------------------------------------------------------------------------------------
# De acordo com os resultados do teste t e da analise dos dados, há diferença entre o ICM de homens e mulheres, porém
#não há diferença em média entre o IMC dos homens de cada turma e o IMC das mulheres de cada turma.