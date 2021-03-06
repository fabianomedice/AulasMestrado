#==============================================================================
#  Terceiro Projeto - M�todos Estat�sticos Avan�ados em Epidemiologia
#==============================================================================
#
#  Descri��o do Estudo:  Foram avaliados dados relativos � idade no momento do trauma, 
#  dente acometido, per�odo extraoral e meio de armazenamento do dente avulsionado, 
#  per�odo de imobiliza��o, uso de antibioticoterapia sist�mica no momento do reimplante e 
#  tempo decorrido entre o reimplante e o inicio do tratamento endod�ntico radical. Tamanho 
#  de amostra igual a 165 pacientes.
#
#===============================================================================

#-------------------------------------------------------------------------------
#  Limpeza de vari�veis
#-------------------------------------------------------------------------------

rm(list=ls(all=TRUE)) # limpar todas as vari�veis do R

#-------------------------------------------------------------------------------
#  Leitura dos Dados do Experimento
#-------------------------------------------------------------------------------

Dados<-read.table("Banco_dados_projeto3.txt", dec=",", h=T)


#-------------------------------------------------------------------------------
#  Regress�o Logistico Simples
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
	#  Cria��o da Fun��o de lineariza��o do modelo logistico
	#-------------------------------------------------------------------------
	logitloess <- function(x, y, s) {
     		logit <- function(pr) {
			log(pr/(1-pr))
      	}
	   	if (missing(s)) {
			locspan <- 0.7
	    	} else {
			locspan <- s
      	}
	   	loessfit <- predict(loess(y~x,span=locspan))
	    	pi <- pmax(pmin(loessfit,0.9999),0.0001)
    		logitfitted <- logit(pi)
	     	plot(x, logitfitted, ylab="logit", xlab="x")
   	}
#-------------------------------------------------------------------------------


#PerEOb15 - Bin�ria - Teste Qui Quadrado
TestePerEOb15 = table(Dados$Ind1gbin,Dados$Pereob15)
dimnames(TestePerEOb15)<- list(Ind1gbin = c("reabsor��es ausentes e leves","reabsor��es moderadas e graves"), PerEOb15 = c("<= 15 min", "> 15 min")) 
#Fazendo os gr�ficos dos dados
barplot(TestePerEOb15,beside=T,ylim=c(0,120),ylab="N�mero de casos Reabsor��o radicular externa", xlab="Tempo de perman�ncia extraoral",legend=T,args.legend=list(x="topleft"))
QuiQuadradoPerEOb15<-chisq.test(TestePerEOb15)
QuiQuadradoPerEOb15

#Meio3 - Categ�rica - Teste Qui Quadrado
TesteMeio3 = table(Dados$Ind1gbin,Dados$Meio3)
dimnames(TesteMeio3)<- list(Ind1gbin = c("reabsor��es ausentes e leves","reabsor��es moderadas e graves"), Meio3 = c("Meios �midos", "Leite", "Seco")) 
#Fazendo os gr�ficos dos dados
barplot(TesteMeio3,beside=T,ylim=c(0,50),ylab="N�mero de casos Reabsor��o radicular externa", xlab="Condi��o de armazenamento do dente ",legend=T,args.legend=list(x="topleft"))
QuiQuadradoMeio3<-chisq.test(TesteMeio3)
QuiQuadradoMeio3

#TempoTERdR - Numerico - Teste logistico
#Gr�fico de Dispers�o
plot(Dados$TempoTERd,Dados$Ind1gbin,xlab="tempo decorrido entre o reimplante dent�rio e a realiza��o do TER",ylab="Indice de reabsor��o observado")
#Testando sem o logaritmo ---------------------------------------------
logitloess(Dados$TempoTERd,Dados$Ind1gbin-1)
TesteTempoTERdR<-glm((Dados$Ind1gbin-1)~Dados$TempoTERd+I(Dados$TempoTERd^2),family=binomial, data=Dados)
summary(TesteTempoTERdR)
x=seq(min(Dados$TempoTERd),max(Dados$TempoTERd),0.1)
y=-1.913e-05*x^2+1.704e-02*x-2.566e+00
lines(y~x)
# N�o ficou bom 
#-----------------------------------------------------------------------------

