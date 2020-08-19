########################### Aula Prática - Análise Descritiva #################
#data: 30/03/2012

## Importando o banco de dados no formato csv
## Antes de usar o comando abaixo, mudar o diretório para a pasta que está o banco de dados
 data <- read.csv2("dados_andre.csv")
 attach(data) ## O função attach "libera" o banco de dados
 head(data)
 dim(data)
 class(data)
################################## Variáveis Qualitativas

##Variável Doença 
 doença.tb <- table(Doença)
 doença.tb

 doença.tbp <- prop.table(doença.tb)
 doença.tbp

##Variável Sexo
 sexo.tb <- table(Sexo)
 sexo.tb

 sexo.tbp <- prop.table(sexo.tb)
 sexo.tbp

##Variável Recusa de Alimentos
 recusa.tb<- table(recusa.de.alimento)
 recusa.tb

 recusa.tbp<- prop.table(recusa.tb)
 recusa.tbp

##Gráficos
 par(mfrow=c(1,3)) ## Permite construir 3 gráficos na mesma janela
 par(mar=c(4,4,4,4))
 pie(doença.tb,col=c("seagreen4","skyblue4"), main="Doença", radius=1.1)
 pie(sexo.tb,col=c("seagreen4","skyblue4"), main="Sexo", radius=1.1)
 barplot(recusa.tb, col="seagreen4", names=c("As vezes","Não Recusa ","Recusa"), ylim=c(0,120), main="Recusa de alimentos")

################################## Variáveis Quantitativas
 
 install.packages("fields") ## Instalando um pacote (deve estar conectado na Internet)
 require(fields) ## Carregando um pacote

 tab<- cbind(stats(idade), stats(peso))
 colnames(tab)<- c("Idade","Peso")
 tab

 round(tab,2) ## Arrendondar para dois digitos

##Gráficos
 par(mfrow=c(1,2))
 par(mar=c(4.5,5,2,2))
 boxplot(idade, main="Idade", ylab="Idade - Semanas", col="gold4")
 boxplot(peso, main="Peso", ylab="kg", col="gold4")
 hist(idade, main="Idade", xlab="Idade - Semanas", ylab="Frequência", col="gold4")
 hist(peso, main="Peso", xlab="kg", ylab="Frequência", col="gold4")

##################### Qualitativa x Quantitativa
#Peso x Doença
###utilização da função tapply

##Utilizando a função stats dentro do comando tapply
 tab1<-tapply(peso, Doença, stats)
 tab1 ## é uma lista

 round(data.frame(tab1[1], tab1[2]),3)
 t(round(data.frame(tab1[1], tab1[2]),3))[,-9]

## Gráficos
 par(mfrow=c(1,1))
 boxplot( peso ~ Doença, col="seagreen4", xlab="Doença", ylab="Peso- Kg")

################### Qualitativa x Qualitativa
#Doença x  recusa.de.alimento

 t1 <- table(Doença, recusa.de.alimento)
 t1

 round(prop.table(t1),4)
 round(prop.table(t1, mar=1),4)

## Gráficos
 barplot(t1, beside=T, col=c("green4","red4"), ylab="Frequência Absoluta")
 legend("topright", fill=c("green4","red4"), c("Não","Sim"), title="Doença", bty="n")

 barplot(cbind(t(prop.table(t1,1)),""), beside=F, col=c("green4","gold3","red4"), ylab="Frequência Relativa")
 legend("bottomright", fill=c("green4","gold3","red4"), c("Não recusa","Às vezes","Sempre"), title="Recusa de Alimentos", bty="n")

################# Quantitativa x Quantitativa

## Gráficos
## diagrama de dispersão entre idade e peso
 plot(idade,peso, pch=20, col="red4")
 abline(lm(peso~idade))


