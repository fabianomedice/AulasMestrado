#==============================================================================
#  Segundo Projeto - Métodos Estatísticos Avançados em Epidemiologia
#==============================================================================
#
#  Descrição do Estudo:  O aumento da obesidade infantil e o fato de se tratar de um fator
#  de risco para a obesidade adulta torna a avaliação cuidadosa da composição
#  corporal na criança uma importante variável de promoção de saúde.
#  Existem alguns métodos de medição indireta da composição corporal. O
#  método de bioimpedância é tomado como aquele de referência. Ele consiste
#  na condução de uma corrente elétrica de baixa intensidade através do corpo.
#
#===============================================================================

#-------------------------------------------------------------------------------
#  Limpeza de variáveis
#-------------------------------------------------------------------------------
#  

 rm(list=ls(all=TRUE)) # limpar todas as variáveis do R

#-------------------------------------------------------------------------------
#  Leitura dos Dados do Experimento
#-------------------------------------------------------------------------------

  Dados<-read.table("Banco_dados_projeto2.txt",h=T)

#-------------------------------------------------------------------------------
#  Alteração da Legenda dos Dados do Experimento
#-------------------------------------------------------------------------------

Numero_Linhas = dim(Dados)
Numero_Linhas = Numero_Linhas[1]

 for (i in 1:Numero_Linhas) {

	#Mudando o sexo
	if (Dados$Sexo[i] == 0) 
		Dados$Sexo[i] = 'Menino'
	if (Dados$Sexo[i] == 1) 
		Dados$Sexo[i] = 'Menina'

	#Mudando a classificação
	if (Dados$Classificação[i] == 0) 
		Dados$Classificação[i] = 'Eutrofico'
	if (Dados$Classificação[i] == 1) 
		Dados$Classificação[i] = 'Obeso'
	if (Dados$Classificação[i] == 2) 
		Dados$Classificação[i] = 'Sobrepeso'

 }

#Transformando em variável categorica
Dados$Sexo <- factor(Dados$Sexo)
Dados$Classificação <- factor(Dados$Classificação)


#  Acertando a classe das variáveis

#  Desfecho (Y)
  Bioimpedancia <- Dados$BIA

#  Variaveis explicativas (X)
  Sexo <- Dados$Sexo
  Idade <- Dados$Idade
  Classificacao <- Dados$Classificação
  Pregas <- Dados$Pregas
  Conicidade <- Dados$Conicidade
  CinturaQuadril <- Dados$CinturaQuadril 
  CinturaEstatura <- Dados$CinturaEstatura 

#-------------------------------------------------------------------------------
#  Escolha da melhor opção para o IMC, entre as variaveis Dados$IMC, Dados$Percentil e Dados$Escorez
#-------------------------------------------------------------------------------

  mod <- lm(Bioimpedancia~Dados$IMC)
  summary(mod)

  mod <- lm(Bioimpedancia~Dados$Percentil)
  summary(mod)

  mod <- lm(Bioimpedancia~Dados$Escorez)
  summary(mod)

# Por o Dados$Escorez possuir o melhor valor R^2 

  IMC <- Dados$Escorez

#-------------------------------------------------------------------------------
#  Teste de variáveis quadraticas
#-------------------------------------------------------------------------------