windows()

#Testando com o logaritmo ----------------------------------------------------
logitloess(log(Dados$TempoTERd+1,base=exp(1)),Dados$Ind1gbin-1)
TesteTempoTERdR<-glm((Dados$Ind1gbin-1)~log(Dados$TempoTERd+1,base=exp(1))+I(log(Dados$TempoTERd+1,base=exp(1))^2),family=binomial, data=Dados)
summary(TesteTempoTERdR)
x=seq(min(log(Dados$TempoTERd+1,base=exp(1))),max(log(Dados$TempoTERd+1,base=exp(1))),0.1)
y=-0.9316*x^2+10.4206*x-28.5653 
lines(y~x)
# Ficou bom e entrou
#-----------------------------------------------------------------------------


#SplintD - Numerico - Teste logistico
#Gr�fico de Dispers�o
plot(Dados$Splintd,Dados$Ind1gbin,xlab="tempo de imobiliza��o do dente ap�s o reimplante",ylab="Indice de reabsor��o observado")
#----------- Remo��o dos NAs ----------
# Cria��o do novo vetor Splintd
NumeroDeNAs = table(complete.cases(Dados$Splintd))
NovoSplintd = rep(0,length(Dados$Splintd)-NumeroDeNAs[1])
NovoInd1gbin = rep(0,length(Dados$Splintd)-NumeroDeNAs[1])
NovoNumRegistro = rep(0,length(Dados$Splintd)-NumeroDeNAs[1])
j=1
for (i in 1:length(Dados$Splintd)){
	if(complete.cases(Dados$Splintd[i])== 1){
		NovoSplintd[j]=Dados$Splintd[i]
		NovoInd1gbin[j]=Dados$Ind1gbin[i]-1
		NovoNumRegistro[j]=Dados$NumRegistro[i]
		j = j+1
	}
}
#Testando sem o logaritmo ----------------------------------------------------
logitloess(NovoSplintd,NovoInd1gbin)
TesteSplintd<-glm((NovoInd1gbin)~(NovoSplintd)+I((NovoSplintd)^2),family=binomial, data=Dados)
summary(TesteSplintd)
x=seq(min(NovoSplintd),max(NovoSplintd),0.1)
y=-1.622e-05*x^2+1.502e-02*x-2.204
lines(y~x)
# N�o ficou bom mas passou no teste
#-----------------------------------------------------------------------------

windows()

#Testando com o logaritmo linear ----------------------------------------------------
logitloess(log(NovoSplintd,base=exp(1)),NovoInd1gbin)
TesteSplintd<-glm((NovoInd1gbin)~log(NovoSplintd,base=exp(1)),family=binomial, data=Dados)
summary(TesteSplintd)
x=seq(min(log(NovoSplintd,base=exp(1))),max(log(NovoSplintd,base=exp(1))),0.1)
y=1.1264*x-5.7927
lines(y~x)
# N�o ficou bom mas passou no teste
#-----------------------------------------------------------------------------

windows()

#Testando com o logaritmo ao quadrado ----------------------------------------------------
logitloess(log(NovoSplintd,base=exp(1)),NovoInd1gbin)
TesteSplintd<-glm((NovoInd1gbin)~log(NovoSplintd,base=exp(1))+I(log(NovoSplintd,base=exp(1))^2),family=binomial, data=Dados)
summary(TesteSplintd)
x=seq(min(log(NovoSplintd,base=exp(1))),max(log(NovoSplintd,base=exp(1))),0.1)
y=-0.3793*x^2+4.5566*x-13.2661
lines(y~x)
# N�o ficou bom mas passou no teste e vai ser usado
#-----------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Escolha da melhor op��o para Idade, entre as variaveis Dados$Idade11 e Dados$Idde16
#-------------------------------------------------------------------------------

