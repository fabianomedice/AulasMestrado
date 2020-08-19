#==============================================================================
#  Quarto Projeto - Métodos Estatísticos Avançados em Epidemiologia
#==============================================================================
#
#  Descrição do Estudo:  
#
#===============================================================================

#-------------------------------------------------------------------------------
#  Limpeza de variáveis
#-------------------------------------------------------------------------------

rm(list=ls(all=TRUE)) # limpar todas as variáveis do R

#-------------------------------------------------------------------------------
#  Leitura dos Dados do Experimento
#-------------------------------------------------------------------------------

Dados<-read.table("Banco_dados_projeto4.txt", dec=".", h=T)

#---------------------Arrumando o Banco de dados-----------------------------
#----------- Remoção dos NAs ----------
#Remoção dos dados das colunas TEMPOACOMP, METASTASE, GENERO, GRUPOIDADE, LOCALMMPR, TIPOHE, CATBRESLOW, ULCERHE
Dados = Dados[complete.cases(Dados[c(1:7,9)]),]

#Remoção das colunas que não serão utilizadas
Dados = Dados[-8]
Dados = Dados[-9]

#Troca do 2 por 0 na indicação da censura
Dados$METASTASE = abs(2-Dados$METASTASE)

#Trocando os nomes dos dados
tamanho = dim(Dados)
for (i in 1:tamanho[1]){
	#Mudando GENERO
	if(Dados$GENERO[i] == 1){
		Dados$GENERO[i] = "M"
	}else{
		Dados$GENERO[i] = "F"
	}
	#Mudando GRUPOIDADE
	if(Dados$GRUPOIDADE[i] == 1){
		Dados$GRUPOIDADE[i] = "18-40"
	} else {
		if(Dados$GRUPOIDADE[i] == 2){
			Dados$GRUPOIDADE[i] = ">40-60"
		}else{
			Dados$GRUPOIDADE[i]=">60"
		}
	}
	#Mudando LOCALMMPR
	if(Dados$LOCALMMPR[i] == 1){
		Dados$LOCALMMPR[i] = "CABEÇA E PESCOÇO + TRONCO"
	} else {
		if(Dados$LOCALMMPR[i] == 2){
			Dados$LOCALMMPR[i] = "MEMBROS SUPERIORES + INFERIORES"
		}else{
			Dados$LOCALMMPR[i]="ACRAL"
		}
	}
	#Mudando TIPOHE
	if(Dados$TIPOHE[i] == 1){
		Dados$TIPOHE[i] = "EXTENSIVO SUPERFICIAL + LENTIGO MALIGNO"
	} else {
		if(Dados$TIPOHE[i] == 3){
			Dados$TIPOHE[i] = "NODULAR"
		}else{
			Dados$TIPOHE[i]="LENTIGINOSO ACRAL"
		}
	}

	#Mudando CATBRESLOW
	if(Dados$CATBRESLOW[i] == 1){
		Dados$CATBRESLOW[i] = "<=1mm"
	} else {
		if(Dados$CATBRESLOW[i] == 2){
			Dados$CATBRESLOW[i] = "1-4mm"
		}else{
			Dados$CATBRESLOW[i]=">4mm"
		}
	}

	#ULCERHE
	if(Dados$ULCERHE[i] == 1){
		Dados$ULCERHE[i] = "NÃO"
	} else {
		Dados$ULCERHE[i] = "SIM"
	}

}

#----------------------------------------------------------------------------
#Chamando Biblioteca para funcionar os comandos
# Códigos em R apresentados no Capítulo 2 - Kaplan-Meier e Logrank
#
 require(survival)
 require(km.ci)
#

#Desfecho Y
Y = Surv(Dados$TEMPOACOMP, Dados$METASTASE)

#-------------------------------------------------------------------------------
#  Analise de Sobrevivência Univariada
#-------------------------------------------------------------------------------

#Kaplan-Meier da Variável GENERO
KM_GENERO = survfit(Y~Dados$GENERO)
summary(KM_GENERO)
plot(KM_GENERO, lty=c(1,2), main="Kaplan-Meier de GENERO", xlab="Tempo (meses)",ylab="S(t) estimada")
legend(1,0.3,lty=c(1,2),c("F","M"),lwd=1, bty="n")
#LogRank da Variável GENERO
survdiff(Y~Dados$GENERO)

#Kaplan-Meier da Variável GRUPOIDADE
KM_GRUPOIDADE = survfit(Y~Dados$GRUPOIDADE)
summary(KM_GRUPOIDADE)
plot(KM_GRUPOIDADE, lty=c(1,2,3), main="Kaplan-Meier de GRUPOIDADE", xlab="Tempo (meses)",ylab="S(t) estimada")
legend(1,0.3,lty=c(1,2,3),c(">40-60",">60","18-40"),lwd=1, bty="n")
#LogRank da Variável GRUPOIDADE
survdiff(Y~Dados$GRUPOIDADE)

#Kaplan-Meier da Variável LOCALMMPR
KM_LOCALMMPR = survfit(Y~Dados$LOCALMMPR)
summary(KM_LOCALMMPR)
plot(KM_LOCALMMPR, lty=c(1,2,3), main="Kaplan-Meier de LOCALMMPR", xlab="Tempo (meses)",ylab="S(t) estimada")
legend(1,0.3,lty=c(1,2,3),c("ACRAL","CABEÇA E PESCOÇO + TRONCO","MEMBROS SUPERIORES + INFERIORES"),lwd=1, bty="n")
#LogRank da Variável LOCALMMPR
survdiff(Y~Dados$LOCALMMPR)