par(mfrow=c(2,2))
plot(Dados$Sexo,Dados$BIA,xlab="Sexo", ylab="Bioimpedancia")
lines(lowess(Dados$BIA~Dados$Sexo))
plot(Dados$Idade,Dados$BIA,xlab="Idade", ylab="Bioimpedancia")
lines(lowess(Dados$BIA~Dados$Idade))
plot(Dados$Classificação,Dados$BIA,xlab="Classificação", ylab="Bioimpedancia")
lines(lowess(Dados$BIA~Dados$Classificação))
plot(Dados$Pregas,Dados$BIA,xlab="Pregas", ylab="Bioimpedancia")
lines(lowess(Dados$BIA~Dados$Pregas))
windows()
par(mfrow=c(2,2))
plot(Dados$Conicidade,Dados$BIA,xlab="Conicidade", ylab="Bioimpedancia")
lines(lowess(Dados$BIA~Dados$Conicidade))
plot(Dados$CinturaQuadril,Dados$BIA,xlab="Cintura Quadril", ylab="Bioimpedancia")
lines(lowess(Dados$BIA~Dados$CinturaQuadril))
plot(Dados$CinturaEstatura,Dados$BIA,xlab="Cintura Estatura", ylab="Bioimpedancia")
lines(lowess(Dados$BIA~Dados$CinturaEstatura))
plot(Dados$Escorez,Dados$BIA,xlab="Escore Z", ylab="Bioimpedancia")
lines(lowess(Dados$BIA~Dados$Escorez))


#-------------------------------------------------------------------------------
#  Regressões Lineares Simples
#-------------------------------------------------------------------------------

#  Regressão Linear Simples para Sexo

  mod1 <- lm(Bioimpedancia~Sexo)
  summary(mod1)

#  Regressão Linear Simples para Idade

  mod2 <- lm(Bioimpedancia~Idade+I(Idade^2))
  summary(mod2)

#  Regressão Linear Simples para IMC

  mod3 <- lm(Bioimpedancia~IMC)
  summary(mod3)

#  Regressão Linear Simples para Classificação

  mod4 <- lm(Bioimpedancia~Classificacao)
  summary(mod4)

#  Regressão Linear Simples para Pregas

  mod5 <- lm(Bioimpedancia~Pregas+I(Pregas^2))
  summary(mod5)

#  Regressão Linear Simples para Conicidade

  mod6 <- lm(Bioimpedancia~Conicidade)
  summary(mod6)

#  Regressão Linear Simples para Cintura Quadril

  mod7 <- lm(Bioimpedancia~CinturaQuadril)
  summary(mod7)

#  Regressão Linear Simples para Cintura Estatura

  mod8 <- lm(Bioimpedancia~CinturaEstatura)
  summary(mod8)

#-------------------------------------------------------------------------------
#  Regressões Lineares Multipla sem interação
#-------------------------------------------------------------------------------

# Variaveis que entram:
# Sexo, Idade, IMC, Classificação, Pregas, Conicidade, CinturaQuadril, CinturaEstatura

#  Regressão Linear Múltipla: Todas variaveis

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+IMC+Classificacao+Pregas+I(Pregas^2)+Conicidade+CinturaQuadril+CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla: Retirada da IMC

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Classificacao+Pregas+I(Pregas^2)+Conicidade+CinturaQuadril+CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla: Retirada da IMC e Classificação

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaQuadril+CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla: Retirada da IMC, Classificação e CinturaQuadril

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura)
  summary(mod)

#-------------------------------------------------------------------------------
#  Regressões Lineares Multipla com interação
#-------------------------------------------------------------------------------