#Criando as tabelas para o Qui-Quadrado
#a fun��o table(x,y)faz com que a primeira variavel (x) seja as linhas da tabela e a
#segunda variavel (y) seja as colunas da tabela

TesteIdade11 = table(Dados$Ind1gbin,Dados$Idade11)
dimnames(TesteIdade11)<- list(Ind1gbin = c("reabsor��es ausentes e leves","reabsor��es moderadas e graves"), Idade11 = c("<= 11 anos", "> 11 anos")) 
TesteIdade16 = table(Dados$Ind1gbin,Dados$Idde16)
dimnames(TesteIdade16)<- list(Ind1gbin = c("reabsor��es ausentes e leves","reabsor��es moderadas e graves"), Idade16 = c("<= 16 anos", "> 16 anos")) 

#Fazendo os gr�ficos dos dados
barplot(TesteIdade11,beside=T,ylim=c(0,100),ylab="N�mero de casos Reabsor��o radicular externa", xlab="Idade",legend=T,args.legend=list(x="topleft"))
windows()
barplot(TesteIdade16,beside=T,ylim=c(0,100),ylab="N�mero de casos Reabsor��o radicular externa", xlab="Idade",legend=T,args.legend=list(x="topright"))

QuiQuadradoIdade11<-chisq.test(TesteIdade11)
QuiQuadradoIdade11
#Chances para a reabsor��o ausente e leve
RazaoChancesIdade11 = (TesteIdade11[1,1]*TesteIdade11[2,2])/(TesteIdade11[1,2]*TesteIdade11[2,1])
#Chances para a reabsor��o moderadas e graves
RazaoChancesIdade11 = 1/RazaoChancesIdade11 
RazaoChancesIdade11 

QuiQuadradoIdade16<-chisq.test(TesteIdade16)
QuiQuadradoIdade16
#Chances para a reabsor��o ausente e leve
RazaoChancesIdade16 = (TesteIdade16[1,1]*TesteIdade16[2,2])/(TesteIdade16[1,2]*TesteIdade16[2,1])
#Chances para a reabsor��o moderadas e graves
RazaoChancesIdade16 = 1/RazaoChancesIdade16 
RazaoChancesIdade16

#Pelo a Raz�o de Chances ser maior, escolhemos o Idade16 

#-------------------------------------------------------------------------------
#  Regress�es Logistica Multipla sem intera��o
#-------------------------------------------------------------------------------

#---- Ajuste dos Dados para o Modelo ------------------------------------
NumeroDeNAs = table(complete.cases(Dados$Splintd))
NovoSplintd = rep(0,length(Dados$Splintd)-NumeroDeNAs[1])
NovoInd1gbin = rep(0,length(Dados$Splintd)-NumeroDeNAs[1])
NovoTempoTERd = rep(0,length(Dados$Splintd)-NumeroDeNAs[1])
NovoIdade16 = rep(0,length(Dados$Splintd)-NumeroDeNAs[1])
j=1
for (i in 1:length(Dados$Splintd)){
	if(complete.cases(Dados$Splintd[i])== 1){
		NovoTempoTERd[j]=Dados$TempoTERd[i]
		NovoIdade16[j]=Dados$Idde16[i]
		NovoSplintd[j]=Dados$Splintd[i]
		NovoInd1gbin[j]=Dados$Ind1gbin[i]-1
		j = j+1
	}
}
#-------------------------------------------------------------------------

#Variaveis que n�o entraram PerEOb15,Meio3
Modelo = glm(NovoInd1gbin~log(NovoTempoTERd+1,base=exp(1))+I(log(NovoTempoTERd+1,base=exp(1))^2)+log(NovoSplintd,base=exp(1))+I(log(NovoSplintd,base=exp(1))^2)+NovoIdade16,family=binomial, data=Dados)
summary(Modelo)

