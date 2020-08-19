########################### Aula Pr�tica - An�lise Descritiva #################
#data: 30/03/2012

## Importando o banco de dados no formato csv
## Antes de usar o comando abaixo, mudar o diret�rio para a pasta que est� o banco de dados
 data <- read.csv2("dados_andre.csv")
 attach(data) ## O fun��o attach "libera" o banco de dados
 head(data)
 dim(data)
 class(data)
################################## Vari�veis Qualitativas

##Vari�vel Doen�a 
 doen�a.tb <- table(Doen�a)
 doen�a.tb

 doen�a.tbp <- prop.table(doen�a.tb)
 doen�a.tbp

##Vari�vel Sexo
 sexo.tb <- table(Sexo)
 sexo.tb

 sexo.tbp <- prop.table(sexo.tb)
 sexo.tbp

##Vari�vel Recusa de Alimentos
 recusa.tb<- table(recusa.de.alimento)
 recusa.tb

 recusa.tbp<- prop.table(recusa.tb)
 recusa.tbp

##Gr�ficos
 par(mfrow=c(1,3)) ## Permite construir 3 gr�ficos na mesma janela
 par(mar=c(4,4,4,4))
 pie(doen�a.tb,col=c("seagreen4","skyblue4"), main="Doen�a", radius=1.1)
 pie(sexo.tb,col=c("seagreen4","skyblue4"), main="Sexo", radius=1.1)
 barplot(recusa.tb, col="seagreen4", names=c("As vezes","N�o Recusa ","Recusa"), ylim=c(0,120), main="Recusa de alimentos")

################################## Vari�veis Quantitativas
 
 install.packages("fields") ## Instalando um pacote (deve estar conectado na Internet)
 require(fields) ## Carregando um pacote

 tab<- cbind(stats(idade), stats(peso))
 colnames(tab)<- c("Idade","Peso")
 tab

 round(tab,2) ## Arrendondar para dois digitos

##Gr�ficos
 par(mfrow=c(1,2))
 par(mar=c(4.5,5,2,2))
 boxplot(idade, main="Idade", ylab="Idade - Semanas", col="gold4")
 boxplot(peso, main="Peso", ylab="kg", col="gold4")
 hist(idade, main="Idade", xlab="Idade - Semanas", ylab="Frequ�ncia", col="gold4")
 hist(peso, main="Peso", xlab="kg", ylab="Frequ�ncia", col="gold4")

##################### Qualitativa x Quantitativa
#Peso x Doen�a
###utiliza��o da fun��o tapply

##Utilizando a fun��o stats dentro do comando tapply
 tab1<-tapply(peso, Doen�a, stats)
 tab1 ## � uma lista

 round(data.frame(tab1[1], tab1[2]),3)
 t(round(data.frame(tab1[1], tab1[2]),3))[,-9]

## Gr�ficos
 par(mfrow=c(1,1))
 boxplot( peso ~ Doen�a, col="seagreen4", xlab="Doen�a", ylab="Peso- Kg")

################### Qualitativa x Qualitativa
#Doen�a x  recusa.de.alimento

 t1 <- table(Doen�a, recusa.de.alimento)
 t1

 round(prop.table(t1),4)
 round(prop.table(t1, mar=1),4)

## Gr�ficos
 barplot(t1, beside=T, col=c("green4","red4"), ylab="Frequ�ncia Absoluta")
 legend("topright", fill=c("green4","red4"), c("N�o","Sim"), title="Doen�a", bty="n")

 barplot(cbind(t(prop.table(t1,1)),""), beside=F, col=c("green4","gold3","red4"), ylab="Frequ�ncia Relativa")
 legend("bottomright", fill=c("green4","gold3","red4"), c("N�o recusa","�s vezes","Sempre"), title="Recusa de Alimentos", bty="n")

################# Quantitativa x Quantitativa

## Gr�ficos
## diagrama de dispers�o entre idade e peso
 plot(idade,peso, pch=20, col="red4")
 abline(lm(peso~idade))