#  Regressão Linear Múltipla com interação

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:I(Idade^2)+Sexo:Pregas+Sexo:I(Pregas^2)+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Pregas+Idade:I(Pregas^2)+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):Conicidade+I(Idade^2):CinturaEstatura+Pregas:Conicidade+Pregas:CinturaEstatura+I(Pregas^2):Conicidade+I(Pregas^2):CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2)

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:I(Idade^2)+Sexo:Pregas+Sexo:I(Pregas^2)+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Pregas+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):Conicidade+I(Idade^2):CinturaEstatura+Pregas:Conicidade+Pregas:CinturaEstatura+I(Pregas^2):Conicidade+I(Pregas^2):CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:I(Idade^2)+Sexo:Pregas+Sexo:I(Pregas^2)+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):Conicidade+I(Idade^2):CinturaEstatura+Pregas:Conicidade+Pregas:CinturaEstatura+I(Pregas^2):Conicidade+I(Pregas^2):CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:I(Idade^2)+Sexo:Pregas+Sexo:I(Pregas^2)+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):Conicidade+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+I(Pregas^2):CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:I(Idade^2)+Sexo:Pregas+Sexo:I(Pregas^2)+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):Conicidade+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2) 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:I(Idade^2)+Sexo:Pregas+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):Conicidade+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:I(Idade^2)+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):Conicidade+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:I(Idade^2)+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2) 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Idade+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:Conicidade+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:CinturaEstatura+I(Idade^2):Pregas+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:CinturaEstatura+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+Pregas:Conicidade+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas, Pregas:Conicidade 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Conicidade+Sexo:CinturaEstatura+Idade:CinturaEstatura+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas, Pregas:Conicidade, Sexo:CinturaEstatura 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Sexo:Conicidade+Idade:CinturaEstatura+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas, Pregas:Conicidade, Sexo:CinturaEstatura, Sexo:Conicidade 

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Idade:CinturaEstatura+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+I(Pregas^2):Conicidade+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas, Pregas:Conicidade, Sexo:CinturaEstatura, Sexo:Conicidade, I(Pregas^2):Conicidade  

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Idade:CinturaEstatura+I(Idade^2):I(Pregas^2)+I(Idade^2):CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas, Pregas:Conicidade, Sexo:CinturaEstatura, Sexo:Conicidade, I(Pregas^2):Conicidade, I(Idade^2):I(Pregas^2)  

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Idade:CinturaEstatura+I(Idade^2):CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas, Pregas:Conicidade, Sexo:CinturaEstatura, Sexo:Conicidade, I(Pregas^2):Conicidade, I(Idade^2):I(Pregas^2), I(Idade^2):CinturaEstatura   

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Idade:CinturaEstatura+I(Idade^2):CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas, Pregas:Conicidade, Sexo:CinturaEstatura, Sexo:Conicidade, I(Pregas^2):Conicidade, I(Idade^2):I(Pregas^2), I(Idade^2):CinturaEstatura, I(Idade^2):CinturaEstatura   

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Idade:CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#  Regressão Linear Múltipla com interação sem Idade:I(Pregas^2),Idade:Pregas, Pregas:CinturaEstatura, I(Pregas^2):CinturaEstatura, Sexo:I(Pregas^2), Sexo:Pregas, I(Idade^2):Conicidade, Sexo:I(Idade^2), Sexo:Idade, Idade:Conicidade, I(Idade^2):Pregas, Pregas:Conicidade, Sexo:CinturaEstatura, Sexo:Conicidade, I(Pregas^2):Conicidade, I(Idade^2):I(Pregas^2), I(Idade^2):CinturaEstatura, I(Idade^2):CinturaEstatura, Idade:CinturaEstatura    

  mod <- lm(Bioimpedancia~Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Conicidade:CinturaEstatura)
  summary(mod)

#-------------------------------------------------------------------------------
#  Teste do Modelo achado
#-------------------------------------------------------------------------------
#Modelo -> Bioimpedancia = Sexo+Idade+I(Idade^2)+Pregas+I(Pregas^2)+Conicidade+CinturaEstatura+Conicidade:CinturaEstatura

#  Teste Faraway (Homocedasticidade)
#
   summary(lm(abs(residuals(mod))~fitted(mod)))
#
#  Teste Shapiro (normalidade) 
   shapiro.test(mod$resid)

#-------------------------------------------------------------------------------
#  Graficos dos Parametros do Modelo Final
#-------------------------------------------------------------------------------

#Para Idade
   xIdade = seq(min(Idade),max(Idade),0.01)
   yIdade = xIdade*(23.41)+xIdade^2*(-1.480)
   plot(xIdade,yIdade,xlab="Idade",ylab="Bioimpedancia")   