#Sai as variaveis I(log(NovoSplintd, base = exp(1))^2)
Modelo = glm(NovoInd1gbin~log(NovoTempoTERd+1,base=exp(1))+I(log(NovoTempoTERd+1,base=exp(1))^2)+log(NovoSplintd,base=exp(1))+NovoIdade16,family=binomial, data=Dados)
summary(Modelo)

#Sai as variaveis I(log(NovoSplintd, base = exp(1))^2) e log(NovoSplintd, base = exp(1))
Modelo = glm(NovoInd1gbin~log(NovoTempoTERd+1,base=exp(1))+I(log(NovoTempoTERd+1,base=exp(1))^2)+NovoIdade16,family=binomial, data=Dados)
summary(Modelo)

#Assim entra as variaveis log(NovoTempoTERd + 1, base = exp(1)), log(NovoTempoTERd + 1, base = exp(1)) e NovoIdade16

#-------------------------------------------------------------------------------
#  Regress�es Logistica Multipla com intera��o
#-------------------------------------------------------------------------------
#Todas as intera��es
Modelo = glm(NovoInd1gbin~log(NovoTempoTERd+1,base=exp(1))+I(log(NovoTempoTERd+1,base=exp(1))^2)+NovoIdade16+log(NovoTempoTERd+1,base=exp(1)):NovoIdade16+I(log(NovoTempoTERd+1,base=exp(1))^2):NovoIdade16,family=binomial, data=Dados)
summary(Modelo)

#Ambas intera��es foram rejeitadas juntas, ent�o n�o h� intera��o
Modelo = glm(NovoInd1gbin~log(NovoTempoTERd+1,base=exp(1))+I(log(NovoTempoTERd+1,base=exp(1))^2)+NovoIdade16,family=binomial, data=Dados)

#-------------------------------------------------------------------------------
#  Teste do Modelo achado
#-------------------------------------------------------------------------------

#   Hosmer e Lemeshow
#
# Define a funcao que faz o teste de Hosmer-Lemeshow
# y    - Dados observados
# yhat - Dados ajustados
# g    - Numero de grupos
#
 hosmerlem <- function(y, yhat, g = 10) {
  cutyhat <- cut(yhat, breaks = quantile(yhat, probs = seq(0, 1, 1 / g)), include.lowest = TRUE)
  obs <- xtabs(cbind(1 - y, y) ~ cutyhat)
  expect <- xtabs(cbind(1 - yhat, yhat) ~ cutyhat)
  chisq <- sum((obs - expect) ^ 2 / expect)
  P <- 1 - pchisq(chisq, g - 2)
  return(list(chisq = chisq, p.value = P, df = g - 2))
  }
#

hosmerlem(NovoInd1gbin, Modelo$fitted.values, g = 10)

#-------------------------------------------------------------------------------
#  Graficos dos Parametros do Modelo Final
#-------------------------------------------------------------------------------

#Para Idade16
RC_Idade16 = exp(-2.3759)
IntConfianca_Idade16_inf = exp(-2.3759 - 1.96*1.1008)
IntConfianca_Idade16_sup = exp(-2.3759 + 1.96*1.1008)

#Para TempoTERd
X_TempoTERd = seq(min(NovoTempoTERd),max(NovoTempoTERd),10)
Y_TempoTERd = exp(-0.8982*(log(X_TempoTERd + 1, base = exp(1)))^2 + 10.2423*log(X_TempoTERd + 1, base = exp(1)))
plot(X_TempoTERd,Y_TempoTERd, type="l", xlab="TempoTERdR - Dias", ylab="Chance de Reabsor��o Moderada e Grave")
#-------------------------------------------------------------------------------
#  Fim do programa
#-------------------------------------------------------------------------------

