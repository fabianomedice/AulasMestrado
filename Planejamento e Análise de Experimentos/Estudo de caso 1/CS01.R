#--------------------------
# Gerar dados para an�lise
#--------------------------

#C�digo para gerar os dados do novo programa

#library(ExpDE)
##Par�metros para gerar as amostras
#mre <- list(name = "recombination_bin", cr = 0.9)
#mmu <- list(name = "mutation_rand", f = 2)
#mpo <- 100
#mse <- list(name = "selection_standard")
#mst <- list(names = "stop_maxeval", maxevals = 10000)
#mpr <- list(name = "sphere", xmin = -seq(1, 20), xmax = 20 + 5 * seq(5, 24))


#Par�metros da popula��o e para teste da hip�tese
z_alfa        = qnorm(0.01)
z_beta        = qnorm(0.2)
media         = 50
sigma         = 10
delta.star    = 4


#C�lculo do n�mero de amostras
n_samples = round((z_alfa + z_beta)^2 * sigma^2 / 
                    delta.star^2)

##Gera��o das amostras
#Samples = sapply(1:n_samples, 
#                 FUN = function(x) {
#                        return (ExpDE(mpo, mmu, mre, 
#                                      mse, mst, mpr, 
#                                      showpars = list(show.iters = "none"))$Fbest)
#                                        }
#                )

#write.csv(Samples, "Samples_DE.csv", row.names = FALSE)

#Leitura das amostras obtidas
Samples = as.matrix(read.csv("Samples_DE.CSV"))

#Teste de normalidade de Shapiro-Wilk 
shapiro.test(Samples)

#Histograma das amostras
hist(Samples, breaks = 15)

#Aplica��o do teste t nas amostras obtidas, considerando hip�tese alternativa unilateral inferior
t.test(Samples, alternative = "less", mu = 50, conf.level = 0.99)

#Aplica��o do teste qui quadrado
qchisq(1-0.05, df=n_samples-1) #Obten��o do quantil do teste qui quadrado
(n_samples-1)*var(Samples)/100 #calculando o valor da estat�stica de teste

#C�lculo do Intervalo de Confian�a 
(n_samples-1)*var(Samples)/qchisq(0.05, df=n_samples-1)