#Para Pregas
   xPregas = seq(min(Pregas),max(Pregas),0.1)
   yPregas = xPregas*(0.5340)+xPregas^2*(-0.006293)
   par(mfrow=c(1,2))
   plot(xPregas,yPregas,xlab="Pregas",ylab="Bioimpedancia")
   plot(Dados$Pregas,Dados$BIA,xlab="Pregas", ylab="Bioimpedancia")
   lines(lowess(Dados$BIA~Dados$Pregas))
#Temos que trabalhar com Conicidade e CinturaEstatura juntas
#A equação e: Bioimpedancia = Conicidade*(163.8)+CinturaEstatura*(368.3)+Conicidade*CinturaEstatura*(-251.5)
#Fazendo linhas de CinturaEstatura, variando de 0.1 em 0.1
   xCinturaEstatura = seq(min(CinturaEstatura),max(CinturaEstatura),0.1)
   xConicidade = seq(min(Conicidade),max(Conicidade),0.0001)
   yConicidade = xConicidade*(163.8)+xCinturaEstatura*(368.3)+xConicidade*xCinturaEstatura*(-251.5)
   plot(xConicidade,yConicidade,xlab="Conicidade",ylab="Bioimpedancia")
   N_Linhas = length(xCinturaEstatura)
#Fazendo as linhas
#Para 0.41
   yConicidade = xConicidade*(163.8)+xCinturaEstatura[1]*(368.3)+xConicidade*xCinturaEstatura[1]*(-251.5)
   lines(xConicidade,yConicidade,)
#Para 0.51
   yConicidade = xConicidade*(163.8)+xCinturaEstatura[2]*(368.3)+xConicidade*xCinturaEstatura[2]*(-251.5)
   lines(xConicidade,yConicidade,)
#Para 0.61
   yConicidade = xConicidade*(163.8)+xCinturaEstatura[3]*(368.3)+xConicidade*xCinturaEstatura[3]*(-251.5)
   lines(xConicidade,yConicidade,)
#Para 0.71
   yConicidade = xConicidade*(163.8)+xCinturaEstatura[4]*(368.3)+xConicidade*xCinturaEstatura[4]*(-251.5)
   lines(xConicidade,yConicidade,)
   text(locator(), labels = c("CinturaEstatura=0,41","CinturaEstatura=0,51","CinturaEstatura=0,61","CinturaEstatura=0,71"))

   
#-------------------------------------------------------------------------------
#  Fim do programa
#-------------------------------------------------------------------------------

  par(mfrow=c(2,2))
  plot(mod13, which=c(1:4),pch=16, add.smooth=T)


   plot(Dados$Sexo,Dados$BIA,xlab="Sexo", ylab="Bioimpedancia")
   lines(lowess(Dados$BIA~Dados$Sexo))











#  Gráfico para verificar independência (na sequência de 
#    coleta dos dados)
#
   par(mfrow=c(1,1))
   plot(mod13$residuals,pch=16,ylab="Residuals")
#
#  Como aparentemente as suposições foram validadas,
#   Porque gênero perdeu a significância na regressão múltipla?
# 
  levels(X2) <- c("mulher","homem")
  boxplot(X1~X2, xlab="Gênero", ylab="idade")
# 
# Homens são mais velhos que as mulheres. Isto significa que 
# idade é um fator de confusão para a associação entre Pio e gênero.
#
#
##################################################################################
#      TÓPICOS ESPECIAIS
#
#  Excluindo o paciente 25
#
  ex2<-ex1[-25,]
  mod7<-gamlss(ex2$pio~ex2$idade+ex2$sexo,sigma.formula= ~ex2$idade,family=NO)
  plot(mod7)
  wp(mod7)
  summary(mod7)
  mod8<-lm(ex2$pio~ex2$idade+ex2$sexo)
  summary(mod8)
  par(mfrow=c(2,2))
  plot(mod8)
  shapiro.test(mod8$resid)
#
#=========================================================================================