#Kaplan-Meier da Variável TIPOHE
KM_TIPOHE = survfit(Y~Dados$TIPOHE)
summary(KM_TIPOHE)
plot(KM_TIPOHE, lty=c(1,2,3), main="Kaplan-Meier de TIPOHE", xlab="Tempo (meses)",ylab="S(t) estimada")
legend(1,0.3,lty=c(1,2,3),c("EXTENSIVO SUPERFICIAL + LENTIGO MALIGNO","LENTIGINOSO ACRAL","NODULAR"),lwd=1, bty="n")
#LogRank da Variável TIPOHE
survdiff(Y~Dados$TIPOHE)

#Kaplan-Meier da Variável CATBRESLOW
KM_CATBRESLOW = survfit(Y~Dados$CATBRESLOW)
summary(KM_CATBRESLOW)
plot(KM_TIPOHE, lty=c(1,2,3), main="Kaplan-Meier de CATBRESLOW", xlab="Tempo (meses)",ylab="S(t) estimada")
legend(1,0.3,lty=c(1,2,3),c("<=1mm",">4mm","1-4mm"),lwd=1, bty="n")
#LogRank da Variável CATBRESLOW
survdiff(Y~Dados$CATBRESLOW)

#Kaplan-Meier da Variável ULCERHE
KM_ULCERHE = survfit(Y~Dados$ULCERHE)
summary(KM_ULCERHE)
plot(KM_ULCERHE , lty=c(1,2), main="Kaplan-Meier de ULCERHE", xlab="Tempo (meses)",ylab="S(t) estimada")
legend(1,0.3,lty=c(1,2),c("NÃO","SIM"),lwd=1, bty="n")
#LogRank da Variável ULCERHE
survdiff(Y~Dados$ULCERHE)

#-------------------------------------------------------------------------------
#  Analise de Sobrevivência Multivariada
#-------------------------------------------------------------------------------
#Variaveis que entram
#GENERO, GRUPOIDADE, TIPOHE, CATBRESLOW, ULCERHE
#Montando o Modelo de Cox sem interação
Modelo<-coxph(Y~Dados$GENERO+Dados$GRUPOIDADE+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#Retirado GRUPOIDADE
Modelo<-coxph(Y~Dados$GENERO+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#Montando o Modelo de Cox com interação
Modelo<-coxph(Y~Dados$GENERO+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE+Dados$GENERO:Dados$TIPOHE+Dados$GENERO:Dados$CATBRESLOW+Dados$GENERO:Dados$ULCERHE+Dados$TIPOHE:Dados$CATBRESLOW+Dados$TIPOHE:Dados$ULCERHE+Dados$CATBRESLOW:Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#Retirado GENERO:CATBRESLOW
Modelo<-coxph(Y~Dados$GENERO+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE+Dados$GENERO:Dados$TIPOHE+Dados$GENERO:Dados$ULCERHE+Dados$TIPOHE:Dados$CATBRESLOW+Dados$TIPOHE:Dados$ULCERHE+Dados$CATBRESLOW:Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#Retirado GENERO:CATBRESLOW e TIPOHE:ULCERHE
Modelo<-coxph(Y~Dados$GENERO+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE+Dados$GENERO:Dados$TIPOHE+Dados$GENERO:Dados$ULCERHE+Dados$TIPOHE:Dados$CATBRESLOW+Dados$CATBRESLOW:Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#Retirado GENERO:CATBRESLOW, TIPOHE:ULCERHE e GENERO:TIPOHE
Modelo<-coxph(Y~Dados$GENERO+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE+Dados$GENERO:Dados$ULCERHE+Dados$TIPOHE:Dados$CATBRESLOW+Dados$CATBRESLOW:Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#Retirado GENERO:CATBRESLOW, TIPOHE:ULCERHE, GENERO:TIPOHE e GENERO:ULCERHE
Modelo<-coxph(Y~Dados$GENERO+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE+Dados$TIPOHE:Dados$CATBRESLOW+Dados$CATBRESLOW:Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#Retirado GENERO:CATBRESLOW, TIPOHE:ULCERHE, GENERO:TIPOHE, GENERO:ULCERHE e TIPOHE:CATBRESLOW
Modelo<-coxph(Y~Dados$GENERO+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE+Dados$CATBRESLOW:Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#Retirado GENERO:CATBRESLOW, TIPOHE:ULCERHE, GENERO:TIPOHE, GENERO:ULCERHE, TIPOHE:CATBRESLOW e CATBRESLOW:ULCERHE
Modelo<-coxph(Y~Dados$GENERO+Dados$TIPOHE+Dados$CATBRESLOW+Dados$ULCERHE,data=Dados,method="breslow")
summary(Modelo)

#-------------------------------------------------------------------------------
#  Validação do Modelo
#-------------------------------------------------------------------------------
# Teste de Schoenfeld de Adequação do Modelo
resid(Modelo,type="scaledsch")
cox.zph(Modelo, transform="identity")

par(mfrow=c(3,2))
plot(cox.zph(Modelo))

#-------------------------------------------------------------------------------
#  Fim do programa
#-------------------------------------------------------------------------------

